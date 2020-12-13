Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11E62D8E61
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 16:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgLMPtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 10:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437310AbgLMPsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:48:45 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7345BC0617B0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 07:48:05 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id hk16so5145301pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 07:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8NPGizKXhIw6LYHXB/g9S8tO1PI1jnab/kHwdu+D4Ug=;
        b=oPhLptY/qqtVKcudr08x3sHl/beeopjU2TvjrXHJdbdVPPdS0MzXzYtLXXVwG0Kq9T
         LBT6BWP2ta14GXxYp9tksWuJeAS6qn8SpJY6r47m4sdbVKSIoNgUnqC28+KRfhvgKzEh
         rHf6XfhSkWrc68sLAIaVZLFfxWgZgB72Nj/z8hfBYNIXbuuIa+S/Q/pvITtnuZtVnEDK
         TFUj9PXtBxk4BkbUr2lzrE+//C5cLsozVE4abh8MKeo0enW/Mn00E07+Y9fL+wNaGikY
         JeGvaAfrOQgZ77NQUeCvXlv8TZTtitHBy8BVJVTBoWOQx2l8K82DhTAZbOUksv7sGT0i
         57CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8NPGizKXhIw6LYHXB/g9S8tO1PI1jnab/kHwdu+D4Ug=;
        b=W/uufzvdp95dratk/m1qc8comPttnMipcj0wTSjLjjCsrKp83qQShBGS586w+ADyRO
         gPwZAhE692qEqqO1ap4pFvXwpfKJV6f+3fsV+ClPQDEWF/kXeT+rKxza21Aab5mqETcR
         U5RuZZZKdHTNFddxVljbY7oRgkSs9o7up5A7/6+36Yoxu9+KwTolPEjExplU/MHd9mtU
         fzZYNNWvcDy/y+eAz0djfD2yn9eFxILldth72XFx5/rcc1rKlMOP4l6pkU/M9gr1H8Q9
         fAPSCfZ1X7Si3AZAJChQJYlptzNeU4QPJ3S/49iUdjwCIY8a/Z/T23ZZJJeyvEb3vL+w
         mPzw==
X-Gm-Message-State: AOAM5308oElMymFddDReJc6E4IAP+hFcYhrUFFjBgw8PbcKlwpj7IEIH
        v/429rBu0sC29hwL2GDJtf60Ww==
X-Google-Smtp-Source: ABdhPJzpr/Z/RxuagpBkxf5dniRoM/fCaPYTeqJPB/w+ZQSOkCMu4OPhrK8dBKr4Mu4cgwEFvFE4oA==
X-Received: by 2002:a17:90b:4a81:: with SMTP id lp1mr22041651pjb.55.1607874485011;
        Sun, 13 Dec 2020 07:48:05 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id e24sm13113753pjt.16.2020.12.13.07.47.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Dec 2020 07:48:04 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v9 10/11] mm/hugetlb: Gather discrete indexes of tail page
Date:   Sun, 13 Dec 2020 23:45:33 +0800
Message-Id: <20201213154534.54826-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201213154534.54826-1-songmuchun@bytedance.com>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For HugeTLB page, there are more metadata to save in the struct page.
But the head struct page cannot meet our needs, so we have to abuse
other tail struct page to store the metadata. In order to avoid
conflicts caused by subsequent use of more tail struct pages, we can
gather these discrete indexes of tail struct page. In this case, it
will be easier to add a new tail page index later.

There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
page structs can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, so
add a BUILD_BUG_ON to catch invalid usage of the tail struct page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h        | 13 +++++++++++++
 include/linux/hugetlb_cgroup.h | 15 +++++++++------
 mm/hugetlb.c                   | 16 ++++++++--------
 mm/hugetlb_vmemmap.c           |  8 ++++++++
 4 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 66d82ae7b712..7295f6b3d55e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -28,6 +28,19 @@ typedef struct { unsigned long pd; } hugepd_t;
 #include <linux/shm.h>
 #include <asm/tlbflush.h>
 
+enum {
+	SUBPAGE_INDEX_ACTIVE = 1,	/* reuse page flags of PG_private */
+	SUBPAGE_INDEX_TEMPORARY,	/* reuse page->mapping */
+#ifdef CONFIG_CGROUP_HUGETLB
+	SUBPAGE_INDEX_CGROUP = SUBPAGE_INDEX_TEMPORARY,/* reuse page->private */
+	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
+#endif
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	SUBPAGE_INDEX_HWPOISON,		/* reuse page->private */
+#endif
+	NR_USED_SUBPAGE,
+};
+
 struct hugepage_subpool {
 	spinlock_t lock;
 	long count;
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 2ad6e92f124a..3d3c1c49efe4 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -24,8 +24,9 @@ struct file_region;
 /*
  * Minimum page order trackable by hugetlb cgroup.
  * At least 4 pages are necessary for all the tracking information.
- * The second tail page (hpage[2]) is the fault usage cgroup.
- * The third tail page (hpage[3]) is the reservation usage cgroup.
+ * The second tail page (hpage[SUBPAGE_INDEX_CGROUP]) is the fault
+ * usage cgroup. The third tail page (hpage[SUBPAGE_INDEX_CGROUP_RSVD])
+ * is the reservation usage cgroup.
  */
 #define HUGETLB_CGROUP_MIN_ORDER	2
 
@@ -66,9 +67,9 @@ __hugetlb_cgroup_from_page(struct page *page, bool rsvd)
 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return NULL;
 	if (rsvd)
-		return (struct hugetlb_cgroup *)page[3].private;
+		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP_RSVD);
 	else
-		return (struct hugetlb_cgroup *)page[2].private;
+		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP);
 }
 
 static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
@@ -90,9 +91,11 @@ static inline int __set_hugetlb_cgroup(struct page *page,
 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return -1;
 	if (rsvd)
-		page[3].private = (unsigned long)h_cg;
+		set_page_private(page + SUBPAGE_INDEX_CGROUP_RSVD,
+				 (unsigned long)h_cg);
 	else
-		page[2].private = (unsigned long)h_cg;
+		set_page_private(page + SUBPAGE_INDEX_CGROUP,
+				 (unsigned long)h_cg);
 	return 0;
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2b45235a70e9..0e8f13184de0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1360,7 +1360,7 @@ static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
 	if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
 		return;
 
-	page = head + page_private(head + 4);
+	page = head + page_private(head + SUBPAGE_INDEX_HWPOISON);
 
 	/*
 	 * Move PageHWPoison flag from head page to the raw error page,
@@ -1379,7 +1379,7 @@ static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
 		return;
 
 	if (free_vmemmap_pages_per_hpage(h)) {
-		set_page_private(head + 4, page - head);
+		set_page_private(head + SUBPAGE_INDEX_HWPOISON, page - head);
 	} else if (page != head) {
 		/*
 		 * Move PageHWPoison flag from head page to the raw error page,
@@ -1456,20 +1456,20 @@ struct hstate *size_to_hstate(unsigned long size)
 bool page_huge_active(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHuge(page), page);
-	return PageHead(page) && PagePrivate(&page[1]);
+	return PageHead(page) && PagePrivate(&page[SUBPAGE_INDEX_ACTIVE]);
 }
 
 /* never called for tail page */
 static void set_page_huge_active(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHeadHuge(page), page);
-	SetPagePrivate(&page[1]);
+	SetPagePrivate(&page[SUBPAGE_INDEX_ACTIVE]);
 }
 
 static void clear_page_huge_active(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHeadHuge(page), page);
-	ClearPagePrivate(&page[1]);
+	ClearPagePrivate(&page[SUBPAGE_INDEX_ACTIVE]);
 }
 
 /*
@@ -1481,17 +1481,17 @@ static inline bool PageHugeTemporary(struct page *page)
 	if (!PageHuge(page))
 		return false;
 
-	return (unsigned long)page[2].mapping == -1U;
+	return (unsigned long)page[SUBPAGE_INDEX_TEMPORARY].mapping == -1U;
 }
 
 static inline void SetPageHugeTemporary(struct page *page)
 {
-	page[2].mapping = (void *)-1U;
+	page[SUBPAGE_INDEX_TEMPORARY].mapping = (void *)-1U;
 }
 
 static inline void ClearPageHugeTemporary(struct page *page)
 {
-	page[2].mapping = NULL;
+	page[SUBPAGE_INDEX_TEMPORARY].mapping = NULL;
 }
 
 static void __free_huge_page(struct page *page)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index d3b4c39f67c0..bbcefd5fb7d1 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -232,6 +232,14 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int nr_pages = pages_per_huge_page(h);
 	unsigned int vmemmap_pages;
 
+	/*
+	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
+	 * page structs can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, so
+	 * add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
+	 */
+	BUILD_BUG_ON(NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
+
 	if (!hugetlb_free_vmemmap_enabled)
 		return;
 
-- 
2.11.0

