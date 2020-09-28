Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569A227B3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgI1SBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:55 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:44839 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbgI1SBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 63CD4E17;
        Mon, 28 Sep 2020 13:55:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=/iLEjo06CSGEa
        pnKoXGuDZP8TVgidFWGouWqDpYGetE=; b=icWNxsjP5uTrE1Wr00eXXG21kKr2M
        Ox47jYHnPPsqXuEP56ze8OfuK5dJhEWI3tiOjmE/wg9/kNfQn7iMP9yWPbACoK8Q
        cD3RRxZk6XNVp/mCy+bIQsIxt5V072Bhuq0vtpPTPhT/d3xWSN+J4MoXh16+H5eG
        v59KtFZyMKwDfKrCEYBqjVmxbgcypgAieDrYNMkjz/kQm/VNVSZBWrcEcjvb/rw2
        YclNLp8BFacCVHwYq+bp6aPtTTOnr7s7XJotUllDdusH4zTx4uBqCLxXZT65KbJM
        eU0LwvA3bqh6S7n5XwJWqgVxgvngC0lZ90Ag7sYUXz6CGcd8oG8kl5W4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=/iLEjo06CSGEapnKoXGuDZP8TVgidFWGouWqDpYGetE=; b=Tg3P8xtH
        TViy2l/mFvSjJoNoBDpxk75TuNZ8EqJZ/CTAp9WbBlTIVk+fVA846N07vudBXCgn
        C3cdbptY+QDoJM4Vkq34CMNsSKa7xaT14vgZdf3nsMstJZStH4OcxX218z+LDBFa
        K2aal2SwC+TY0VcD+5H/QaSuzdz0jMOHzu2zzGQhxnuLPtGqlMSnjK4J6Q9fVLFO
        8ZC7jIuLgyCvbBO1o1nzHRp+6jKgXE3vx05UqsUR+iBwEJrvN3scabP5v0Y33BUt
        pkhEvriaDsoU/JscsJscbxnAH7wenSLZtxzRI9u8Kn5c++rZ7D2zmT2SN/4LA9T3
        Ps05L5Jub3pFYA==
X-ME-Sender: <xms:hyNyX4jfVvEwJtsEYbVPZydrhAVHc-rM6OFwdnlH-o2cz-il8Il_Pg>
    <xme:hyNyXxB5JxhSN1UFnGTXdlIN2OAbXDndeTjq2Lob7vozlfFkM6pmG5ZZAKukyXxk7
    819KkNlqK-GRmdRlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:hyNyXwFEszFPYR214QvxBJsd74mF1DBOjSsu29m1qSM-WLfmyYapvA>
    <xmx:hyNyX5RGPAz8ho-k4YqbDNGKCX1ZmcDG51VZ46eXkvJ2PG89Zqo5PQ>
    <xmx:hyNyX1zJxgGwhGeEaQ2R6fE6dM3QVz7ZOJTPmmxlcXNNZjYbR0bK-A>
    <xmx:iCNyX6LOSDy3JCVtO3_8XZEJ29GS16tlluf2DxwDvgpr1j-w3eAFOIejTwI>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 53DB63064686;
        Mon, 28 Sep 2020 13:55:19 -0400 (EDT)
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
Subject: [RFC PATCH v2 04/30] mm: add new helper functions to allocate one PMD page with 512 PTE pages.
Date:   Mon, 28 Sep 2020 13:54:02 -0400
Message-Id: <20200928175428.4110504-5-zi.yan@sent.com>
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

This prepares for PUD THP support, which allocates 512 of such PMD pages
when creating a PUD THP. These page table pages will be withdrawn during
THP split.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/x86/include/asm/pgalloc.h | 60 ++++++++++++++++++++++++++++++++++
 arch/x86/mm/pgtable.c          | 25 ++++++++++++++
 include/linux/huge_mm.h        |  3 ++
 3 files changed, 88 insertions(+)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index 62ad61d6fefc..b24284522973 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -52,6 +52,19 @@ extern pgd_t *pgd_alloc(struct mm_struct *);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
 extern pgtable_t pte_alloc_one(struct mm_struct *);
+extern pgtable_t pte_alloc_order(struct mm_struct *mm, unsigned long address,
+		int order);
+
+static inline void pte_free_order(struct mm_struct *mm, struct page *pte,
+		int order)
+{
+	int i;
+
+	for (i = 0; i < (1<<order); i++) {
+		pgtable_pte_page_dtor(&pte[i]);
+		__free_page(&pte[i]);
+	}
+}
 
 extern void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte);
 
@@ -87,6 +100,53 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
 #if CONFIG_PGTABLE_LEVELS > 2
+static inline pmd_t *pmd_alloc_one_page_with_ptes(struct mm_struct *mm, unsigned long addr)
+{
+	pgtable_t pte_pgtables;
+	pmd_t *pmd;
+	spinlock_t *pmd_ptl;
+	int i;
+
+	pte_pgtables = pte_alloc_order(mm, addr,
+		HPAGE_PUD_ORDER - HPAGE_PMD_ORDER);
+	if (!pte_pgtables)
+		return NULL;
+
+	pmd = pmd_alloc_one(mm, addr);
+	if (unlikely(!pmd)) {
+		pte_free_order(mm, pte_pgtables,
+			HPAGE_PUD_ORDER - HPAGE_PMD_ORDER);
+		return NULL;
+	}
+	pmd_ptl = pmd_lock(mm, pmd);
+
+	for (i = 0; i < (1<<(HPAGE_PUD_ORDER - HPAGE_PMD_ORDER)); i++)
+		pgtable_trans_huge_deposit(mm, pmd, pte_pgtables + i);
+
+	spin_unlock(pmd_ptl);
+
+	return pmd;
+}
+
+static inline void pmd_free_page_with_ptes(struct mm_struct *mm, pmd_t *pmd)
+{
+	spinlock_t *pmd_ptl;
+	int i;
+
+	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
+	pmd_ptl = pmd_lock(mm, pmd);
+
+	for (i = 0; i < (1<<(HPAGE_PUD_ORDER - HPAGE_PMD_ORDER)); i++) {
+		pgtable_t pte_pgtable;
+
+		pte_pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+		pte_free(mm, pte_pgtable);
+	}
+
+	spin_unlock(pmd_ptl);
+	pmd_free(mm, pmd);
+}
+
 extern void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd);
 
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index dfd82f51ba66..7be73aee6183 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -33,6 +33,31 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 	return __pte_alloc_one(mm, __userpte_alloc_gfp);
 }
 
+pgtable_t pte_alloc_order(struct mm_struct *mm, unsigned long address, int order)
+{
+	struct page *pte;
+	int i;
+
+	pte = alloc_pages(__userpte_alloc_gfp, order);
+	if (!pte)
+		return NULL;
+	split_page(pte, order);
+	for (i = 1; i < (1 << order); i++)
+		set_page_private(pte + i, 0);
+
+	for (i = 0; i < (1<<order); i++) {
+		if (!pgtable_pte_page_ctor(&pte[i])) {
+			__free_page(&pte[i]);
+			while (--i >= 0) {
+				pgtable_pte_page_dtor(&pte[i]);
+				__free_page(&pte[i]);
+			}
+			return NULL;
+		}
+	}
+	return pte;
+}
+
 static int __init setup_userpte(char *arg)
 {
 	if (!arg)
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 8a8bc46a2432..e9d228d4fc69 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -115,6 +115,9 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
 #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
 
+#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define HPAGE_PMD_SHIFT PMD_SHIFT
 #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
-- 
2.28.0

