Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFA127B3E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgI1SBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:47 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:51225 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726826AbgI1SBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 08D60E88;
        Mon, 28 Sep 2020 13:55:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=jyLbUIlQCtFGz
        7jNfvQyTQJ+R8QHi6y2ry8kkWn61AM=; b=Hn+ay/U24pF9LPmOCv8p85LuSyLZ0
        y0ZSMPnUWnZX31bAwM8Q6H9Hwo9HID53QZHuf7l8xSoxbNFvGPCSJerBi2mlVPJD
        32sascRspIB3Acwx6IH4s+eDaKdr0S8h6cpMLaBMWNFWrrToWZmNQQf4lvGWSwH7
        g9QfUUAR+x6gfRcHlF9XDSe5xpU4Kki5/QFgMz35tctxXjN1FbykfLau2pass/xl
        pPJo503R6m91iX9IRxsCLppmH9cvoBYJLWX0xkLSlSs/JgDdBpR1oOhn3MxDcHoJ
        YPTwCOvUc2dpSFW2cWiUoczp270HXyC5LalEO7StcsE3k/RnezgRRhIyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=jyLbUIlQCtFGz7jNfvQyTQJ+R8QHi6y2ry8kkWn61AM=; b=Ut2Dy29W
        xcq2q4FraGvdMfQI4YwmLJbOh/OHg/8Y78QXH8MYWJ+4HDgw/+KwsZuJQgSPu7xp
        8xmca4fOxBiPs+NvyOd2C8zR8v5KmxNMvYN8h4NDfVULGJSJuJHAc8Zuj/0PNhwI
        SXaAcAAA0yQtJ1AOf3tLqzjNOu5TK/4JKbIjz9Wy2sY8jpr9O5DNuLgVDXnSb1p8
        3at9g1Y2vASoyD24YMTepZULAoAUdpdLK3clNsiySLpkrlzyAgG3kVNcJB4IeM3y
        37LA+pBIg5PUg92JeRIjN95+LeU+vXWrHVR/09ogLZDuJUIBtiHiBvwEw5dQhwo6
        tVVlIcy4MbQ1gg==
X-ME-Sender: <xms:jCNyX2PtdqVU0iZI05t76kJXrFzOFUQaPQ6aBcnwjAp0HposdqShSQ>
    <xme:jCNyX08hJEaGtwWMvFY07ZcmZghuNe8_5MdHQhho0ujLxBGZzBUTPevHWZ-qxYUD4
    NXFlAsEaBfNrWYNqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:jCNyX9SAg4EPqNuDwTddc7lIPhi8GmSwtEpnSdc9Kq8iWKrDJSu5mQ>
    <xmx:jCNyX2u-DyspJqyjNMl0NXe3_XS9Chy6Kdzyl1wz8CfOI3pzuGXdcQ>
    <xmx:jCNyX-f5rwtv5Bu0iXRasR2V4ayB4uAXVk6-DUaQOKxQizrcJADeCw>
    <xmx:jCNyX52h-FVUhHbW6GFsO7oBNPsiDg3AG2UkrdIX66qjTgq_hMFSTrU4hjI>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 219893064610;
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
Subject: [RFC PATCH v2 17/30] mm: thp: PUD THP COW splits PUD page and falls back to PMD page.
Date:   Mon, 28 Sep 2020 13:54:15 -0400
Message-Id: <20200928175428.4110504-18-zi.yan@sent.com>
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

COW on PUD THPs has the same behavior as COW on PMD THPs to avoid high
COW overhead. As a result, do_huge_pmd_wp will see PMD-mapped PUD THPs,
thus needs to count PUD mappings in total mapcount when calling
page_trans_huge_map_swapcount in reuse_swap_page to avoid false positive.
Change page_trans_huge_map_swapcount to get it right.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h |  5 +++++
 mm/huge_memory.c        | 13 +++++++++++++
 mm/memory.c             |  3 +--
 mm/swapfile.c           |  7 ++++++-
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e5c68e680907..589e5af5a1c2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -19,6 +19,7 @@ extern int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 extern void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud);
 extern int do_huge_pud_anonymous_page(struct vm_fault *vmf);
+extern vm_fault_t do_huge_pud_wp_page(struct vm_fault *vmf, pud_t orig_pud);
 #else
 static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 {
@@ -27,6 +28,10 @@ extern int do_huge_pud_anonymous_page(struct vm_fault *vmf)
 {
 	return VM_FAULT_FALLBACK;
 }
+extern vm_fault_t do_huge_pud_wp_page(struct vm_fault *vmf, pud_t orig_pud)
+{
+	return VM_FAULT_FALLBACK;
+}
 #endif
 
 extern vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4a899e856088..9aa19aa643cd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1335,6 +1335,19 @@ void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 unlock:
 	spin_unlock(vmf->ptl);
 }
+
+vm_fault_t do_huge_pud_wp_page(struct vm_fault *vmf, pud_t orig_pud)
+{
+	struct vm_area_struct *vma = vmf->vma;
+
+	/*
+	 * split pud directly. a whole pud page is not swappable, so there is
+	 * no need to try reuse_swap_page
+	 */
+	__split_huge_pud(vma, vmf->pud, vmf->address, false, NULL);
+	return VM_FAULT_FALLBACK;
+}
+
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd)
diff --git a/mm/memory.c b/mm/memory.c
index e0e0459c0caf..ab80d13807aa 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4141,9 +4141,8 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vmf->vma))
-		return VM_FAULT_FALLBACK;
+		return do_huge_pud_wp_page(vmf, orig_pud);
 	if (vmf->vma->vm_ops->huge_fault)
 		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 495ecdbd7859..a6989b0c4d44 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1635,7 +1635,12 @@ static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
 	/* hugetlbfs shouldn't call it */
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 
-	if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!PageTransCompound(page))) {
+	if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!PageTransCompound(page)) ||
+	    /*
+	     * PMD-mapped PUD THP need to take PUD mappings into account by
+	     * using page_trans_huge_mapcount
+	     */
+	    unlikely(thp_order(page) == HPAGE_PUD_ORDER)) {
 		mapcount = page_trans_huge_mapcount(page, total_mapcount);
 		if (PageSwapCache(page))
 			swapcount = page_swapcount(page);
-- 
2.28.0

