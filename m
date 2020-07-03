Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63688213141
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 04:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgGCCG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 22:06:26 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:57602 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbgGCCGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:06:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U1XOPYX_1593741976;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U1XOPYX_1593741976)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 10:06:17 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 5/5] tracing: toplevel d_entry already initialized
Date:   Fri,  3 Jul 2020 10:06:12 +0800
Message-Id: <20200703020612.12930-5-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
References: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have following call flow:

    tracer_init_tracefs()
        tracing_init_dentry()
        event_trace_init()
            tracing_init_dentry()

This shows tracing_init_dentry() is called twice in this flow and this
is not necessary.

Let's remove the second one when it is for sure be properly initialized.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 kernel/trace/trace_events.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 8b3aa57dcea6..76879b29cf33 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3434,7 +3434,6 @@ early_initcall(event_trace_enable_again);
 __init int event_trace_init(void)
 {
 	struct trace_array *tr;
-	struct dentry *d_tracer;
 	struct dentry *entry;
 	int ret;
 
@@ -3442,10 +3441,6 @@ __init int event_trace_init(void)
 	if (!tr)
 		return -ENODEV;
 
-	d_tracer = tracing_init_dentry();
-	if (IS_ERR(d_tracer))
-		return 0;
-
 	entry = tracefs_create_file("available_events", 0444, NULL,
 				    tr, &ftrace_avail_fops);
 	if (!entry)
-- 
2.20.1 (Apple Git-117)

