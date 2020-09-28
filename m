Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0A127B3F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgI1SCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:19 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:59003 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbgI1SBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id B0D5BE1E;
        Mon, 28 Sep 2020 13:55:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=ibZzjGtUmXNRx
        N5Ks+shsif1f52725VsPFkhAaQPr2s=; b=XoR5kJLQUL6nBYC9owYSwRWOgPzHD
        PuIqp/bJRAg1phhiy5eBZSKaE6kwmrz2e3OUEpqaavw685V2W/rUIL07/jmHlKhp
        qkkLP/f3mE9izBcpVpVBMJ8ObyVcB97XPyTzOQCFB2s96TPY0OYVNCHMbWPAMIaf
        cMePPbmoa/CmIqy2XRAWv5ioAePR3z0SyRfnywZxkFDrQFbr4zWZeLTu/YPGPup7
        igPwTIPk8q4L5Ty0p/UgX2ZYpw/zas0spnYYNZusx9yh6n5tqrra3caJE78w5ZIs
        DLuSGG+fHev8rRhmSsHav0i4Ihz/QnI+gPOctddiBCOcMXYgZreXNOLcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ibZzjGtUmXNRxN5Ks+shsif1f52725VsPFkhAaQPr2s=; b=l4IGgVOd
        0x5MR01ycWOtAC/Qp6b/tLeE+QORW0hvfDXZx9VZW/afDTtnKAWS3vXsaUP9oUsV
        TYXp0+GfAG3VsUYGJksYldnMX7yKfcOUir+aNsYzfsCRIGcGjf4OsvlhEBQmDqTo
        +RR/zBg6+7IFnfeLpLnGpplXYIPjknpXxc3Mi/jOihG2/ImB62thIkafp63/Shfu
        oM48V3sKUBMzY/S3hEQeIH05oi4jDxSWo/QaND2HBLxwXgqQlX4uqjMXvLjEFHeZ
        nmYI9ZrTljz7kZm+a63n0R/+MfnPZEkibPIgUPt8jpNGjx3V5AQ2I/2ZCAl2Swfh
        wvoJIwioqkDjPQ==
X-ME-Sender: <xms:iiNyX2QnbtCBL4QwbDYqkbAEzAM5F_YbQgu2CuwTBGHluE6iP0j3dw>
    <xme:iiNyX7y5cAat-zpD_w4LDWhIgh2pAO9w9J1-3byr9c6dfztrIWpxCPFsEEJOIMtfr
    RaOs8SshQnUcppt3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:iiNyXz1Vjj1O9wt5h2WO73Zu86wOc4f_QfzbYE1Zh--VpahZ3l-9uw>
    <xmx:iiNyXyCFTtUX_HpwL0U9dPJxP-8qz5PxiWOnEmpPzoxJp0w1fGFqhQ>
    <xmx:iiNyX_gyzRM_S1UrenuCUzAAIHDXQ3pSg7DxY50t9lBj46CZCBhPTw>
    <xmx:iiNyX_5Er0eHhW9u474MZGTZhvrGzP3U-GnLEuOirHeqNRysmuvpWJOzB7U>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id CD7A33064610;
        Mon, 28 Sep 2020 13:55:21 -0400 (EDT)
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
Subject: [RFC PATCH v2 11/30] mm: thp: handling PUD THP reference bit.
Date:   Mon, 28 Sep 2020 13:54:09 -0400
Message-Id: <20200928175428.4110504-12-zi.yan@sent.com>
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

Add PUD-level TLB flush ops and teach page_vma_mapped_talk about PUD
THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/x86/include/asm/pgtable.h |  3 +++
 arch/x86/mm/pgtable.c          | 13 +++++++++++++
 include/linux/mmu_notifier.h   | 13 +++++++++++++
 include/linux/pgtable.h        | 14 ++++++++++++++
 include/linux/rmap.h           |  1 +
 mm/page_vma_mapped.c           | 33 +++++++++++++++++++++++++++++----
 mm/rmap.c                      | 12 +++++++++---
 7 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 199de6be2f6d..8bf7bfd71a46 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1127,6 +1127,9 @@ extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
 extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
 				  unsigned long address, pmd_t *pmdp);
 
+#define __HAVE_ARCH_PUDP_CLEAR_YOUNG_FLUSH
+extern int pudp_clear_flush_young(struct vm_area_struct *vma,
+				  unsigned long address, pud_t *pudp);
 
 #define pmd_write pmd_write
 static inline int pmd_write(pmd_t pmd)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 7be73aee6183..e4a2dffcc418 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -633,6 +633,19 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
 
 	return young;
 }
+int pudp_clear_flush_young(struct vm_area_struct *vma,
+			   unsigned long address, pud_t *pudp)
+{
+	int young;
+
+	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
+
+	young = pudp_test_and_clear_young(vma, address, pudp);
+	if (young)
+		flush_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
+
+	return young;
+}
 #endif
 
 /**
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index b8200782dede..4ffa179e654f 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -557,6 +557,19 @@ static inline void mmu_notifier_range_init_migrate(
 	__young;							\
 })
 
+#define pudp_clear_flush_young_notify(__vma, __address, __pudp)		\
+({									\
+	int __young;							\
+	struct vm_area_struct *___vma = __vma;				\
+	unsigned long ___address = __address;				\
+	__young = pudp_clear_flush_young(___vma, ___address, __pudp);	\
+	__young |= mmu_notifier_clear_flush_young(___vma->vm_mm,	\
+						  ___address,		\
+						  ___address +		\
+							PUD_SIZE);	\
+	__young;							\
+})
+
 #define ptep_clear_young_notify(__vma, __address, __ptep)		\
 ({									\
 	int __young;							\
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1f6d46465c54..bb163504fb01 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -243,6 +243,20 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef __HAVE_ARCH_PUDP_CLEAR_YOUNG_FLUSH
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+extern int pudp_clear_flush_young(struct vm_area_struct *vma,
+				  unsigned long address, pud_t *pudp);
+#else
+int pudp_clear_flush_young(struct vm_area_struct *vma,
+				  unsigned long address, pud_t *pudp)
+{
+	BUILD_BUG();
+	return 0;
+}
+#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD  */
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 3a6adfa70fb0..0af61dd193d2 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -206,6 +206,7 @@ struct page_vma_mapped_walk {
 	struct page *page;
 	struct vm_area_struct *vma;
 	unsigned long address;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	spinlock_t *ptl;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 5e77b269c330..f88e845ad5e6 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -145,9 +145,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	struct page *page = pvmw->page;
 	pgd_t *pgd;
 	p4d_t *p4d;
-	pud_t *pud;
+	pud_t pude;
 	pmd_t pmde;
 
+	if (!pvmw->pte && !pvmw->pmd && pvmw->pud)
+		return not_found(pvmw);
+
 	/* The only possible pmd mapping has been handled on last iteration */
 	if (pvmw->pmd && !pvmw->pte)
 		return not_found(pvmw);
@@ -174,10 +177,32 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	p4d = p4d_offset(pgd, pvmw->address);
 	if (!p4d_present(*p4d))
 		return false;
-	pud = pud_offset(p4d, pvmw->address);
-	if (!pud_present(*pud))
+	pvmw->pud = pud_offset(p4d, pvmw->address);
+
+	/*
+	 * Make sure the pud value isn't cached in a register by the
+	 * compiler and used as a stale value after we've observed a
+	 * subsequent update.
+	 */
+	pude = READ_ONCE(*pvmw->pud);
+	if (pud_trans_huge(pude)) {
+		pvmw->ptl = pud_lock(mm, pvmw->pud);
+		if (likely(pud_trans_huge(*pvmw->pud))) {
+			if (pvmw->flags & PVMW_MIGRATION)
+				return not_found(pvmw);
+			if (pud_page(*pvmw->pud) != page)
+				return not_found(pvmw);
+			return true;
+		} else if (!pud_present(*pvmw->pud))
+			return not_found(pvmw);
+
+		/* THP pud was split under us: handle on pmd level */
+		spin_unlock(pvmw->ptl);
+		pvmw->ptl = NULL;
+	} else if (!pud_present(pude))
 		return false;
-	pvmw->pmd = pmd_offset(pud, pvmw->address);
+
+	pvmw->pmd = pmd_offset(pvmw->pud, pvmw->address);
 	/*
 	 * Make sure the pmd value isn't cached in a register by the
 	 * compiler and used as a stale value after we've observed a
diff --git a/mm/rmap.c b/mm/rmap.c
index 5683f367a792..629f8fe7ffac 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -803,9 +803,15 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 					referenced++;
 			}
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-			if (pmdp_clear_flush_young_notify(vma, address,
-						pvmw.pmd))
-				referenced++;
+			if (pvmw.pmd) {
+				if (pmdp_clear_flush_young_notify(vma, address,
+							pvmw.pmd))
+					referenced++;
+			} else if (pvmw.pud) {
+				if (pudp_clear_flush_young_notify(vma, address,
+							pvmw.pud))
+					referenced++;
+			}
 		} else {
 			/* unexpected pmd-mapped page? */
 			WARN_ON_ONCE(1);
-- 
2.28.0

