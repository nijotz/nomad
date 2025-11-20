git_bin=$(command -v git)
if [[ -z $git_bin ]]; then
    echo "git command not found; skipping nomad check"
fi

pushd ~/.nomad > /dev/null
if [[ $(git status --porcelain) ]]; then
    echo "[WARNING] Uncommited changes in nomad"
fi
popd > /dev/null
