Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C632737FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgIVBZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729540AbgIVBYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34AC623A9A;
        Tue, 22 Sep 2020 01:24:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX35-001sKF-8C; Mon, 21 Sep 2020 21:24:51 -0400
Message-ID: <20200922012451.106065172@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [for-next][PATCH 08/26] tracing: make tracing_init_dentry() returns an integer instead of a
 d_entry pointer
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@linux.alibaba.com>

Current tracing_init_dentry() return a d_entry pointer, while is not
necessary. This function returns NULL on success or error on failure,
which means there is no valid d_entry pointer return.

Let's return 0 on success and negative value for error.

Link: https://lkml.kernel.org/r/20200712011036.70948-5-richard.weiyang@linux.alibaba.com

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c                 | 36 ++++++++++++++--------------
 kernel/trace/trace.h                 |  2 +-
 kernel/trace/trace_dynevent.c        |  8 +++----
 kernel/trace/trace_events_synth.c    |  9 +++----
 kernel/trace/trace_functions_graph.c |  8 +++----
 kernel/trace/trace_hwlat.c           |  8 +++----
 kernel/trace/trace_kprobe.c          | 10 ++++----
 kernel/trace/trace_printk.c          |  8 +++----
 kernel/trace/trace_stack.c           | 12 +++++-----
 kernel/trace/trace_stat.c            |  8 +++----
 kernel/trace/trace_uprobe.c          |  9 ++++---
 11 files changed, 57 insertions(+), 61 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c26345e83..29a9034b38d0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8971,21 +8971,21 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
  * directory. It is called via fs_initcall() by any of the boot up code
  * and expects to return the dentry of the top level tracing directory.
  */
-struct dentry *tracing_init_dentry(void)
+int tracing_init_dentry(void)
 {
 	struct trace_array *tr = &global_trace;
 
 	if (security_locked_down(LOCKDOWN_TRACEFS)) {
 		pr_warn("Tracing disabled due to lockdown\n");
-		return ERR_PTR(-EPERM);
+		return -EPERM;
 	}
 
 	/* The top level trace array uses  NULL as parent */
 	if (tr->dir)
-		return NULL;
+		return 0;
 
 	if (WARN_ON(!tracefs_initialized()))
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 
 	/*
 	 * As there may still be users that expect the tracing
@@ -8996,7 +8996,7 @@ struct dentry *tracing_init_dentry(void)
 	tr->dir = debugfs_create_automount("tracing", NULL,
 					   trace_automount, NULL);
 
-	return NULL;
+	return 0;
 }
 
 extern struct trace_eval_map *__start_ftrace_eval_maps[];
@@ -9083,48 +9083,48 @@ static struct notifier_block trace_module_nb = {
 
 static __init int tracer_init_tracefs(void)
 {
-	struct dentry *d_tracer;
+	int ret;
 
 	trace_access_lock_init();
 
-	d_tracer = tracing_init_dentry();
-	if (IS_ERR(d_tracer))
+	ret = tracing_init_dentry();
+	if (ret)
 		return 0;
 
 	event_trace_init();
 
-	init_tracer_tracefs(&global_trace, d_tracer);
-	ftrace_init_tracefs_toplevel(&global_trace, d_tracer);
+	init_tracer_tracefs(&global_trace, NULL);
+	ftrace_init_tracefs_toplevel(&global_trace, NULL);
 
-	trace_create_file("tracing_thresh", 0644, d_tracer,
+	trace_create_file("tracing_thresh", 0644, NULL,
 			&global_trace, &tracing_thresh_fops);
 
-	trace_create_file("README", 0444, d_tracer,
+	trace_create_file("README", 0444, NULL,
 			NULL, &tracing_readme_fops);
 
-	trace_create_file("saved_cmdlines", 0444, d_tracer,
+	trace_create_file("saved_cmdlines", 0444, NULL,
 			NULL, &tracing_saved_cmdlines_fops);
 
-	trace_create_file("saved_cmdlines_size", 0644, d_tracer,
+	trace_create_file("saved_cmdlines_size", 0644, NULL,
 			  NULL, &tracing_saved_cmdlines_size_fops);
 
-	trace_create_file("saved_tgids", 0444, d_tracer,
+	trace_create_file("saved_tgids", 0444, NULL,
 			NULL, &tracing_saved_tgids_fops);
 
 	trace_eval_init();
 
-	trace_create_eval_file(d_tracer);
+	trace_create_eval_file(NULL);
 
 #ifdef CONFIG_MODULES
 	register_module_notifier(&trace_module_nb);
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-	trace_create_file("dyn_ftrace_total_info", 0444, d_tracer,
+	trace_create_file("dyn_ftrace_total_info", 0444, NULL,
 			NULL, &tracing_dyn_info_fops);
 #endif
 
-	create_trace_instances(d_tracer);
+	create_trace_instances(NULL);
 
 	update_tracer_options(&global_trace);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 610d21355526..0d3a405fe446 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -737,7 +737,7 @@ struct dentry *trace_create_file(const char *name,
 				 void *data,
 				 const struct file_operations *fops);
 
-struct dentry *tracing_init_dentry(void);
+int tracing_init_dentry(void);
 
 struct ring_buffer_event;
 
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 9f2e8520b748..9442a9bb080e 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -206,14 +206,14 @@ static const struct file_operations dynamic_events_ops = {
 /* Make a tracefs interface for controlling dynamic events */
 static __init int init_dynamic_event(void)
 {
-	struct dentry *d_tracer;
 	struct dentry *entry;
+	int ret;
 
-	d_tracer = tracing_init_dentry();
-	if (IS_ERR(d_tracer))
+	ret = tracing_init_dentry();
+	if (ret)
 		return 0;
 
-	entry = tracefs_create_file("dynamic_events", 0644, d_tracer,
+	entry = tracefs_create_file("dynamic_events", 0644, NULL,
 				    NULL, &dynamic_events_ops);
 
 	/* Event list interface */
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index c6cca0d1d584..f86a2aa0bccd 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1757,7 +1757,6 @@ static const struct file_operations synth_events_fops = {
 static __init int trace_events_synth_init(void)
 {
 	struct dentry *entry = NULL;
-	struct dentry *d_tracer;
 	int err = 0;
 
 	err = dyn_event_register(&synth_event_ops);
@@ -1766,13 +1765,11 @@ static __init int trace_events_synth_init(void)
 		return err;
 	}
 
-	d_tracer = tracing_init_dentry();
-	if (IS_ERR(d_tracer)) {
-		err = PTR_ERR(d_tracer);
+	err = tracing_init_dentry();
+	if (err)
 		goto err;
-	}
 
-	entry = tracefs_create_file("synthetic_events", 0644, d_tracer,
+	entry = tracefs_create_file("synthetic_events", 0644, NULL,
 				    NULL, &synth_events_fops);
 	if (!entry) {
 		err = -ENODEV;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 4a9c49c08ec9..60d66278aa0d 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1336,13 +1336,13 @@ static const struct file_operations graph_depth_fops = {
 
 static __init int init_graph_tracefs(void)
 {
-	struct dentry *d_tracer;
+	int ret;
 
-	d_tracer = tracing_init_dentry();
-	if (IS_ERR(d_tracer))
+	ret = tracing_init_dentry();
+	if (ret)
 		return 0;
 
-	trace_create_file("max_graph_depth", 0644, d_tracer,
+	trace_create_file("max_graph_depth", 0644, NULL,
 			  NULL, &graph_depth_fops);
 
 	return 0;
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 17873e5d0353..c9ad5c6fbaad 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -538,14 +538,14 @@ static const struct file_operations window_fops = {
  */
 static int init_tracefs(void)
 {
-	struct dentry *d_tracer;
+	int ret;
 	struct dentry *top_dir;
 
-	d_tracer = tracing_init_dentry();
-	if (IS_ERR(d_tracer))
+	ret = tracing_init_dentry();
+	if (ret)
 		return -ENOMEM;
 
-	top_dir = tracefs_create_dir("hwlat_detector", d_tracer);
+	top_dir = tracefs_create_dir("hwlat_detector", NULL);
 	if (!top_dir)
 		return -ENOMEM;
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index aefb6065b508..feca9b19cd74 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1901,14 +1901,14 @@ subsys_initcall(init_kprobe_trace_early);
 /* Make a tracefs interface for controlling probe points */
 static __init int init_kprobe_trace(void)
 {
-	struct dentry *d_tracer;
+	int ret;
 	struct dentry *entry;
 
-	d_tracer = tracing_init_dentry();
-	if (IS_ERR(d_tracer))
+	ret = tracing_init_dentry();
+	if (ret)
 		return 0;
 
-	entry = tracefs_create_file("kprobe_events", 0644, d_tracer,
+	entry = tracefs_create_file("kprobe_events", 0644, NULL,
 				    NULL, &kprobe_events_ops);
 
 	/* Event list interface */
@@ -1916,7 +1916,7 @@ static __init int init_kprobe_trace(void)
 		pr_warn("Could not create tracefs 'kprobe_events' entry\n");
 
 	/* Profile interface */
-	entry = tracefs_create_file("kprobe_profile", 0444, d_tracer,
+	entry = tracefs_create_file("kprobe_profile", 0444, NULL,
 				    NULL, &kprobe_profile_ops);
 
 	if (!entry)
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index d4e31e969206..71b2e0fdc3e0 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -367,13 +367,13 @@ static const struct file_operations ftrace_formats_fops = {
 
 static __init int init_trace_printk_function_export(void)
 {
-	struct dentry *d_tracer;
+	int ret;
 
-	d_tracer = tracing_init_dentry();
-	if (IS_ERR(d_tracer))
+	ret = tracing_init_dentry();
+	if (ret)
 		return 0;
 
-	trace_create_file("printk_formats", 0444, d_tracer,
+	trace_create_file("printk_formats", 0444, NULL,
 				    NULL, &ftrace_formats_fops);
 
 	return 0;
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 98bba4764c52..c408423e5d65 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -554,20 +554,20 @@ __setup("stacktrace", enable_stacktrace);
 
 static __init int stack_trace_init(void)
 {
-	struct dentry *d_tracer;
+	int ret;
 
-	d_tracer = tracing_init_dentry();
-	if (IS_ERR(d_tracer))
+	ret = tracing_init_dentry();
+	if (ret)
 		return 0;
 
-	trace_create_file("stack_max_size", 0644, d_tracer,
+	trace_create_file("stack_max_size", 0644, NULL,
 			&stack_trace_max_size, &stack_max_size_fops);
 
-	trace_create_file("stack_trace", 0444, d_tracer,
+	trace_create_file("stack_trace", 0444, NULL,
 			NULL, &stack_trace_fops);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-	trace_create_file("stack_trace_filter", 0644, d_tracer,
+	trace_create_file("stack_trace_filter", 0644, NULL,
 			  &trace_ops, &stack_trace_filter_fops);
 #endif
 
diff --git a/kernel/trace/trace_stat.c b/kernel/trace/trace_stat.c
index d1fa19773cc8..8d141c3825a9 100644
--- a/kernel/trace/trace_stat.c
+++ b/kernel/trace/trace_stat.c
@@ -276,13 +276,13 @@ static const struct file_operations tracing_stat_fops = {
 
 static int tracing_stat_init(void)
 {
-	struct dentry *d_tracing;
+	int ret;
 
-	d_tracing = tracing_init_dentry();
-	if (IS_ERR(d_tracing))
+	ret = tracing_init_dentry();
+	if (ret)
 		return -ENODEV;
 
-	stat_dir = tracefs_create_dir("trace_stat", d_tracing);
+	stat_dir = tracefs_create_dir("trace_stat", NULL);
 	if (!stat_dir) {
 		pr_warn("Could not create tracefs 'trace_stat' entry\n");
 		return -ENOMEM;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f4286c9bdeb4..56729c6b6614 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1625,21 +1625,20 @@ void destroy_local_trace_uprobe(struct trace_event_call *event_call)
 /* Make a trace interface for controling probe points */
 static __init int init_uprobe_trace(void)
 {
-	struct dentry *d_tracer;
 	int ret;
 
 	ret = dyn_event_register(&trace_uprobe_ops);
 	if (ret)
 		return ret;
 
-	d_tracer = tracing_init_dentry();
-	if (IS_ERR(d_tracer))
+	ret = tracing_init_dentry();
+	if (ret)
 		return 0;
 
-	trace_create_file("uprobe_events", 0644, d_tracer,
+	trace_create_file("uprobe_events", 0644, NULL,
 				    NULL, &uprobe_events_ops);
 	/* Profile interface */
-	trace_create_file("uprobe_profile", 0444, d_tracer,
+	trace_create_file("uprobe_profile", 0444, NULL,
 				    NULL, &uprobe_profile_ops);
 	return 0;
 }
-- 
2.28.0


