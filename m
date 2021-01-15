Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8A82F81CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbhAORMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:12:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733262AbhAORLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fzb3OrCvuj9u1ejMitFEdOZGsE/rKLZCXUuasJ8wkyY=;
        b=HaTIODwWSpDHyMcE6h58R2rzIHBgThQFXDUvSw/LF6lWJrDMnjlgkHOF5wyLEiYPik+4cQ
        4iVX96yzd2FtG6iTOJExul7e0hFLXQeJRqs39cu96MtHcDg3u7t8/CJX+8KxSn4Q6uYkib
        YAumIe01Eo9Nw3PHekR1cYDZhSOOlbg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-jQb4p1n3Oq6Qs-DZIYmQMQ-1; Fri, 15 Jan 2021 12:09:52 -0500
X-MC-Unique: jQb4p1n3Oq6Qs-DZIYmQMQ-1
Received: by mail-qv1-f70.google.com with SMTP id j24so8266368qvg.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fzb3OrCvuj9u1ejMitFEdOZGsE/rKLZCXUuasJ8wkyY=;
        b=CbY26I23ywlbgL5qWRGVbVCnjPawyOSL8bLUbC3G9oEBE9jBt3kKoVTV/6LsolnMIi
         lJvxqao9NmeIIn5lczvLSvctxTM9MXOiOQZoXK1g6bj+CNUt7Mh8M7W/LjpYwpder3BK
         M9ZgGRr/HGEvep+8MbqTa/4gdbHB0zS2BvKxhv498QDGV9djG7Xd7NquYRcFgk7RVo3l
         y7KaK+fB62KHlD2AB384ih8B5YsShHgGHg/dN36qdHfTz15RKkQ6V7aMFGf/57ipoqws
         5zFLwhSVDyLXdnNjjNP/ACx1qUoIZUqJpIwk18hiybj3zUjVEEN985j2izjkyAmMefuY
         vO6g==
X-Gm-Message-State: AOAM532SLPJ8AB98hz3hsiXYCjX5XyrfONWdgvlnm0ATXpHTxd/Nucrh
        8J6LtXetue0qGdN/7fKOlJXivSTNi5Dyi8ldyJvdHPjuGWI9OCTsorWpOktjbHzEv6zSg2nkeqv
        kbJ94cK8Z1NvSOuAq5kTGkyfV/E1Y/ZApuHPMyE/hAXJSQQ8Sok3+GrY92sDHB45aQiIRRx8NkQ
        ==
X-Received: by 2002:ac8:8ca:: with SMTP id y10mr1953485qth.330.1610730591539;
        Fri, 15 Jan 2021 09:09:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynPbJZARbFKUAqCyYrAIhsUHZ/PdW2ilr6NGS4nhJHsYltq257UUAHhzGtHV6iYBRr031H3A==
X-Received: by 2002:ac8:8ca:: with SMTP id y10mr1953445qth.330.1610730591246;
        Fri, 15 Jan 2021 09:09:51 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:50 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH RFC 21/30] hugetlb: Pass vma into huge_pte_alloc()
Date:   Fri, 15 Jan 2021 12:08:58 -0500
Message-Id: <20210115170907.24498-22-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a preparation work to be able to behave differently in the per
architecture huge_pte_alloc() according to different VMA attributes.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/hugetlbpage.c   | 2 +-
 arch/ia64/mm/hugetlbpage.c    | 3 ++-
 arch/mips/mm/hugetlbpage.c    | 4 ++--
 arch/parisc/mm/hugetlbpage.c  | 2 +-
 arch/powerpc/mm/hugetlbpage.c | 3 ++-
 arch/s390/mm/hugetlbpage.c    | 2 +-
 arch/sh/mm/hugetlbpage.c      | 2 +-
 arch/sparc/mm/hugetlbpage.c   | 2 +-
 include/linux/hugetlb.h       | 2 +-
 mm/hugetlb.c                  | 6 +++---
 mm/userfaultfd.c              | 2 +-
 11 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 55ecf6de9ff7..5b32ec888698 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -252,7 +252,7 @@ void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 		set_pte(ptep, pte);
 }
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgdp;
diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index b331f94d20ac..f993cb36c062 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -25,7 +25,8 @@ unsigned int hpage_shift = HPAGE_SHIFT_DEFAULT;
 EXPORT_SYMBOL(hpage_shift);
 
 pte_t *
-huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
+huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+	       unsigned long addr, unsigned long sz)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
 	pgd_t *pgd;
diff --git a/arch/mips/mm/hugetlbpage.c b/arch/mips/mm/hugetlbpage.c
index 77ffece9c270..c1d8f51c5255 100644
--- a/arch/mips/mm/hugetlbpage.c
+++ b/arch/mips/mm/hugetlbpage.c
@@ -21,8 +21,8 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr,
-		      unsigned long sz)
+pte_t *huge_pte_alloc(struct mm_struct *mm, structt vm_area_struct *vma,
+		      unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index d7ba014a7fbb..e141441bfa64 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -44,7 +44,7 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 }
 
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 36c3800769fb..2514884c0d20 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -106,7 +106,8 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
  * At this point we do the placement change only for BOOK3S 64. This would
  * possibly work on other subarchs.
  */
-pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+		      unsigned long addr, unsigned long sz)
 {
 	pgd_t *pg;
 	p4d_t *p4;
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 3b5a4d25ca9b..da36d13ffc16 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -189,7 +189,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 	return pte;
 }
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgdp;
diff --git a/arch/sh/mm/hugetlbpage.c b/arch/sh/mm/hugetlbpage.c
index 220d7bc43d2b..999ab5916e69 100644
--- a/arch/sh/mm/hugetlbpage.c
+++ b/arch/sh/mm/hugetlbpage.c
@@ -21,7 +21,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index ec423b5f17dd..ae06f7df9750 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -272,7 +272,7 @@ static unsigned long huge_tte_to_size(pte_t pte)
 	return size;
 }
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index fe1dde0afbaf..7d4c5669e118 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -162,7 +162,7 @@ extern struct list_head huge_boot_pages;
 
 /* arch callbacks */
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz);
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 18b236bac6cd..eb7cd0c7d6d2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3767,7 +3767,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		src_pte = huge_pte_offset(src, addr, sz);
 		if (!src_pte)
 			continue;
-		dst_pte = huge_pte_alloc(dst, addr, sz);
+		dst_pte = huge_pte_alloc(dst, vma, addr, sz);
 		if (!dst_pte) {
 			ret = -ENOMEM;
 			break;
@@ -4484,7 +4484,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 */
 	mapping = vma->vm_file->f_mapping;
 	i_mmap_lock_read(mapping);
-	ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
+	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
 	if (!ptep) {
 		i_mmap_unlock_read(mapping);
 		return VM_FAULT_OOM;
@@ -5407,7 +5407,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 480d91b783d4..3d49b888e3e8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -291,7 +291,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		err = -ENOMEM;
-		dst_pte = huge_pte_alloc(dst_mm, dst_addr, vma_hpagesize);
+		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			i_mmap_unlock_read(mapping);
-- 
2.26.2

