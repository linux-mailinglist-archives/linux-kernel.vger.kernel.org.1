Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2D723E15C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 20:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgHFSqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 14:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgHFSqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:46:20 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 394FF20855;
        Thu,  6 Aug 2020 18:46:20 +0000 (UTC)
Date:   Thu, 6 Aug 2020 14:46:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Sean Paul <sean@poorly.run>
Subject: [PATCH v2] tracing: Add trace_array_init_printk() to initialize
 instance trace_printk() buffers
Message-ID: <20200806144618.4384a0f9@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As trace_array_printk() used with not global instances will not add noise to
the main buffer, they are OK to have in the kernel (unlike trace_printk()).
This require the subsystem to create their own tracing instance, and the
trace_array_printk() only writes into those instances.

Add trace_array_init_printk() to initialize the trace_printk() buffers
without printing out the WARNING message.

Reported-by: Sean Paul <sean@poorly.run>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes since v1:
  Added EXPORT_SYMBOL_GPL() to trace_array_init_printk() as it is
  required for another function that is exported.

 kernel/trace/trace.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 06c0feae5ff9..c5f822736261 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3129,6 +3129,9 @@ static int alloc_percpu_trace_buffer(void)
 {
 	struct trace_buffer_struct *buffers;
 
+	if (trace_percpu_buffer)
+		return 0;
+
 	buffers = alloc_percpu(struct trace_buffer_struct);
 	if (MEM_FAIL(!buffers, "Could not allocate percpu trace_printk buffer"))
 		return -ENOMEM;
@@ -3331,6 +3334,26 @@ int trace_array_vprintk(struct trace_array *tr,
 	return __trace_array_vprintk(tr->array_buffer.buffer, ip, fmt, args);
 }
 
+/**
+ * trace_array_printk - Print a message to a specific instance
+ * @tr: The instance trace_array descriptor
+ * @ip: The instruction pointer that this is called from.
+ * @fmt: The format to print (printf format)
+ *
+ * If a subsystem sets up its own instance, they have the right to
+ * printk strings into their tracing instance buffer using this
+ * function. Note, this function will not write into the top level
+ * buffer (use trace_printk() for that), as writing into the top level
+ * buffer should only have events that can be individually disabled.
+ * trace_printk() is only used for debugging a kernel, and should not
+ * be ever encorporated in normal use.
+ *
+ * trace_array_printk() can be used, as it will not add noise to the
+ * top level tracing buffer.
+ *
+ * Note, trace_array_init_printk() must be called on @tr before this
+ * can be used.
+ */
 __printf(3, 0)
 int trace_array_printk(struct trace_array *tr,
 		       unsigned long ip, const char *fmt, ...)
@@ -3355,6 +3378,27 @@ int trace_array_printk(struct trace_array *tr,
 }
 EXPORT_SYMBOL_GPL(trace_array_printk);
 
+/**
+ * trace_array_init_printk - Initialize buffers for trace_array_printk()
+ * @tr: The trace array to initialize the buffers for
+ *
+ * As trace_array_printk() only writes into instances, they are OK to
+ * have in the kernel (unlike trace_printk()). This needs to be called
+ * before trace_array_printk() can be used on a trace_array.
+ */
+int trace_array_init_printk(struct trace_array *tr)
+{
+	if (!tr)
+		return -ENOENT;
+
+	/* This is only allowed for created instances */
+	if (tr == &global_trace)
+		return -EINVAL;
+
+	return alloc_percpu_trace_buffer();
+}
+EXPORT_SYMBOL_GPL(trace_array_init_printk);
+
 __printf(3, 4)
 int trace_array_printk_buf(struct trace_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...)
-- 
2.25.4

