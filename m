Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4DC2D1A03
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgLGTr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:47:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgLGTr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:47:56 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ED15238A1;
        Mon,  7 Dec 2020 19:47:15 +0000 (UTC)
Date:   Mon, 7 Dec 2020 14:47:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: tracer_init_tracefs really slow
Message-ID: <20201207144713.1b19afe2@gandalf.local.home>
In-Reply-To: <31a0d6b7cf7326e7e2f55ab2b668defb0c10b140.camel@pengutronix.de>
References: <68d7b3327052757d0cd6359a6c9015a85b437232.camel@pengutronix.de>
        <20201203211854.7e5caa49@oasis.local.home>
        <31a0d6b7cf7326e7e2f55ab2b668defb0c10b140.camel@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 17:24:58 +0100
Lucas Stach <l.stach@pengutronix.de> wrote:

> I would be happy to test a patch on our whimpy machines, though. :)

Let me know if this helps:

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 06134189e9a7..48aa5b6a7d15 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9062,7 +9062,10 @@ int tracing_init_dentry(void)
 extern struct trace_eval_map *__start_ftrace_eval_maps[];
 extern struct trace_eval_map *__stop_ftrace_eval_maps[];
 
-static void __init trace_eval_init(void)
+static struct workqueue_struct *eval_map_wq __initdata;
+struct work_struct eval_map_work __initdata;
+
+static void __init eval_map_work_func(struct work_struct *work)
 {
 	int len;
 
@@ -9070,6 +9073,34 @@ static void __init trace_eval_init(void)
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
+subsys_initcall(trace_eval_init);
+late_initcall_sync(trace_eval_sync);
+
+
 #ifdef CONFIG_MODULES
 static void trace_module_add_evals(struct module *mod)
 {
@@ -9171,8 +9202,6 @@ static __init int tracer_init_tracefs(void)
 	trace_create_file("saved_tgids", 0444, NULL,
 			NULL, &tracing_saved_tgids_fops);
 
-	trace_eval_init();
-
 	trace_create_eval_file(NULL);
 
 #ifdef CONFIG_MODULES
