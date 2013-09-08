#!/usr/bin/env python2
# Author: cybojanek :-)
# Makefile dependency graph generator
import pygraphviz
import subprocess
import sys

extension_color_map = {
    ".h": "#EF9B16",
    ".c": "#69980E",
    ".o": "#336AD0",
    ".so": "#9F7B00",
    ".a": "#64410A",
}

def get_color(n):
    ext = n.split('.')[-1]
    color = extension_color_map.get(".%s" % ext, "#FFFFFF")
    return color

if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.stderr.write("Pipe 'make -d --dry-run' outout to stdin and, %s "
                         "OUTFILE.png\n" % sys.argv[0])
    # Strip whitespace from right
    lines = [x.rstrip() for x in sys.stdin.readlines()]
    # Level stack
    levels = [-1]
    # Target stack
    targets = [""]
    # Dependency map
    target_map = {"": set()}

    for line in lines:
        # Get level based on whitespace on the left
        level, line = len(line) - len(line.lstrip()), line.lstrip()
        if line.startswith("Considering target file") or line.startswith("Pruning file"):  # New target
            target = line.split('`')[1][0:-2]
            if level > levels[-1]:  # Child
                # Add ourselves to our parent
                target_map[targets[-1]].add(target)
                # Make ourselves the new parent
                targets.append(target)
                # Update level
                levels.append(level)
                # Add ourself to the target_map for children
                if target not in target_map:
                    target_map[target] = set()
            elif level < levels[-1]:  # New parent
                # Go back up
                while levels[-1] >= level:
                    # Go down a level
                    levels.pop()
                    # Pop off old level child
                    targets.pop()
                # Add ourselves to parent
                target_map[targets[-1]].add(target)
                # Make ourselves the new parent
                targets.append(target)
                # Add our level
                levels.append(level)
                # Add ourself to the target_map
                if target not in target_map:
                    target_map[target] = set()
                #targets.append(target)
            elif level == levels[-1]:  # Sibling
                # Remove neighbor
                targets.pop()
                # Add ourselves to parent
                target_map[targets[-1]].add(target)
                # Make ourselves the new parent
                targets.append(target)
                # Add ourself to the target_map
                if target not in target_map:
                    target_map[target] = set()
        # Sanity check
        assert len(targets) == len(levels)

    # Generate graph
    g = pygraphviz.AGraph(strict=True, directed=True)
    g.node_attr['style'] = 'filled'

    for key, values in target_map.iteritems():
        # Special handle for root, being ""
        if key == "":
            for node in values:
                g.add_node(node, fillcolor=get_color(node))
        else:
            # Add all nodes first to have them colorized
            for n in [key] + [v for v in values]:
                g.add_node(n, fillcolor=get_color(n))
            # Now make all edges
            for node in values:
                g.add_edge(key, node)
    g.draw(sys.argv[1], prog='dot')
