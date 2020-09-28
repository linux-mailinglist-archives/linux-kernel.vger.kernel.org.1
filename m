Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82D027B3FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgI1SBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:18 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:43645 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgI1SBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:18 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 14:01:17 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id A4C2CE21;
        Mon, 28 Sep 2020 13:55:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=8Oi70jGe8Gu0u
        ZIuNyP+QGtlOgK/mS4X4NyXkO0eQ0c=; b=JqPeyEE+MzNnOOMdegl5R7KikhSKS
        A9fna4KhQ3+IA70ib+vN5ROsqKjIAqa0zq/p4eel6y+/P7va8UaVMEOCj6JJvCFx
        uAGSnZreNkQydqM2Y5rz4FglzgHScixIuFqCvzn15qObfg7XjTprUklCtnt9DS6L
        i2/CGJ9XoXXF61SxuuqPBQ7mcspSUXHvl1cIfTvX37qnxtEcdrgULgXe7TKhnw0r
        XCJi6Fq2QjdutAVioEoSZ/CiuNN6Vuu+3Ca1nYD7tQhM7dfaPUo/RXNIgSB7hZqt
        VTKwQ0zmdS0bvwqW+bvizh4M+S0oVIBZ8rKlXp357HtjqYrWzuMyNutpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=8Oi70jGe8Gu0uZIuNyP+QGtlOgK/mS4X4NyXkO0eQ0c=; b=ErH1HLnr
        yCLslm/NxxyASe24LQ4KLQPAR4q4XlFMtcjyk53xoshrDh+eRnKiDyAEMhW63yzj
        +JUmQesUN3ynbjied11OwHUqmNwmAfB71HOABfDJPbjXZSCZWy5Ftwjd1qU47Ltq
        0+BVt4/oC2RIHGvekoghQ5jogZk3EuZSz9CDzMx+uqL9irgsK7/MpLD2vI+sH0jy
        lookiLhIgGHNxUWs6Rr5Yh0OfMGZYeEpjVV0wv70IlbL4DNO4ggxHUbT27d6ICks
        SwiZoIweP+ITvHFjtOkd+7bcxPbGf12Mxpyz0j87wRn7AT+0q3ir8UhvRxzRwjKr
        HiTdcH+0aX3CXQ==
X-ME-Sender: <xms:iSNyXxqkGaBEXW676znv-FLaFcVEIEM0QYxZmFu-ehDuz3L_c7dPsw>
    <xme:iSNyXzpXSFAYIMG6p_3SibyhKIJ3pH3rOaw4IIO0cS4K_HIb1wuerF0CYx3AJDCFI
    0bUkwDywSL2F1nyzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:iSNyX-OXA9r_B7yyd28RU-s_q_SyHx27BjnQe2wJdNcdOPkSOmJqFQ>
    <xmx:iSNyX84JJTI1RJO-R_ZpUcN5jm6SBRS82oz2g88dhjwTsbG9ntR_BA>
    <xmx:iSNyXw4FwIobK-hzmEkkuId9d_uQD66rYGMfRqgrwi4GrOsr7W0DaA>
    <xmx:iSNyX_Srx-xDK6gHyYcuw2AbjAyOqoCSILNJjw6Q6WA2TU6UaUMrFUcOfP0>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id BCA143064687;
        Mon, 28 Sep 2020 13:55:20 -0400 (EDT)
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
Subject: [RFC PATCH v2 08/30] mm: thp: add PUD THP support for copy_huge_pud.
Date:   Mon, 28 Sep 2020 13:54:06 -0400
Message-Id: <20200928175428.4110504-9-zi.yan@sent.com>
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

copy_huge_pud needs to allocate 1 PMD page table page and 512 PTE page
table pages and deposit them when copying a PUD THP. It is similar to
what we do at PUD THP page faults.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 20a3d393d451..ea9fbedcda26 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1264,7 +1264,12 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 {
 	spinlock_t *dst_ptl, *src_ptl;
 	pud_t pud;
-	int ret;
+	pmd_t *pmd_pgtable = NULL;
+	int ret = -ENOMEM;
+
+	pmd_pgtable = pmd_alloc_one_page_with_ptes(vma->vm_mm, addr);
+	if (unlikely(!pmd_pgtable))
+		goto out;
 
 	dst_ptl = pud_lock(dst_mm, dst_pud);
 	src_ptl = pud_lockptr(src_mm, src_pud);
@@ -1272,16 +1277,30 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	ret = -EAGAIN;
 	pud = *src_pud;
-	if (unlikely(!pud_trans_huge(pud) && !pud_devmap(pud)))
-		goto out_unlock;
 
 	/*
-	 * When page table lock is held, the huge zero pud should not be
-	 * under splitting since we don't split the page itself, only pud to
-	 * a page table.
+	 * only transparent huge pud page needs extra page table pages for
+	 * possible huge page split
 	 */
-	if (is_huge_zero_pud(pud)) {
-		/* No huge zero pud yet */
+	if (!pud_trans_huge(pud))
+		pmd_free_page_with_ptes(dst_mm, pmd_pgtable);
+
+	if (unlikely(!pud_trans_huge(pud) && !pud_devmap(pud)))
+		goto out_unlock;
+
+	if (pud_trans_huge(pud)) {
+		struct page *src_page;
+		int i;
+
+		src_page = pud_page(pud);
+		VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
+		get_page(src_page);
+		page_dup_rmap(src_page, true);
+		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PUD_NR);
+		mm_inc_nr_pmds(dst_mm);
+		for (i = 0; i < (1<<(HPAGE_PUD_ORDER - HPAGE_PMD_ORDER)); i++)
+			mm_inc_nr_ptes(dst_mm);
+		pgtable_trans_huge_pud_deposit(dst_mm, dst_pud, virt_to_page(pmd_pgtable));
 	}
 
 	pudp_set_wrprotect(src_mm, addr, src_pud);
@@ -1292,6 +1311,7 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 out_unlock:
 	spin_unlock(src_ptl);
 	spin_unlock(dst_ptl);
+out:
 	return ret;
 }
 
-- 
2.28.0

