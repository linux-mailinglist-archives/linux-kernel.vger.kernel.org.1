Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C224D2F81E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387672AbhAORNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:13:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbhAORKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxL/EXqPGyWZMDtVPV4yKceP//rOWf13NhV4Ho8YVV0=;
        b=ZdJmvZgOVCinHeIqETk1S500noIQt155xhoMVl3XHHjTntPRBkTgSN2414/KmRH3kyeYyh
        vSFulniRrUN4+SvPKAt0S/miFOKVhhCTQKvNxwAMrCzLCgoVJqOpLDpgeJSTDKM/wokHjk
        M+hjt0O39I5W47EeyTQ8ln9Ky5c2iB4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-KLEE-SqIPgS9bLT47jCnXw-1; Fri, 15 Jan 2021 12:09:14 -0500
X-MC-Unique: KLEE-SqIPgS9bLT47jCnXw-1
Received: by mail-qk1-f200.google.com with SMTP id s66so8604848qkh.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uxL/EXqPGyWZMDtVPV4yKceP//rOWf13NhV4Ho8YVV0=;
        b=shEMoHQ/aXgkpyYXIcHHxQZ5BZVGb6zvnncq2eJRU5kU2yRp07n07dnp6BSGPpqGe2
         fa3IixIUIlVlOnZVfwwAEMJHxAxyDXqM67/S4lRBCus+D2kntoGRk7uYb21plhLus17Z
         ggybsG35lDSnBl0werF9Z5q8Z5y1881YuYjrwUQb2HoUVnsEu+rz1uPaiW2YG/FUys5k
         5L0ahG6M8NMT4y6B6fRKD3HS5HlkbcYi+Llt8W2tgGtsuwq/WKb1xWGdo312SgK6CfVJ
         g/oHipoui3b2boeyeFCA7uryYhIz8rRwqKrk/UKd3E1UBLtAvOr0qB/MsEVnRQP1/4ge
         W/7w==
X-Gm-Message-State: AOAM530yywWbdG7xWUcPpOOVFtqBgjDAvW2UPqVZtxa4aU/QP21iL8L3
        NMg++74VCi8+ObAIHue8LRluok9ZcMElkaf/sZbs98FahtWtH1NzyqPC5b/83IUOcRzvrKcC7I5
        v6qkvajXXQL5l3mG3TUghin6qke0ol8WYKoHWg/OHxBPVj9AlXYxjoSqnb88VSDJPm4+eH12f+g
        ==
X-Received: by 2002:ac8:4e0e:: with SMTP id c14mr12659987qtw.71.1610730553228;
        Fri, 15 Jan 2021 09:09:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxk/GhB36vk+VQJjp7yB/I/Ci+O+t+37/F8esLD26hM8u75lmGxSsENJDlgYLD/4ZSHsS7ccw==
X-Received: by 2002:ac8:4e0e:: with SMTP id c14mr12659938qtw.71.1610730552804;
        Fri, 15 Jan 2021 09:09:12 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:12 -0800 (PST)
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
Subject: [PATCH RFC 02/30] mm/userfaultfd: Fix uffd-wp special cases for fork()
Date:   Fri, 15 Jan 2021 12:08:39 -0500
Message-Id: <20210115170907.24498-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We tried to do something similar in b569a1760782 ("userfaultfd: wp: drop
_PAGE_UFFD_WP properly when fork") previously, but it's not doing it all
right..  A few fixes around the code path:

  1. We were referencing VM_UFFD_WP vm_flags on the _old_ vma rather than the
     new vma.  That's overlooked in b569a1760782, so it won't work as expected.
     Thanks to the recent rework on fork code (7a4830c380f3a8b3), we can easily
     get the new vma now, so switch the checks to that.

  2. Dropping the uffd-wp bit in copy_huge_pmd() could be wrong if the huge pmd
     is a migration huge pmd.  When it happens, instead of using pmd_uffd_wp(),
     we should use pmd_swp_uffd_wp(). The fix is simply to handle them separately.

  3. Forget to carry over uffd-wp bit for a write migration huge pmd entry.
     This also happens in copy_huge_pmd(), where we converted a write huge
     migration entry into a read one.

  4. In copy_nonpresent_pte(), drop uffd-wp if necessary for swap ptes.

  5. In copy_present_page() when COW is enforced when fork(), we also need to
     pass over the uffd-wp bit if VM_UFFD_WP is armed on the new vma, and when
     the pte to be copied has uffd-wp bit set.

Remove the comment in copy_present_pte() about this.  It won't help a huge lot
to only comment there, but comment everywhere would be an overkill.  Let's
assume the commit messages would help.

Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Fixes: b569a1760782f3da03ff718d61f74163dea599ff
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h |  3 ++-
 mm/huge_memory.c        | 23 ++++++++++-------------
 mm/memory.c             | 24 +++++++++++++-----------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0365aa97f8e7..77b8d2132c3a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -10,7 +10,8 @@
 extern vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
 extern int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			 pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
-			 struct vm_area_struct *vma);
+			 struct vm_area_struct *src_vma,
+			 struct vm_area_struct *dst_vma);
 extern void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd);
 extern int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			 pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b64ad1947900..35d4acac6874 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -996,7 +996,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
-		  struct vm_area_struct *vma)
+		  struct vm_area_struct *src_vma, struct vm_area_struct *dst_vma)
 {
 	spinlock_t *dst_ptl, *src_ptl;
 	struct page *src_page;
@@ -1005,7 +1005,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	int ret = -ENOMEM;
 
 	/* Skip if can be re-fill on fault */
-	if (!vma_is_anonymous(vma))
+	if (!vma_is_anonymous(dst_vma))
 		return 0;
 
 	pgtable = pte_alloc_one(dst_mm);
@@ -1019,14 +1019,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	ret = -EAGAIN;
 	pmd = *src_pmd;
 
-	/*
-	 * Make sure the _PAGE_UFFD_WP bit is cleared if the new VMA
-	 * does not have the VM_UFFD_WP, which means that the uffd
-	 * fork event is not enabled.
-	 */
-	if (!(vma->vm_flags & VM_UFFD_WP))
-		pmd = pmd_clear_uffd_wp(pmd);
-
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 	if (unlikely(is_swap_pmd(pmd))) {
 		swp_entry_t entry = pmd_to_swp_entry(pmd);
@@ -1037,11 +1029,15 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			pmd = swp_entry_to_pmd(entry);
 			if (pmd_swp_soft_dirty(*src_pmd))
 				pmd = pmd_swp_mksoft_dirty(pmd);
+			if (pmd_swp_uffd_wp(*src_pmd))
+				pmd = pmd_swp_mkuffd_wp(pmd);
 			set_pmd_at(src_mm, addr, src_pmd, pmd);
 		}
 		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 		mm_inc_nr_ptes(dst_mm);
 		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+		if (!(dst_vma->vm_flags & VM_UFFD_WP))
+			pmd = pmd_swp_clear_uffd_wp(pmd);
 		set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 		ret = 0;
 		goto out_unlock;
@@ -1077,13 +1073,13 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * best effort that the pinned pages won't be replaced by another
 	 * random page during the coming copy-on-write.
 	 */
-	if (unlikely(is_cow_mapping(vma->vm_flags) &&
+	if (unlikely(is_cow_mapping(src_vma->vm_flags) &&
 		     atomic_read(&src_mm->has_pinned) &&
 		     page_maybe_dma_pinned(src_page))) {
 		pte_free(dst_mm, pgtable);
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
-		__split_huge_pmd(vma, src_pmd, addr, false, NULL);
+		__split_huge_pmd(src_vma, src_pmd, addr, false, NULL);
 		return -EAGAIN;
 	}
 
@@ -1093,8 +1089,9 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 out_zero_page:
 	mm_inc_nr_ptes(dst_mm);
 	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
-
 	pmdp_set_wrprotect(src_mm, addr, src_pmd);
+	if (!(dst_vma->vm_flags & VM_UFFD_WP))
+		pmd = pmd_clear_uffd_wp(pmd);
 	pmd = pmd_mkold(pmd_wrprotect(pmd));
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 
diff --git a/mm/memory.c b/mm/memory.c
index c48f8df6e502..d6d2873368e1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -696,10 +696,10 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 static unsigned long
 copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
-		unsigned long addr, int *rss)
+		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *src_vma,
+		struct vm_area_struct *dst_vma, unsigned long addr, int *rss)
 {
-	unsigned long vm_flags = vma->vm_flags;
+	unsigned long vm_flags = dst_vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
 	swp_entry_t entry = pte_to_swp_entry(pte);
@@ -768,6 +768,8 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
 	}
+	if (!userfaultfd_wp(dst_vma))
+		pte = pte_swp_clear_uffd_wp(pte);
 	set_pte_at(dst_mm, addr, dst_pte, pte);
 	return 0;
 }
@@ -839,6 +841,9 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	/* All done, just insert the new page copy in the child */
 	pte = mk_pte(new_page, dst_vma->vm_page_prot);
 	pte = maybe_mkwrite(pte_mkdirty(pte), dst_vma);
+	if (userfaultfd_wp(dst_vma) && pte_uffd_wp(*src_pte))
+		/* Uffd-wp needs to be delivered to dest pte as well */
+		pte = pte_wrprotect(pte_mkuffd_wp(pte));
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
 	return 0;
 }
@@ -888,12 +893,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		pte = pte_mkclean(pte);
 	pte = pte_mkold(pte);
 
-	/*
-	 * Make sure the _PAGE_UFFD_WP bit is cleared if the new VMA
-	 * does not have the VM_UFFD_WP, which means that the uffd
-	 * fork event is not enabled.
-	 */
-	if (!(vm_flags & VM_UFFD_WP))
+	if (!(dst_vma->vm_flags & VM_UFFD_WP))
 		pte = pte_clear_uffd_wp(pte);
 
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
@@ -968,7 +968,8 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		if (unlikely(!pte_present(*src_pte))) {
 			entry.val = copy_nonpresent_pte(dst_mm, src_mm,
 							dst_pte, src_pte,
-							src_vma, addr, rss);
+							src_vma, dst_vma,
+							addr, rss);
 			if (entry.val)
 				break;
 			progress += 8;
@@ -1046,7 +1047,8 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			int err;
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm,
-					    dst_pmd, src_pmd, addr, src_vma);
+					    dst_pmd, src_pmd, addr, src_vma,
+					    dst_vma);
 			if (err == -ENOMEM)
 				return -ENOMEM;
 			if (!err)
-- 
2.26.2

