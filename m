Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2B227B3E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgI1SBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:22 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:50441 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbgI1SBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 20126CA9;
        Mon, 28 Sep 2020 13:55:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=Gw9wJp8IzBhsG
        H24yD81uyFcJHF+7lzeeR/XcfNfCU4=; b=SFN+ToHp6cDYhIHKZ6aqpXAKZhKxg
        JIKpwEvVd5BVBsllSuSC1ILsH9d1DXKq1Tdu+JcGFF0ChdtruiJoRjA6XVt3OTit
        J1B1qWqYMQVnVO2Capb3wOtBkCeKM81btetu2U2SKV9UStuM4YrNfVzMv4mKFYGG
        q6+pXjvoPVP2CtFoGvvZk51daMMV4iy7ubXuhU7PLHuCDiQUfFYuiSGYo2JMYOto
        TiGLpfsG6IYkfercEC3jvzIwQyWopKtPKW80ycBCN3qH65S70ZarTk178byTPjQW
        g0sZLftwy0nBdtiq+2suCJ7m97EgyyKqQblEu+F8oFSu3RLrnc6TZU7hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Gw9wJp8IzBhsGH24yD81uyFcJHF+7lzeeR/XcfNfCU4=; b=h4x5vkIt
        TzXUSQ5j3DQb3gs/I0aMZeDa5H7HGY1DL5RgahoQU8/AFWwORPr7liJJXkHNvPKE
        T02inzV9jWm/fM1GO/dgy+rfcQ7Col3DNVBa2mr9SZ85W8znEyxZ7NUO6Az+Yq2g
        VzevDyZPZDYFEtNOYQ88X1Bq4w/586jfPKW0qe87iApCwnELMiZVvlHZlI/mSmUj
        q3iJ0CqfqEnQ5lhtxyTQNr8Pz4u8MAK+HIUpT6b1XiyEw4oeAQ0YZdVCuTT5KVs8
        Fcb1BnbcYo2iiLCU2STafCImHGpKcFmTAe6lMyP5PXR/rvWV8PH//pB/9vu00KTg
        P5GMaF6bHRitCQ==
X-ME-Sender: <xms:iCNyX1KZ7XgKFWnx1M9k7zeB_717PEWHblAcMsA_bAOSzRQ_c274sA>
    <xme:iCNyXxIQeLB-kW3hy2kExBbZ2hCh2JdH8VxuE8XFJfyP47KKPadPbax87nISLostN
    DzSMvFmJuHCDFLobw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:iCNyX9tbh2V6-9OlTKwQD8kCqgZdfPVnacz_FH4dB0BWeDECa9ML5A>
    <xmx:iCNyX2ZK8LMm0AVRVqtauwdA7jhE7L3mw-kUQkL7VG5jAL2OYacG1A>
    <xmx:iCNyX8YVc8ZLnyDX299kC8X4DuGX7cSaEZMsHzMwnw6nJda8oWVldQ>
    <xmx:iCNyXyyOwQYgWB_btzm2NEmyFoMtE6jDPFaA-GVbnPEZTXTJYv56LcynxM0>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC2BB306468A;
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
Subject: [RFC PATCH v2 05/30] mm: thp: add page table deposit/withdraw functions for PUD THP.
Date:   Mon, 28 Sep 2020 13:54:03 -0400
Message-Id: <20200928175428.4110504-6-zi.yan@sent.com>
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

We deposit 512 PMD pages, each of which has 512 PTE pages deposited in
its ->deposit_head, to mm->deposit_head_pud. They will be withdrawn and
used when a PUD THP split into 512 PMD THPs. In this way, when any of
the 512 PMD THPs is split further, we will use the existing code path to
withdraw PTE pages for use.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/mm.h       |  2 ++
 include/linux/mm_types.h |  3 +++
 include/linux/pgtable.h  |  3 +++
 kernel/fork.c            |  6 ++++++
 mm/pgtable-generic.c     | 23 +++++++++++++++++++++++
 5 files changed, 37 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 01b62da34794..8f54f06c8eb6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2321,6 +2321,8 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 	return ptl;
 }
 
+#define huge_pud_deposit_head(mm, pud) ((mm)->deposit_head_pud)
+
 extern void __init pagecache_init(void);
 extern void __init free_area_init_memoryless_node(int nid);
 extern void free_initmem(void);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index be842926577a..5ff4dd6a3e32 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -515,6 +515,9 @@ struct mm_struct {
 		/* pgtable deposit list head, protected by page_table_lock */
 		struct llist_head deposit_head_pmd;
 #endif
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+		struct llist_head deposit_head_pud; /* protected by page_table_lock */
+#endif
 #ifdef CONFIG_NUMA_BALANCING
 		/*
 		 * numa_next_scan is the next time that the PTEs will be marked
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 177eab8e1c31..1f6d46465c54 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -465,10 +465,13 @@ static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 #ifndef __HAVE_ARCH_PGTABLE_DEPOSIT
 extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				       pgtable_t pgtable);
+extern void pgtable_trans_huge_pud_deposit(struct mm_struct *mm, pud_t *pudp,
+				       pgtable_t pgtable);
 #endif
 
 #ifndef __HAVE_ARCH_PGTABLE_WITHDRAW
 extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+extern pgtable_t pgtable_trans_huge_pud_withdraw(struct mm_struct *mm, pud_t *pudp);
 #endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/kernel/fork.c b/kernel/fork.c
index 9c8e880538de..86fbeec751ef 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -663,6 +663,9 @@ static void check_mm(struct mm_struct *mm)
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	VM_BUG_ON_MM(!llist_empty(&mm->deposit_head_pmd), mm);
 #endif
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	VM_BUG_ON_MM(!llist_empty(&mm->deposit_head_pud), mm);
+#endif
 }
 
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, GFP_KERNEL))
@@ -1023,6 +1026,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	init_tlb_flush_pending(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	init_llist_head(&mm->deposit_head_pmd);
+#endif
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	init_llist_head(&mm->deposit_head_pud);
 #endif
 	mm_init_uprobes_state(mm);
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index dbb0154165f1..a014cf847067 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -166,6 +166,15 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 	/* FIFO */
 	llist_add(&pgtable->deposit_node, &huge_pmd_deposit_head(mm, pmdp));
 }
+
+void pgtable_trans_huge_pud_deposit(struct mm_struct *mm, pud_t *pudp,
+				pgtable_t pgtable)
+{
+	assert_spin_locked(pud_lockptr(mm, pudp));
+
+	/* FIFO */
+	llist_add(&pgtable->deposit_node, &huge_pud_deposit_head(mm, pudp));
+}
 #endif
 
 #ifndef __HAVE_ARCH_PGTABLE_WITHDRAW
@@ -183,6 +192,20 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 			struct page, deposit_node);
 	return pgtable;
 }
+
+pgtable_t pgtable_trans_huge_pud_withdraw(struct mm_struct *mm, pud_t *pudp)
+{
+	pgtable_t pgtable;
+
+	assert_spin_locked(pud_lockptr(mm, pudp));
+
+	/* only withdraw from a non empty list */
+	VM_BUG_ON(llist_empty(&huge_pud_deposit_head(mm, pudp)));
+	/* FIFO */
+	pgtable = llist_entry(llist_del_first(&huge_pud_deposit_head(mm, pmdp)),
+			struct page, deposit_node);
+	return pgtable;
+}
 #endif
 
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
-- 
2.28.0

