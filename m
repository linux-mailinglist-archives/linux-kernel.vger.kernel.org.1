Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AA82D4482
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbgLIOjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgLIOjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:39:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45E2C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 06:38:56 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kn0cG-0000Mf-BH; Wed, 09 Dec 2020 15:38:52 +0100
Message-ID: <a7549324e3dcbacf2b52f8260fdf3a9a98e6171e.camel@pengutronix.de>
Subject: Re: tracer_init_tracefs really slow
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Wed, 09 Dec 2020 15:38:50 +0100
In-Reply-To: <20201207144713.1b19afe2@gandalf.local.home>
References: <68d7b3327052757d0cd6359a6c9015a85b437232.camel@pengutronix.de>
         <20201203211854.7e5caa49@oasis.local.home>
         <31a0d6b7cf7326e7e2f55ab2b668defb0c10b140.camel@pengutronix.de>
         <20201207144713.1b19afe2@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Am Montag, den 07.12.2020, 14:47 -0500 schrieb Steven Rostedt:
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

You don't want to do this...

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
... and this. Moving the trace_eval_init into its own initcall means it
gets started before tracer_init_tracefs. As it holds the
trace_event_sem while updating the eval maps, event_trace_init() then
blocks further initcall execution when it tries to grab this semaphore
a bit down the line, killing the parallelism we are trying to unlock
here.

With those 2 lines dropped, the change seems to work as intended and
shaves ~830ms from the kernel boot time on this system.

Regards,
Lucas

 	trace_create_eval_file(NULL);
 

 #ifdef CONFIG_MODULES


