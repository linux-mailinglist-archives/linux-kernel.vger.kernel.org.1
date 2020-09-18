Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A43270263
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgIRQkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgIRQkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600447238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vzu0saCwdR041JzX0luUcHREGkpfe4U/JPtKiyBZHaY=;
        b=MjFz9oon+f8T87F9o83AOXgyCkVC/8zT7lYqtklSL+01IgCFn0ohrNIYZc0Cw+II0e94W+
        dVXzH1RfHR5WWVzh0bSFusp6c82kzidbwwO+rQsK/1g4shTKP/p+zF6/+z3rb7J9OrpTdf
        IzGkCkBXnAcEKatsjar98G4LY3lzzNw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-y9MfKOvSMXy46hHp6Rz0zw-1; Fri, 18 Sep 2020 12:40:36 -0400
X-MC-Unique: y9MfKOvSMXy46hHp6Rz0zw-1
Received: by mail-qt1-f200.google.com with SMTP id m13so5483062qtu.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vzu0saCwdR041JzX0luUcHREGkpfe4U/JPtKiyBZHaY=;
        b=n3oqsWnQsrPhfaiGW5+y/Zuuqrs18fJ8u2ZvILEpWa5xtqQ5Qks2mDfOTrjR3DWBjM
         sMvpqF4VHV9p55unCyKis/FhSAukV6sLmEv/eb4mk/JgIhyxl81lhqAQSxMnHXQN94BM
         tlNFSlFbtvWBsTci26pMpjcqKzIMyEhnUw3lW0EmbMqqpGYqL5+r0xLLVzb3VYwRdDU9
         PTw9Ub17mAVcHVhq6qRaVRo+OtaMLPHvsae3bao9NGUgqSSLoeMtPhMq3BIp+Q461Hke
         CP/3Uc9n48V1A2Wu8X4mHloUzWr4y/0PBZFemfFGQBNrGuVxbU7HI/ssdbf3Y+Dd/r+k
         9Gpw==
X-Gm-Message-State: AOAM5336GVjUuj3Ip/IrwkNDoeXyUzq9noINgk1XpLlRLA4OTxRJV3YN
        /52ssH1+ZtZrKuexqEYcTi6V4QnSyYDcryz2aOouC1tGN4rJj2g/aoxL9nvWiBhOlgjh3cVSyye
        gqZuYxx7uFDW5u0jjOsNlLUqc
X-Received: by 2002:a37:5145:: with SMTP id f66mr21984265qkb.299.1600447235540;
        Fri, 18 Sep 2020 09:40:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzwsEl7XAK0/1crQhXCiwsBgP9XRYqbuFfG97+97fMQe02sEIm+cEaja733tDM9u3bPZnwIA==
X-Received: by 2002:a37:5145:: with SMTP id f66mr21984228qkb.299.1600447235202;
        Fri, 18 Sep 2020 09:40:35 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id t1sm2531244qtj.12.2020.09.18.09.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 09:40:34 -0700 (PDT)
Date:   Fri, 18 Sep 2020 12:40:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20200918164032.GA5962@xz-x1>
References: <20200915193838.GN1221970@ziepe.ca>
 <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Sep 17, 2020 at 12:51:49PM -0700, Linus Torvalds wrote:
> On Thu, Sep 17, 2020 at 12:38 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > Looking for awhile, this now looks reasonable and
> > doable. page_maybe_dma_pinned() was created for exactly this kind of
> > case.
> >
> > I've attached a dumb sketch for the pte level (surely wrong! I have
> > never looked at this part of the mm before!) at the end of this
> > message.
> 
> This looks conceptually fine to me.
> 
> But as mentioned, I think I'd be even happier if we added a "thsi vma
> has seen a page pin event" flag to the vma flags, and didn't rely
> _just_ on the page_maybe_dma_pinned() check, which migth be triggered
> by those fork-happy loads.
> 
> Side note: I wonder if that COW mapping check could be entirely within
> that vm_normal_page() path.
> 
> Because how could a non-normal page be a COW page and not already
> write-protected?

I feel like we still need to keep those to cover !page case for PFNMAP.

I tried to draft a patch, however I do see some other issues, so I'd like to
discuss here before mindlessly going on with it.

Firstly in the draft patch mm->has_pinned is introduced and it's written to 1
as long as FOLL_GUP is called once.  It's never reset after set.

One more thing (I think) we need to do is to pass the new vma from
copy_page_range() down into the end because if we want to start cow during
fork() then we need to operate on that new vma too when new page linked to it
rather than the parent's.

One issue is when we charge for cgroup we probably can't do that onto the new
mm/task, since copy_namespaces() is called after copy_mm().  I don't know
enough about cgroup, I thought the child will inherit the parent's, but I'm not
sure.  Or, can we change that order of copy_namespaces() && copy_mm()?  I don't
see a problem so far but I'd like to ask first..

The other thing is on how to fail.  E.g., when COW failed due to either
charging of cgroup or ENOMEM, ideally we should fail fork() too.  Though that
might need more changes - current patch silently kept the shared page for
simplicity.

The draft patch is attached for reference.  It should cover the small pages,
but at least it needs to cover huge pages and also a well written commit log.

Thanks,

-- 
Peter Xu

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-Do-early-cow-for-FOLL_PIN-pages-during-fork.patch"

From 0b41b082f06535f092e78bdd4f0501ddbb7de165 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 18 Sep 2020 11:56:27 -0400
Subject: [PATCH] mm: Do early cow for FOLL_PIN pages during fork()

Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h       |  2 +-
 include/linux/mm_types.h |  1 +
 kernel/fork.c            |  3 +-
 mm/gup.c                 | 15 +++++++
 mm/memory.c              | 85 +++++++++++++++++++++++++++++++++++-----
 5 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ca6e6a81576b..bf1ac54be55e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1644,7 +1644,7 @@ struct mmu_notifier_range;
 void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
-			struct vm_area_struct *vma);
+		    struct vm_area_struct *vma, struct vm_area_struct *new);
 int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 		   struct mmu_notifier_range *range,
 		   pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 496c3ff97cce..b3812fa6383f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -458,6 +458,7 @@ struct mm_struct {
 
 		unsigned long total_vm;	   /* Total pages mapped */
 		unsigned long locked_vm;   /* Pages that have PG_mlocked set */
+		unsigned long has_pinned;  /* Whether this mm has pinned any page */
 		atomic64_t    pinned_vm;   /* Refcount permanently increased */
 		unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
 		unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
diff --git a/kernel/fork.c b/kernel/fork.c
index 49677d668de4..843807ade6dd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -589,7 +589,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
-			retval = copy_page_range(mm, oldmm, mpnt);
+			retval = copy_page_range(mm, oldmm, mpnt, tmp);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
@@ -1011,6 +1011,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
 	mm->locked_vm = 0;
+	mm->has_pinned = 0;
 	atomic64_set(&mm->pinned_vm, 0);
 	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
 	spin_lock_init(&mm->page_table_lock);
diff --git a/mm/gup.c b/mm/gup.c
index e5739a1974d5..cab10cefefe4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1255,6 +1255,17 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 		BUG_ON(*locked != 1);
 	}
 
+	/*
+	 * Mark the mm struct if there's any page pinning attempt.  We're
+	 * aggresive on this bit since even if the pinned pages were unpinned
+	 * later on, we'll still keep this bit set for this address space just
+	 * to make everything easy.
+	 *
+	 * TODO: Ideally we can use mm->pinned_vm but only until it's stable.
+	 */
+	if (flags & FOLL_PIN)
+		WRITE_ONCE(mm->has_pinned, 1);
+
 	/*
 	 * FOLL_PIN and FOLL_GET are mutually exclusive. Traditional behavior
 	 * is to set FOLL_GET if the caller wants pages[] filled in (but has
@@ -2660,6 +2671,10 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
 				       FOLL_FAST_ONLY)))
 		return -EINVAL;
 
+	/* Please refer to comments in __get_user_pages_locked() */
+	if (gup_flags & FOLL_PIN)
+		WRITE_ONCE(current->mm->has_pinned, 1);
+
 	if (!(gup_flags & FOLL_FAST_ONLY))
 		might_lock_read(&current->mm->mmap_lock);
 
diff --git a/mm/memory.c b/mm/memory.c
index 469af373ae76..be9e2946c462 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -689,6 +689,38 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 }
 #endif
 
+/*
+ * Do early cow for the page and the pte. Return true if page duplicate
+ * succeeded, false otherwise.
+ */
+static bool duplicate_page(struct mm_struct *mm, struct vm_area_struct *vma,
+			   unsigned long address, struct page *page,
+			   pte_t *newpte)
+{
+       struct page *new_page;
+       pte_t entry;
+
+       new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
+       if (!new_page)
+               return false;
+
+       copy_user_highpage(new_page, page, address, vma);
+       if (mem_cgroup_charge(new_page, mm, GFP_KERNEL)) {
+	       put_page(new_page);
+	       return false;
+       }
+       cgroup_throttle_swaprate(new_page, GFP_KERNEL);
+       __SetPageUptodate(new_page);
+
+       entry = mk_pte(new_page, vma->vm_page_prot);
+       entry = pte_sw_mkyoung(entry);
+       entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+       *newpte = entry;
+       page_add_new_anon_rmap(new_page, vma, address, false);
+
+       return true;
+}
+
 /*
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
@@ -698,11 +730,13 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 static inline unsigned long
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
+	        struct vm_area_struct *new,
 		unsigned long addr, int *rss)
 {
 	unsigned long vm_flags = vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
+	bool wp;
 
 	/* pte contains position in swap or file, so copy. */
 	if (unlikely(!pte_present(pte))) {
@@ -779,10 +813,7 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * If it's a COW mapping, write protect it both
 	 * in the parent and the child
 	 */
-	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
-		ptep_set_wrprotect(src_mm, addr, src_pte);
-		pte = pte_wrprotect(pte);
-	}
+	wp = is_cow_mapping(vm_flags) && pte_write(pte);
 
 	/*
 	 * If it's a shared mapping, mark it clean in
@@ -805,6 +836,36 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		get_page(page);
 		page_dup_rmap(page, false);
 		rss[mm_counter(page)]++;
+
+		/*
+		 * If the page is pinned in source mm, do early cow right now
+		 * so that the pinned page won't be replaced by another random
+		 * page without being noticed after the fork().
+		 *
+		 * Note: There can be some very rare cases that we'll do
+		 * unnecessary cow here, due to page_maybe_dma_pinned() is
+		 * sometimes bogus, and has_pinned flag is currently aggresive
+		 * too.  However this should be good enough for us for now as
+		 * long as we covered all the pinned pages.
+		 *
+		 * If page copy triggered successfully, undo wp.  Otherwise we
+		 * probably don't have enough memory for use, we can either
+		 * report up so we fail the fork(), or for simplicity we keep
+		 * the old behavior of keep the page shared.
+		 *
+		 * Note: we passed in src_mm here for accounting because
+		 * copy_namespaces() should not have been done when copy_mm()
+		 * happens.
+		 */
+		if (wp && READ_ONCE(src_mm->has_pinned) &&
+		    page_maybe_dma_pinned(page) &&
+		    duplicate_page(src_mm, new, addr, page, &pte))
+			wp = false;
+	}
+
+	if (wp) {
+		ptep_set_wrprotect(src_mm, addr, src_pte);
+		pte = pte_wrprotect(pte);
 	}
 
 out_set_pte:
@@ -814,6 +875,7 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		   pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
+		   struct vm_area_struct *new,
 		   unsigned long addr, unsigned long end)
 {
 	pte_t *orig_src_pte, *orig_dst_pte;
@@ -852,7 +914,7 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			continue;
 		}
 		entry.val = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
-							vma, addr, rss);
+					 vma, new, addr, rss);
 		if (entry.val)
 			break;
 		progress += 8;
@@ -877,6 +939,7 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
+		struct vm_area_struct *new,
 		unsigned long addr, unsigned long end)
 {
 	pmd_t *src_pmd, *dst_pmd;
@@ -903,7 +966,7 @@ static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
 		if (copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
-						vma, addr, next))
+				   vma, new, addr, next))
 			return -ENOMEM;
 	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
 	return 0;
@@ -911,6 +974,7 @@ static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src
 
 static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		p4d_t *dst_p4d, p4d_t *src_p4d, struct vm_area_struct *vma,
+		struct vm_area_struct *new,
 		unsigned long addr, unsigned long end)
 {
 	pud_t *src_pud, *dst_pud;
@@ -937,7 +1001,7 @@ static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src
 		if (pud_none_or_clear_bad(src_pud))
 			continue;
 		if (copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
-						vma, addr, next))
+				   vma, new, addr, next))
 			return -ENOMEM;
 	} while (dst_pud++, src_pud++, addr = next, addr != end);
 	return 0;
@@ -945,6 +1009,7 @@ static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src
 
 static inline int copy_p4d_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pgd_t *dst_pgd, pgd_t *src_pgd, struct vm_area_struct *vma,
+		struct vm_area_struct *new,
 		unsigned long addr, unsigned long end)
 {
 	p4d_t *src_p4d, *dst_p4d;
@@ -959,14 +1024,14 @@ static inline int copy_p4d_range(struct mm_struct *dst_mm, struct mm_struct *src
 		if (p4d_none_or_clear_bad(src_p4d))
 			continue;
 		if (copy_pud_range(dst_mm, src_mm, dst_p4d, src_p4d,
-						vma, addr, next))
+				   vma, new, addr, next))
 			return -ENOMEM;
 	} while (dst_p4d++, src_p4d++, addr = next, addr != end);
 	return 0;
 }
 
 int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		struct vm_area_struct *vma)
+		    struct vm_area_struct *vma, struct vm_area_struct *new)
 {
 	pgd_t *src_pgd, *dst_pgd;
 	unsigned long next;
@@ -1021,7 +1086,7 @@ int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		if (pgd_none_or_clear_bad(src_pgd))
 			continue;
 		if (unlikely(copy_p4d_range(dst_mm, src_mm, dst_pgd, src_pgd,
-					    vma, addr, next))) {
+					    vma, new, addr, next))) {
 			ret = -ENOMEM;
 			break;
 		}
-- 
2.26.2


--n8g4imXOkfNTN/H1--

