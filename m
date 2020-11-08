Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24542AAB7A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 15:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgKHONe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 09:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgKHONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:13:32 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA12DC0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 06:13:32 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 10so5524072pfp.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 06:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPUydp30fWy+MU4/eu8iga11LsHGz1kfWVa+NKHtmHo=;
        b=cLzCshRbriymhPy8zuYQduoXq9+a5XMwMsn0or3GXr1jYGac/3kzJgw6uXfG0dXdrB
         PUPlzhveufYg6Xh5hY3e0YOsUlwRJBLu9R7Pc2y8G1hykgBC/H+7Lx1DWIwiDm8YKZZP
         8uhY7TLqHJOQis5OfKVQ3GuqHLgGMwNm4hCxIa2ln4Dyt0RbnGHEZka/BQYXFfjkBag3
         D5Qi/qXZBIAKNmcQGXYiAaHIGfhQHx383QjialHV6tS4/TrS9t4/Xtah7vrkDO9+DOjz
         STWHboPyr55qqSflyWAnyP9OzDc0QcvMego/foAXNVokTvf8c9zcpLTi8W3b8KpdP448
         ZLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPUydp30fWy+MU4/eu8iga11LsHGz1kfWVa+NKHtmHo=;
        b=aKDarqHvL7SuxUMzzBO86NujtFzHORxAVu1/IJVp1IFWMlXo7PIAXOhu6RaY6bjaXz
         nRZpIJ0LIQN4ahAbcoTKk1KmUX4T8QVb+oZN0R9vSj4bfaaUedezN0X/f3mCETZ0VS3l
         Asve0FCRONz1A5LU/8Ge4tiE+QKmVqaOgE3HBzwKE9fQ6HLE14IzJwCIIogpICdEy5By
         PRxl7QfmoxYwxakSlqWrpGV/FP5sRublZur0cCBleWNbXqqPUA+lXO6IHgXztFKzTCuI
         tim7inxH1El409APj8Git3t0XZo6y7ASM1q951k7h3D7SoDyQzSBgihrrgnXe6vGn0Sd
         ffyw==
X-Gm-Message-State: AOAM533Mmxm+EA0Uu8ErBs30y0X3P7ePxfg9rh7zUNPCvSkvIaTjbd64
        DQ7dQcPBOKCT0SMj4bglZKKcJg==
X-Google-Smtp-Source: ABdhPJwEw5PPDdZNhvD9uElUQkqM9KX15pUXzknhBUUDOT9pBIO6vjW9WXNHV5zSOfgtkR+QAZwFjA==
X-Received: by 2002:a62:92c5:0:b029:156:6a7f:ccff with SMTP id o188-20020a6292c50000b02901566a7fccffmr10007401pfd.39.1604844812258;
        Sun, 08 Nov 2020 06:13:32 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.13.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:13:31 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 11/21] mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb page
Date:   Sun,  8 Nov 2020 22:11:03 +0800
Message-Id: <20201108141113.65450-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we free a hugetlb page to the buddy, we should allocate the vmemmap
pages associated with it. We can do that in the __free_hugepage().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ded7f0fbde35..8295911fe76e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1307,6 +1307,8 @@ static void __free_hugepage(struct hstate *h, struct page *page);
  * reserve at least 2 pages as vmemmap areas.
  */
 #define RESERVE_VMEMMAP_NR	2U
+#define RESERVE_VMEMMAP_SIZE	(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
+#define GFP_VMEMMAP_PAGE	(GFP_KERNEL | __GFP_NOFAIL | __GFP_MEMALLOC)
 
 #define page_huge_pte(page)	((page)->pmd_huge_pte)
 
@@ -1490,7 +1492,7 @@ static void __free_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
 					 struct list_head *free_pages)
 {
 	unsigned long next;
-	unsigned long start = addr + RESERVE_VMEMMAP_NR * PAGE_SIZE;
+	unsigned long start = addr + RESERVE_VMEMMAP_SIZE;
 	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
 	struct page *reuse = NULL;
 
@@ -1578,6 +1580,106 @@ static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 	free_vmemmap_page_list(&free_pages);
 }
 
+static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
+					  unsigned long start,
+					  unsigned int nr_remap,
+					  struct list_head *remap_pages)
+{
+	pgprot_t pgprot = PAGE_KERNEL;
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
+		entry = mk_pte(page, pgprot);
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
+	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
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
+	for (i = 0; i < free_vmemmap_pages_per_hpage(h); i++) {
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
+	if (!free_vmemmap_pages_per_hpage(h))
+		return;
+
+	alloc_vmemmap_pages(h, &remap_pages);
+
+	pmd = vmemmap_to_pmd(head);
+	ptl = vmemmap_pmd_lock(pmd);
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
@@ -1653,6 +1755,10 @@ static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
 
+static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+}
+
 static inline void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	__free_hugepage(h, page);
@@ -1685,6 +1791,8 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 {
 	int i;
 
+	alloc_huge_page_vmemmap(h, page);
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
-- 
2.11.0

