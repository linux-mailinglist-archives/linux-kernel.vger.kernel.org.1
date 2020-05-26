Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F481CB74E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 20:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgEHScu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 14:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728032AbgEHScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:32:42 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2ECC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:32:42 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n14so2628653qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gEsuCl/jh1GeHgdn0FOVKPNUgKGHCcGpgaHvUQUBVHw=;
        b=jwIJEbNfT/2CL0tzS3TiYOLlNBsdiZqhcBkAT2z2pYTVuCdkSo46gg7XewMb8yiQuP
         ftQK5gtM/sZXuE/XcL94iRwGO6nHM7F6M9Oqj/Qu+IlSEdC1Wgr+lamK77D9m9bHorqy
         ilsPqXGtEuyPwsR/OOW6etaQb2mig9DfovoTHQ0sQS5pAmCmSavQGPgD2n+EFpuUQIWX
         n6YOeAdC41DRw4RXJxu/IXoSdZxob4X+9yMGTh0wXK3Op0zFcsqequmYpSN85dur9nVf
         Z9KATcJmLKDj1ShIVtLXDNVNpSB2gsC6HDM+xGwTomo6F8J2rwI2H57oFUKlt/j8xqZE
         lUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gEsuCl/jh1GeHgdn0FOVKPNUgKGHCcGpgaHvUQUBVHw=;
        b=gYRr76zVsbBp+gVNauVkEgTr5haJDxJ6ihHv78i6ZyHfNzlumof908MJ5i82ir6ssH
         GBX+adFb/XWnnTHALI094mMKROuDYORWBGG4+fAzPeSPoYQBJoeFuzx9EUW+CxSj/EPe
         cVcYBg1ZTLLEucymOI1rEfbG8lulm37HP8EWtYGpk7lZ11avYCpIW/E0msS3n/3s6q/v
         ZedcyVMmoxzVM0cmMVNpkR3hVYif0Br4TXKQpHV6lIWvbnI3LHGLepFvcqMHnP0F1h2N
         tvKIXavH1S//jjDpIAD2yvRi5i1YMgv56kHM2o3+Y0yfbP0ZpI3RDe7BkB4Y7/9dXYEr
         jXXA==
X-Gm-Message-State: AGi0PubN0FSddRsUULR/LILSOt2A1WMkPQtTy9qAGtXU+37ZFJ0w2HLk
        bR8su3vbahYafdYFTZ9/I/sJhA==
X-Google-Smtp-Source: APiQypJMpRJ88KOHhg4rWkabtFU2Ek09QL0qeneqJOMfFjmiP/CPoKYsAH0QT5oCdxQUffgHmUPiiw==
X-Received: by 2002:a37:a412:: with SMTP id n18mr4077666qke.134.1588962761498;
        Fri, 08 May 2020 11:32:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id 33sm2022173qtc.82.2020.05.08.11.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:39 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 16/19] mm: memcontrol: charge swapin pages on instantiation
Date:   Fri,  8 May 2020 14:31:03 -0400
Message-Id: <20200508183105.225460-17-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
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

v2: simplify swapin error checking (Joonsoo)

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
---
 mm/memory.c     | 15 ++++++---
 mm/shmem.c      | 14 ++++----
 mm/swap_state.c | 89 ++++++++++++++++++++++++++-----------------------
 mm/swapfile.c   |  6 ----
 4 files changed, 67 insertions(+), 57 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 832ee914cbcf..93900b121b6e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3125,9 +3125,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
@@ -3189,10 +3200,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_page;
 	}
 
-	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL, true)) {
-		ret = VM_FAULT_OOM;
-		goto out_page;
-	}
 	cgroup_throttle_swaprate(page, GFP_KERNEL);
 
 	/*
diff --git a/mm/shmem.c b/mm/shmem.c
index d0306a36f42c..98547dc4642d 100644
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
index 558e224138d1..4052c011391d 100644
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
 
-	if (new_page)
-		put_page(new_page);
-	return found_page;
+		return NULL;
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
+
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
index 8c9b6767013b..3bc7acc68ba8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1867,11 +1867,6 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
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
@@ -1897,7 +1892,6 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	activate_page(page);
 out:
 	pte_unmap_unlock(pte, ptl);
-out_nolock:
 	if (page != swapcache) {
 		unlock_page(page);
 		put_page(page);
-- 
2.26.2

