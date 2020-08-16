Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1DA245594
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 05:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgHPDsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 23:48:14 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:49280 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728950AbgHPDsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 23:48:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U5s0mT9_1597549686;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5s0mT9_1597549686)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 16 Aug 2020 11:48:11 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/2] mm/pageblock: remove false sharing in pageblock_flags
Date:   Sun, 16 Aug 2020 11:47:57 +0800
Message-Id: <1597549677-7480-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1597549677-7480-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1597549677-7480-1-git-send-email-alex.shi@linux.alibaba.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current pageblock_flags is only 4 bits, so it has to share a char size
in cmpxchg when get set, the false sharing cause perf drop.

If we incrase the bits up to 8, false sharing would gone in cmpxchg. and
the only cost is half char per pageblock, which is half char per 128MB
on x86, 4 chars in 1 GB.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/pageblock-flags.h | 2 +-
 mm/page_alloc.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index d189441568eb..556fc2c0b392 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -25,7 +25,7 @@ enum pageblock_bits {
 	 * Assume the bits will always align on a word. If this assumption
 	 * changes then get/set pageblock needs updating.
 	 */
-	NR_PAGEBLOCK_BITS
+	NR_PAGEBLOCK_BITS = 8
 };
 
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 142803d1f49b..01c3fb822732 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -521,7 +521,7 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	unsigned long bitidx, word_bitidx;
 	unsigned char old_word, word;
 
-	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
+	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 8);
 	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
 
 	bitmap = get_pageblock_bitmap(page, pfn);
-- 
1.8.3.1

