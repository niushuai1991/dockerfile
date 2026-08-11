#!/bin/bash


# Check if the POETRY_PYPI_URL environment variable is set
if [ -n "$POETRY_PYPI_URL" ]; then
    echo "Configuring Poetry to use mirror source: $POETRY_PYPI_URL"
    poetry config repositories.pypi "$POETRY_PYPI_URL"
else
    echo "POETRY_PYPI_URL is not set, using the default PyPI source"
fi

echo "Installing dependencies..."
poetry install --project=/opt/marker
if [ $? -ne 0 ]; then
    echo "Error: 'poetry install' failed."
    exit 1
fi
#rm -rf /root/.cache/pypoetry/

nohup /opt/monitor_marker.sh > /var/log/monitor_marker.log 2>&1 &
echo "Starting the service..."
exec python /opt/marker/marker_server.py --host 0.0.0.0 --port 80

