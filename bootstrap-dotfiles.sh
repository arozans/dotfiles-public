#!/bin/bash
# 
# Based on https://github.com/romkatv/dotfiles-public/blob/master/bin/bootstrap-dotfiles.sh
#
# Clones dotfiles-public and dotfiles-private from github. dotfiles-private is encrypted with git-remote-gcrypt. Requires `git`, git-remote-gcrypt, pgp keys set up and ssh
# keys for github.

set -xueEo pipefail

if [[ -z "${GITHUB_USERNAME:-}" ]]; then
  echo "ERROR: GITHUB_USERNAME not set" >&2
  exit 1
fi

if [[ -z "${PGP_DOTFILES_KEY:-}" ]]; then
  echo "ERROR: PGP_DOTFILES_KEY not set" >&2
  exit 1
fi

if [[ -z "${TARGET_BRANCH:-}" ]]; then
  echo "ERROR: TARGET_BRANCH set" >&2
  exit 1
fi


function clone_public_repo() {
  local repo=$1
  local git_dir="$HOME/.$repo"
  local uri="git@github.com:$GITHUB_USERNAME/$repo.git"

  if [[ -e "$git_dir" ]]; then
    return 0
  fi

  git --git-dir="$git_dir" init --initial-branch $TARGET_BRANCH 
  git --git-dir="$git_dir" config core.bare false
  git --git-dir="$git_dir" config status.showuntrackedfiles no
  git --git-dir="$git_dir" remote add origin "$uri"
  git --git-dir="$git_dir" fetch
  git --git-dir="$git_dir" reset origin/$TARGET_BRANCH
  git --git-dir="$git_dir" branch -u origin/$TARGET_BRANCH
  git --git-dir="$git_dir" checkout -- .
  git --git-dir="$git_dir" submodule update --init --recursive
}

function clone_private_repo() {
  local repo=$1
  local git_dir="$HOME/.$repo"
  local uri="git@github.com:$GITHUB_USERNAME/$repo.git"

  if [[ -e "$git_dir" ]]; then
    return 0
  fi

  git --git-dir="$git_dir" init --initial-branch $TARGET_BRANCH 
  git --git-dir="$git_dir" config core.bare false
  git --git-dir="$git_dir" config status.showuntrackedfiles no
  git --git-dir="$git_dir" remote add origin gcrypt::"$uri"
  git --git-dir="$git_dir" config remote.origin.gcrypt-participants "$PGP_DOTFILES_KEY"
  git --git-dir="$git_dir" fetch
  git --git-dir="$git_dir" reset origin/$TARGET_BRANCH
  git --git-dir="$git_dir" branch -u origin/$TARGET_BRANCH
  git --git-dir="$git_dir" checkout -- .
  git --git-dir="$git_dir" submodule update --init --recursive
}

if [[ "$(id -u)" == 0 ]]; then
  echo "bootstrap-dotfiles.sh: please run as non-root" >&2
  exit 1
fi

clone_public_repo dotfiles-public
clone_private_repo dotfiles-private

