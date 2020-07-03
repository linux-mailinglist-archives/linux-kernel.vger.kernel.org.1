Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629D9213142
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 04:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgGCCGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 22:06:24 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:50766 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbgGCCGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:06:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U1X8AZ._1593741976;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U1X8AZ._1593741976)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 10:06:16 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 4/5] tracing: use NULL directly to create root level tracefs
Date:   Fri,  3 Jul 2020 10:06:11 +0800
Message-Id: <20200703020612.12930-4-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
References: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tracing_init_dentry() has two types of return value:

  * NULL if succeed
  * IS_ERR() if failed

If the function return error, the following check would return from the
function. So we are sure d_tracer passed in here is NULL.

This is a preparation for following cleanup.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 kernel/trace/trace_events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f6f55682d3e2..8b3aa57dcea6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3446,7 +3446,7 @@ __init int event_trace_init(void)
 	if (IS_ERR(d_tracer))
 		return 0;
 
-	entry = tracefs_create_file("available_events", 0444, d_tracer,
+	entry = tracefs_create_file("available_events", 0444, NULL,
 				    tr, &ftrace_avail_fops);
 	if (!entry)
 		pr_warn("Could not create tracefs 'available_events' entry\n");
@@ -3457,7 +3457,7 @@ __init int event_trace_init(void)
 	if (trace_define_common_fields())
 		pr_warn("tracing: Failed to allocate common fields");
 
-	ret = early_event_add_tracer(d_tracer, tr);
+	ret = early_event_add_tracer(NULL, tr);
 	if (ret)
 		return ret;
 
-- 
2.20.1 (Apple Git-117)

