Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8297326A955
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 18:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgIOQHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 12:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727313AbgIOPSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600183073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=60/kh//GDCvP2xM12zggzBGJulNI8TqJRDHUA++p484=;
        b=YXgF1fB2TH37DoHfeiqQlyqP+ap4qU0Dqfj6OpcoTjkTv7/2OmO5e+VJujF365mye383ew
        iQdfDeakiXY1QOGDH+jSaQqJ4UQIsOCUO+07/CGN39YsGdJ8m03gMuWzgHhrmjCLwEfgBN
        VdAOGa7qI5vBiXHqk7r/uKqxjN6KDWA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-xU_kU-hWPfWiP-bZHvNVkA-1; Tue, 15 Sep 2020 11:17:50 -0400
X-MC-Unique: xU_kU-hWPfWiP-bZHvNVkA-1
Received: by mail-qk1-f200.google.com with SMTP id s141so3093445qka.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=60/kh//GDCvP2xM12zggzBGJulNI8TqJRDHUA++p484=;
        b=gIqOI5sDIOAuyP/scZfl3HU7hddJxvvjUW7bKPFCk5CaIGYUbt956pNw0TEb8EHRTS
         4z0D6+h22TZQ1k4zAPbP+jXdGEIpmHdkXcrInvTMe7No7FvofKRfb5NZ4aeabc8qeqp6
         T/eSIDr08omTCVQVnP4ZtH7NxE3MyRuNkZCdTs/RD0fwctY1L4g8i+7qrSW6CaghDaNV
         I35uIX8mA64qXg+c0Zbvt2cnYVZJ5aLB4pDP7F7JD9MVSKBXqxQl30rfEe9OWHPw6gD5
         iSuBdsmXN708zbB4d6iC39OYiHTFp/2MEUwv9MX1GdSh+P2xqetByG5IQF2/ZhS4gh/W
         l8rw==
X-Gm-Message-State: AOAM531m0tL8kKO+GrqwG7oZ/rQ02hHxkWtUrw059XDcQSR5k7J26veA
        1YBX8UiGZ2ADWydReTsVYRYzB1LbBLXO79LI/5Qy99lwQ1ZKH+f4zRXFSGvik0KqJKdRBWAp/6o
        y+2gQNfK4h76wsTVddQB5Uykf
X-Received: by 2002:a37:9d86:: with SMTP id g128mr17578111qke.26.1600183069874;
        Tue, 15 Sep 2020 08:17:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpywjXiIwUlAxOMJpbcnI5i/QOZGhl5WE2DXPQjOMtlW8uHq7jJ+kn52iySytIGb3dkhMCzA==
X-Received: by 2002:a37:9d86:: with SMTP id g128mr17578082qke.26.1600183069565;
        Tue, 15 Sep 2020 08:17:49 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id x49sm17340916qtc.94.2020.09.15.08.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:17:48 -0700 (PDT)
Date:   Tue, 15 Sep 2020 11:17:46 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200915151746.GB2949@xz-x1>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-2-peterx@redhat.com>
 <20200914143829.GA1424636@nvidia.com>
 <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
 <20200914183436.GD30881@xz-x1>
 <20200914211515.GA5901@xz-x1>
 <20200914225542.GO904879@nvidia.com>
 <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
 <20200914232851.GH1221970@ziepe.ca>
 <20200915145040.GA2949@xz-x1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20200915145040.GA2949@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Sep 15, 2020 at 10:50:40AM -0400, Peter Xu wrote:
> Hi, all,
> 
> I prepared another version of the FOLL_PIN enforced cow patch attached, just in
> case it would still be anything close to useful (though now I highly doubt it
> considering below...).  I took care of !USERFAULTFD as suggested by Leon, and
> also the fast gup path.

Now with the patch attached (for real..).

> 
> However...
> 
> On Mon, Sep 14, 2020 at 08:28:51PM -0300, Jason Gunthorpe wrote:
> > Yes, this stuff does pin_user_pages_fast() and MADV_DONTFORK
> > together. It sets FOLL_FORCE and FOLL_WRITE to get an exclusive copy
> > of the page and MADV_DONTFORK was needed to ensure that a future fork
> > doesn't establish a COW that would break the DMA by moving the
> > physical page over to the fork. DMA should stay with the process that
> > called pin_user_pages_fast() (Is MADV_DONTFORK still needed with
> > recent years work to GUP/etc? It is a pretty terrible ancient thing)
> 
> ... Now I'm more confused on what has happened.
> 
> If we're with FORCE|WRITE, iiuc it should guarantee that the page will trigger
> COW during gup even if it is shared, so no problem on the gup side.  Then I'm
> quite confused on why the write bit is not set when cow triggered.
> 
> E.g., in wp_page_copy(), if I'm not wrong, the write bit is only controlled by
> (besides the fix patch, though I believe the rdma test should have nothing to
> do with uffd-wp after all so it should be the same anyways):
> 
>         entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> 
> It means, as long as the rdma region has VM_WRITE set (which I think of no
> reason on why it shouldn't...), then it should have the write bit in the COWed
> page entry.  If so, the page should be stable and I don't undersdand why
> another COW could even trigger and how the code path in the "trial cow" patch
> is triggered.
> 
> Or, the VMA is without VM_WRITE due to some reason?  Sorry I probably know
> nothing about RDMA, more information on that side might help too. E.g., is the
> hardware going to walk the software process page table too when doing RDMA (or
> is IOMMU page table used, or none)?
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-gup-Allow-enfornced-COW-for-FOLL_PIN.patch"

From 37c24a746b769b3cbf619a1d1d57052728b203cb Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Mon, 14 Sep 2020 15:34:41 -0400
Subject: [PATCH] mm/gup: Allow enfornced COW for FOLL_PIN

FOLL_PIN may need the enforced COW mechanism as reported by Jason and analyzed
by Linus [1].  This is a continued work based on previous patch [2], however
there's some trivial differences.

Instead of applying enforced COW everywhere, we only apply it for FOLL_PIN to
make sure the pages that were pinned will not be COWed again later on.  In
other words, we'll do early phase COW for pinned page along with the gup
procedure.  And since only FOLL_PIN is affected, we don't need to introduce a
new flag as FOLL_BREAK_COW.  However we'll still need a new fault flag as
FAULT_FLAG_BREAK_COW inside the page fault handler.

Now userfaultfd-wp needs to be ready with COW happening since read gup could
trigger COW now with FOLL_PIN (which will never happen previously).  So when
COW happens we'll need to carry over the uffd-wp bits too if it's there.

Meanwhile, both userfaultfd_pte_wp() and userfaultfd_huge_pmd_wp() need to be
smarter than before on that it needs to return true only if this is a "real"
write fault.  With that extra check, we can identify a real write against an
enforced COW procedure from a FOLL_PIN gup.

Note: hugetlbfs is not considered throughout this patch, because it's missing
some required bits after all (like proper setting of FOLL_COW when page fault
retries).  Considering we may want to unbreak RDMA tests even during the rcs,
this patch only fixes the non-hugetlbfs cases. THPs should still be in count.

[1] https://lore.kernel.org/lkml/20200914143829.GA1424636@nvidia.com
[2] https://lore.kernel.org/lkml/20200811183950.10603-1-peterx@redhat.com

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h            |  2 ++
 include/linux/userfaultfd_k.h | 18 ++++++++----------
 mm/gup.c                      | 21 ++++++++++++++-------
 mm/huge_memory.c              | 17 ++++++++++++-----
 mm/memory.c                   | 16 +++++++++-------
 5 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ca6e6a81576b..741574bfd343 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -416,6 +416,7 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_BREAK_COW: Do COW explicitly for the fault (even for read).
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -446,6 +447,7 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_REMOTE			0x80
 #define FAULT_FLAG_INSTRUCTION  		0x100
 #define FAULT_FLAG_INTERRUPTIBLE		0x200
+#define FAULT_FLAG_BREAK_COW			0x400
 
 /*
  * The default fault flags that should be used by most of the
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index a8e5f3ea9bb2..b6ea5381afb3 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -62,16 +62,16 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_UFFD_WP;
 }
 
-static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
-				      pte_t pte)
+static inline bool userfaultfd_pte_wp(struct vm_fault *vmf, pte_t pte)
 {
-	return userfaultfd_wp(vma) && pte_uffd_wp(pte);
+	return (vmf->flags & FAULT_FLAG_WRITE) &&
+	    userfaultfd_wp(vmf->vma) && pte_uffd_wp(pte);
 }
 
-static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
-					   pmd_t pmd)
+static inline bool userfaultfd_huge_pmd_wp(struct vm_fault *vmf, pmd_t pmd)
 {
-	return userfaultfd_wp(vma) && pmd_uffd_wp(pmd);
+	return (vmf->flags & FAULT_FLAG_WRITE) &&
+	    userfaultfd_wp(vmf->vma) && pmd_uffd_wp(pmd);
 }
 
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
@@ -123,14 +123,12 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 	return false;
 }
 
-static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
-				      pte_t pte)
+static inline bool userfaultfd_pte_wp(struct vm_fault *vmf, pte_t pte)
 {
 	return false;
 }
 
-static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
-					   pmd_t pmd)
+static inline bool userfaultfd_huge_pmd_wp(struct vm_fault *vmf, pmd_t pmd)
 {
 	return false;
 }
diff --git a/mm/gup.c b/mm/gup.c
index e5739a1974d5..7e685f01b57e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -381,13 +381,13 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 }
 
 /*
- * FOLL_FORCE can write to even unwritable pte's, but only
- * after we've gone through a COW cycle and they are dirty.
+ * FOLL_FORCE (or FOLL_PIN, which requires enforced COW even for read) can
+ * write to even unwritable pte's, but only after we've gone through a COW
+ * cycle and they are dirty.
  */
 static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
 {
-	return pte_write(pte) ||
-		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
+	return pte_write(pte) || ((flags & FOLL_COW) && pte_dirty(pte));
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
@@ -430,7 +430,12 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	}
 	if ((flags & FOLL_NUMA) && pte_protnone(pte))
 		goto no_page;
-	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
+	/*
+	 * We need the same write permission for FOLL_PIN pages, so that we
+	 * will guarantee to trigger early COW for pinned pages.
+	 */
+	if ((flags & (FOLL_WRITE | FOLL_PIN)) &&
+	    !can_follow_write_pte(pte, flags)) {
 		pte_unmap_unlock(ptep, ptl);
 		return NULL;
 	}
@@ -874,6 +879,8 @@ static int faultin_page(struct vm_area_struct *vma,
 		 */
 		fault_flags |= FAULT_FLAG_TRIED;
 	}
+	if (*flags & FOLL_PIN)
+		fault_flags |= FAULT_FLAG_BREAK_COW;
 
 	ret = handle_mm_fault(vma, address, fault_flags, NULL);
 	if (ret & VM_FAULT_ERROR) {
@@ -2146,7 +2153,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		if (pte_protnone(pte))
 			goto pte_unmap;
 
-		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
+		if (!pte_access_permitted(pte, flags & (FOLL_WRITE | FOLL_PIN)))
 			goto pte_unmap;
 
 		if (pte_devmap(pte)) {
@@ -2338,7 +2345,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 
 	pte = huge_ptep_get(ptep);
 
-	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
+	if (!pte_access_permitted(pte, flags & (FOLL_WRITE | FOLL_PIN)))
 		return 0;
 
 	/* hugepages are never "special" */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7ff29cc3d55c..e927e968952b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1276,6 +1276,8 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		pmd_t entry;
 		entry = pmd_mkyoung(orig_pmd);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+		if (pmd_uffd_wp(orig_pmd))
+			entry = pmd_mkuffd_wp(pmd_wrprotect(entry));
 		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
 			update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		unlock_page(page);
@@ -1291,13 +1293,13 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 }
 
 /*
- * FOLL_FORCE can write to even unwritable pmd's, but only
- * after we've gone through a COW cycle and they are dirty.
+ * FOLL_FORCE (or FOLL_PIN, which requires enforced COW even for read) can
+ * write to even unwritable pte's, but only after we've gone through a COW
+ * cycle and they are dirty.
  */
 static inline bool can_follow_write_pmd(pmd_t pmd, unsigned int flags)
 {
-	return pmd_write(pmd) ||
-	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pmd_dirty(pmd));
+	return pmd_write(pmd) || ((flags & FOLL_COW) && pmd_dirty(pmd));
 }
 
 struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
@@ -1310,7 +1312,12 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 
 	assert_spin_locked(pmd_lockptr(mm, pmd));
 
-	if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags))
+	/*
+	 * We need the same write permission for FOLL_PIN pages, so that we
+	 * will guarantee to trigger early COW for pinned pages.
+	 */
+	if ((flags & (FOLL_WRITE | FOLL_PIN)) &&
+	    !can_follow_write_pmd(*pmd, flags))
 		goto out;
 
 	/* Avoid dumping huge zero page */
diff --git a/mm/memory.c b/mm/memory.c
index 469af373ae76..68aadb9c18f5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2719,6 +2719,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		entry = pte_sw_mkyoung(entry);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		if (pte_uffd_wp(vmf->orig_pte))
+			entry = pte_mkuffd_wp(pte_wrprotect(entry));
 		/*
 		 * Clear the pte entry and flush it first, before updating the
 		 * pte with the new entry. This will avoid a race condition
@@ -2912,7 +2914,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
-	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
+	if (userfaultfd_pte_wp(vmf, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return handle_userfault(vmf, VM_UFFD_WP);
 	}
@@ -3273,7 +3275,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		put_page(swapcache);
 	}
 
-	if (vmf->flags & FAULT_FLAG_WRITE) {
+	if (vmf->flags & (FAULT_FLAG_WRITE | FAULT_FLAG_BREAK_COW)) {
 		ret |= do_wp_page(vmf);
 		if (ret & VM_FAULT_ERROR)
 			ret &= VM_FAULT_ERROR;
@@ -4100,7 +4102,7 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
 {
 	if (vma_is_anonymous(vmf->vma)) {
-		if (userfaultfd_huge_pmd_wp(vmf->vma, orig_pmd))
+		if (userfaultfd_huge_pmd_wp(vmf, orig_pmd))
 			return handle_userfault(vmf, VM_UFFD_WP);
 		return do_huge_pmd_wp_page(vmf, orig_pmd);
 	}
@@ -4224,7 +4226,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
 		goto unlock;
 	}
-	if (vmf->flags & FAULT_FLAG_WRITE) {
+	if (vmf->flags & (FAULT_FLAG_WRITE | FAULT_FLAG_BREAK_COW)) {
 		if (!pte_write(entry))
 			return do_wp_page(vmf);
 		entry = pte_mkdirty(entry);
@@ -4267,7 +4269,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		.pgoff = linear_page_index(vma, address),
 		.gfp_mask = __get_fault_gfp_mask(vma),
 	};
-	unsigned int dirty = flags & FAULT_FLAG_WRITE;
+	bool cow = flags & (FAULT_FLAG_WRITE | FAULT_FLAG_BREAK_COW);
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -4294,7 +4296,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 
 			/* NUMA case for anonymous PUDs would go here */
 
-			if (dirty && !pud_write(orig_pud)) {
+			if (cow && !pud_write(orig_pud)) {
 				ret = wp_huge_pud(&vmf, orig_pud);
 				if (!(ret & VM_FAULT_FALLBACK))
 					return ret;
@@ -4332,7 +4334,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 			if (pmd_protnone(orig_pmd) && vma_is_accessible(vma))
 				return do_huge_pmd_numa_page(&vmf, orig_pmd);
 
-			if (dirty && !pmd_write(orig_pmd)) {
+			if (cow && !pmd_write(orig_pmd)) {
 				ret = wp_huge_pmd(&vmf, orig_pmd);
 				if (!(ret & VM_FAULT_FALLBACK))
 					return ret;
-- 
2.26.2


--+HP7ph2BbKc20aGI--

