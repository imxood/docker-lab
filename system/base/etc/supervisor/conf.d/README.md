# Child configuration for supervisord

## Requirements

In `dockerfiles/Dockerfile.$FEATURE`:

```
ADD startup.aux/$FEATURE/xxx.conf /etc/supervisor/conf.d/
```
