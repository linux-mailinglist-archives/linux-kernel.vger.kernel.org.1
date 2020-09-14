Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB0B269786
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgINVPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbgINVPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600118121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wg4n9qnrSHECJot5yfHBj5zRmpYN2B+JhmG4AEOMbx0=;
        b=YS0WKVefQT7K+klwTSMc3v2dJ0FYCK8GmZI3aaByrn9gAiInxe8HDZvJuU22w9IPVEhiDK
        KTGOaa3WutXNzKfMIv58epRZHq3kTTZFkN6HtaK/3rS9H7qTOEnD3mi+5qWiXC0YW+W9AJ
        jY0cox7yl1EA+7p5LKAMXMmvbCHTROc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-_DeSDvxQOMWdd0YSyJSV5Q-1; Mon, 14 Sep 2020 17:15:19 -0400
X-MC-Unique: _DeSDvxQOMWdd0YSyJSV5Q-1
Received: by mail-qv1-f71.google.com with SMTP id h9so820955qvr.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wg4n9qnrSHECJot5yfHBj5zRmpYN2B+JhmG4AEOMbx0=;
        b=sbl+pOdQcr6FuSWigexKEClrSxpzv3mukSoAnxnZM8NiVz0WeTXZxqzIQR6M7R2Eo6
         v0kL7ItobkYloDPW40b3Z5qbl8FjJc3MJ21Qj7Tw9HFDSsJi3Ui1M0OC5m93B5V0lMai
         PvFsZkge4U94m0d5Bk5mS4j2Cm0cOCXwin0ps2asJy3Jy24dySlc5JXViwIYAsCFudXI
         MLmUOKg4MxtHHMZGhOmkAyh6CHfKa11H+5FZ+4OvrP6FxEJYfhRYVNQssx4dGBfn482X
         WorQxeHQfM5M+toN8PDGz/1Vs2P8J/TggTBW6qABNx4wyM8sLAmIfJv19sAkEuhv1Vzw
         As3g==
X-Gm-Message-State: AOAM533HiO7/CpDrwGFHflVWeeWTpaJ71ZY0vo6l+ek9Z6d1TASNYlp8
        +6yD61dnZRfLJPJru/R48ciEV5v+hv77XQ/8QfCFyIZZ14o6EpeZJlJWoEU0SpPNb5YETPIjA6L
        koTYkFNIxljN1gzdAFfU+KTEb
X-Received: by 2002:aed:2b86:: with SMTP id e6mr15033347qtd.86.1600118118851;
        Mon, 14 Sep 2020 14:15:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr+oSp9v+wNmMZaDUlfRBAOjMQhvdyOw+iQYzS4cCh24EOs3iuayQiizUjf2TLuIJ14rTLhQ==
X-Received: by 2002:aed:2b86:: with SMTP id e6mr15033310qtd.86.1600118118513;
        Mon, 14 Sep 2020 14:15:18 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id s25sm6929172qtc.90.2020.09.14.14.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:15:17 -0700 (PDT)
Date:   Mon, 14 Sep 2020 17:15:15 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200914211515.GA5901@xz-x1>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-2-peterx@redhat.com>
 <20200914143829.GA1424636@nvidia.com>
 <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
 <20200914183436.GD30881@xz-x1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20200914183436.GD30881@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Sep 14, 2020 at 02:34:36PM -0400, Peter Xu wrote:
> On Mon, Sep 14, 2020 at 10:32:11AM -0700, Linus Torvalds wrote:
> > On Mon, Sep 14, 2020 at 7:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > I don't have a detailed explanation right now, but this patch appears
> > > to be causing a regression where RDMA subsystem tests fail. Tests
> > > return to normal when this patch is reverted.
> > >
> > > It kind of looks like the process is not seeing DMA'd data to a
> > > pin_user_pages()?
> > 
> > I'm a nincompoop. I actually _talked_ to Hugh Dickins about this when
> > he raised concerns, and I dismissed his concerns with "but PAGE_PIN is
> > special".
> > 
> > As usual, Hugh was right. Page pinning certainly _is_ special, but
> > it's not that different from the regular GUP code.
> > 
> > But in the meantime, I have a lovely confirmation from the kernel test
> > robot, saying that commit 09854ba94c results in a
> > "vm-scalability.throughput 31.4% improvement", which was what I was
> > hoping for - the complexity wasn't just complexity, it was active
> > badness due to the page locking horrors.
> > 
> > I think what we want to do is basically do the "early COW", but only
> > do it for FOLL_PIN (and not turn them into writes for anything but the
> > COW code). So basically redo the "enforced COW mechanism", but rather
> > than do it for everything, now do it only for FOLL_PIN, and only in
> > that COW path.
> > 
> > Peter - any chance you can look at this? I'm still looking at the page
> > lock fairness performance regression, although I now think I have a
> > test patch for Phoronix to test out.
> 
> Sure, I'll try to prepare something like that and share it shortly.

Jason, would you please try the attached patch to see whether it unbreaks the
rdma test?  Thanks!

-- 
Peter Xu

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-gup-Allow-enfornced-COW-for-FOLL_PIN.patch"

From 93c534866d2c548cf193a5c17f7058a1f770df5a Mon Sep 17 00:00:00 2001
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

Fast gup is not affected by this because it is never used with FOLL_PIN.

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
 include/linux/userfaultfd_k.h | 12 ++++++------
 mm/gup.c                      | 17 ++++++++++++-----
 mm/huge_memory.c              | 17 ++++++++++++-----
 mm/memory.c                   | 16 +++++++++-------
 5 files changed, 41 insertions(+), 23 deletions(-)

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
index a8e5f3ea9bb2..fbcb75daf870 100644
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
diff --git a/mm/gup.c b/mm/gup.c
index e5739a1974d5..2011542c4044 100644
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


--zhXaljGHf11kAtnf--

