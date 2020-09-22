Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A6E2737E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgIVBZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgIVBYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F029023AFB;
        Tue, 22 Sep 2020 01:24:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX37-001sQ4-0v; Mon, 21 Sep 2020 21:24:53 -0400
Message-ID: <20200922012452.912476978@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 20/26] selftests/ftrace: Add %return suffix tests
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add kprobe %return suffix testcase and syntax error tests
for %return suffix.

Link: https://lkml.kernel.org/r/159972817653.428528.9180599115849301184.stgit@devnote2

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../test.d/kprobe/kprobe_syntax_errors.tc     |  6 ++++++
 .../test.d/kprobe/kretprobe_return_suffix.tc  | 21 +++++++++++++++++++
 .../test.d/kprobe/uprobe_syntax_errors.tc     |  6 ++++++
 3 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_return_suffix.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index b4d834675e59..56b3f36c722b 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -97,4 +97,10 @@ check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
 check_error '^p:kprobes/testevent _do_fork abcd=\1'	# SAME_PROBE
 fi
 
+# %return suffix errors
+if grep -q "place (kretprobe): .*%return.*" README; then
+check_error 'p vfs_read^%hoge'		# BAD_ADDR_SUFFIX
+check_error 'p ^vfs_read+10%return'	# BAD_RETPROBE
+fi
+
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_return_suffix.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_return_suffix.tc
new file mode 100644
index 000000000000..f07bd15cc033
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_return_suffix.tc
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kretprobe %%return suffix test
+# requires: kprobe_events '<symbol>[+<offset>]%return':README
+
+# Test for kretprobe by "r"
+echo 'r:myprobeaccept vfs_read' > kprobe_events
+RESULT1=`cat kprobe_events`
+
+# Test for kretprobe by "%return"
+echo 'p:myprobeaccept vfs_read%return' > kprobe_events
+RESULT2=`cat kprobe_events`
+
+if [ "$RESULT1" != "$RESULT2" ]; then
+	echo "Error: %return suffix didn't make a return probe."
+	echo "r-command: $RESULT1"
+	echo "%return: $RESULT2"
+	exit_fail
+fi
+
+echo > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
index 7b5b60c3c5a2..f5e3f9e4a01f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
@@ -17,4 +17,10 @@ check_error 'p /bin/sh:10(10)^a'	# BAD_REFCNT_SUFFIX
 check_error 'p /bin/sh:10 ^@+ab'	# BAD_FILE_OFFS
 check_error 'p /bin/sh:10 ^@symbol'	# SYM_ON_UPROBE
 
+# %return suffix error
+if grep -q "place (uprobe): .*%return.*" README; then
+check_error 'p /bin/sh:10^%hoge'	# BAD_ADDR_SUFFIX
+check_error 'p /bin/sh:10(10)^%return'	# BAD_REFCNT_SUFFIX
+fi
+
 exit 0
-- 
2.28.0


