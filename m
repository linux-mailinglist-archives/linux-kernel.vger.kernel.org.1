Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD3D27942C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgIYW0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729044AbgIYW0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:26:07 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601072765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f3neVB71YauFQCPpMdApRLGs3XY1TIPPKty54SXGigA=;
        b=HdUyxTNGOU7HDUAPOTo3ccbkbJCUj7za7fcPqd01jga8fCjR+IyUIs49wh2R3qgZo3Ik9y
        5tlLJzei8+C/cHkcjtn4EEIm02kBhUXSF34jz3LzHDNAyMEDGueRoF0O+ucjS5czZ8CWhj
        HIDIrS3TAW6DFrJNL7yEQ1SaWv3+Ces=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-pK9ULYr2PC6_Fpzu5VG2MA-1; Fri, 25 Sep 2020 18:26:03 -0400
X-MC-Unique: pK9ULYr2PC6_Fpzu5VG2MA-1
Received: by mail-qv1-f70.google.com with SMTP id i17so2721830qvj.22
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3neVB71YauFQCPpMdApRLGs3XY1TIPPKty54SXGigA=;
        b=kvW+DiopiUFJtlYQDxDYa0Lm13JYR3PdJihTokzeQaXpxM3TUFURjymCoMuB8+iD9T
         Z7upuQA6FCRQCFGmnCo71bxv9o2noAOG979XuyWB7Cos8e8EnEFpoCl0hnc+ykzc0CEN
         GmcmBeIhg6xX2JAoqTfA/tBq6IlcOI2L3laoaLwPhjOwpxuEZtNh6ctAWu5/5+iu/edt
         vl3mliL9VnhgDUEmBzab4E/MZEf99VCz1A/SYhcT28T5FtQ2dYH6ZzglK/zpZheKXOVF
         3c6HkQXv8bDPiXsCtx4fot8p+HQjraFNl2O+h949aJ/UIJGnspJlMOjMbDAOWlEZum44
         cPIA==
X-Gm-Message-State: AOAM530RMc0mYp1LjlbBen1BWDCa0cWci2m/9LoRLlyClMxyyCYYv8Ed
        NZWuE/uuDBmXxXNMK5vFI65bdeQ22LO9npmgWiUVzvVbinGTihjmNXdHBzPlulInP4OswE/wZ30
        iyfkUaJd6PnYIBLIdcaU/dcpE
X-Received: by 2002:aed:2986:: with SMTP id o6mr1957588qtd.269.1601072762219;
        Fri, 25 Sep 2020 15:26:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNQ9JPn6Tr7y13N2I/zWl13emViM7mij2pf9V7O1fD80kpqHM0nnvuLIe1K91wSXn1j0IKNA==
X-Received: by 2002:aed:2986:: with SMTP id o6mr1957549qtd.269.1601072761830;
        Fri, 25 Sep 2020 15:26:01 -0700 (PDT)
Received: from localhost.localdomain (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id w44sm3051471qth.9.2020.09.25.15.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 15:26:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v2 3/4] mm: Do early cow for pinned pages during fork() for ptes
Date:   Fri, 25 Sep 2020 18:25:59 -0400
Message-Id: <20200925222600.6832-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200925222600.6832-1-peterx@redhat.com>
References: <20200925222600.6832-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It allows copy_pte_range() to do early cow if the pages were pinned on the
source mm.  Currently we don't have an accurate way to know whether a page is
pinned or not.  The only thing we have is page_maybe_dma_pinned().  However
that's good enough for now.  Especially, with the newly added mm->has_pinned
flag to make sure we won't affect processes that never pinned any pages.

It would be easier if we can do GFP_KERNEL allocation within copy_one_pte().
Unluckily, we can't because we're with the page table locks held for both the
parent and child processes.  So the page allocation needs to be done outside
copy_one_pte().

Some trick is there in copy_present_pte(), majorly the wrprotect trick to block
concurrent fast-gup.  Comments in the function should explain better in place.

Oleg Nesterov reported a (probably harmless) bug during review that we didn't
reset entry.val properly in copy_pte_range() so that potentially there's chance
to call add_swap_count_continuation() multiple times on the same swp entry.
However that should be harmless since even if it happens, the same function
(add_swap_count_continuation()) will return directly noticing that there're
enough space for the swp counter.  So instead of a standalone stable patch, it
is touched up in this patch directly.

Reference discussions:

  https://lore.kernel.org/lkml/20200914143829.GA1424636@nvidia.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 156 insertions(+), 16 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4c56d7b92b0e..92ad08616e60 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -773,15 +773,109 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	return 0;
 }
 
-static inline void
+/*
+ * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
+ * is required to copy this pte.
+ */
+static inline int
 copy_present_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
-		unsigned long addr, int *rss)
+		struct vm_area_struct *new,
+		unsigned long addr, int *rss, struct page **prealloc)
 {
 	unsigned long vm_flags = vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
 
+	page = vm_normal_page(vma, addr, pte);
+	if (page) {
+		if (is_cow_mapping(vm_flags)) {
+			bool is_write = pte_write(pte);
+
+			/*
+			 * The trick starts.
+			 *
+			 * What we want to do is to check whether this page may
+			 * have been pinned by the parent process.  If so,
+			 * instead of wrprotect the pte on both sides, we copy
+			 * the page immediately so that we'll always guarantee
+			 * the pinned page won't be randomly replaced in the
+			 * future.
+			 *
+			 * To achieve this, we do the following:
+			 *
+			 * 1. Write-protect the pte if it's writable.  This is
+			 *    to protect concurrent write fast-gup with
+			 *    FOLL_PIN, so that we'll fail the fast-gup with
+			 *    the write bit removed.
+			 *
+			 * 2. Check page_maybe_dma_pinned() to see whether this
+			 *    page may have been pinned.
+			 *
+			 * The order of these steps is important to serialize
+			 * against the fast-gup code (gup_pte_range()) on the
+			 * pte check and try_grab_compound_head(), so that
+			 * we'll make sure either we'll capture that fast-gup
+			 * so we'll copy the pinned page here, or we'll fail
+			 * that fast-gup.
+			 */
+			if (is_write) {
+				ptep_set_wrprotect(src_mm, addr, src_pte);
+				/*
+				 * This is not needed for serializing fast-gup,
+				 * however always make it consistent with
+				 * src_pte, since we'll need it when current
+				 * page is not pinned.
+				 */
+				pte = pte_wrprotect(pte);
+			}
+
+			if (atomic_read(&src_mm->has_pinned) &&
+			    page_maybe_dma_pinned(page)) {
+				struct page *new_page = *prealloc;
+
+				/*
+				 * This is possibly pinned page, need to copy.
+				 * Safe to release the write bit if necessary.
+				 */
+				if (is_write)
+					set_pte_at(src_mm, addr, src_pte,
+						   pte_mkwrite(pte));
+
+				/* If we don't have a pre-allocated page, ask */
+				if (!new_page)
+					return -EAGAIN;
+
+				/*
+				 * We have a prealloc page, all good!  Take it
+				 * over and copy the page & arm it.
+				 */
+				*prealloc = NULL;
+				copy_user_highpage(new_page, page, addr, vma);
+				__SetPageUptodate(new_page);
+				pte = mk_pte(new_page, new->vm_page_prot);
+				pte = pte_sw_mkyoung(pte);
+				pte = maybe_mkwrite(pte_mkdirty(pte), new);
+				page_add_new_anon_rmap(new_page, new, addr, false);
+				rss[mm_counter(new_page)]++;
+				set_pte_at(dst_mm, addr, dst_pte, pte);
+				return 0;
+			}
+
+			/*
+			 * Logically we should recover the wrprotect() for
+			 * fast-gup, however when reach here it also means we
+			 * actually need to wrprotect() it again for cow.
+			 * Simply keep everything.  Note that there's another
+			 * chunk of cow logic below, but we should still need
+			 * that for !page case.
+			 */
+		}
+		get_page(page);
+		page_dup_rmap(page, false);
+		rss[mm_counter(page)]++;
+	}
+
 	/*
 	 * If it's a COW mapping, write protect it both
 	 * in the parent and the child
@@ -807,14 +901,27 @@ copy_present_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	if (!(vm_flags & VM_UFFD_WP))
 		pte = pte_clear_uffd_wp(pte);
 
-	page = vm_normal_page(vma, addr, pte);
-	if (page) {
-		get_page(page);
-		page_dup_rmap(page, false);
-		rss[mm_counter(page)]++;
+	set_pte_at(dst_mm, addr, dst_pte, pte);
+	return 0;
+}
+
+static inline struct page *
+page_copy_prealloc(struct mm_struct *src_mm, struct vm_area_struct *vma,
+		   unsigned long addr)
+{
+	struct page *new_page;
+
+	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, addr);
+	if (!new_page)
+		return NULL;
+
+	if (mem_cgroup_charge(new_page, src_mm, GFP_KERNEL)) {
+		put_page(new_page);
+		return NULL;
 	}
+	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
 
-	set_pte_at(dst_mm, addr, dst_pte, pte);
+	return new_page;
 }
 
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -825,16 +932,20 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	pte_t *orig_src_pte, *orig_dst_pte;
 	pte_t *src_pte, *dst_pte;
 	spinlock_t *src_ptl, *dst_ptl;
-	int progress = 0;
+	int progress, ret = 0;
 	int rss[NR_MM_COUNTERS];
 	swp_entry_t entry = (swp_entry_t){0};
+	struct page *prealloc = NULL;
 
 again:
+	progress = 0;
 	init_rss_vec(rss);
 
 	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
-	if (!dst_pte)
-		return -ENOMEM;
+	if (!dst_pte) {
+		ret = -ENOMEM;
+		goto out;
+	}
 	src_pte = pte_offset_map(src_pmd, addr);
 	src_ptl = pte_lockptr(src_mm, src_pmd);
 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
@@ -866,8 +977,25 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			progress += 8;
 			continue;
 		}
-		copy_present_pte(dst_mm, src_mm, dst_pte, src_pte,
-				 vma, addr, rss);
+		/* copy_present_pte() will clear `*prealloc' if consumed */
+		ret = copy_present_pte(dst_mm, src_mm, dst_pte, src_pte,
+				       vma, new, addr, rss, &prealloc);
+		/*
+		 * If we need a pre-allocated page for this pte, drop the
+		 * locks, allocate, and try again.
+		 */
+		if (unlikely(ret == -EAGAIN))
+			break;
+		if (unlikely(prealloc)) {
+			/*
+			 * pre-alloc page cannot be reused by next time so as
+			 * to strictly follow mempolicy (e.g., alloc_page_vma()
+			 * will allocate page according to address).  This
+			 * could only happen if one pinned pte changed.
+			 */
+			put_page(prealloc);
+			prealloc = NULL;
+		}
 		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 
@@ -879,13 +1007,25 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	cond_resched();
 
 	if (entry.val) {
-		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0)
+		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		entry.val = 0;
+	} else if (ret) {
+		WARN_ON_ONCE(ret != -EAGAIN);
+		prealloc = page_copy_prealloc(src_mm, vma, addr);
+		if (!prealloc)
 			return -ENOMEM;
-		progress = 0;
+		/* We've captured and resolved the error. Reset, try again. */
+		ret = 0;
 	}
 	if (addr != end)
 		goto again;
-	return 0;
+out:
+	if (unlikely(prealloc))
+		put_page(prealloc);
+	return ret;
 }
 
 static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-- 
2.26.2

