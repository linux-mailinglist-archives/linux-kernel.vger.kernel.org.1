Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463B6297437
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463291AbgJWQfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbgJWQdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:51 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBA3F246E1;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=uQxL4fjRXwR/EwQ2p4DPmP+oTqGlbr4Aye0gJB0dI5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2vDNg0Mz6RK6EHbm9ScUhhs2mzV1lMCKQdLZKZiNtlx1lZFI1F1CwqF2HXJq8AW6
         8e9a95M1G9gbEf0i3a852U5t5wjg1/TAbdm3CJt2YjZsfWrmBwqINHWHGuOyvYuT0V
         u3CFOd6SGHI7Ztaha5WFfr/a3SzihbcDkCZcq/j4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Axr-Q9; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 54/56] mm: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:41 +0200
Message-Id: <61d452a7006c9aca9bb352bfa6ed52537dba5060.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 mm/gup.c        | 24 +++++++++++++-----------
 mm/page_alloc.c | 16 ++++++++--------
 mm/truncate.c   | 10 ++++++++--
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 102877ed77a4..3dc7c0fe9231 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1926,7 +1926,19 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
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
@@ -1942,16 +1954,6 @@ EXPORT_SYMBOL(get_user_pages);
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
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 23f5066bd4a5..c94094ce1621 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -495,14 +495,6 @@ static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
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
@@ -521,6 +513,14 @@ unsigned long __get_pfnblock_flags_mask(struct page *page,
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
diff --git a/mm/truncate.c b/mm/truncate.c
index 18cec39a9f53..58fa634cf4f8 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -637,9 +637,15 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 EXPORT_SYMBOL(invalidate_mapping_pages);
 
 /**
- * This helper is similar with the above one, except that it accounts for pages
- * that are likely on a pagevec and count them in @nr_pagevec, which will used by
+ * invalidate_mapping_pagevec - This helper is similar with
+ * invalidate_mapping_pages(), except that it accounts for pages tat are
+ * likely on a pagevec and count them in @nr_pagevec, which will used by
  * the caller.
+ *
+ * @mapping: the address_space which holds the pages to invalidate
+ * @start: the offset 'from' which to invalidate
+ * @end: the offset 'to' which to invalidate (inclusive)
+ *
  */
 void invalidate_mapping_pagevec(struct address_space *mapping,
 		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec)
-- 
2.26.2

