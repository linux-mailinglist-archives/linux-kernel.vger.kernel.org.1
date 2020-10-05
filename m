Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E5D2830A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgJEHNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:13:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:10318 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgJEHNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:13:38 -0400
IronPort-SDR: 50VTpTMovMNxbb68Vse6upuLt5keY80QjmqzCuGGsHdEQgKkCoVhDnUt1XyN/ZlzW7Tu+XTzAF
 LhYvJ+BECTJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="227479256"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="227479256"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 00:13:35 -0700
IronPort-SDR: ALAxdpZ2lk2a7hk11JblBXmJZW0mfBGUbml1HO5cfVM9tJcmj9p6FsW0aUgF4eTdwJqEujHfmG
 hkesVGibureA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="309718080"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Oct 2020 00:13:33 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 2/8] tracing: Add flag to control different traces
Date:   Mon,  5 Oct 2020 10:13:13 +0300
Message-Id: <20201005071319.78508-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005071319.78508-1-alexander.shishkin@linux.intel.com>
References: <20201005071319.78508-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

More traces like event trace or trace marker will be supported.
Add flag for difference traces, so that they can be controlled
separately. Move current function trace to it's own flag
instead of global ftrace enable flag.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 include/linux/trace.h |  5 +++++
 kernel/trace/trace.c  | 36 +++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index 36d255d66f88..c115a5d2269f 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -3,6 +3,9 @@
 #define _LINUX_TRACE_H
 
 #ifdef CONFIG_TRACING
+
+#define TRACE_EXPORT_FUNCTION	BIT(0)
+
 /*
  * The trace export - an export of Ftrace output. The trace_export
  * can process traces and export them to a registered destination as
@@ -15,10 +18,12 @@
  * next		- pointer to the next trace_export
  * write	- copy traces which have been delt with ->commit() to
  *		  the destination
+ * flags	- which ftrace to be exported
  */
 struct trace_export {
 	struct trace_export __rcu	*next;
 	void (*write)(struct trace_export *, const void *, unsigned int);
+	int flags;
 };
 
 int register_ftrace_export(struct trace_export *export);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f40d850ebabc..3ca121ad8728 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2744,33 +2744,37 @@ trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
 
 static void
 trace_process_export(struct trace_export *export,
-	       struct ring_buffer_event *event)
+	       struct ring_buffer_event *event, int flag)
 {
 	struct trace_entry *entry;
 	unsigned int size = 0;
 
-	entry = ring_buffer_event_data(event);
-	size = ring_buffer_event_length(event);
-	export->write(export, entry, size);
+	if (export->flags & flag) {
+		entry = ring_buffer_event_data(event);
+		size = ring_buffer_event_length(event);
+		export->write(export, entry, size);
+	}
 }
 
 static DEFINE_MUTEX(ftrace_export_lock);
 
 static struct trace_export __rcu *ftrace_exports_list __read_mostly;
 
-static DEFINE_STATIC_KEY_FALSE(ftrace_exports_enabled);
+static DEFINE_STATIC_KEY_FALSE(trace_function_exports_enabled);
 
-static inline void ftrace_exports_enable(void)
+static inline void ftrace_exports_enable(struct trace_export *export)
 {
-	static_branch_enable(&ftrace_exports_enabled);
+	if (export->flags & TRACE_EXPORT_FUNCTION)
+		static_branch_inc(&trace_function_exports_enabled);
 }
 
-static inline void ftrace_exports_disable(void)
+static inline void ftrace_exports_disable(struct trace_export *export)
 {
-	static_branch_disable(&ftrace_exports_enabled);
+	if (export->flags & TRACE_EXPORT_FUNCTION)
+		static_branch_dec(&trace_function_exports_enabled);
 }
 
-static void ftrace_exports(struct ring_buffer_event *event)
+static void ftrace_exports(struct ring_buffer_event *event, int flag)
 {
 	struct trace_export *export;
 
@@ -2778,7 +2782,7 @@ static void ftrace_exports(struct ring_buffer_event *event)
 
 	export = rcu_dereference_raw_check(ftrace_exports_list);
 	while (export) {
-		trace_process_export(export, event);
+		trace_process_export(export, event, flag);
 		export = rcu_dereference_raw_check(export->next);
 	}
 
@@ -2818,8 +2822,7 @@ rm_trace_export(struct trace_export **list, struct trace_export *export)
 static inline void
 add_ftrace_export(struct trace_export **list, struct trace_export *export)
 {
-	if (*list == NULL)
-		ftrace_exports_enable();
+	ftrace_exports_enable(export);
 
 	add_trace_export(list, export);
 }
@@ -2830,8 +2833,7 @@ rm_ftrace_export(struct trace_export **list, struct trace_export *export)
 	int ret;
 
 	ret = rm_trace_export(list, export);
-	if (*list == NULL)
-		ftrace_exports_disable();
+	ftrace_exports_disable(export);
 
 	return ret;
 }
@@ -2884,8 +2886,8 @@ trace_function(struct trace_array *tr,
 	entry->parent_ip		= parent_ip;
 
 	if (!call_filter_check_discard(call, entry, buffer, event)) {
-		if (static_branch_unlikely(&ftrace_exports_enabled))
-			ftrace_exports(event);
+		if (static_branch_unlikely(&trace_function_exports_enabled))
+			ftrace_exports(event, TRACE_EXPORT_FUNCTION);
 		__buffer_unlock_commit(buffer, event);
 	}
 }
-- 
2.28.0

