Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C106B212F1F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 00:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGBV6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 17:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgGBV6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:58:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2DAB20781;
        Thu,  2 Jul 2020 21:58:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr7Dz-004BdL-ME; Thu, 02 Jul 2020 17:58:31 -0400
Message-ID: <20200702215831.571904149@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 17:58:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 01/18] tracing: Only allow trace_array_printk() to be used by instances
References: <20200702215812.428188663@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

To prevent default "trace_printks()" from spamming the top level tracing
ring buffer, only allow trace instances to use trace_array_printk() (which
can be used without the trace_printk() start up warning).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb62269724d5..8241d1448d70 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3346,12 +3346,16 @@ int trace_array_printk(struct trace_array *tr,
 	int ret;
 	va_list ap;
 
-	if (!(global_trace.trace_flags & TRACE_ITER_PRINTK))
-		return 0;
-
 	if (!tr)
 		return -ENOENT;
 
+	/* This is only allowed for created instances */
+	if (tr == &global_trace)
+		return 0;
+
+	if (!(tr->trace_flags & TRACE_ITER_PRINTK))
+		return 0;
+
 	va_start(ap, fmt);
 	ret = trace_array_vprintk(tr, ip, fmt, ap);
 	va_end(ap);
-- 
2.26.2


