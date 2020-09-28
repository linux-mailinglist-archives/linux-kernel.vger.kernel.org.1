Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228EA27B401
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgI1SDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:03:03 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:38975 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbgI1SBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 29242EAA;
        Mon, 28 Sep 2020 13:55:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=wDKwPLy4VFcLp
        paBAPPIxv3ZweIVcEaNjmSuTChBG+s=; b=SothXaKew0HL/ALe/TnCgWjpYQ8pC
        tbv2CUOxJpzhRqjkYJEqAITyyGHHLYx7HlbnSDIOgqOP05pVD20Fx/8RA//b2x2/
        Z1xVLe9KUT8sEtlUHEqqf5SFtimaePtA51rd30UoAsDR9vGF2J38J+VerOqycBi2
        31m5zQUUEVEnvAsH9pE8VxCrkwWFaWAIi55dcO1K/llRiEPi4EZoRx+Aar4dmIiI
        Zxlyj2p9rQnMWwWlp2BJ7SikpQ4pc3G8rzCYJRkay8qyaSZShbYnSMKqvnyaycC/
        RMYSep9fZEskFD01A6N/VgWnM3D/xQBE/+9pQGy7vx0Lpe0ZskOKEQPfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wDKwPLy4VFcLppaBAPPIxv3ZweIVcEaNjmSuTChBG+s=; b=KJiZvA+m
        GN9UiZpcZOT2xWfn4MVpTO8SvyzBqPJ8am2es2pJitbp7NKnX6q1fSntWVgm6Kzd
        pSCe8IzArU7X+/c3+F6kyae20+LriQLBV01kl077B8g/fqA+Ny9ikJDkBOv/YsfL
        6zeLtdZrwowN9W26Xt9+dA//vy79oPcMSFr66NgKRPDtKxEpgntDWrmQ1V7emwJd
        x3f8gIGOhZKNC4CjVesuqwS+M0FEl/0Acxzyt29RmkonR9/6saL1iV8OG9SOemGg
        GYs2N4KGk5qsBsE5muwou6VbOgRBMEvQEaoOs/IrioGyZZS8r+tHT/X+JwKw9UnH
        Ly/Eg3biRTGyrQ==
X-ME-Sender: <xms:jiNyX1kkdto2JyJDLM2n_BoYj3wUErQDb0ZUgamWnglhbsk6DZDnVg>
    <xme:jiNyXw2M9yB2XYLo37w_3nUYQdzqEKIIfHs9Syy4zhhSTcx8VR9dGzLqvBgspXS2r
    1K7Yc-s5L5_HRecWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:jiNyX7qnlsr7i6_SCGc0GQocufrKqPdgHgzopYPDhHS5NmvC6KirKA>
    <xmx:jiNyX1nyMc3a9IKO9Y3bCflaLZoQwePOibqM3UIRkhA4rn9FkFs3Rw>
    <xmx:jiNyXz3qTxI7znSlLmrJxvIiK4R7_zPoRTm11lH_aZeGmLLutfQOrA>
    <xmx:jiNyX9PafhtgH3eqcfLb4qzvBSKQFvcoXA5cOjzHF4hL2XUWWL5Za-asShM>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3C9EF306467E;
        Mon, 28 Sep 2020 13:55:26 -0400 (EDT)
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
Subject: [RFC PATCH v2 23/30] mm: support PUD THP pagemap support.
Date:   Mon, 28 Sep 2020 13:54:21 -0400
Message-Id: <20200928175428.4110504-24-zi.yan@sent.com>
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

pagemap_pud_range is added to print pud page flags properly.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/task_mmu.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 077196182288..04a3158d0d5b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1553,6 +1553,68 @@ static int pagemap_pmd_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 	return err;
 }
 
+static int pagemap_pud_range(pud_t pud, pud_t *pudp, unsigned long addr,
+			unsigned long end, struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+	struct pagemapread *pm = walk->private;
+	spinlock_t *ptl;
+	int err = 0;
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	ptl = pud_trans_huge_lock(pudp, vma);
+	if (ptl) {
+		u64 flags = 0, frame = 0;
+		struct page *page = NULL;
+
+		if (memcmp(pudp, &pud, sizeof(pud)) != 0) {
+			walk->action = ACTION_AGAIN;
+			spin_unlock(ptl);
+			return 0;
+		}
+		if (vma->vm_flags & VM_SOFTDIRTY)
+			flags |= PM_SOFT_DIRTY;
+
+		if (pud_present(pud)) {
+			page = pud_page(pud);
+
+			flags |= PM_PRESENT;
+			if (pud_soft_dirty(pud))
+				flags |= PM_SOFT_DIRTY;
+			if (pm->show_pfn)
+				frame = pud_pfn(pud) +
+					((addr & ~PUD_MASK) >> PAGE_SHIFT);
+		}
+
+		if (page && page_mapcount(page) == 1)
+			flags |= PM_MMAP_EXCLUSIVE;
+
+		for (; addr != end; addr += PAGE_SIZE) {
+			pagemap_entry_t pme = make_pme(frame, flags);
+
+			err = add_to_pagemap(addr, &pme, pm);
+			if (err)
+				break;
+			if (pm->show_pfn) {
+				if (flags & PM_PRESENT)
+					frame++;
+				else if (flags & PM_SWAP)
+					frame += (1 << MAX_SWAPFILES_SHIFT);
+			}
+		}
+		spin_unlock(ptl);
+		walk->action = ACTION_CONTINUE;
+		return err;
+	}
+
+	if (pud_trans_unstable(&pud)) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
+#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
+	return err;
+}
+
 #ifdef CONFIG_HUGETLB_PAGE
 /* This function walks within one hugetlb entry in the single call */
 static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
@@ -1603,6 +1665,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 #endif /* HUGETLB_PAGE */
 
 static const struct mm_walk_ops pagemap_ops = {
+	.pud_entry	= pagemap_pud_range,
 	.pmd_entry	= pagemap_pmd_range,
 	.pte_hole	= pagemap_pte_hole,
 	.hugetlb_entry	= pagemap_hugetlb_range,
-- 
2.28.0

