Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17952737EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgIVBZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729599AbgIVBYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF14323B09;
        Tue, 22 Sep 2020 01:24:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX37-001sSU-P1; Mon, 21 Sep 2020 21:24:53 -0400
Message-ID: <20200922012453.653572248@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 25/26] tracing/boot, kprobe, synth: Initialize boot-time tracing earlier
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Initialize boot-time tracing in core_initcall_sync instead of
fs_initcall, and initialize required tracers (kprobes and synth)
in core_initcall. This will allow the boot-time tracing to trace
__init code from the beginning of postcore_initcall stage.

Link: https://lkml.kernel.org/r/159974155727.478751.7486926132902849578.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c         |  7 +++++--
 kernel/trace/trace_events_synth.c | 19 ++++++++++++++-----
 kernel/trace/trace_kprobe.c       |  6 +++---
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index d52d441a17e8..754e3cf2df3a 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -340,5 +340,8 @@ static int __init trace_boot_init(void)
 
 	return 0;
 }
-
-fs_initcall(trace_boot_init);
+/*
+ * Start tracing at the end of core-initcall, so that it starts tracing
+ * from the beginning of postcore_initcall.
+ */
+core_initcall_sync(trace_boot_init);
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 7c765e80e974..a9cd7793f7ea 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1754,17 +1754,26 @@ static const struct file_operations synth_events_fops = {
 	.release        = seq_release,
 };
 
-static __init int trace_events_synth_init(void)
+/*
+ * Register dynevent at core_initcall. This allows kernel to setup kprobe
+ * events in postcore_initcall without tracefs.
+ */
+static __init int trace_events_synth_init_early(void)
 {
-	struct dentry *entry = NULL;
 	int err = 0;
 
 	err = dyn_event_register(&synth_event_ops);
-	if (err) {
+	if (err)
 		pr_warn("Could not register synth_event_ops\n");
-		return err;
-	}
 
+	return err;
+}
+core_initcall(trace_events_synth_init_early);
+
+static __init int trace_events_synth_init(void)
+{
+	struct dentry *entry = NULL;
+	int err = 0;
 	err = tracing_init_dentry();
 	if (err)
 		goto err;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9d46415296eb..b911e9f6d9f5 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1897,8 +1897,8 @@ static __init void setup_boot_kprobe_events(void)
 }
 
 /*
- * Register dynevent at subsys_initcall. This allows kernel to setup kprobe
- * events in fs_initcall without tracefs.
+ * Register dynevent at core_initcall. This allows kernel to setup kprobe
+ * events in postcore_initcall without tracefs.
  */
 static __init int init_kprobe_trace_early(void)
 {
@@ -1913,7 +1913,7 @@ static __init int init_kprobe_trace_early(void)
 
 	return 0;
 }
-subsys_initcall(init_kprobe_trace_early);
+core_initcall(init_kprobe_trace_early);
 
 /* Make a tracefs interface for controlling probe points */
 static __init int init_kprobe_trace(void)
-- 
2.28.0


