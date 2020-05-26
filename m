Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517A21B1922
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 00:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgDTWMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 18:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgDTWMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:12:12 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5778DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:12:12 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z90so9994289qtd.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zr0/JVMBQwjg9aArJWroaeN5ok3252hEeR27LcXN9Yg=;
        b=Ar1FXL6XgAU5mNq+0E42gP1ecnAQihfSkKfejqMS0LxdunB5XQzX40p2w5hGt1vr+G
         MK3rfOzR8yw/2DxrZV4hSS3hDH2Z9dDxA5+9IZC03UmxwKsx0PhT7zD/I2Qnv/bdLfeu
         BVA1pFbybDvbP4w5jUlsKsG3j+yMVsanxdw++rmfVNWIIxE9ivKCjoLPf0cRG+XqhXwJ
         uSfXUg29BVzg5NNV7aX0kn1BAHI+5HrWWUznpQHoGIDk/gbAc3lxdJesmCsc2zRhbVZb
         Q4Lpb4iPl+YZnl5cw+yqG2QG4Zp63fNNOM0uB3O602xTx10+1CVbRTFBRVj/Lz+LjHim
         YlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zr0/JVMBQwjg9aArJWroaeN5ok3252hEeR27LcXN9Yg=;
        b=jYM/LdIQv3GGLDealsB8P1jdlaibYiUgiEwF9W93SJfrTj4hpn61ZwZoCQdy+trhbn
         CNpPkE8rSSliQquvl93r3ctSvWBXC/zWmlNCNlzy66rLQN1fWIIQJf2xznCqK77BoK+n
         5kh8eNiQocm2iRGif71qL988pp7bmVq9rvdAFi271MWB8ChVidR6UPRJJCCbvTF/p97D
         g3Z98ZYEjjTwDN7CFT1BCcuW69Al/AG36/IuHPZefzeRvd2r66z6WgJwIqmHjQYmXRC4
         io0XIVh7XqikLAXrW3mTkXRipPxtIEISglYfrM5FWPln5YE2wS9RiHczQ0q4JvhAR6PU
         CKLQ==
X-Gm-Message-State: AGi0PuZgpxvj+G8/aylcPnh9SjeFAu97vBCvS/sYk5Ey3O9OZN0BHKTR
        o2DYObdRNv9i8U3Clfx/+8aMeg==
X-Google-Smtp-Source: APiQypLDPLbw8K6vBH2MCeBcuiNq5wvC5+BEz9tFnwZhtFD9xEn5ajH5ckf0pDLihXbSl99gpfA8kg==
X-Received: by 2002:ac8:f23:: with SMTP id e32mr18560594qtk.368.1587420731478;
        Mon, 20 Apr 2020 15:12:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id t75sm586797qke.127.2020.04.20.15.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:12:10 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 16/18] mm: memcontrol: charge swapin pages on instantiation
Date:   Mon, 20 Apr 2020 18:11:24 -0400
Message-Id: <20200420221126.341272-17-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, users that are otherwise memory controlled can easily
escape their containment and allocate significant amounts of memory
that they're not being charged for. That's because swap readahead
pages are not being charged until somebody actually faults them into
their page table. This can be exploited with MADV_WILLNEED, which
triggers arbitrary readahead allocations without charging the pages.

There are additional problems with the delayed charging of swap pages:

1. To implement refault/workingset detection for anonymous pages, we
   need to have a target LRU available at swapin time, but the LRU is
   not determinable until the page has been charged.

2. To implement per-cgroup LRU locking, we need page->mem_cgroup to be
   stable when the page is isolated from the LRU; otherwise, the locks
   change under us. But swapcache gets charged after it's already on
   the LRU, and even if we cannot isolate it ourselves (since charging
   is not exactly optional).

The previous patch ensured we always maintain cgroup ownership records
for swap pages. This patch moves the swapcache charging point from the
fault handler to swapin time to fix all of the above problems.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memory.c     | 15 ++++++---
 mm/shmem.c      | 14 ++++----
 mm/swap_state.c | 89 ++++++++++++++++++++++++++-----------------------
 mm/swapfile.c   |  6 ----
 4 files changed, 67 insertions(+), 57 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3fa379d9b17d..5d266532fc40 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3127,9 +3127,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
 							vmf->address);
 			if (page) {
+				int err;
+
 				__SetPageLocked(page);
 				__SetPageSwapBacked(page);
 				set_page_private(page, entry.val);
+
+				/* Tell memcg to use swap ownership records */
+				SetPageSwapCache(page);
+				err = mem_cgroup_charge(page, vma->vm_mm,
+							GFP_KERNEL, false);
+				ClearPageSwapCache(page);
+				if (err)
+					goto out_page;
+
 				lru_cache_add_anon(page);
 				swap_readpage(page, true);
 			}
@@ -3191,10 +3202,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_page;
 	}
 
-	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL, true)) {
-		ret = VM_FAULT_OOM;
-		goto out_page;
-	}
 	cgroup_throttle_swaprate(page, GFP_KERNEL);
 
 	/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 363bd11eba85..966f150a4823 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -623,13 +623,15 @@ static int shmem_add_to_page_cache(struct page *page,
 	page->mapping = mapping;
 	page->index = index;
 
-	error = mem_cgroup_charge(page, charge_mm, gfp, PageSwapCache(page));
-	if (error) {
-		if (!PageSwapCache(page) && PageTransHuge(page)) {
-			count_vm_event(THP_FILE_FALLBACK);
-			count_vm_event(THP_FILE_FALLBACK_CHARGE);
+	if (!PageSwapCache(page)) {
+		error = mem_cgroup_charge(page, charge_mm, gfp, false);
+		if (error) {
+			if (PageTransHuge(page)) {
+				count_vm_event(THP_FILE_FALLBACK);
+				count_vm_event(THP_FILE_FALLBACK_CHARGE);
+			}
+			goto error;
 		}
-		goto error;
 	}
 	cgroup_throttle_swaprate(page, gfp);
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ebed37bbf7a3..f3b9073bfff3 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -360,12 +360,13 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			struct vm_area_struct *vma, unsigned long addr,
 			bool *new_page_allocated)
 {
-	struct page *found_page = NULL, *new_page = NULL;
 	struct swap_info_struct *si;
-	int err;
+	struct page *page;
+
 	*new_page_allocated = false;
 
-	do {
+	for (;;) {
+		int err;
 		/*
 		 * First check the swap cache.  Since this is normally
 		 * called after lookup_swap_cache() failed, re-calling
@@ -373,12 +374,12 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 */
 		si = get_swap_device(entry);
 		if (!si)
-			break;
-		found_page = find_get_page(swap_address_space(entry),
-					   swp_offset(entry));
+			return NULL;
+		page = find_get_page(swap_address_space(entry),
+				     swp_offset(entry));
 		put_swap_device(si);
-		if (found_page)
-			break;
+		if (page)
+			return page;
 
 		/*
 		 * Just skip read ahead for unused swap slot.
@@ -389,21 +390,15 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * else swap_off will be aborted if we return NULL.
 		 */
 		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
-			break;
-
-		/*
-		 * Get a new page to read into from swap.
-		 */
-		if (!new_page) {
-			new_page = alloc_page_vma(gfp_mask, vma, addr);
-			if (!new_page)
-				break;		/* Out of memory */
-		}
+			return NULL;
 
 		/*
 		 * Swap entry may have been freed since our caller observed it.
 		 */
 		err = swapcache_prepare(entry);
+		if (!err)
+			break;
+
 		if (err == -EEXIST) {
 			/*
 			 * We might race against get_swap_page() and stumble
@@ -412,31 +407,43 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			 */
 			cond_resched();
 			continue;
-		} else if (err)		/* swp entry is obsolete ? */
-			break;
-
-		/* May fail (-ENOMEM) if XArray node allocation failed. */
-		__SetPageLocked(new_page);
-		__SetPageSwapBacked(new_page);
-		err = add_to_swap_cache(new_page, entry, gfp_mask & GFP_KERNEL);
-		if (likely(!err)) {
-			/* Initiate read into locked page */
-			SetPageWorkingset(new_page);
-			lru_cache_add_anon(new_page);
-			*new_page_allocated = true;
-			return new_page;
 		}
-		__ClearPageLocked(new_page);
-		/*
-		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
-		 * clear SWAP_HAS_CACHE flag.
-		 */
-		put_swap_page(new_page, entry);
-	} while (err != -ENOMEM);
+		if (err)		/* swp entry is obsolete ? */
+			return NULL;
+	}
+
+	/*
+	 * The swap entry is ours to swap in. Prepare a new page.
+	 */
+
+	page = alloc_page_vma(gfp_mask, vma, addr);
+	if (!page)
+		goto fail_free;
+
+	__SetPageLocked(page);
+	__SetPageSwapBacked(page);
+
+	/* May fail (-ENOMEM) if XArray node allocation failed. */
+	if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL))
+		goto fail_unlock;
+
+	if (mem_cgroup_charge(page, NULL, gfp_mask & GFP_KERNEL, false))
+		goto fail_delete;
+
+	/* Initiate read into locked page */
+	SetPageWorkingset(page);
+	lru_cache_add_anon(page);
+	*new_page_allocated = true;
+	return page;
 
-	if (new_page)
-		put_page(new_page);
-	return found_page;
+fail_delete:
+	delete_from_swap_cache(page);
+fail_unlock:
+	unlock_page(page);
+	put_page(page);
+fail_free:
+	swap_free(entry);
+	return NULL;
 }
 
 /*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 08140aed9258..e41074848f25 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1863,11 +1863,6 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	if (unlikely(!page))
 		return -ENOMEM;
 
-	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL, true)) {
-		ret = -ENOMEM;
-		goto out_nolock;
-	}
-
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	if (unlikely(!pte_same_as_swp(*pte, swp_entry_to_pte(entry)))) {
 		ret = 0;
@@ -1893,7 +1888,6 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	activate_page(page);
 out:
 	pte_unmap_unlock(pte, ptl);
-out_nolock:
 	if (page != swapcache) {
 		unlock_page(page);
 		put_page(page);
-- 
2.26.0

