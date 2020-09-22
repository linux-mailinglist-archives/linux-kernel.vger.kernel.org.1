Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA5927380D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgIVB0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729542AbgIVBYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 116EB23AC2;
        Tue, 22 Sep 2020 01:24:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX35-001sJl-2P; Mon, 21 Sep 2020 21:24:51 -0400
Message-ID: <20200922012450.955420567@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [for-next][PATCH 07/26] tracing: toplevel d_entry already initialized
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@linux.alibaba.com>

Currently we have following call flow:

    tracer_init_tracefs()
        tracing_init_dentry()
        event_trace_init()
            tracing_init_dentry()

This shows tracing_init_dentry() is called twice in this flow and this
is not necessary.

Let's remove the second one when it is for sure be properly initialized.

Link: https://lkml.kernel.org/r/20200712011036.70948-4-richard.weiyang@linux.alibaba.com

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a85effb2373b..ee25d849ebba 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3434,7 +3434,6 @@ early_initcall(event_trace_enable_again);
 __init int event_trace_init(void)
 {
 	struct trace_array *tr;
-	struct dentry *d_tracer;
 	struct dentry *entry;
 	int ret;
 
@@ -3442,11 +3441,7 @@ __init int event_trace_init(void)
 	if (!tr)
 		return -ENODEV;
 
-	d_tracer = tracing_init_dentry();
-	if (IS_ERR(d_tracer))
-		return 0;
-
-	entry = tracefs_create_file("available_events", 0444, d_tracer,
+	entry = tracefs_create_file("available_events", 0444, NULL,
 				    tr, &ftrace_avail_fops);
 	if (!entry)
 		pr_warn("Could not create tracefs 'available_events' entry\n");
@@ -3457,7 +3452,7 @@ __init int event_trace_init(void)
 	if (trace_define_common_fields())
 		pr_warn("tracing: Failed to allocate common fields");
 
-	ret = early_event_add_tracer(d_tracer, tr);
+	ret = early_event_add_tracer(NULL, tr);
 	if (ret)
 		return ret;
 
-- 
2.28.0


