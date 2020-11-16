Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA682B40C0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgKPKTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbgKPKSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:32 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE85D2463D;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=0sQW+g6cEsXpFr6snJ6ztA+4abjwbDH4DFLh7sXWUmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZpYqYUKWj4Ys0HiUuVbFKYGIO/asdWAb4LHJsSVXW2lhFlLR9eBXe3lpbTrbFV5J
         z/dwgwn3ec7EkOHQwkaUI48FwDpr9ETwLF55nvGbW4cSOKq4Mc0ynSgHj4EKCat9P3
         fCTClkfqSr0IwGovhiF8WZa+gurUXtD+/g0fOxKM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwEs-N9; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mattew Wilcox <willy@infradead.org>
Subject: [PATCH v4 25/27] mm: fix kernel-doc markups
Date:   Mon, 16 Nov 2020 11:18:21 +0100
Message-Id: <80e85dddc92d333bc2159ee8a2294921612e8745.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc markups should use this format:
        identifier - description

Fix some issues on mm files:

1) The definition for get_user_pages_locked() doesn't follow
   it. Also, it expects a short descrpition at the header,
   followed by a long one, after the parameters. Fix it.

2) Kernel-doc requires that a kernel-doc markup to be immediatly
   below the function prototype, as otherwise it will rename it.
   So, move get_pfnblock_flags_mask() description to the right
   place.

3) Make invalidate_mapping_pagevec() to also follow the
   expected kernel-doc format.

While here, fix a few minor English syntax issues, as suggested
by Matthew:
	will used -> will be used
	similar with -> similar to

Suggested-by: Mattew Wilcox <willy@infradead.org> # English fixes
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 mm/gup.c        | 24 +++++++++++++-----------
 mm/page_alloc.c | 16 ++++++++--------
 mm/truncate.c   | 10 ++++++++--
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 49c4eabca271..f3751bf28326 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1924,66 +1924,68 @@ static long __get_user_pages_remote(struct mm_struct *mm,
  *              Or NULL if the caller does not require them.
  *
  * This is the same as get_user_pages_remote(), just with a less-flexible
  * calling convention where we assume that the mm being operated on belongs to
  * the current task, and doesn't allow passing of a locked parameter.  We also
  * obviously don't pass FOLL_REMOTE in here.
  */
 long get_user_pages(unsigned long start, unsigned long nr_pages,
 		unsigned int gup_flags, struct page **pages,
 		struct vm_area_struct **vmas)
 {
 	if (!is_valid_gup_flags(gup_flags))
 		return -EINVAL;
 
 	return __gup_longterm_locked(current->mm, start, nr_pages,
 				     pages, vmas, gup_flags | FOLL_TOUCH);
 }
 EXPORT_SYMBOL(get_user_pages);
 
 /**
- * get_user_pages_locked() is suitable to replace the form:
+ * get_user_pages_locked() - variant of get_user_pages()
+ *
+ * @start:      starting user address
+ * @nr_pages:   number of pages from start to pin
+ * @gup_flags:  flags modifying lookup behaviour
+ * @pages:      array that receives pointers to the pages pinned.
+ *              Should be at least nr_pages long. Or NULL, if caller
+ *              only intends to ensure the pages are faulted in.
+ * @locked:     pointer to lock flag indicating whether lock is held and
+ *              subsequently whether VM_FAULT_RETRY functionality can be
+ *              utilised. Lock must initially be held.
+ *
+ * It is suitable to replace the form:
  *
  *      mmap_read_lock(mm);
  *      do_something()
  *      get_user_pages(mm, ..., pages, NULL);
  *      mmap_read_unlock(mm);
  *
  *  to:
  *
  *      int locked = 1;
  *      mmap_read_lock(mm);
  *      do_something()
  *      get_user_pages_locked(mm, ..., pages, &locked);
  *      if (locked)
  *          mmap_read_unlock(mm);
  *
- * @start:      starting user address
- * @nr_pages:   number of pages from start to pin
- * @gup_flags:  flags modifying lookup behaviour
- * @pages:      array that receives pointers to the pages pinned.
- *              Should be at least nr_pages long. Or NULL, if caller
- *              only intends to ensure the pages are faulted in.
- * @locked:     pointer to lock flag indicating whether lock is held and
- *              subsequently whether VM_FAULT_RETRY functionality can be
- *              utilised. Lock must initially be held.
- *
  * We can leverage the VM_FAULT_RETRY functionality in the page fault
  * paths better by using either get_user_pages_locked() or
  * get_user_pages_unlocked().
  *
  */
 long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
 			   int *locked)
 {
 	/*
 	 * FIXME: Current FOLL_LONGTERM behavior is incompatible with
 	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
 	 * vmas.  As there are no users of this flag in this call we simply
 	 * disallow this option for now.
 	 */
 	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
 		return -EINVAL;
 	/*
 	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
 	 * never directly by the caller, so enforce that:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 63d8d8b72c10..7e4d1e4bdee9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -478,66 +478,66 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 static inline unsigned long *get_pageblock_bitmap(struct page *page,
 							unsigned long pfn)
 {
 #ifdef CONFIG_SPARSEMEM
 	return section_to_usemap(__pfn_to_section(pfn));
 #else
 	return page_zone(page)->pageblock_flags;
 #endif /* CONFIG_SPARSEMEM */
 }
 
 static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
 {
 #ifdef CONFIG_SPARSEMEM
 	pfn &= (PAGES_PER_SECTION-1);
 #else
 	pfn = pfn - round_down(page_zone(page)->zone_start_pfn, pageblock_nr_pages);
 #endif /* CONFIG_SPARSEMEM */
 	return (pfn >> pageblock_order) * NR_PAGEBLOCK_BITS;
 }
 
-/**
- * get_pfnblock_flags_mask - Return the requested group of flags for the pageblock_nr_pages block of pages
- * @page: The page within the block of interest
- * @pfn: The target page frame number
- * @mask: mask of bits that the caller is interested in
- *
- * Return: pageblock_bits flags
- */
 static __always_inline
 unsigned long __get_pfnblock_flags_mask(struct page *page,
 					unsigned long pfn,
 					unsigned long mask)
 {
 	unsigned long *bitmap;
 	unsigned long bitidx, word_bitidx;
 	unsigned long word;
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	bitidx = pfn_to_bitidx(page, pfn);
 	word_bitidx = bitidx / BITS_PER_LONG;
 	bitidx &= (BITS_PER_LONG-1);
 
 	word = bitmap[word_bitidx];
 	return (word >> bitidx) & mask;
 }
 
+/**
+ * get_pfnblock_flags_mask - Return the requested group of flags for the pageblock_nr_pages block of pages
+ * @page: The page within the block of interest
+ * @pfn: The target page frame number
+ * @mask: mask of bits that the caller is interested in
+ *
+ * Return: pageblock_bits flags
+ */
 unsigned long get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
 					unsigned long mask)
 {
 	return __get_pfnblock_flags_mask(page, pfn, mask);
 }
 
 static __always_inline int get_pfnblock_migratetype(struct page *page, unsigned long pfn)
 {
 	return __get_pfnblock_flags_mask(page, pfn, MIGRATETYPE_MASK);
 }
 
 /**
  * set_pfnblock_flags_mask - Set the requested group of flags for a pageblock_nr_pages block of pages
  * @page: The page within the block of interest
  * @flags: The flags to set
  * @pfn: The target page frame number
  * @mask: mask of bits that the caller is interested in
  */
 void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 					unsigned long pfn,
diff --git a/mm/truncate.c b/mm/truncate.c
index 960edf5803ca..604eaabc6d06 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -620,43 +620,49 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
  * @start: the offset 'from' which to invalidate
  * @end: the offset 'to' which to invalidate (inclusive)
  *
  * This function only removes the unlocked pages, if you want to
  * remove all the pages of one inode, you must call truncate_inode_pages.
  *
  * invalidate_mapping_pages() will not block on IO activity. It will not
  * invalidate pages which are dirty, locked, under writeback or mapped into
  * pagetables.
  *
  * Return: the number of the pages that were invalidated
  */
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 		pgoff_t start, pgoff_t end)
 {
 	return __invalidate_mapping_pages(mapping, start, end, NULL);
 }
 EXPORT_SYMBOL(invalidate_mapping_pages);
 
 /**
- * This helper is similar with the above one, except that it accounts for pages
- * that are likely on a pagevec and count them in @nr_pagevec, which will used by
+ * invalidate_mapping_pagevec - This helper is similar to
+ * invalidate_mapping_pages(), except that it accounts for pages that are
+ * likely on a pagevec and count them in @nr_pagevec, which will be used by
  * the caller.
+ *
+ * @mapping: the address_space which holds the pages to invalidate
+ * @start: the offset 'from' which to invalidate
+ * @end: the offset 'to' which to invalidate (inclusive)
+ *
  */
 void invalidate_mapping_pagevec(struct address_space *mapping,
 		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec)
 {
 	__invalidate_mapping_pages(mapping, start, end, nr_pagevec);
 }
 
 /*
  * This is like invalidate_complete_page(), except it ignores the page's
  * refcount.  We do this because invalidate_inode_pages2() needs stronger
  * invalidation guarantees, and cannot afford to leave pages behind because
  * shrink_page_list() has a temp ref on them, or because they're transiently
  * sitting in the lru_cache_add() pagevecs.
  */
 static int
 invalidate_complete_page2(struct address_space *mapping, struct page *page)
 {
 	unsigned long flags;
 
 	if (page->mapping != mapping)
-- 
2.28.0

