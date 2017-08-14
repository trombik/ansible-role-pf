# ansible-role-pf

Configure pf firewall

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `pf_conf` | path to `pf.conf(5)` | `/etc/pf.conf` |
| `pf_conf_dir` | directory where additional `pf.conf(5)` fragments can be placed. the role does not do anything with it but create the directory.| `/etc/pf.conf.d` |
| `pf_rule` | see below | |

## `pf_rule`

By default, the following `pf(4)` rules are created.

* skip on lo
* block everything by default
* pass all icmp and ssh to the host
* pass all from the host to any

The default value of `pf_rule` is:

```
set skip on { lo }
block log all
pass in  proto icmp from any to any
pass in  proto tcp from any to any port 22
pass out on egress from (egress) to any
```
# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-pf
  vars:
    pf_rule: |
      set skip on lo

      block return    # block stateless traffic
      pass            # establish keep-state

      # By default, do not permit remote connections to X11
      block return in on ! lo0 proto tcp to port 6000:6010
```

# License

```
Copyright (c) 2016 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [ansible-role-init](https://gist.github.com/trombik/d01e280f02c78618429e334d8e4995c0)
