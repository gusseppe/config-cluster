# Registry Switcher Usage Guide

The `registry_switcher.py` script has been enhanced to copy and transform configuration directories for different deployment environments.

## Key Features

✅ **Copy and Transform**: Creates a new directory with updated registry URLs  
✅ **Simple Operation**: One command to copy and update all files  
✅ **Safe**: Asks for confirmation before overwriting existing directories  
✅ **Comprehensive**: Updates all file types (YAML, shell scripts, README files, etc.)  
✅ **Flexible**: Supports custom source and target registries  

## Basic Usage

### Copy config-local to config-cluster (Default)
```bash
python3 registry_switcher.py config-local config-cluster
```
This copies `config-local/` to `config-cluster/` and converts all `vcf-np-w2-harbor-az1.sunat.peru/agentes` references to `vcf-np-w2-harbor-az1.sunat.peru/agentes`.

### Process Existing Directory In-Place
```bash
python3 registry_switcher.py config-cluster --in-place
```
This processes an existing directory without copying.

### Custom Registries
```bash
python3 registry_switcher.py config-local config-cluster \
  --source localhost:8080 \
  --target my.registry.com/project
```

## What Gets Updated

The script updates registry URLs in:
- **YAML files**: `image:` references in Kubernetes manifests
- **Shell scripts**: Registry variables and image references  
- **README files**: Documentation references
- **Config files**: Any file containing registry URLs

## Example Transformation

**Before** (config-local):
```yaml
image: vcf-np-w2-harbor-az1.sunat.peru/agentes/register:latest
```

**After** (config-cluster):
```yaml
image: vcf-np-w2-harbor-az1.sunat.peru/agentes/register:latest
```

## Deployment Workflow

1. **Develop locally** using `config-local/` with `vcf-np-w2-harbor-az1.sunat.peru/agentes` registry
2. **Generate cluster config** using the registry switcher:
   ```bash
   python3 registry_switcher.py config-local config-cluster
   ```
3. **Deploy to cluster** using the generated `config-cluster/` files

## Safety Features

- ✅ Confirms before overwriting existing directories
- ✅ Skips binary files and archives (.tgz, .zip, etc.)
- ✅ Provides detailed summary of files processed
- ✅ Only modifies files that actually contain registry references

This makes it easy to maintain separate configurations for local development and cluster deployment!
