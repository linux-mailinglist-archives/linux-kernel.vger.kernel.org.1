Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF72324323A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 03:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgHMBrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 21:47:05 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:11293 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbgHMBrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 21:47:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597283223; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=HxCfYC2xv00tXAiLIPOETixrQkxjILsLd6JuWxta3aY=; b=SBBytNi528JS6TfisEDR7Z4mRZnC27KrhxbAZ7jUV1AuwZeyadpitwfhaRW1KYk7iV+dNlRP
 dFgHdywpNUrT5jWBfFH6tBj9c5Nt+TMgZArKIB+PREkvwcZ3nzu4vTzYcm1ceeQuMt9T/+qJ
 bMv2OzpTY3w/SDxy5d88NtAL5xg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f349b65c85a1092b0870081 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 01:46:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 49122C433C6; Thu, 13 Aug 2020 01:46:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EEB4C433AF;
        Thu, 13 Aug 2020 01:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EEB4C433AF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Subject: [PATCH v3 3/6] tracing: add trace_export support for event trace
Date:   Thu, 13 Aug 2020 09:45:49 +0800
Message-Id: <20200813014552.23539-4-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200813014552.23539-1-tingwei@codeaurora.org>
References: <20200813014552.23539-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only function traces can be exported to other destinations currently.
This patch exports event trace as well. Move trace export related
function to the beginning of file so other trace can call
trace_process_export() to export.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace.h |   1 +
 kernel/trace/trace.c  | 259 ++++++++++++++++++++++--------------------
 2 files changed, 135 insertions(+), 125 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index bc93063dda39..5a01eeffb254 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -5,6 +5,7 @@
 #ifdef CONFIG_TRACING
 
 #define TRACE_EXPORT_FUNCTION	BIT(0)
+#define TRACE_EXPORT_EVENT	BIT(1)
 
 /*
  * The trace export - an export of Ftrace output. The trace_export
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8f1e66831e9e..2f9302a8b322 100644
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
@@ -2702,6 +2834,8 @@ void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
 	if (static_key_false(&tracepoint_printk_key.key))
 		output_printk(fbuffer);
 
+	if (static_branch_unlikely(&trace_event_exports_enabled))
+		ftrace_exports(fbuffer->event, TRACE_EXPORT_EVENT);
 	event_trigger_unlock_commit_regs(fbuffer->trace_file, fbuffer->buffer,
 				    fbuffer->event, fbuffer->entry,
 				    fbuffer->flags, fbuffer->pc, fbuffer->regs);
@@ -2745,131 +2879,6 @@ trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

