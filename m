Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5212F81C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbhAORLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:11:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729819AbhAORLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMVLMMoC7/lVRGIgCdIMxtKXCeDrCmUB3i6hisp0Dww=;
        b=E3QJIuN7XpHUZNK2jyzeSxVCgJ+2cwb3fVkvmvyyE3+olcAHPk1cQaTbIoK19ZqrQU/LMA
        b5Y+VeH0+lJoEU61/E+psSqQ29U0rSt1vIKbbQnZsVsoGomviRlCQu08hk+EwHl2iBJW3a
        GUr6XPCHqmnJK21qW/WfzIz3AZtPMuw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-J2PysoMlNb2HPumenzmwkw-1; Fri, 15 Jan 2021 12:10:01 -0500
X-MC-Unique: J2PysoMlNb2HPumenzmwkw-1
Received: by mail-qk1-f197.google.com with SMTP id i82so8618088qke.19
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sMVLMMoC7/lVRGIgCdIMxtKXCeDrCmUB3i6hisp0Dww=;
        b=C5YbAo5ZZYdk2SUwCrAK5qEAUxB90Lo8IpBb/eTiHhslV3sopBfPpkUFRXgM5EyPhm
         b9151Ojz31mRR6CZHTbaPz6ZuLM9GAs3fkwohrAmTrK1Qt5Q095nBamFcElrEWpXyq8S
         U2mvKQ+qYbANpv17vd+LsKeVM1zvfP1bnqJgO57ho6XH0PAuBg1IQNCKFm0lshWULbts
         QY5qRo6ggpH7Xc9S9dhVtlscw+6E4jOCo83W6RZozblGc+ZYVd/sr+iJ111NpFEF/Sx5
         9Ab+N7+F0opATT+My1iokvB0lSXhJ/zBF5z+NTRaBBXulaptt4h0z1FbEPL/2c2qa/Ez
         GJ5A==
X-Gm-Message-State: AOAM533E2zuIoCtQ0QdtwPz5Zkvgw+cREbRRuiWHOuiV9CJ8Ecr4oeme
        GJGcizSQ1kzf3aTE1zUB0Nn5UmBpl31jKTML7CNVDsfwGvD9mYMqmsNQrcKETqyT42HXda/FJYj
        Uv7gw3eCEt5wsZzrkl4M2SeA1DMLcA3JBJzX7ekDBgIHwk2KNAaUksCnSPplBxL6CiW3M8wMhXA
        ==
X-Received: by 2002:a37:aa57:: with SMTP id t84mr13907184qke.348.1610730600686;
        Fri, 15 Jan 2021 09:10:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpVqmDPrezOxqwa3bnjl7O2ntRnlxdZLk3dna2VNrZfC5BdmyIlUWV+uAZwcf84SZLYFbF3g==
X-Received: by 2002:a37:aa57:: with SMTP id t84mr13907135qke.348.1610730600356;
        Fri, 15 Jan 2021 09:10:00 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:59 -0800 (PST)
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
Subject: [PATCH RFC 26/30] hugetlb/userfaultfd: Handle uffd-wp special pte in hugetlb pf handler
Date:   Fri, 15 Jan 2021 12:09:03 -0500
Message-Id: <20210115170907.24498-27-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach the hugetlb page fault code to understand uffd-wp special pte.  For
example, when seeing such a pte we need to convert any write fault into a read
one (which is fake - we'll retry the write later if so).  Meanwhile, for
handle_userfault() we'll need to make sure we must wait for the special swap
pte too just like a none pte.

Note that we also need to teach UFFDIO_COPY about this special pte across the
code path so that we can safely install a new page at this special pte as long
as we know it's a stall entry.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c |  5 ++++-
 mm/hugetlb.c     | 35 ++++++++++++++++++++++++++++-------
 mm/userfaultfd.c |  3 ++-
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 3190dff39d6c..3264ec46242b 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -248,8 +248,11 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
 	 * changes under us.
+	 *
+	 * Regarding uffd-wp special case, please refer to comments in
+	 * userfaultfd_must_wait().
 	 */
-	if (huge_pte_none(pte))
+	if (huge_pte_none(pte) || pte_swp_uffd_wp_special(pte))
 		ret = true;
 	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
 		ret = true;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a971513cdff6..9b9f71ec30e1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4253,7 +4253,8 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep, unsigned int flags)
+			unsigned long address, pte_t *ptep,
+			pte_t old_pte, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
@@ -4297,6 +4298,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				.vma = vma,
 				.address = haddr,
 				.flags = flags,
+				.orig_pte = old_pte,
 				/*
 				 * Hard to debug if it ends up being
 				 * used by a callee that assumes
@@ -4394,7 +4396,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	ret = 0;
-	if (!huge_pte_none(huge_ptep_get(ptep)))
+	if (!pte_same(huge_ptep_get(ptep), old_pte))
 		goto backout;
 
 	if (anon_rmap) {
@@ -4404,6 +4406,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		page_dup_rmap(page, true);
 	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
+	if (unlikely(flags & FAULT_FLAG_UFFD_WP)) {
+		WARN_ON_ONCE(flags & FAULT_FLAG_WRITE);
+		/* We should have the write bit cleared already, but be safe */
+		new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
+	}
 	set_huge_pte_at(mm, haddr, ptep, new_pte);
 
 	hugetlb_count_add(pages_per_huge_page(h), mm);
@@ -4485,9 +4492,16 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, mm, ptep);
 			return 0;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
+		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
+		} else if (unlikely(is_swap_special_pte(entry))) {
+			/* Must be a uffd-wp special swap pte */
+			WARN_ON_ONCE(!pte_swp_uffd_wp_special(entry));
+			flags |= FAULT_FLAG_UFFD_WP;
+			/* Emulate a read fault */
+			flags &= ~FAULT_FLAG_WRITE;
+		}
 	}
 
 	/*
@@ -4519,8 +4533,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	entry = huge_ptep_get(ptep);
-	if (huge_pte_none(entry)) {
-		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep, flags);
+	/*
+	 * FAULT_FLAG_UFFD_WP should be handled merely the same as pte none
+	 * because it's basically a none pte with a special marker
+	 */
+	if (huge_pte_none(entry) || pte_swp_uffd_wp_special(entry)) {
+		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
+				      entry, flags);
 		goto out_mutex;
 	}
 
@@ -4651,7 +4670,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	unsigned long size;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	struct hstate *h = hstate_vma(dst_vma);
-	pte_t _dst_pte;
+	pte_t _dst_pte, cur_pte;
 	spinlock_t *ptl;
 	int ret;
 	struct page *page;
@@ -4725,8 +4744,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (idx >= size)
 		goto out_release_unlock;
 
+	cur_pte = huge_ptep_get(dst_pte);
 	ret = -EEXIST;
-	if (!huge_pte_none(huge_ptep_get(dst_pte)))
+	/* Please refer to shmem_mfill_atomic_pte() for uffd-wp special case */
+	if (!huge_pte_none(cur_pte) && !pte_swp_uffd_wp_special(cur_pte))
 		goto out_release_unlock;
 
 	if (vm_shared) {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3d49b888e3e8..1dff5b9a2c26 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -300,7 +300,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 
 		err = -EEXIST;
 		dst_pteval = huge_ptep_get(dst_pte);
-		if (!huge_pte_none(dst_pteval)) {
+		if (!huge_pte_none(dst_pteval) &&
+		    !pte_swp_uffd_wp_special(dst_pteval)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			i_mmap_unlock_read(mapping);
 			goto out_unlock;
-- 
2.26.2

