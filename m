Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39AA22D7AD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 15:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGYNAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 09:00:55 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:38711 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726583AbgGYNAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 09:00:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U3l6fmD_1595682015;
Received: from aliy8.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3l6fmD_1595682015)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 25 Jul 2020 21:00:28 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com
Subject: [PATCH v17 20/21] mm/pgdat: remove pgdat lru_lock
Date:   Sat, 25 Jul 2020 20:59:57 +0800
Message-Id: <1595681998-19193-21-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
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
index 30b961a9a749..8af956aa13cf 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -735,7 +735,6 @@ struct deferred_split {
 
 	/* Write-intensive fields used by page reclaim */
 	ZONE_PADDING(_pad1_)
-	spinlock_t		lru_lock;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 	/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e028b87ce294..4d7df42b32d6 100644
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

