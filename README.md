## Helm Chart config merger

This helm chart helper function allows you to merge multiple dicts to keep configs for your multiple environments in one file and steer them wit `--set`.

## Testing

use `--set` with below parameters:
  - `env` for environment: Production, Staging, UAT or whatever you want
  - `region` for region: R1, R2, europewest, eastasia, antarctica
  - `zone` for zone, again, whatever name you want

### Example
`helm template . --set env=Production --set region=R1 --set zone=zone1 -f .\droid-brain.yaml`

## Values file

There are two files, `droid-brain.yaml` and `invoice-creator.yaml` that shows config options.