Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D336B243239
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 03:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHMBq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 21:46:56 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:11293 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbgHMBqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 21:46:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597283215; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=TkFuY0ECli/sCKgYmNqUO1n0Jk8nvCqHM1OFgJ1hDxQ=; b=ewu1atPlt92naUAjsQxch6CCe/epvlkzDRaJrfynRHxc95Mip+quvie5W1I5cogX8yCLFJ4D
 3rfsX5nlqOcTN8e9YsSIvupLDeq5vmhwc40DMcnKJSENz0OCUfzpSi6B+Yel9skbrk7as/MU
 eIjbOWU87QqWhCzYSLDlBhToVUw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f349b621e4d3989d4264319 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 01:46:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B4235C433CA; Thu, 13 Aug 2020 01:46:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E70E5C433C6;
        Thu, 13 Aug 2020 01:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E70E5C433C6
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
Subject: [PATCH v3 2/6] tracing: add flag to control different traces
Date:   Thu, 13 Aug 2020 09:45:48 +0800
Message-Id: <20200813014552.23539-3-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200813014552.23539-1-tingwei@codeaurora.org>
References: <20200813014552.23539-1-tingwei@codeaurora.org>
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
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace.h |  5 +++++
 kernel/trace/trace.c  | 36 +++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index 7fd86d3c691f..bc93063dda39 100644
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

