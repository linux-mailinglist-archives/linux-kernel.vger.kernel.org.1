Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98E01F619B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 08:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgFKGRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 02:17:21 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50530 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgFKGRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:17:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U.EnDBD_1591856231;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U.EnDBD_1591856231)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Jun 2020 14:17:12 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: [PATCH v12 15/16] mm/pgdat: remove pgdat lru_lock
Date:   Thu, 11 Jun 2020 14:16:48 +0800
Message-Id: <1591856209-166869-16-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now pgdat.lru_lock was replaced by lruvec lock. It's not used anymore.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
---
 include/linux/mmzone.h | 1 -
 mm/page_alloc.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e178aa624e46..d32a17e1d8c2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -723,7 +723,6 @@ struct deferred_split {
 
 	/* Write-intensive fields used by page reclaim */
 	ZONE_PADDING(_pad1_)
-	spinlock_t		lru_lock;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 	/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48eb0f1410d4..05ce6e1a3098 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6721,7 +6721,6 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 	init_waitqueue_head(&pgdat->pfmemalloc_wait);
 
 	pgdat_page_ext_init(pgdat);
-	spin_lock_init(&pgdat->lru_lock);
 	lruvec_init(&pgdat->__lruvec);
 }
 
-- 
1.8.3.1

