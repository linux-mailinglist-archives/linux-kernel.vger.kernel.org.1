Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA30257207
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 05:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgHaDLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 23:11:35 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:38760 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbgHaDLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:11:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U7J4KfP_1598843467;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7J4KfP_1598843467)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Aug 2020 11:11:07 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 2/6] ftrace: use fls() to get the bits for dup_hash()
Date:   Mon, 31 Aug 2020 11:11:00 +0800
Message-Id: <20200831031104.23322-3-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
References: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The effect here is to get the number of bits, lets use fls() to do
this job.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 kernel/trace/ftrace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 12cb535769bc..9021e16fa079 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1370,8 +1370,9 @@ static struct ftrace_hash *dup_hash(struct ftrace_hash *src, int size)
 	/*
 	 * Make the hash size about 1/2 the # found
 	 */
-	for (size /= 2; size; size >>= 1)
-		bits++;
+	bits = fls(size);
+	if (bits)
+		bits--;
 
 	/* Don't allocate too much */
 	if (bits > FTRACE_HASH_MAX_BITS)
-- 
2.20.1 (Apple Git-117)

