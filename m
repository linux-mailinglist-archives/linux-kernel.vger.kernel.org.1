Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4659C2BC58A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 13:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgKVMCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 07:02:09 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:34647 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727391AbgKVMCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 07:02:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UG8CY14_1606046523;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UG8CY14_1606046523)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 22 Nov 2020 20:02:04 +0800
Subject: Re: [PATCH next] mm/vmscan: __isolate_lru_page_prepare clean up
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1605859413-53864-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201120151307.4d9e3ef092ba01a325db7ce2@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a355270e-5949-ebb2-30cb-a3723f6c93f8@linux.alibaba.com>
Date:   Sun, 22 Nov 2020 20:00:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201120151307.4d9e3ef092ba01a325db7ce2@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/21 ÉÏÎç7:13, Andrew Morton Ð´µÀ:
> On Fri, 20 Nov 2020 16:03:33 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
>> The function just return 2 results, so use a 'switch' to deal with its
>> result is unnecessary, and simplify it to a bool func as Vlastimil
>> suggested.
>>
>> Also removed 'goto' in using by reusing list_move().
>>
>> ...
>>
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1540,7 +1540,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>>   */
>>  int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
>>  {
>> -	int ret = -EBUSY;
>> +	int ret = false;
>>  
>>  	/* Only take pages on the LRU. */
>>  	if (!PageLRU(page))
>> @@ -1590,7 +1590,7 @@ int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
>>  	if ((mode & ISOLATE_UNMAPPED) && page_mapped(page))
>>  		return ret;
>>  
>> -	return 0;
>> +	return true;
>>  }
> 
> The resulting __isolate_lru_page_prepare() is rather unpleasing.
> 
> - Why return an int and not a bool?
> 
> - `int ret = false' is a big hint that `ret' should have bool type!
> 
> - Why not just remove `ret' and do `return false' in all those `return
>   ret' places?
> 
> - The __isolate_lru_page_prepare() kerneldoc still says "returns 0 on
>   success, -ve errno on failure".  
> 

Hi Andrew,

Thanks a lot for caching and sorry for the bad patch.
It initially a 'int' version, and change it to bool in a hurry weekend.
I am sorry.

From 36c4fbda2d55633d3c1a3e79f045cd9877453ab7 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Fri, 20 Nov 2020 14:49:16 +0800
Subject: [PATCH v2 next] mm/vmscan: __isolate_lru_page_prepare clean up

The function just return 2 results, so use a 'switch' to deal with its
result is unnecessary, and simplify it to a bool func as Vlastimil
suggested.

Also remove 'goto' by reusing list_move().

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/compaction.c |  2 +-
 mm/vmscan.c     | 69 +++++++++++++++++++++++--------------------------
 2 files changed, 34 insertions(+), 37 deletions(-)

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
index c6f94e55c3fe..ab2fdee0828e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1536,19 +1536,17 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
  * page:	page to consider
  * mode:	one of the LRU isolation modes defined above
  *
- * returns 0 on success, -ve errno on failure.
+ * returns ture on success, false on failure.
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
@@ -1674,35 +1672,34 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		 * only when the page is being freed somewhere else.
 		 */
 		scan += nr_pages;
-		switch (__isolate_lru_page_prepare(page, mode)) {
-		case 0:
+		if (!__isolate_lru_page_prepare(page, mode)) {
+			/* else it is being freed elsewhere */
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
+
+		if (!TestClearPageLRU(page)) {
 			/*
-			 * Be careful not to clear PageLRU until after we're
-			 * sure the page is not being freed elsewhere -- the
-			 * page release code relies on it.
+			 * This page may in other isolation path,
+			 * but we still hold lru_lock.
 			 */
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
-
-		default:
-busy:
-			/* else it is being freed elsewhere */
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

