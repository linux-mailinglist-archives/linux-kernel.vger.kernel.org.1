Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53FF2737E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgIVBZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbgIVBYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4727123AA7;
        Tue, 22 Sep 2020 01:24:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX37-001sR2-Ar; Mon, 21 Sep 2020 21:24:53 -0400
Message-ID: <20200922012453.211330313@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 22/26] tracing: Define event fields early stage
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Define event fields at early stage so that boot-time tracing can
access the event fields (like per-event filter setting).

Link: https://lkml.kernel.org/r/159974152862.478751.2023768466808361350.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 92 ++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 37 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ee25d849ebba..8e87fbab6930 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2123,12 +2123,48 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	return NULL;
 }
 
+static int
+event_define_fields(struct trace_event_call *call)
+{
+	struct list_head *head;
+	int ret = 0;
+
+	/*
+	 * Other events may have the same class. Only update
+	 * the fields if they are not already defined.
+	 */
+	head = trace_get_fields(call);
+	if (list_empty(head)) {
+		struct trace_event_fields *field = call->class->fields_array;
+		unsigned int offset = sizeof(struct trace_entry);
+
+		for (; field->type; field++) {
+			if (field->type == TRACE_FUNCTION_TYPE) {
+				field->define_fields(call);
+				break;
+			}
+
+			offset = ALIGN(offset, field->align);
+			ret = trace_define_field(call, field->type, field->name,
+						 offset, field->size,
+						 field->is_signed, field->filter_type);
+			if (WARN_ON_ONCE(ret)) {
+				pr_err("error code is %d\n", ret);
+				break;
+			}
+
+			offset += field->size;
+		}
+	}
+
+	return ret;
+}
+
 static int
 event_create_dir(struct dentry *parent, struct trace_event_file *file)
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
-	struct list_head *head;
 	struct dentry *d_events;
 	const char *name;
 	int ret;
@@ -2162,35 +2198,10 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 				  &ftrace_event_id_fops);
 #endif
 
-	/*
-	 * Other events may have the same class. Only update
-	 * the fields if they are not already defined.
-	 */
-	head = trace_get_fields(call);
-	if (list_empty(head)) {
-		struct trace_event_fields *field = call->class->fields_array;
-		unsigned int offset = sizeof(struct trace_entry);
-
-		for (; field->type; field++) {
-			if (field->type == TRACE_FUNCTION_TYPE) {
-				ret = field->define_fields(call);
-				break;
-			}
-
-			offset = ALIGN(offset, field->align);
-			ret = trace_define_field(call, field->type, field->name,
-						 offset, field->size,
-						 field->is_signed, field->filter_type);
-			if (ret)
-				break;
-
-			offset += field->size;
-		}
-		if (ret < 0) {
-			pr_warn("Could not initialize trace point events/%s\n",
-				name);
-			return -1;
-		}
+	ret = event_define_fields(call);
+	if (ret < 0) {
+		pr_warn("Could not initialize trace point events/%s\n", name);
+		return ret;
 	}
 
 	/*
@@ -2493,7 +2504,7 @@ __trace_early_add_new_event(struct trace_event_call *call,
 	if (!file)
 		return -ENOMEM;
 
-	return 0;
+	return event_define_fields(call);
 }
 
 struct ftrace_module_file_ops;
@@ -3431,6 +3442,18 @@ static __init int event_trace_enable_again(void)
 
 early_initcall(event_trace_enable_again);
 
+/* Init fields which doesn't related to the tracefs */
+static __init int event_trace_init_fields(void)
+{
+	if (trace_define_generic_fields())
+		pr_warn("tracing: Failed to allocated generic fields");
+
+	if (trace_define_common_fields())
+		pr_warn("tracing: Failed to allocate common fields");
+
+	return 0;
+}
+
 __init int event_trace_init(void)
 {
 	struct trace_array *tr;
@@ -3446,12 +3469,6 @@ __init int event_trace_init(void)
 	if (!entry)
 		pr_warn("Could not create tracefs 'available_events' entry\n");
 
-	if (trace_define_generic_fields())
-		pr_warn("tracing: Failed to allocated generic fields");
-
-	if (trace_define_common_fields())
-		pr_warn("tracing: Failed to allocate common fields");
-
 	ret = early_event_add_tracer(NULL, tr);
 	if (ret)
 		return ret;
@@ -3469,6 +3486,7 @@ void __init trace_event_init(void)
 	event_trace_memsetup();
 	init_ftrace_syscalls();
 	event_trace_enable();
+	event_trace_init_fields();
 }
 
 #ifdef CONFIG_EVENT_TRACE_STARTUP_TEST
-- 
2.28.0


