Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3AA2BC5F3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 15:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgKVOCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 09:02:14 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:37981 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727567AbgKVOCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 09:02:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UG8gdoX_1606053728;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UG8gdoX_1606053728)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 22 Nov 2020 22:02:09 +0800
Subject: Re: [PATCH next] mm/vmscan: __isolate_lru_page_prepare clean up
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1605859413-53864-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201120151307.4d9e3ef092ba01a325db7ce2@linux-foundation.org>
 <a355270e-5949-ebb2-30cb-a3723f6c93f8@linux.alibaba.com>
 <20201122123552.GF4327@casper.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <728874d7-2d93-4049-68c1-dcc3b2d52ccd@linux.alibaba.com>
Date:   Sun, 22 Nov 2020 22:00:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201122123552.GF4327@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/22 ÏÂÎç8:35, Matthew Wilcox Ð´µÀ:
> On Sun, Nov 22, 2020 at 08:00:19PM +0800, Alex Shi wrote:
>>  mm/compaction.c |  2 +-
>>  mm/vmscan.c     | 69 +++++++++++++++++++++++--------------------------
>>  2 files changed, 34 insertions(+), 37 deletions(-)
> 
> How is it possible you're changing the signature of a function without
> touching a header file?  Surely __isolate_lru_page_prepare() must be declared
> in mm/internal.h ?
> 
>> +++ b/mm/vmscan.c
>> @@ -1536,19 +1536,17 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>>   * page:	page to consider
>>   * mode:	one of the LRU isolation modes defined above
>>   *
>> - * returns 0 on success, -ve errno on failure.
>> + * returns ture on success, false on failure.
> 
> "true".
> 
>> @@ -1674,35 +1672,34 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>>  		 * only when the page is being freed somewhere else.
>>  		 */
>>  		scan += nr_pages;
>> -		switch (__isolate_lru_page_prepare(page, mode)) {
>> -		case 0:
>> +		if (!__isolate_lru_page_prepare(page, mode)) {
>> +			/* else it is being freed elsewhere */
> 
> I don't think the word "else" helps here.  Just
> 			/* It is being freed elsewhere */
> 
>> +		if (!TestClearPageLRU(page)) {
>>  			/*
>> +			 * This page may in other isolation path,
>> +			 * but we still hold lru_lock.
>>  			 */
> 
> I don't think this comment helps me understand what's going on here.
> Maybe:
> 
> 			/* Another thread is already isolating this page */
> 
>> +			put_page(page);
>>  			list_move(&page->lru, src);
>> +			continue;
>>  		}

Hi Matthew,

Thanks a lot for all comments, I picked all up and here is the v3:

From 167131dd106a96fd08af725df850e0da6ec899af Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Fri, 20 Nov 2020 14:49:16 +0800
Subject: [PATCH v3 next] mm/vmscan: __isolate_lru_page_prepare clean up

The function just return 2 results, so use a 'switch' to deal with its
result is unnecessary, and simplify it to a bool func as Vlastimil
suggested.

Also remove 'goto' by reusing list_move(), and take Matthew Wilcox's
suggestion to update comments in function.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/swap.h |  2 +-
 mm/compaction.c      |  2 +-
 mm/vmscan.c          | 68 ++++++++++++++++++++------------------------
 3 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 596bc2f4d9b0..5bba15ac5a2e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -356,7 +356,7 @@ extern void lru_cache_add_inactive_or_unevictable(struct page *page,
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
 extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 					gfp_t gfp_mask, nodemask_t *mask);
-extern int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode);
+extern bool __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode);
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
diff --git a/mm/compaction.c b/mm/compaction.c
index b68931854253..8d71ffebe6cb 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -988,7 +988,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (unlikely(!get_page_unless_zero(page)))
 			goto isolate_fail;
 
-		if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
+		if (!__isolate_lru_page_prepare(page, isolate_mode))
 			goto isolate_fail_put;
 
 		/* Try isolate the page */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c6f94e55c3fe..4d2703c43310 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1536,19 +1536,17 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
  * page:	page to consider
  * mode:	one of the LRU isolation modes defined above
  *
- * returns 0 on success, -ve errno on failure.
+ * returns true on success, false on failure.
  */
-int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
+bool __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
 {
-	int ret = -EBUSY;
-
 	/* Only take pages on the LRU. */
 	if (!PageLRU(page))
-		return ret;
+		return false;
 
 	/* Compaction should not handle unevictable pages but CMA can do so */
 	if (PageUnevictable(page) && !(mode & ISOLATE_UNEVICTABLE))
-		return ret;
+		return false;
 
 	/*
 	 * To minimise LRU disruption, the caller can indicate that it only
@@ -1561,7 +1559,7 @@ int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
 	if (mode & ISOLATE_ASYNC_MIGRATE) {
 		/* All the caller can do on PageWriteback is block */
 		if (PageWriteback(page))
-			return ret;
+			return false;
 
 		if (PageDirty(page)) {
 			struct address_space *mapping;
@@ -1577,20 +1575,20 @@ int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
 			 * from the page cache.
 			 */
 			if (!trylock_page(page))
-				return ret;
+				return false;
 
 			mapping = page_mapping(page);
 			migrate_dirty = !mapping || mapping->a_ops->migratepage;
 			unlock_page(page);
 			if (!migrate_dirty)
-				return ret;
+				return false;
 		}
 	}
 
 	if ((mode & ISOLATE_UNMAPPED) && page_mapped(page))
-		return ret;
+		return false;
 
-	return 0;
+	return true;
 }
 
 /*
@@ -1674,35 +1672,31 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		 * only when the page is being freed somewhere else.
 		 */
 		scan += nr_pages;
-		switch (__isolate_lru_page_prepare(page, mode)) {
-		case 0:
-			/*
-			 * Be careful not to clear PageLRU until after we're
-			 * sure the page is not being freed elsewhere -- the
-			 * page release code relies on it.
-			 */
-			if (unlikely(!get_page_unless_zero(page)))
-				goto busy;
-
-			if (!TestClearPageLRU(page)) {
-				/*
-				 * This page may in other isolation path,
-				 * but we still hold lru_lock.
-				 */
-				put_page(page);
-				goto busy;
-			}
-
-			nr_taken += nr_pages;
-			nr_zone_taken[page_zonenum(page)] += nr_pages;
-			list_move(&page->lru, dst);
-			break;
+		if (!__isolate_lru_page_prepare(page, mode)) {
+			/* It is being freed elsewhere */
+			list_move(&page->lru, src);
+			continue;
+		}
+		/*
+		 * Be careful not to clear PageLRU until after we're
+		 * sure the page is not being freed elsewhere -- the
+		 * page release code relies on it.
+		 */
+		if (unlikely(!get_page_unless_zero(page))) {
+			list_move(&page->lru, src);
+			continue;
+		}
 
-		default:
-busy:
-			/* else it is being freed elsewhere */
+		if (!TestClearPageLRU(page)) {
+			/* Another thread is already isolating this page */
+			put_page(page);
 			list_move(&page->lru, src);
+			continue;
 		}
+
+		nr_taken += nr_pages;
+		nr_zone_taken[page_zonenum(page)] += nr_pages;
+		list_move(&page->lru, dst);
 	}
 
 	/*
-- 
2.29.GIT

