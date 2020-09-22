Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC227380C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgIVB0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729534AbgIVBYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D886923ABA;
        Tue, 22 Sep 2020 01:24:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX34-001sJH-To; Mon, 21 Sep 2020 21:24:50 -0400
Message-ID: <20200922012450.804166879@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 06/26] tools/bootconfig: Add --init option for bconf2ftrace.sh
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since the ftrace current setting may conflict with the new setting
from bootconfig, add the --init option to initialize ftrace before
setting for bconf2ftrace.sh.

E.g.
 $ bconf2ftrace.sh --init boottrace.bconf

This initialization method copied from selftests/ftrace.

Link: https://lkml.kernel.org/r/159704853203.175360.17029578033994278231.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/scripts/bconf2ftrace.sh |  12 ++-
 tools/bootconfig/scripts/ftrace.sh       | 109 +++++++++++++++++++++++
 2 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 tools/bootconfig/scripts/ftrace.sh

diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
index a46e984fb2ff..595e164dc352 100755
--- a/tools/bootconfig/scripts/bconf2ftrace.sh
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -3,8 +3,9 @@
 
 usage() {
 	echo "Ftrace boottime trace test tool"
-	echo "Usage: $0 [--apply] [--debug] BOOTCONFIG-FILE"
+	echo "Usage: $0 [--apply|--init] [--debug] BOOTCONFIG-FILE"
 	echo "    --apply: Test actual apply to tracefs (need sudo)"
+	echo "    --init:  Initialize ftrace before applying (imply --apply)"
 	exit 1
 }
 
@@ -13,12 +14,16 @@ usage() {
 BCONF=
 DEBUG=
 APPLY=
+INIT=
 while [ x"$1" != x ]; do
 	case "$1" in
 	"--debug")
 		DEBUG=$1;;
 	"--apply")
 		APPLY=$1;;
+	"--init")
+		APPLY=$1
+		INIT=$1;;
 	*)
 		[ ! -f $1 ] && usage
 		BCONF=$1;;
@@ -57,6 +62,11 @@ if [ -z "$TRACEFS" ]; then
 	fi
 fi
 
+if [ x"$INIT" != x ]; then
+	. `dirname $0`/ftrace.sh
+	(cd $TRACEFS; initialize_ftrace)
+fi
+
 . `dirname $0`/xbc.sh
 
 ######## main #########
diff --git a/tools/bootconfig/scripts/ftrace.sh b/tools/bootconfig/scripts/ftrace.sh
new file mode 100644
index 000000000000..186eed923041
--- /dev/null
+++ b/tools/bootconfig/scripts/ftrace.sh
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+clear_trace() { # reset trace output
+    echo > trace
+}
+
+disable_tracing() { # stop trace recording
+    echo 0 > tracing_on
+}
+
+enable_tracing() { # start trace recording
+    echo 1 > tracing_on
+}
+
+reset_tracer() { # reset the current tracer
+    echo nop > current_tracer
+}
+
+reset_trigger_file() {
+    # remove action triggers first
+    grep -H ':on[^:]*(' $@ |
+    while read line; do
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" >> $file
+    done
+    grep -Hv ^# $@ |
+    while read line; do
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" > $file
+    done
+}
+
+reset_trigger() { # reset all current setting triggers
+    if [ -d events/synthetic ]; then
+        reset_trigger_file events/synthetic/*/trigger
+    fi
+    reset_trigger_file events/*/*/trigger
+}
+
+reset_events_filter() { # reset all current setting filters
+    grep -v ^none events/*/*/filter |
+    while read line; do
+	echo 0 > `echo $line | cut -f1 -d:`
+    done
+}
+
+reset_ftrace_filter() { # reset all triggers in set_ftrace_filter
+    if [ ! -f set_ftrace_filter ]; then
+      return 0
+    fi
+    echo > set_ftrace_filter
+    grep -v '^#' set_ftrace_filter | while read t; do
+	tr=`echo $t | cut -d: -f2`
+	if [ "$tr" = "" ]; then
+	    continue
+	fi
+	if ! grep -q "$t" set_ftrace_filter; then
+		continue;
+	fi
+	name=`echo $t | cut -d: -f1 | cut -d' ' -f1`
+	if [ $tr = "enable_event" -o $tr = "disable_event" ]; then
+	    tr=`echo $t | cut -d: -f2-4`
+	    limit=`echo $t | cut -d: -f5`
+	else
+	    tr=`echo $t | cut -d: -f2`
+	    limit=`echo $t | cut -d: -f3`
+	fi
+	if [ "$limit" != "unlimited" ]; then
+	    tr="$tr:$limit"
+	fi
+	echo "!$name:$tr" > set_ftrace_filter
+    done
+}
+
+disable_events() {
+    echo 0 > events/enable
+}
+
+clear_synthetic_events() { # reset all current synthetic events
+    grep -v ^# synthetic_events |
+    while read line; do
+        echo "!$line" >> synthetic_events
+    done
+}
+
+initialize_ftrace() { # Reset ftrace to initial-state
+# As the initial state, ftrace will be set to nop tracer,
+# no events, no triggers, no filters, no function filters,
+# no probes, and tracing on.
+    disable_tracing
+    reset_tracer
+    reset_trigger
+    reset_events_filter
+    reset_ftrace_filter
+    disable_events
+    [ -f set_event_pid ] && echo > set_event_pid
+    [ -f set_ftrace_pid ] && echo > set_ftrace_pid
+    [ -f set_ftrace_notrace ] && echo > set_ftrace_notrace
+    [ -f set_graph_function ] && echo | tee set_graph_*
+    [ -f stack_trace_filter ] && echo > stack_trace_filter
+    [ -f kprobe_events ] && echo > kprobe_events
+    [ -f uprobe_events ] && echo > uprobe_events
+    [ -f synthetic_events ] && echo > synthetic_events
+    [ -f snapshot ] && echo 0 > snapshot
+    clear_trace
+    enable_tracing
+}
-- 
2.28.0


