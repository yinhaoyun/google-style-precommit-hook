A handy [pre-commit](http://pre-commit.com/) hook which will run Google's java
code style formatter for you on your code!

# Installation of pre-commit
```bash
pip install pre-commit
pre-commit --version # check installed version
```

# Usage

```bash
cd git_workspace # Enter your workspace of code
pre-commit install # to set up the git hook scripts
pre-commit sample-config > .pre-commit-config.yaml # Generate basic config
```

Then append following to `.pre-commit-config.yaml` (At end of the config file)

```yaml
repos:
-   repo: https://github.com/yinhaoyun/google-style-precommit-hook
    rev: 909297438a038e795db596ffcb408d2891b6d096
    hooks:
    -   id: google-style-java
```

*Note*: this file stores Google's code style formatter jar in a `.cache/`
directory so that it doesn't need to be re-downloaded each time.  You will
probably want to add `.cache/` to the `.gitignore` file of the project which
uses this hook.
