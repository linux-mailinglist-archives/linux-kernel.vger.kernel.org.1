Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE777213143
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 04:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgGCCG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 22:06:28 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46867 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbgGCCGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:06:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U1WwZ34_1593741975;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U1WwZ34_1593741975)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 10:06:15 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 3/5] tracing: save one trace_event->type by using __TRACE_LAST_TYPE
Date:   Fri,  3 Jul 2020 10:06:10 +0800
Message-Id: <20200703020612.12930-3-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
References: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static defined trace_event->type stops at (__TRACE_LAST_TYPE - 1) and
dynamic trace_event->type starts from (__TRACE_LAST_TYPE + 1).

To save one trace_event->type index, let's use __TRACE_LAST_TYPE.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 kernel/trace/trace_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index b704b3ef4264..818f0c9d10c5 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -20,7 +20,7 @@ DECLARE_RWSEM(trace_event_sem);
 
 static struct hlist_head event_hash[EVENT_HASHSIZE] __read_mostly;
 
-static int next_event_type = __TRACE_LAST_TYPE + 1;
+static int next_event_type = __TRACE_LAST_TYPE;
 
 enum print_line_t trace_print_bputs_msg_only(struct trace_iterator *iter)
 {
@@ -675,7 +675,7 @@ static LIST_HEAD(ftrace_event_list);
 static int trace_search_list(struct list_head **list)
 {
 	struct trace_event *e;
-	int next = __TRACE_LAST_TYPE + 1;
+	int next = __TRACE_LAST_TYPE;
 
 	if (list_empty(&ftrace_event_list)) {
 		*list = &ftrace_event_list;
-- 
2.20.1 (Apple Git-117)

