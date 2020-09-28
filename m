Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A38727B3DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgI1SBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:19 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:57835 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbgI1SBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id CD665E95;
        Mon, 28 Sep 2020 13:55:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=rCrx+wAdGZ4Zl
        ehY5QUiHxqrgmnxiUlf7t6hp6icemY=; b=C59hXIN3yDOINTV4MVhsGhLRUzwbb
        UPYycdysWR66pa3JrnWmafuw+ydviMmjuub/cZjzkxcTSrwEf1egf7K15FUE21p9
        VX5G/HvxQfQf1mUglYVirkX8aqYpUeIjAkh9WTA/NR7zQXZ796GWOeBNOwUHfWBM
        4aeHzyUYchfYdwTavalwYz9rk4Drjb2J++j9zqE8QlqtOZ22ldVNH2Z44tnVtDg7
        I9BLU8RaYOjrP2/8X1A3EonlKFzgNuiTHDdqIJjyuK5kMFpsC8uleqFfTdtp2A1R
        LYBLJc3pAJL1D5Y9zlkGE/3sCPaj+3sqEu5kkJ0Htf07i8Dq+jS7yUtJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=rCrx+wAdGZ4ZlehY5QUiHxqrgmnxiUlf7t6hp6icemY=; b=j0FrHWS4
        1N0CXibOSAMghD1zLIu+sQukT6SNTW/kSB6KK/HftENN6LSVEp/CD4PoV0gUvMF6
        jwjV3nFr2HFXDeDXzIMhgat1bW1MrHJO4uEyTl1BER304W5U62M6tvUvxzQWiXmN
        HLVoP0EPK9z1AYu1BPVdvzrAVXe36zHuq2YRXzuvuqHe7OlhcjF+RsSGsJSyFzdb
        9NzU2wcTfNu4+BXfOxjOg/VJouNM4wyXbnZRu8a2+Dw24k4x9qvhcKdrDcucy1zs
        QCHA31YxWEW9DB5ArwgoAy5uhggRmeaYWku+9J30YS+Hi7DR81RrNrcXLVlOwf0c
        qF/eh0+d4rS/Cw==
X-ME-Sender: <xms:jyNyX5UjrFXCzZlrXJINZxj9ckdetSlm3ZXVZK5z0HVAcNcdGTioZg>
    <xme:jyNyX5kglW3r2lbs9fmt_Qf5kfTYMo-dpGSmSqthfafH7vULXC-pCJNNtzSvjyND2
    cLQ2Ob1Ydw1vtcLmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:jyNyX1avNFYFVVfEzYVU0pXCXSR3orX6ymCdsPPPP_csMd3SfaETmw>
    <xmx:jyNyX8VXIYahs7JBxUHbE2nCcGNXzR_DUFYRy6gc5Q5ByGwu8h4S-A>
    <xmx:jyNyXzkh7QwN4Xkgcb9zr0qJQ3uVVnuuAjGucZRVwZFkpTs39UzG2w>
    <xmx:jyNyX48sN6b5Pc7tzSQH8Oly851go1vuPwwc2YklGZBJJ_bQ-Y5fQFZcTEY>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id E98073064674;
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
Subject: [RFC PATCH v2 25/30] mm: vma: add VM_HUGEPAGE_PUD to vm_flags at bit 37.
Date:   Mon, 28 Sep 2020 13:54:23 -0400
Message-Id: <20200928175428.4110504-26-zi.yan@sent.com>
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

madvise can set this bit via MADV_HUGEPAGE | MADV_HUGEPAGE_1GB and unset
it via MADV_NOHUGEPAGE | MADV_HUGEPAGE_1GB. Later, kernel will check
this bit to decide whether to allocate PUD THPs or not on a VMA when the
global PUD THP is set to madvise.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/mm.h | 6 ++++++
 mm/khugepaged.c    | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 51b75ffa6a6c..78bee63c64da 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -305,11 +305,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -325,6 +327,10 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+#define VM_HUGEPAGE_PUD VM_HIGH_ARCH_5
+#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
+
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b34c78085017..f085c218ea84 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -345,6 +345,9 @@ struct attribute_group khugepaged_attr_group = {
 int hugepage_madvise(struct vm_area_struct *vma,
 		     unsigned long *vm_flags, int advice)
 {
+	/* only support 1GB PUD THP on x86 now */
+	bool use_pud_page = advice & MADV_HUGEPAGE_1GB;
+
 	advice = advice & MADV_BEHAVIOR_MASK;
 	switch (advice) {
 	case MADV_HUGEPAGE:
@@ -359,6 +362,9 @@ int hugepage_madvise(struct vm_area_struct *vma,
 #endif
 		*vm_flags &= ~VM_NOHUGEPAGE;
 		*vm_flags |= VM_HUGEPAGE;
+
+		if (use_pud_page)
+			*vm_flags |= VM_HUGEPAGE_PUD;
 		/*
 		 * If the vma become good for khugepaged to scan,
 		 * register it here without waiting a page fault that
@@ -371,6 +377,9 @@ int hugepage_madvise(struct vm_area_struct *vma,
 	case MADV_NOHUGEPAGE:
 		*vm_flags &= ~VM_HUGEPAGE;
 		*vm_flags |= VM_NOHUGEPAGE;
+
+		if (use_pud_page)
+			*vm_flags &= ~VM_HUGEPAGE_PUD;
 		/*
 		 * Setting VM_NOHUGEPAGE will prevent khugepaged from scanning
 		 * this vma even if we leave the mm registered in khugepaged if
-- 
2.28.0

