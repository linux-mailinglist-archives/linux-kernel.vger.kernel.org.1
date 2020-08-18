Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3522480DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 10:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHRIoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 04:44:55 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:56695 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgHRIoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:44:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U67qSYH_1597740291;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U67qSYH_1597740291)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Aug 2020 16:44:51 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     alexander.h.duyck@linux.intel.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v2] mm/page_reporting: drop stale list head check in page_reporting_cycle
Date:   Tue, 18 Aug 2020 16:44:48 +0800
Message-Id: <20200818084448.33969-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

list_for_each_entry_safe() guarantees that we will never stumble over
the list head; "&page->lru != list" will always evaluate to true. Let's
simplify.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/page_reporting.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 3bbd471cfc81..aaaa3605123d 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -178,7 +178,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		 * the new head of the free list before we release the
 		 * zone lock.
 		 */
-		if (&page->lru != list && !list_is_first(&page->lru, list))
+		if (!list_is_first(&page->lru, list))
 			list_rotate_to_front(&page->lru, list);
 
 		/* release lock before waiting on report processing */
-- 
2.20.1 (Apple Git-117)

