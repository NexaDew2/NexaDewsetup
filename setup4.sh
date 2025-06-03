#!/bin/bash
set -e

component=$1

if [ -z "$component" ]; then
  echo "❌ Error: Component name is required."
  exit 1
fi

BASE_DIR="./src/components"
COMPONENT_DIR="$BASE_DIR/$component"

mkdir -p "$COMPONENT_DIR"

cat > "$COMPONENT_DIR/$component.jsx" <<EOF
import React from 'react';

const $component = () => {
  return (
    <div>
      $component Component
    </div>
  );
};

export default $component;
EOF

cat > "$COMPONENT_DIR/$component.test.jsx" <<EOF
import React from 'react';
import { render, screen } from '@testing-library/react';
import $component from './$component';

test('renders $component', () => {
  render(<$component />);
  expect(screen.getByText('$component Component')).toBeInTheDocument();
});
EOF

cat > "$COMPONENT_DIR/$component.stories.jsx" <<EOF
import React from 'react';
import $component from './$component';

export default {
  title: '$component',
  component: $component,
};

export const Default = () => <$component />;
EOF

cat > "$COMPONENT_DIR/README.md" <<EOF
# $component

React component for **$component**.

## Usage

\`\`\`jsx
import $component from './$component';

<$component />
\`\`\`
EOF

echo "✅ Component $component created with all files in $COMPONENT_DIR"
