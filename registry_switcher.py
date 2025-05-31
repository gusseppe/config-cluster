#!/usr/bin/env python3
import argparse
import os
import re
import shutil
from pathlib import Path
import yaml
from typing import List, Set

class RegistrySwitcher:
    def __init__(self, source_registry: str, target_registry: str):
        self.source_registry = source_registry
        self.target_registry = target_registry
        self.processed_files: Set[Path] = set()
        
    def copy_and_process_directory(self, source_dir: Path, target_dir: Path) -> None:
        """Copy source directory to target directory and process all files."""
        source_dir = source_dir.resolve()
        target_dir = target_dir.resolve()
        
        if not source_dir.exists():
            print(f"❌ Source directory not found: {source_dir}")
            return
            
        if target_dir.exists():
            print(f"⚠️  Target directory already exists: {target_dir}")
            response = input("Do you want to overwrite it? (y/N): ")
            if response.lower() not in ['y', 'yes']:
                print("❌ Aborted")
                return
            shutil.rmtree(target_dir)
        
        print(f"📁 Copying {source_dir} to {target_dir}...")
        shutil.copytree(source_dir, target_dir)
        print(f"✅ Directory copied successfully")
        
        print(f"🔄 Processing files to replace registry URLs...")
        print(f"   From: {self.source_registry}")
        print(f"   To:   {self.target_registry}")
        
        self.process_directory(target_dir)
        
    def process_file(self, file_path: Path) -> bool:
        """Process a file and replace registry URLs."""
        try:
            if not file_path.exists():
                return False
                
            if file_path in self.processed_files:
                return False
                
            # Skip certain files and directories
            if (file_path.name.startswith('.') or 
                file_path.suffix.lower() in ['.tgz', '.gz', '.tar', '.zip', '.jpg', '.png', '.gif', '.ico']):
                return False
                
            # Read the content of the file
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
            except (UnicodeDecodeError, PermissionError):
                # Skip binary files or files we can't read
                return False
                
            # Simple replacement of registry URLs
            if self.source_registry in content:
                new_content = content.replace(self.source_registry, self.target_registry)
                
                # Write the modified content back to the file
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                self.processed_files.add(file_path)
                
                try:
                    relative_path = file_path.relative_to(Path.cwd())
                except ValueError:
                    relative_path = file_path
                print(f"✓ Updated: {relative_path}")
                return True
            return False
            
        except Exception as e:
            print(f"⚠️  Error processing {file_path}: {str(e)}")
            return False
    
    def process_directory(self, directory_path: Path) -> None:
        """Process all relevant files in a directory and its subdirectories."""
        directory_path = directory_path.resolve()
        if not directory_path.exists():
            print(f"❌ Directory not found: {directory_path}")
            return
            
        # Track statistics
        stats = {
            'processed': 0,
            'updated': 0,
            'skipped': 0,
            'errors': 0
        }
        
        try:
            # Process all files recursively
            for file_path in directory_path.rglob('*'):
                if file_path.is_file():
                    stats['processed'] += 1
                    if self.process_file(file_path):
                        stats['updated'] += 1
                    else:
                        stats['skipped'] += 1
            
            # Print summary
            print(f"\n📊 Processing Summary:")
            print(f"   Files Updated: {stats['updated']}")
            print(f"   Files Skipped: {stats['skipped']}")
            print(f"   Total Files:   {stats['processed']}")
            
            if stats['updated'] > 0:
                print(f"\n✅ Successfully updated registry references!")
            else:
                print(f"\n ℹ️  No registry references found to update.")
            
        except Exception as e:
            print(f"❌ Error processing directory {directory_path}: {str(e)}")

def main():
    parser = argparse.ArgumentParser(
        description='Copy directory and switch Docker registry URLs in configuration files',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Copy config-local to config-cluster and convert vcf-np-w2-harbor-az1.sunat.peru/agentes to production registry
  %(prog)s config-local config-cluster
  
  # Copy with custom registries
  %(prog)s config-local config-cluster --source localhost:8080 --target my.registry.com/project
  
  # Process existing directory in-place (no copy)
  %(prog)s config-cluster --in-place
        """
    )
    
    parser.add_argument('source', help='Source directory to copy from')
    parser.add_argument('target', nargs='?', help='Target directory to copy to (required unless --in-place)')
    parser.add_argument('--source-registry', '-s', default='vcf-np-w2-harbor-az1.sunat.peru/agentes',
                      help='Source registry URL to replace (default: vcf-np-w2-harbor-az1.sunat.peru/agentes)')
    parser.add_argument('--target-registry', '-t', default='vcf-np-w2-harbor-az1.sunat.peru/agentes',
                      help='Target registry URL to replace with (default: vcf-np-w2-harbor-az1.sunat.peru/agentes)')
    parser.add_argument('--in-place', action='store_true',
                      help='Process existing directory in-place without copying')
    parser.add_argument('--verbose', '-v', action='store_true',
                      help='Show more detailed output')
    
    args = parser.parse_args()
    
    # Validate arguments
    if not args.in_place and not args.target:
        parser.error("Target directory is required unless --in-place is specified")
    
    # Create switcher instance
    switcher = RegistrySwitcher(args.source_registry, args.target_registry)
    
    # Process based on mode
    if args.in_place:
        # Process existing directory in-place
        source_path = Path(args.source).resolve()
        if not source_path.exists() or not source_path.is_dir():
            print(f"❌ Invalid source directory: {source_path}")
            return
        
        print(f"🔄 Processing directory in-place: {source_path}")
        print(f"   From: {args.source_registry}")
        print(f"   To:   {args.target_registry}")
        switcher.process_directory(source_path)
    else:
        # Copy and process
        source_path = Path(args.source).resolve()
        target_path = Path(args.target).resolve()
        
        if not source_path.exists() or not source_path.is_dir():
            print(f"❌ Invalid source directory: {source_path}")
            return
            
        switcher.copy_and_process_directory(source_path, target_path)

if __name__ == '__main__':
    main()