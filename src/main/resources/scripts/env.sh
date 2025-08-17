#!/bin/bash
set -e

# Application name from Dockerfile ARG
export EXPORT_DIR="/SavedExportDir"

mkdir -p $EXPORT_DIR

# Path to SymmetricDS
export SYM_HOME="/symmetricds"
export PATH=$PATH:$SYM_HOME/bin

# JDBC drivers
export CLASSPATH=$SYM_HOME/lib/*

# H2 Docker container access
export H2_JDBC="jdbc:h2:mem:db"
