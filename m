Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C9C2F81D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbhAORMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:12:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733236AbhAORLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACj7dAXdw9MZrmiH0lb9ADzAHOunb4bShuydpXqJ1bw=;
        b=gGvLyj96yHCW/lOgqTNO7t/zFmWbU1OFt6d4QKskAxOlsM1RjWZnN4oEt1HQTTmb7oU6Z5
        4B/bL6kG4OAfWaaeNzX/nGMBckopvBNFGngum/oLY3vbf2wcoNz4AomgdgUJIULhRExCFZ
        rqqKGx1gBBBNd2n7MELNmP9iObzJbt4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-hQyxL3dqPzmtLAiwX473kA-1; Fri, 15 Jan 2021 12:09:50 -0500
X-MC-Unique: hQyxL3dqPzmtLAiwX473kA-1
Received: by mail-qt1-f199.google.com with SMTP id l7so7871062qth.15
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACj7dAXdw9MZrmiH0lb9ADzAHOunb4bShuydpXqJ1bw=;
        b=oIMjJlK/6wt55TF9k+kWRw0HqK3BsZoa12e1d1dKmmEF1Qy10y2D/SVRBIg57X27cl
         N0y7feSaKvEVKxVzOhGxkU/PnGAqK/BVkB7I2Z2/7fZEelsNcUZBibt/edUqcXskCEsQ
         GXtItHo6uuA/dz8EXg6hk9c2vp9RcM6qLu1OtoalzI9c2nrv1pGwNAvfkvFbvncVkgvi
         lBiBD6hYXSHnx2ID7luHlio/3SsTkROy36LCMwVtiLoQzjubdJsGb57fWZu2/oNLMJXb
         6ZMVE4H76vxU5PB059OGzXON7swVSt7RUrxAs+lU/CCuhWf1UI2Oim9WrCjkksTqkBPe
         KCvQ==
X-Gm-Message-State: AOAM533zOdKAc+OK8+vJ0pzJHT0CUKu3h++uGEgUi2TFW6WiRZbHCzoW
        AduwHsrlDppEM2McyoWG1jCQZpjfD1+zUQTMh81uZ6uKCAD+NOXDqPYJmHTEnICnBCFNa8vqwDi
        7wvAYjRG4K7ONHZhTXdowbeZ1f972jJVHkCDeS9PJdZSbajsvnUqdXLm9tdq03QCGlCrUqztGUg
        ==
X-Received: by 2002:a05:620a:145a:: with SMTP id i26mr13319249qkl.31.1610730589122;
        Fri, 15 Jan 2021 09:09:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJym5MvHIxxRQ18MHwTBywIzvX4iFw2g80I1OMBrnkwSP/L9AX0DIkatK4Nke7iZJFu9Bek/gQ==
X-Received: by 2002:a05:620a:145a:: with SMTP id i26mr13319205qkl.31.1610730588799;
        Fri, 15 Jan 2021 09:09:48 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:48 -0800 (PST)
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
Subject: [PATCH RFC 20/30] hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT
Date:   Fri, 15 Jan 2021 12:08:57 -0500
Message-Id: <20210115170907.24498-21-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This starts from passing cp_flags into hugetlb_change_protection() so hugetlb
will be able to handle MM_CP_UFFD_WP[_RESOLVE] requests.

huge_pte_clear_uffd_wp() is introduced to handle the case where the
UFFDIO_WRITEPROTECT is requested upon migrating huge page entries.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/asm-generic/hugetlb.h |  5 +++++
 include/linux/hugetlb.h       |  6 ++++--
 mm/hugetlb.c                  | 13 ++++++++++++-
 mm/mprotect.c                 |  3 ++-
 mm/userfaultfd.c              |  8 ++++++++
 5 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 548212eccbd6..181cdc3297e7 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -32,6 +32,11 @@ static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
 	return pte_mkuffd_wp(pte);
 }
 
+static inline pte_t huge_pte_clear_uffd_wp(pte_t pte)
+{
+	return pte_clear_uffd_wp(pte);
+}
+
 static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return pte_modify(pte, newprot);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bd061f7eedcb..fe1dde0afbaf 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -185,7 +185,8 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot);
+		unsigned long address, unsigned long end, pgprot_t newprot,
+		unsigned long cp_flags);
 
 bool is_hugetlb_entry_migration(pte_t pte);
 
@@ -343,7 +344,8 @@ static inline void move_hugetlb_state(struct page *oldpage,
 
 static inline unsigned long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
-			unsigned long end, pgprot_t newprot)
+			unsigned long end, pgprot_t newprot,
+			unsigned long cp_flags)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 563b8f70537f..18b236bac6cd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4938,7 +4938,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 #endif
 
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot)
+		unsigned long address, unsigned long end,
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long start = address;
@@ -4948,6 +4949,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	unsigned long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
+	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
+	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -4988,6 +4991,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 				make_migration_entry_read(&entry);
 				newpte = swp_entry_to_pte(entry);
+				if (uffd_wp)
+					newpte = pte_swp_mkuffd_wp(newpte);
+				else if (uffd_wp_resolve)
+					newpte = pte_swp_clear_uffd_wp(newpte);
 				set_huge_swap_pte_at(mm, address, ptep,
 						     newpte, huge_page_size(h));
 				pages++;
@@ -5001,6 +5008,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			old_pte = huge_ptep_modify_prot_start(vma, address, ptep);
 			pte = pte_mkhuge(huge_pte_modify(old_pte, newprot));
 			pte = arch_make_huge_pte(pte, vma, NULL, 0);
+			if (uffd_wp)
+				pte = huge_pte_mkuffd_wp(huge_pte_wrprotect(pte));
+			else if (uffd_wp_resolve)
+				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
 		}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 055871322007..fce87ac99117 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -416,7 +416,8 @@ unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
 
 	if (is_vm_hugetlb_page(vma))
-		pages = hugetlb_change_protection(vma, start, end, newprot);
+		pages = hugetlb_change_protection(vma, start, end, newprot,
+						  cp_flags);
 	else
 		pages = change_protection_range(vma, start, end, newprot,
 						cp_flags);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index b00e5e6b8b8b..480d91b783d4 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -644,6 +644,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			unsigned long len, bool enable_wp, bool *mmap_changing)
 {
 	struct vm_area_struct *dst_vma;
+	unsigned long page_mask;
 	pgprot_t newprot;
 	int err;
 
@@ -680,6 +681,13 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	if (!vma_is_anonymous(dst_vma))
 		goto out_unlock;
 
+	if (is_vm_hugetlb_page(dst_vma)) {
+		err = -EINVAL;
+		page_mask = vma_kernel_pagesize(dst_vma) - 1;
+		if ((start & page_mask) || (len & page_mask))
+			goto out_unlock;
+	}
+
 	if (enable_wp)
 		newprot = vm_get_page_prot(dst_vma->vm_flags & ~(VM_WRITE));
 	else
-- 
2.26.2

