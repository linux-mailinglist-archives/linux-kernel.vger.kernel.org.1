Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0803D27B3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgI1SCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:22 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:52613 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726805AbgI1SBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5D92DDFE;
        Mon, 28 Sep 2020 13:55:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=MBT4lm3A6+58v
        V7ehE09nj7/xFAdFR40w6fslUm1WHg=; b=FlooIRVkdGPvb1B7X33VMVVF7n1wp
        UaiRQX3EmCVmt/S4kWXjwbr+wxvmtwKz/o32+LPHhDnEqzYXNaUZH3Agt4uODi/N
        u1VsDn9q3cikNtuB0yPsELVxjObNKNUnO8y+BaDqEomDgvsTCETHzvo74rOK5yY+
        oK6rWPiA7p41AlgsbrySWm0sBqGTz0V4KLOyiCk7UkDIkUOZoSUCrbHAF5VZT0xg
        3uBDSUrzngY11kwyAIgPwwCgTQrhtg0JKIBdJuX4cnzq6/eoe7hCUBhkVbEB+kpe
        wniG+QViuPc4DP5ipHub+1vg9Cy1bFBYQkm72AXY4xNXY8V5A0TA0uMbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=MBT4lm3A6+58vV7ehE09nj7/xFAdFR40w6fslUm1WHg=; b=kHadzIx4
        bbpU4sVnHcsUyE8DrZY+I7WIgidMRqHicibUFP8S0l1ShpZrx2yt/0bGuTfOfQ3f
        EpWdJBuIuk5HZPdxgZlWZZ+tlftu+UU26K/LAfVxHqd1l6yaYh21QW1kUiek4NSP
        KZXYP2v+5PtncTH4MIy0mCpjVHaSnKoH9xjcoaxiMpi6co3+9fXDVYPlifPhP55W
        OL7uZV+kWh1k50T8zqc7CRpEI2uUkYDvSsUUxwUycEW31w61zkGKpH1+BfVu1j5j
        eDEJfXe9GLaPivWkmLfGiqhey9SRlwKcnNiAOonJQtoS9+Jqp2iswdpF/meI3Aog
        E6Xp16XaQ3BI3A==
X-ME-Sender: <xms:jCNyXzt__kXfkxJXc3rIygB49oDL0oWDbc2AcHpyOQibclBHXby7ww>
    <xme:jCNyX0dKBTBb-67JVRa62zRpRyDbXZw97Zr7UzCd-AJkLFBRYjrx9KlLyz5xmgE32
    MovjuI26UplPkm0eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:jCNyX2zC0DVzs06EkyzxNObIAEAWGibsXL9Wzh2OaoVzisp8Ic9K-A>
    <xmx:jCNyXyM8A6Fd6g10cit28lUx-mJQ64plw2GAcSXy32JcrFUOOrEO-Q>
    <xmx:jCNyXz_R73zU-sFsDflSNZBuLBfP76KnoSS4w3zCC_pBIpsoDh6blg>
    <xmx:jCNyX3V8xkh6nBFPQOnyQAzg87RAEL0WEIc5Ed0Lw7vtvGQNR9UFi1kfJ1I>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 775B73064674;
        Mon, 28 Sep 2020 13:55:24 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH v2 18/30] mm: thp: PUD THP follow_p*d_page() support.
Date:   Mon, 28 Sep 2020 13:54:16 -0400
Message-Id: <20200928175428.4110504-19-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928175428.4110504-1-zi.yan@sent.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Add follow_page support for PUD THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 11 +++++++
 mm/gup.c                | 60 ++++++++++++++++++++++++++++++++-
 mm/huge_memory.c        | 73 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 589e5af5a1c2..c7bc40c4a5e2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -20,6 +20,10 @@ extern int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 extern void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud);
 extern int do_huge_pud_anonymous_page(struct vm_fault *vmf);
 extern vm_fault_t do_huge_pud_wp_page(struct vm_fault *vmf, pud_t orig_pud);
+extern struct page *follow_trans_huge_pud(struct vm_area_struct *vma,
+					  unsigned long addr,
+					  pud_t *pud,
+					  unsigned int flags);
 #else
 static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 {
@@ -32,6 +36,13 @@ extern vm_fault_t do_huge_pud_wp_page(struct vm_fault *vmf, pud_t orig_pud)
 {
 	return VM_FAULT_FALLBACK;
 }
+struct page *follow_trans_huge_pud(struct vm_area_struct *vma,
+					  unsigned long addr,
+					  pud_t *pud,
+					  unsigned int flags)
+{
+	return NULL;
+}
 #endif
 
 extern vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd);
diff --git a/mm/gup.c b/mm/gup.c
index b21cc220f036..972cca69f228 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -696,10 +696,68 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 		if (page)
 			return page;
 	}
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	if (likely(!pud_trans_huge(*pud))) {
+		if (unlikely(pud_bad(*pud)))
+			return no_page_table(vma, flags);
+		return follow_pmd_mask(vma, address, pud, flags, ctx);
+	}
+
+	ptl = pud_lock(mm, pud);
+
+	if (unlikely(!pud_trans_huge(*pud))) {
+		spin_unlock(ptl);
+		if (unlikely(pud_bad(*pud)))
+			return no_page_table(vma, flags);
+		return follow_pmd_mask(vma, address, pud, flags, ctx);
+	}
+
+	if (flags & FOLL_SPLIT) {
+		int ret;
+		pmd_t *pmd = NULL;
+
+		page = pud_page(*pud);
+		if (is_huge_zero_page(page)) {
+
+			spin_unlock(ptl);
+			ret = 0;
+			split_huge_pud(vma, pud, address);
+			pmd = pmd_offset(pud, address);
+			split_huge_pmd(vma, pmd, address);
+			if (pmd_trans_unstable(pmd))
+				ret = -EBUSY;
+		} else {
+			get_page(page);
+			spin_unlock(ptl);
+			lock_page(page);
+			ret = split_huge_pud_page(page);
+			if (!ret)
+				ret = split_huge_page(page);
+			else {
+				unlock_page(page);
+				put_page(page);
+				goto out;
+			}
+			unlock_page(page);
+			put_page(page);
+			if (pud_none(*pud))
+				return no_page_table(vma, flags);
+			pmd = pmd_offset(pud, address);
+		}
+out:
+		return ret ? ERR_PTR(ret) :
+			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+	}
+	page = follow_trans_huge_pud(vma, address, pud, flags);
+	spin_unlock(ptl);
+	ctx->page_mask = HPAGE_PUD_NR - 1;
+	return page;
+#else
 	if (unlikely(pud_bad(*pud)))
 		return no_page_table(vma, flags);
-
 	return follow_pmd_mask(vma, address, pud, flags, ctx);
+#endif
 }
 
 static struct page *follow_p4d_mask(struct vm_area_struct *vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9aa19aa643cd..61ae7a0ded84 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1258,6 +1258,77 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 	return page;
 }
 
+/*
+ * FOLL_FORCE can write to even unwritable pmd's, but only
+ * after we've gone through a COW cycle and they are dirty.
+ */
+static inline bool can_follow_write_pud(pud_t pud, unsigned int flags)
+{
+	return pud_write(pud) ||
+	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pud_dirty(pud));
+}
+
+struct page *follow_trans_huge_pud(struct vm_area_struct *vma,
+				   unsigned long addr,
+				   pud_t *pud,
+				   unsigned int flags)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct page *page = NULL;
+
+	assert_spin_locked(pud_lockptr(mm, pud));
+
+	if (flags & FOLL_WRITE && !can_follow_write_pud(*pud, flags))
+		goto out;
+
+	/* Avoid dumping huge zero page */
+	if ((flags & FOLL_DUMP) && is_huge_zero_pud(*pud))
+		return ERR_PTR(-EFAULT);
+
+	/* Full NUMA hinting faults to serialise migration in fault paths */
+	/*&& pud_protnone(*pmd)*/
+	if ((flags & FOLL_NUMA))
+		goto out;
+
+	page = pud_page(*pud);
+	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
+	if (flags & FOLL_TOUCH)
+		touch_pud(vma, addr, pud, flags);
+	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
+		/*
+		 * We don't mlock() pte-mapped THPs. This way we can avoid
+		 * leaking mlocked pages into non-VM_LOCKED VMAs.
+		 *
+		 * For anon THP:
+		 *
+		 * We do the same thing as PMD-level THP.
+		 *
+		 * For file THP:
+		 *
+		 * No support yet.
+		 *
+		 */
+
+		if (PageAnon(page) && compound_mapcount(page) != 1)
+			goto skip_mlock;
+		if (PagePUDDoubleMap(page) || !page->mapping)
+			goto skip_mlock;
+		if (!trylock_page(page))
+			goto skip_mlock;
+		lru_add_drain();
+		if (page->mapping && !PagePUDDoubleMap(page))
+			mlock_vma_page(page);
+		unlock_page(page);
+	}
+skip_mlock:
+	page += (addr & ~HPAGE_PUD_MASK) >> PAGE_SHIFT;
+	VM_BUG_ON_PAGE(!PageCompound(page) && !is_zone_device_page(page), page);
+	if (flags & FOLL_GET)
+		get_page(page);
+
+out:
+	return page;
+}
 int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
 		  struct vm_area_struct *vma)
@@ -1462,7 +1533,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 		goto out;
 
 	page = pmd_page(*pmd);
-	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
+	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page) && !PMDPageInPUD(page), page);
 
 	if (!try_grab_page(page, flags))
 		return ERR_PTR(-ENOMEM);
-- 
2.28.0

