Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8534627B3F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgI1SCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:18 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:43279 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbgI1SBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5FB36E14;
        Mon, 28 Sep 2020 13:55:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=1JXkwDp9KLCIB
        rx6jYPsY+s0zDNvLwvprwELtbcH1wI=; b=PcWM1IW1xAk/OXpjNFCoGNof1Y3rq
        vs5b7fBue3B0+BME4GUysIJ+S4WYQhjEqBOBEvc1+6dH6PvAFp0p+bxR6nC3UwCL
        QWmDIKhhu2th6TIrHogQ4Y4qHpBLJ7oV7DVpW2Dm/yZ+Q4P+1dHyKuZ8KesHQHQ0
        LP2eUwZ+i/hBcZf2JpnSDL7kfPCTVQFC1+IghVLLzc82/z6zbAF1T0Y2LYti2tcy
        nrmBKO4x7ozhh4p0KCbJCHGRD8gWsd/XZy+XDzMbIOySNdsmSq1HJSW8mj+1Iai6
        zE5F6qkIbUh/dUkjrIyA1N4h85KJxLOue0BhTAj/7Acik0nVqJrakDbiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=1JXkwDp9KLCIBrx6jYPsY+s0zDNvLwvprwELtbcH1wI=; b=AeRz+mXg
        aPkenou0K+dBeH6HEtt5xx6xyDf+KqVHVruB4ad0OKP4ypm+UQoakVzPiEa8aqtF
        Ovn79QSuMZJVe59fBWuEE5WH4HfL76eJONMhsi4hhxjhLaNlMgJ7qEnaCVcSd9cp
        mIwwa71J1CgjBELP5af1xR7lZBU2OsbnByryr/HhgWTRHvzCTNu4GqU1FIsRZy1F
        Po0k1s+qL9oLO2f9if4hs5z2lq1Cj+RYZD+apZiA4+aU/cb/K8SLwoFFalv59Jk7
        qusbYcaJyF0Qp/y0afYhMQ49LW1tcq5PkfYbvm88mGBpPhnF9TwrX1ZtfPmkYGQu
        9jvvS5b15y3CSQ==
X-ME-Sender: <xms:hiNyX0NAmd5f5cmZ2DHJZ3_zCebnDmWiW4OF9TSCbw8YTjjEXsm_Qg>
    <xme:hiNyX6-qthaNpPrYuo9Czh0ozLFyhBVY-EXzlzInfwsA3nb4X8IlzcE1Z-NuOzVBq
    KbS2cNjV5IT-xMYfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:hiNyX7Q-1NsjfFaqw2MLoI8paLU8fSunPOVf54vSh48s-yFzO2_hKw>
    <xmx:hiNyX8vWh3SY4pJnBS4JADw9dSSR9gvTo4vUIXW_fjNzSIUV0M_nvQ>
    <xmx:hiNyX8eaOPKgGeqFwTgpzVp0Tm6FKGOZgR8CF0cxL44dky_9LlFafw>
    <xmx:iCNyX7_sGjXA9Z-wtPcG17HQLchBGY6eR9j_nr0EwEzFYtTGmL_r1ZPjwNo>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 40EF8306467D;
        Mon, 28 Sep 2020 13:55:18 -0400 (EDT)
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
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 01/30] mm/pagewalk: use READ_ONCE when reading the PUD entry unlocked
Date:   Mon, 28 Sep 2020 13:53:59 -0400
Message-Id: <20200928175428.4110504-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928175428.4110504-1-zi.yan@sent.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

The pagewalker runs while only holding the mmap_sem for read. The pud can
be set asynchronously, while also holding the mmap_sem for read

eg from:

 handle_mm_fault()
  __handle_mm_fault()
   create_huge_pmd()
    dev_dax_huge_fault()
     __dev_dax_pud_fault()
      vmf_insert_pfn_pud()
       insert_pfn_pud()
        pud_lock()
        set_pud_at()

At least x86 sets the PUD using WRITE_ONCE(), so an unlocked read of
unstable data should be paired to use READ_ONCE().

For the pagewalker to work locklessly the PUD must work similarly to the
PMD: once the PUD entry becomes a pointer to a PMD, it must be stable, and
safe to pass to pmd_offset()

Passing the value from READ_ONCE into the callbacks prevents the callers
from seeing inconsistencies after they re-read, such as seeing pud_none().

If a callback does obtain the pud_lock then it should trigger ACTION_AGAIN
if a data race caused the original value to change.

Use the same pattern as gup_pmd_range() and pass in the address of the
local READ_ONCE stack variable to pmd_offset() to avoid reading it again.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/pagewalk.h   |  2 +-
 mm/hmm.c                   | 16 +++++++---------
 mm/mapping_dirty_helpers.c |  6 ++----
 mm/pagewalk.c              | 28 ++++++++++++++++------------
 mm/ptdump.c                |  3 +--
 5 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index b1cb6b753abb..6caf28aadafb 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -39,7 +39,7 @@ struct mm_walk_ops {
 			 unsigned long next, struct mm_walk *walk);
 	int (*p4d_entry)(p4d_t *p4d, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
-	int (*pud_entry)(pud_t *pud, unsigned long addr,
+	int (*pud_entry)(pud_t pud, pud_t *pudp, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
 	int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
diff --git a/mm/hmm.c b/mm/hmm.c
index 943cb2ba4442..419e9e50fd51 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -402,28 +402,26 @@ static inline unsigned long pud_to_hmm_pfn_flags(struct hmm_range *range,
 	       hmm_pfn_flags_order(PUD_SHIFT - PAGE_SHIFT);
 }
 
-static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
-		struct mm_walk *walk)
+static int hmm_vma_walk_pud(pud_t pud, pud_t *pudp, unsigned long start,
+			    unsigned long end, struct mm_walk *walk)
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	unsigned long addr = start;
-	pud_t pud;
 	int ret = 0;
 	spinlock_t *ptl = pud_trans_huge_lock(pudp, walk->vma);
 
 	if (!ptl)
 		return 0;
+	if (memcmp(pudp, &pud, sizeof(pud)) != 0) {
+		walk->action = ACTION_AGAIN;
+		spin_unlock(ptl);
+		return 0;
+	}
 
 	/* Normally we don't want to split the huge page */
 	walk->action = ACTION_CONTINUE;
 
-	pud = READ_ONCE(*pudp);
-	if (pud_none(pud)) {
-		spin_unlock(ptl);
-		return hmm_vma_walk_hole(start, end, -1, walk);
-	}
-
 	if (pud_huge(pud) && pud_devmap(pud)) {
 		unsigned long i, npages, pfn;
 		unsigned int required_fault;
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 2c7d03675903..9fc46ebef497 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -150,11 +150,9 @@ static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
  * causes dirty info loss. The pagefault handler should do
  * that if needed.
  */
-static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
-			      struct mm_walk *walk)
+static int wp_clean_pud_entry(pud_t pudval, pud_t *pudp, unsigned long addr,
+			      unsigned long end, struct mm_walk *walk)
 {
-	pud_t pudval = READ_ONCE(*pud);
-
 	if (!pud_trans_unstable(&pudval))
 		return 0;
 
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index e81640d9f177..15d1e423b4a3 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -58,7 +58,7 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	return err;
 }
 
-static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
+static int walk_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 			  struct mm_walk *walk)
 {
 	pmd_t *pmd;
@@ -67,7 +67,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	int err = 0;
 	int depth = real_depth(3);
 
-	pmd = pmd_offset(pud, addr);
+	pmd = pmd_offset(&pud, addr);
 	do {
 again:
 		next = pmd_addr_end(addr, end);
@@ -119,17 +119,19 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 			  struct mm_walk *walk)
 {
-	pud_t *pud;
+	pud_t *pudp;
+	pud_t pud;
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 	int depth = real_depth(2);
 
-	pud = pud_offset(p4d, addr);
+	pudp = pud_offset(p4d, addr);
 	do {
  again:
+		pud = READ_ONCE(*pudp);
 		next = pud_addr_end(addr, end);
-		if (pud_none(*pud) || (!walk->vma && !walk->no_vma)) {
+		if (pud_none(pud) || (!walk->vma && !walk->no_vma)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
@@ -140,27 +142,29 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		walk->action = ACTION_SUBTREE;
 
 		if (ops->pud_entry)
-			err = ops->pud_entry(pud, addr, next, walk);
+			err = ops->pud_entry(pud, pudp, addr, next, walk);
 		if (err)
 			break;
 
 		if (walk->action == ACTION_AGAIN)
 			goto again;
 
-		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
+		if ((!walk->vma && (pud_leaf(pud) || !pud_present(pud))) ||
 		    walk->action == ACTION_CONTINUE ||
 		    !(ops->pmd_entry || ops->pte_entry))
 			continue;
 
-		if (walk->vma)
-			split_huge_pud(walk->vma, pud, addr);
-		if (pud_none(*pud))
-			goto again;
+		if (walk->vma) {
+			split_huge_pud(walk->vma, pudp, addr);
+			pud = READ_ONCE(*pudp);
+			if (pud_none(pud))
+				goto again;
+		}
 
 		err = walk_pmd_range(pud, addr, next, walk);
 		if (err)
 			break;
-	} while (pud++, addr = next, addr != end);
+	} while (pudp++, addr = next, addr != end);
 
 	return err;
 }
diff --git a/mm/ptdump.c b/mm/ptdump.c
index ba88ec43ff21..2055b940408e 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -65,11 +65,10 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 	return 0;
 }
 
-static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
+static int ptdump_pud_entry(pud_t val, pud_t *pudp, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	pud_t val = READ_ONCE(*pud);
 
 #if CONFIG_PGTABLE_LEVELS > 2 && defined(CONFIG_KASAN)
 	if (pud_page(val) == virt_to_page(lm_alias(kasan_early_shadow_pmd)))
-- 
2.28.0

