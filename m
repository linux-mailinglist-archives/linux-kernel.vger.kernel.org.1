Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEC927380A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgIVB0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgIVBYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B84F723AA9;
        Tue, 22 Sep 2020 01:24:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX34-001sIn-P4; Mon, 21 Sep 2020 21:24:50 -0400
Message-ID: <20200922012450.653240048@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 05/26] tools/bootconfig: Add a script to generates bootconfig from ftrace
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a ftrace2bconf.sh under tools/bootconfig/scripts which generates
a bootconfig file from the current ftrace settings.

To read the ftrace settings, ftrace2bconf.sh requires the root
privilege (or sudo). The ftrace2bconf.sh will output the bootconfig
to stdout and error messages to stderr, so usually you'll run it as

 # ftrace2bconf.sh > ftrace.bconf

Note that some ftrace configurations are not supported. For example,
function-call/callgraph trace/notrace settings are not supported because
the wildcard has been expanded and lost in the ftrace anymore.

Link: https://lkml.kernel.org/r/159704852163.175360.16738029520293360558.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/scripts/ftrace2bconf.sh | 244 +++++++++++++++++++++++
 1 file changed, 244 insertions(+)
 create mode 100755 tools/bootconfig/scripts/ftrace2bconf.sh

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
new file mode 100755
index 000000000000..6c0d4b61e0c2
--- /dev/null
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -0,0 +1,244 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+usage() {
+	echo "Dump boot-time tracing bootconfig from ftrace"
+	echo "Usage: $0 [--debug] [ > BOOTCONFIG-FILE]"
+	exit 1
+}
+
+DEBUG=
+while [ x"$1" != x ]; do
+	case "$1" in
+	"--debug")
+		DEBUG=$1;;
+	-*)
+		usage
+		;;
+	esac
+	shift 1
+done
+
+if [ x"$DEBUG" != x ]; then
+	set -x
+fi
+
+TRACEFS=`grep -m 1 -w tracefs /proc/mounts | cut -f 2 -d " "`
+if [ -z "$TRACEFS" ]; then
+	if ! grep -wq debugfs /proc/mounts; then
+		echo "Error: No tracefs/debugfs was mounted."
+		exit 1
+	fi
+	TRACEFS=`grep -m 1 -w debugfs /proc/mounts | cut -f 2 -d " "`/tracing
+	if [ ! -d $TRACEFS ]; then
+		echo "Error: ftrace is not enabled on this kernel." 1>&2
+		exit 1
+	fi
+fi
+
+######## main #########
+
+set -e
+
+emit_kv() { # key =|+= value
+	echo "$@"
+}
+
+global_options() {
+	val=`cat $TRACEFS/max_graph_depth`
+	[ $val != 0 ] && emit_kv kernel.fgraph_max_depth = $val
+	if grep -qv "^#" $TRACEFS/set_graph_function $TRACEFS/set_graph_notrace ; then
+		cat 1>&2 << EOF
+# WARN: kernel.fgraph_filters and kernel.fgraph_notrace are not supported, since the wild card expression was expanded and lost from memory.
+EOF
+	fi
+}
+
+kprobe_event_options() {
+	cat $TRACEFS/kprobe_events | while read p args; do
+		case $p in
+		r*)
+		cat 1>&2 << EOF
+# WARN: A return probe found but it is not supported by bootconfig. Skip it.
+EOF
+		continue;;
+		esac
+		p=${p#*:}
+		event=${p#*/}
+		group=${p%/*}
+		if [ $group != "kprobes" ]; then
+			cat 1>&2 << EOF
+# WARN: kprobes group name $group is changed to "kprobes" for bootconfig.
+EOF
+		fi
+		emit_kv $PREFIX.event.kprobes.$event.probes += $args
+	done
+}
+
+synth_event_options() {
+	cat $TRACEFS/synthetic_events | while read event fields; do
+		emit_kv $PREFIX.event.synthetic.$event.fields = `echo $fields | sed "s/;/,/g"`
+	done
+}
+
+# Variables resolver
+DEFINED_VARS=
+UNRESOLVED_EVENTS=
+
+defined_vars() { # event-dir
+	grep "^hist" $1/trigger | grep -o ':[a-zA-Z0-9]*='
+}
+referred_vars() {
+	grep "^hist" $1/trigger | grep -o '$[a-zA-Z0-9]*'
+}
+
+per_event_options() { # event-dir
+	evdir=$1
+	# Check the special event which has no filter and no trigger
+	[ ! -f $evdir/filter ] && return
+
+	if grep -q "^hist:" $evdir/trigger; then
+		# hist action can refer the undefined variables
+		__vars=`defined_vars $evdir`
+		for v in `referred_vars $evdir`; do
+			if echo $DEFINED_VARS $__vars | grep -vqw ${v#$}; then
+				# $v is not defined yet, defer it
+				UNRESOLVED_EVENTS="$UNRESOLVED_EVENTS $evdir"
+				return;
+			fi
+		done
+		DEFINED_VARS="$DEFINED_VARS "`defined_vars $evdir`
+	fi
+	grep -v "^#" $evdir/trigger | while read action active; do
+		emit_kv $PREFIX.event.$group.$event.actions += \'$action\'
+	done
+
+	# enable is not checked; this is done by set_event in the instance.
+	val=`cat $evdir/filter`
+	if [ "$val" != "none" ]; then
+		emit_kv $PREFIX.event.$group.$event.filter = "$val"
+	fi
+}
+
+retry_unresolved() {
+	unresolved=$UNRESOLVED_EVENTS
+	UNRESOLVED_EVENTS=
+	for evdir in $unresolved; do
+		event=${evdir##*/}
+		group=${evdir%/*}; group=${group##*/}
+		per_event_options $evdir
+	done
+}
+
+event_options() {
+	# PREFIX and INSTANCE must be set
+	if [ $PREFIX = "ftrace" ]; then
+		# define the dynamic events
+		kprobe_event_options
+		synth_event_options
+	fi
+	for group in `ls $INSTANCE/events/` ; do
+		[ ! -d $INSTANCE/events/$group ] && continue
+		for event in `ls $INSTANCE/events/$group/` ;do
+			[ ! -d $INSTANCE/events/$group/$event ] && continue
+			per_event_options $INSTANCE/events/$group/$event
+		done
+	done
+	retry=0
+	while [ $retry -lt 3 ]; do
+		retry_unresolved
+		retry=$((retry + 1))
+	done
+	if [ "$UNRESOLVED_EVENTS" ]; then
+		cat 1>&2 << EOF
+! ERROR: hist triggers in $UNRESOLVED_EVENTS use some undefined variables.
+EOF
+	fi
+}
+
+is_default_trace_option() { # option
+grep -qw $1 << EOF
+print-parent
+nosym-offset
+nosym-addr
+noverbose
+noraw
+nohex
+nobin
+noblock
+trace_printk
+annotate
+nouserstacktrace
+nosym-userobj
+noprintk-msg-only
+context-info
+nolatency-format
+record-cmd
+norecord-tgid
+overwrite
+nodisable_on_free
+irq-info
+markers
+noevent-fork
+nopause-on-trace
+function-trace
+nofunction-fork
+nodisplay-graph
+nostacktrace
+notest_nop_accept
+notest_nop_refuse
+EOF
+}
+
+instance_options() { # [instance-name]
+	if [ $# -eq 0 ]; then
+		PREFIX="ftrace"
+		INSTANCE=$TRACEFS
+	else
+		PREFIX="ftrace.instance.$1"
+		INSTANCE=$TRACEFS/instances/$1
+	fi
+	val=
+	for i in `cat $INSTANCE/trace_options`; do
+		is_default_trace_option $i && continue
+		val="$val, $i"
+	done
+	[ "$val" ] && emit_kv $PREFIX.options = "${val#,}"
+	val="local"
+	for i in `cat $INSTANCE/trace_clock` ; do
+		[ "${i#*]}" ] && continue
+		i=${i%]}; val=${i#[}
+	done
+	[ $val != "local" ] && emit_kv $PREFIX.trace_clock = $val
+	val=`cat $INSTANCE/buffer_size_kb`
+	if echo $val | grep -vq "expanded" ; then
+		emit_kv $PREFIX.buffer_size = $val"KB"
+	fi
+	if grep -q "is allocated" $INSTANCE/snapshot ; then
+		emit_kv $PREFIX.alloc_snapshot
+	fi
+	val=`cat $INSTANCE/tracing_cpumask`
+	if [ `echo $val | sed -e s/f//g`x != x ]; then
+		emit_kv $PREFIX.cpumask = $val
+	fi
+
+	val=
+	for i in `cat $INSTANCE/set_event`; do
+		val="$val, $i"
+	done
+	[ "$val" ] && emit_kv $PREFIX.events = "${val#,}"
+	val=`cat $INSTANCE/current_tracer`
+	[ $val != nop ] && emit_kv $PREFIX.tracer = $val
+	if grep -qv "^#" $INSTANCE/set_ftrace_filter $INSTANCE/set_ftrace_notrace; then
+		cat 1>&2 << EOF
+# WARN: kernel.ftrace.filters and kernel.ftrace.notrace are not supported, since the wild card expression was expanded and lost from memory.
+EOF
+	fi
+	event_options
+}
+
+global_options
+instance_options
+for i in `ls $TRACEFS/instances` ; do
+	instance_options $i
+done
-- 
2.28.0


