Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0248324949B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 07:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgHSFs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 01:48:28 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:40044 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726531AbgHSFs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 01:48:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U6CFft4_1597816103;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6CFft4_1597816103)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Aug 2020 13:48:24 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 2/2] mm/pageblock: remove false sharing in pageblock_flags
Date:   Wed, 19 Aug 2020 13:47:55 +0800
Message-Id: <1597816075-61091-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
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
index d189441568eb..f785c9d6d68c 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -25,7 +25,7 @@ enum pageblock_bits {
 	 * Assume the bits will always align on a word. If this assumption
 	 * changes then get/set pageblock needs updating.
 	 */
-	NR_PAGEBLOCK_BITS
+	NR_PAGEBLOCK_BITS = BITS_PER_BYTE
 };
 
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f60071e8a4e1..65f692c762d5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -517,7 +517,7 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	unsigned long bitidx, byte_bitidx;
 	unsigned char old_byte, byte;
 
-	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
+	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != BITS_PER_BYTE);
 	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
 
 	bitmap = get_pageblock_bitmap(page, pfn);
-- 
1.8.3.1

