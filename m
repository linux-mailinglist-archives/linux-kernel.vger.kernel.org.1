Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BAA2830B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgJEHOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:14:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:10318 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgJEHNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:13:40 -0400
IronPort-SDR: NUtZdXmjko/PnGTIQg6cqf1PU2Jnz05ced9F/dN0u0Xu2Xy/7Sx9OtR+lwsKWUrTlWRGfMBivr
 lzgh870hhNtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="227479261"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="227479261"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 00:13:37 -0700
IronPort-SDR: Tyc42IA/WWF7rQYGtYSTF0KxyyXhHtvFawmWxJD/2Fk/UHs3q6GCkqkwOx/XoOyb6umRFeCUs+
 qGy2xA3/BkKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="309718084"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Oct 2020 00:13:35 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 3/8] tracing: Add trace_export support for event trace
Date:   Mon,  5 Oct 2020 10:13:14 +0300
Message-Id: <20201005071319.78508-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005071319.78508-1-alexander.shishkin@linux.intel.com>
References: <20201005071319.78508-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

Only function traces can be exported to other destinations currently.
This patch exports event trace as well. Move trace export related
function to the beginning of file so other trace can call
trace_process_export() to export.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 include/linux/trace.h |   1 +
 kernel/trace/trace.c  | 259 ++++++++++++++++++++++--------------------
 2 files changed, 135 insertions(+), 125 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index c115a5d2269f..86033d214972 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -5,6 +5,7 @@
 #ifdef CONFIG_TRACING
 
 #define TRACE_EXPORT_FUNCTION	BIT(0)
+#define TRACE_EXPORT_EVENT	BIT(1)
 
 /*
  * The trace export - an export of Ftrace output. The trace_export
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3ca121ad8728..a40ee413123c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -251,6 +251,138 @@ unsigned long long ns2usecs(u64 nsec)
 	return nsec;
 }
 
+static void
+trace_process_export(struct trace_export *export,
+	       struct ring_buffer_event *event, int flag)
+{
+	struct trace_entry *entry;
+	unsigned int size = 0;
+
+	if (export->flags & flag) {
+		entry = ring_buffer_event_data(event);
+		size = ring_buffer_event_length(event);
+		export->write(export, entry, size);
+	}
+}
+
+static DEFINE_MUTEX(ftrace_export_lock);
+
+static struct trace_export __rcu *ftrace_exports_list __read_mostly;
+
+static DEFINE_STATIC_KEY_FALSE(trace_function_exports_enabled);
+static DEFINE_STATIC_KEY_FALSE(trace_event_exports_enabled);
+
+static inline void ftrace_exports_enable(struct trace_export *export)
+{
+	if (export->flags & TRACE_EXPORT_FUNCTION)
+		static_branch_inc(&trace_function_exports_enabled);
+
+	if (export->flags & TRACE_EXPORT_EVENT)
+		static_branch_inc(&trace_event_exports_enabled);
+}
+
+static inline void ftrace_exports_disable(struct trace_export *export)
+{
+	if (export->flags & TRACE_EXPORT_FUNCTION)
+		static_branch_dec(&trace_function_exports_enabled);
+
+	if (export->flags & TRACE_EXPORT_EVENT)
+		static_branch_dec(&trace_event_exports_enabled);
+}
+
+static void ftrace_exports(struct ring_buffer_event *event, int flag)
+{
+	struct trace_export *export;
+
+	preempt_disable_notrace();
+
+	export = rcu_dereference_raw_check(ftrace_exports_list);
+	while (export) {
+		trace_process_export(export, event, flag);
+		export = rcu_dereference_raw_check(export->next);
+	}
+
+	preempt_enable_notrace();
+}
+
+static inline void
+add_trace_export(struct trace_export **list, struct trace_export *export)
+{
+	rcu_assign_pointer(export->next, *list);
+	/*
+	 * We are entering export into the list but another
+	 * CPU might be walking that list. We need to make sure
+	 * the export->next pointer is valid before another CPU sees
+	 * the export pointer included into the list.
+	 */
+	rcu_assign_pointer(*list, export);
+}
+
+static inline int
+rm_trace_export(struct trace_export **list, struct trace_export *export)
+{
+	struct trace_export **p;
+
+	for (p = list; *p != NULL; p = &(*p)->next)
+		if (*p == export)
+			break;
+
+	if (*p != export)
+		return -1;
+
+	rcu_assign_pointer(*p, (*p)->next);
+
+	return 0;
+}
+
+static inline void
+add_ftrace_export(struct trace_export **list, struct trace_export *export)
+{
+	ftrace_exports_enable(export);
+
+	add_trace_export(list, export);
+}
+
+static inline int
+rm_ftrace_export(struct trace_export **list, struct trace_export *export)
+{
+	int ret;
+
+	ret = rm_trace_export(list, export);
+	ftrace_exports_disable(export);
+
+	return ret;
+}
+
+int register_ftrace_export(struct trace_export *export)
+{
+	if (WARN_ON_ONCE(!export->write))
+		return -1;
+
+	mutex_lock(&ftrace_export_lock);
+
+	add_ftrace_export(&ftrace_exports_list, export);
+
+	mutex_unlock(&ftrace_export_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_ftrace_export);
+
+int unregister_ftrace_export(struct trace_export *export)
+{
+	int ret;
+
+	mutex_lock(&ftrace_export_lock);
+
+	ret = rm_ftrace_export(&ftrace_exports_list, export);
+
+	mutex_unlock(&ftrace_export_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(unregister_ftrace_export);
+
 /* trace_flags holds trace_options default values */
 #define TRACE_DEFAULT_FLAGS						\
 	(FUNCTION_DEFAULT_FLAGS |					\
@@ -2699,6 +2831,8 @@ void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
 	if (static_key_false(&tracepoint_printk_key.key))
 		output_printk(fbuffer);
 
+	if (static_branch_unlikely(&trace_event_exports_enabled))
+		ftrace_exports(fbuffer->event, TRACE_EXPORT_EVENT);
 	event_trigger_unlock_commit_regs(fbuffer->trace_file, fbuffer->buffer,
 				    fbuffer->event, fbuffer->entry,
 				    fbuffer->flags, fbuffer->pc, fbuffer->regs);
@@ -2742,131 +2876,6 @@ trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
 	__buffer_unlock_commit(buffer, event);
 }
 
-static void
-trace_process_export(struct trace_export *export,
-	       struct ring_buffer_event *event, int flag)
-{
-	struct trace_entry *entry;
-	unsigned int size = 0;
-
-	if (export->flags & flag) {
-		entry = ring_buffer_event_data(event);
-		size = ring_buffer_event_length(event);
-		export->write(export, entry, size);
-	}
-}
-
-static DEFINE_MUTEX(ftrace_export_lock);
-
-static struct trace_export __rcu *ftrace_exports_list __read_mostly;
-
-static DEFINE_STATIC_KEY_FALSE(trace_function_exports_enabled);
-
-static inline void ftrace_exports_enable(struct trace_export *export)
-{
-	if (export->flags & TRACE_EXPORT_FUNCTION)
-		static_branch_inc(&trace_function_exports_enabled);
-}
-
-static inline void ftrace_exports_disable(struct trace_export *export)
-{
-	if (export->flags & TRACE_EXPORT_FUNCTION)
-		static_branch_dec(&trace_function_exports_enabled);
-}
-
-static void ftrace_exports(struct ring_buffer_event *event, int flag)
-{
-	struct trace_export *export;
-
-	preempt_disable_notrace();
-
-	export = rcu_dereference_raw_check(ftrace_exports_list);
-	while (export) {
-		trace_process_export(export, event, flag);
-		export = rcu_dereference_raw_check(export->next);
-	}
-
-	preempt_enable_notrace();
-}
-
-static inline void
-add_trace_export(struct trace_export **list, struct trace_export *export)
-{
-	rcu_assign_pointer(export->next, *list);
-	/*
-	 * We are entering export into the list but another
-	 * CPU might be walking that list. We need to make sure
-	 * the export->next pointer is valid before another CPU sees
-	 * the export pointer included into the list.
-	 */
-	rcu_assign_pointer(*list, export);
-}
-
-static inline int
-rm_trace_export(struct trace_export **list, struct trace_export *export)
-{
-	struct trace_export **p;
-
-	for (p = list; *p != NULL; p = &(*p)->next)
-		if (*p == export)
-			break;
-
-	if (*p != export)
-		return -1;
-
-	rcu_assign_pointer(*p, (*p)->next);
-
-	return 0;
-}
-
-static inline void
-add_ftrace_export(struct trace_export **list, struct trace_export *export)
-{
-	ftrace_exports_enable(export);
-
-	add_trace_export(list, export);
-}
-
-static inline int
-rm_ftrace_export(struct trace_export **list, struct trace_export *export)
-{
-	int ret;
-
-	ret = rm_trace_export(list, export);
-	ftrace_exports_disable(export);
-
-	return ret;
-}
-
-int register_ftrace_export(struct trace_export *export)
-{
-	if (WARN_ON_ONCE(!export->write))
-		return -1;
-
-	mutex_lock(&ftrace_export_lock);
-
-	add_ftrace_export(&ftrace_exports_list, export);
-
-	mutex_unlock(&ftrace_export_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(register_ftrace_export);
-
-int unregister_ftrace_export(struct trace_export *export)
-{
-	int ret;
-
-	mutex_lock(&ftrace_export_lock);
-
-	ret = rm_ftrace_export(&ftrace_exports_list, export);
-
-	mutex_unlock(&ftrace_export_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(unregister_ftrace_export);
-
 void
 trace_function(struct trace_array *tr,
 	       unsigned long ip, unsigned long parent_ip, unsigned long flags,
-- 
2.28.0

