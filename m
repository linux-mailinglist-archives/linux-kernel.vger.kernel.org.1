Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B62621C6E6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 03:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgGLBLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 21:11:38 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:51002 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbgGLBLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 21:11:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U2P6M2A_1594516295;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U2P6M2A_1594516295)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 12 Jul 2020 09:11:35 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v2 3/4] tracing: toplevel d_entry already initialized
Date:   Sun, 12 Jul 2020 09:10:35 +0800
Message-Id: <20200712011036.70948-4-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200712011036.70948-1-richard.weiyang@linux.alibaba.com>
References: <20200712011036.70948-1-richard.weiyang@linux.alibaba.com>
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
v2:
  * merged 4 & 5
---
 kernel/trace/trace_events.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f6f55682d3e2..76879b29cf33 100644
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
2.20.1 (Apple Git-117)

