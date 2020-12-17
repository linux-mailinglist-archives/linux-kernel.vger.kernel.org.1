Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CCA2DCA65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 02:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389052AbgLQBNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 20:13:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388972AbgLQBM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:12:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D3E823D51;
        Thu, 17 Dec 2020 01:05:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kphj5-000xuy-L4; Wed, 16 Dec 2020 20:05:03 -0500
Message-ID: <20201217010503.521310301@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 16 Dec 2020 20:04:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [for-linus][PATCH 9/9] tracing: Offload eval map updates to a work queue
References: <20201217010408.742794078@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In order for tracepoints to export their enums to user space, the use of the
TRACE_DEFINE_ENUM() macro is used. On boot up, the strings shown in the
tracefs "print fmt" lines are processed, and all the enums registered by
TRACE_DEFINE_ENUM are replaced with the interger value. This way, userspace
tools that read the raw binary data, knows how to evaluate the raw events.

This is currently done in an initcall, but it has been noticed that slow
embedded boards that have tracing may take a few seconds to process them
all, and a few seconds slow down on an embedded device is detrimental to the
system.

Instead, offload the work to a work queue and make sure that its finished by
destroying the work queue (which flushes all work) in a late initcall. This
will allow the system to continue to boot and run the updates in the
background, and this speeds up the boot time. Note, the strings being
updated are only used by user space, so finishing the process before the
system is fully booted will prevent any race issues.

Link: https://lore.kernel.org/r/68d7b3327052757d0cd6359a6c9015a85b437232.camel@pengutronix.de

Reported-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index eee484afcc51..eb5205e48733 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9066,7 +9066,10 @@ int tracing_init_dentry(void)
 extern struct trace_eval_map *__start_ftrace_eval_maps[];
 extern struct trace_eval_map *__stop_ftrace_eval_maps[];
 
-static void __init trace_eval_init(void)
+static struct workqueue_struct *eval_map_wq __initdata;
+static struct work_struct eval_map_work __initdata;
+
+static void __init eval_map_work_func(struct work_struct *work)
 {
 	int len;
 
@@ -9074,6 +9077,33 @@ static void __init trace_eval_init(void)
 	trace_insert_eval_map(NULL, __start_ftrace_eval_maps, len);
 }
 
+static int __init trace_eval_init(void)
+{
+	INIT_WORK(&eval_map_work, eval_map_work_func);
+
+	eval_map_wq = alloc_workqueue("eval_map_wq", WQ_UNBOUND, 0);
+	if (!eval_map_wq) {
+		pr_err("Unable to allocate eval_map_wq\n");
+		/* Do work here */
+		eval_map_work_func(&eval_map_work);
+		return -ENOMEM;
+	}
+
+	queue_work(eval_map_wq, &eval_map_work);
+	return 0;
+}
+
+static int __init trace_eval_sync(void)
+{
+	/* Make sure the eval map updates are finished */
+	if (eval_map_wq)
+		destroy_workqueue(eval_map_wq);
+	return 0;
+}
+
+late_initcall_sync(trace_eval_sync);
+
+
 #ifdef CONFIG_MODULES
 static void trace_module_add_evals(struct module *mod)
 {
-- 
2.29.2


