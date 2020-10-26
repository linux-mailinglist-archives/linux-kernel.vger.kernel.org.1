Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C780299020
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782328AbgJZOyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:54:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37176 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782317AbgJZOyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:54:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id h6so6209346pgk.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=62sJLFC5qaviauwqJB3pO8xInKXpUuGZMPO48y/09V8=;
        b=E2DMLsxpmGHKlvPmLN1N5iU2wqQwHqzY287Nsy5ruOE/T5mk1H1hk9WTSjOi+bG2V8
         5alFT20plSRPBNheJ4zDZCNi8mpNJdtbbqhaUVcw5tcTlJlOJjxGwBToP1hKUddRg9kW
         /3YAKRqCOyBL7aTLyGPro9TCG7ioR/5md5ih04LbYPEdpLXcRrF4bmvpJckuiXCMEnrc
         sTPpJTDgj/VfsAiEqVIEXyxRmmyVQO2u1oZXyOa6/hWHKqqT3OvogkC5UozuhyvnWrjH
         KXj6qUgAwsZR84ulOWMchaf42su8oS6BkMulSUYJlOlCkXm8eKF0+p9Ps6jMePAtOgKV
         lgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=62sJLFC5qaviauwqJB3pO8xInKXpUuGZMPO48y/09V8=;
        b=tNWw0QqcpMVn5I+YZHHEhSXkptCoqfHufPunUsZVWGnW5p+461zGg5eiKYiCYAMwlF
         NBtyoL564QPFacDurJihzU7AivZIXtpJ47Gu3c5vfD4CXnOBXzOjz+gvtXpx5F3HbVE3
         BF6Tn/j/IUzhNza31JacvGhoBbeeSRScY8JZjJX0/KHT7aEHa+d8OSPnUU+cFSqJKBvJ
         zKlUn8Vo6JWWAGrOwJjG0aZ0acf3XIBH7Xsd/SrK8iTwC20YM8/9zQjA1UI4fBFoz8J5
         2DB0EDco8jY015Nb8Qni3d/BIA93v7JpafzCX7xIAtMFDZy15Lz3dZ/OgB4tc+uyksjP
         CkLA==
X-Gm-Message-State: AOAM533OFtdLVbPN0IgSE1U88M9ASyO50oDbmKXjf6uTPYmjZK7JHYBi
        5pIlsRXiqTrLUb4HD3umkkLvxw==
X-Google-Smtp-Source: ABdhPJyC8dQjQhTifcsA62I1rIpvskV6p/l27f24b4l6Lips7HNddPFPZaRqoSS+KZGDJKzhLOv/GQ==
X-Received: by 2002:a63:7e4f:: with SMTP id o15mr13922448pgn.428.1603724076786;
        Mon, 26 Oct 2020 07:54:36 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.54.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:54:36 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 09/19] mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb page
Date:   Mon, 26 Oct 2020 22:51:04 +0800
Message-Id: <20201026145114.59424-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we free a hugetlb page to the buddy, we should allocate the vmemmap
pages associated with it. We can do that in the __free_hugepage().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a5500c79e2df..cea580058a16 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1299,6 +1299,7 @@ static void __free_hugepage(struct hstate *h, struct page *page);
 
 #define RESERVE_VMEMMAP_NR	2U
 #define RESERVE_VMEMMAP_SIZE	(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
+#define GFP_VMEMMAP_PAGE	(GFP_KERNEL | __GFP_NOFAIL | __GFP_MEMALLOC)
 
 #define page_huge_pte(page)	((page)->pmd_huge_pte)
 
@@ -1604,6 +1605,107 @@ static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 	free_vmemmap_page_list(&free_pages);
 }
 
+static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
+					  unsigned long start,
+					  unsigned int nr_remap,
+					  struct list_head *remap_pages)
+{
+	void *from = (void *)page_private(reuse);
+	unsigned long addr, end = start + (nr_remap << PAGE_SHIFT);
+
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
+		void *to;
+		struct page *page;
+		pte_t entry, old = *ptep;
+
+		page = list_first_entry_or_null(remap_pages, struct page, lru);
+		list_del(&page->lru);
+		to = page_to_virt(page);
+		copy_page(to, from);
+
+		/*
+		 * Make sure that any data that writes to the @to is made
+		 * visible to the physical page.
+		 */
+		flush_kernel_vmap_range(to, PAGE_SIZE);
+
+		prepare_vmemmap_page(page);
+
+		entry = mk_pte(page, PAGE_KERNEL);
+		set_pte_at(&init_mm, addr, ptep++, entry);
+
+		VM_BUG_ON(!pte_present(old) || pte_page(old) != reuse);
+	}
+}
+
+static void __remap_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
+					  unsigned long addr,
+					  struct list_head *remap_pages)
+{
+	unsigned long next;
+	unsigned long start = addr + RESERVE_VMEMMAP_NR * PAGE_SIZE;
+	unsigned long end = addr + nr_vmemmap_size(h);
+	struct page *reuse = NULL;
+
+	addr = start;
+	do {
+		unsigned int nr_pages;
+		pte_t *ptep;
+
+		ptep = pte_offset_kernel(pmd, addr);
+		if (!reuse) {
+			reuse = pte_page(ptep[-1]);
+			set_page_private(reuse, addr - PAGE_SIZE);
+		}
+
+		next = vmemmap_hpage_addr_end(addr, end);
+		nr_pages = (next - addr) >> PAGE_SHIFT;
+		__remap_huge_page_pte_vmemmap(reuse, ptep, addr, nr_pages,
+					      remap_pages);
+	} while (pmd++, addr = next, addr != end);
+
+	flush_tlb_kernel_range(start, end);
+}
+
+static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
+{
+	int i;
+
+	for (i = 0; i < nr_free_vmemmap(h); i++) {
+		struct page *page;
+
+		/* This should not fail */
+		page = alloc_page(GFP_VMEMMAP_PAGE);
+		list_add_tail(&page->lru, list);
+	}
+}
+
+static void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	pmd_t *pmd;
+	spinlock_t *ptl;
+	LIST_HEAD(remap_pages);
+
+	if (!nr_free_vmemmap(h))
+		return;
+
+	alloc_vmemmap_pages(h, &remap_pages);
+
+	pmd = vmemmap_to_pmd(head);
+	ptl = vmemmap_pmd_lockptr(pmd);
+
+	spin_lock(ptl);
+	__remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head,
+				      &remap_pages);
+	if (!freed_vmemmap_hpage_dec(pmd_page(*pmd))) {
+		/*
+		 * Todo:
+		 * Merge pte to huge pmd if it has ever been split.
+		 */
+	}
+	spin_unlock(ptl);
+}
+
 /*
  * As update_and_free_page() is be called from a non-task context(and hold
  * hugetlb_lock), we can defer the actual freeing in a workqueue to prevent
@@ -1679,6 +1781,10 @@ static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
 
+static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+}
+
 static inline void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	__free_hugepage(h, page);
@@ -1711,6 +1817,8 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 {
 	int i;
 
+	alloc_huge_page_vmemmap(h, page);
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
-- 
2.20.1

