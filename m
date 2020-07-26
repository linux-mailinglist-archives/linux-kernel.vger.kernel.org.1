Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C4822DB7C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 05:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgGZDAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 23:00:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36786 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgGZDAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 23:00:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595732411; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=s240h8o+7svk3PwI/1wlsxxe1upo7XaZCBBdE1l2a7I=; b=nl6KhHYZ7zpnwTSvYn7EdNE7T5i369LzOtbfwz8vCx3KVkngj9z3fCVn/ZFoXnxuNdSYs1+C
 xYHlMkHVe3ZY5R1IBvdt015SCi+y73QkAV9rVdPFuj2CchPf52aycGgMtMDw1Uo14sHvDO3b
 VeFhEtgJzIPgSf+HbwBbBqa1bec=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-west-2.postgun.com with SMTP id
 5f1cf1aa634c4259e342ff6c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 26 Jul 2020 02:59:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EFB85C43395; Sun, 26 Jul 2020 02:59:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9F8EC433C6;
        Sun, 26 Jul 2020 02:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9F8EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] tracing: add flag to control different traces
Date:   Sun, 26 Jul 2020 10:59:27 +0800
Message-Id: <20200726025931.30510-3-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200726025931.30510-1-tingwei@codeaurora.org>
References: <20200726025931.30510-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More traces like event trace or trace marker will be supported.
Add flag for difference traces, so that they can be controlled
separately. Move current function trace to it's own flag
instead of global ftrace enable flag.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
---
 include/linux/trace.h |  5 +++++
 kernel/trace/trace.c  | 36 +++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index 7fd86d3c691f..d2fdf9be84b5 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -3,6 +3,9 @@
 #define _LINUX_TRACE_H
 
 #ifdef CONFIG_TRACING
+
+#define TRACE_EXPORT_FUNCTION	BIT_ULL(0)
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
index bb62269724d5..8f1e66831e9e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2747,33 +2747,37 @@ trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
 
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
 
@@ -2781,7 +2785,7 @@ static void ftrace_exports(struct ring_buffer_event *event)
 
 	export = rcu_dereference_raw_check(ftrace_exports_list);
 	while (export) {
-		trace_process_export(export, event);
+		trace_process_export(export, event, flag);
 		export = rcu_dereference_raw_check(export->next);
 	}
 
@@ -2821,8 +2825,7 @@ rm_trace_export(struct trace_export **list, struct trace_export *export)
 static inline void
 add_ftrace_export(struct trace_export **list, struct trace_export *export)
 {
-	if (*list == NULL)
-		ftrace_exports_enable();
+	ftrace_exports_enable(export);
 
 	add_trace_export(list, export);
 }
@@ -2833,8 +2836,7 @@ rm_ftrace_export(struct trace_export **list, struct trace_export *export)
 	int ret;
 
 	ret = rm_trace_export(list, export);
-	if (*list == NULL)
-		ftrace_exports_disable();
+	ftrace_exports_disable(export);
 
 	return ret;
 }
@@ -2887,8 +2889,8 @@ trace_function(struct trace_array *tr,
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

