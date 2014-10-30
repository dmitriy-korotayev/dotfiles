typeset -A ENV_DEFAULTS
ENV_DEFAULTS=(
    VIM_LITE    false
)

for k in "${(@k)ENV_DEFAULTS}"; do
    [[ -z "${(P)k}" ]] && eval "export $k='$ENV_DEFAULTS[$k]'"
done


typeset -A ENV_VARS
ENV_VARS=(
)
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

for k in "${(@k)ENV_VARS}"; do
    [[ -z "${(P)k}" || -n "${(k)ENV_DEFAULTS[$k]}" ]] && eval "export $k='$ENV_VARS[$k]'"
done
