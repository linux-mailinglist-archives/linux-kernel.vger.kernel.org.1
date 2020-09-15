Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBD626A30A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIOKX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIOKXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:23:55 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B332521D1B;
        Tue, 15 Sep 2020 10:23:53 +0000 (UTC)
Date:   Tue, 15 Sep 2020 13:23:49 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Linux-MM <linux-mm@kvack.org>,
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
Message-ID: <20200915102349.GI35718@unreal>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-2-peterx@redhat.com>
 <20200914143829.GA1424636@nvidia.com>
 <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
 <20200914183436.GD30881@xz-x1>
 <20200914211515.GA5901@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914211515.GA5901@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 05:15:15PM -0400, Peter Xu wrote:
> On Mon, Sep 14, 2020 at 02:34:36PM -0400, Peter Xu wrote:
> > On Mon, Sep 14, 2020 at 10:32:11AM -0700, Linus Torvalds wrote:
> > > On Mon, Sep 14, 2020 at 7:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > I don't have a detailed explanation right now, but this patch appears
> > > > to be causing a regression where RDMA subsystem tests fail. Tests
> > > > return to normal when this patch is reverted.
> > > >
> > > > It kind of looks like the process is not seeing DMA'd data to a
> > > > pin_user_pages()?
> > >
> > > I'm a nincompoop. I actually _talked_ to Hugh Dickins about this when
> > > he raised concerns, and I dismissed his concerns with "but PAGE_PIN is
> > > special".
> > >
> > > As usual, Hugh was right. Page pinning certainly _is_ special, but
> > > it's not that different from the regular GUP code.
> > >
> > > But in the meantime, I have a lovely confirmation from the kernel test
> > > robot, saying that commit 09854ba94c results in a
> > > "vm-scalability.throughput 31.4% improvement", which was what I was
> > > hoping for - the complexity wasn't just complexity, it was active
> > > badness due to the page locking horrors.
> > >
> > > I think what we want to do is basically do the "early COW", but only
> > > do it for FOLL_PIN (and not turn them into writes for anything but the
> > > COW code). So basically redo the "enforced COW mechanism", but rather
> > > than do it for everything, now do it only for FOLL_PIN, and only in
> > > that COW path.
> > >
> > > Peter - any chance you can look at this? I'm still looking at the page
> > > lock fairness performance regression, although I now think I have a
> > > test patch for Phoronix to test out.
> >
> > Sure, I'll try to prepare something like that and share it shortly.
>
> Jason, would you please try the attached patch to see whether it unbreaks the
> rdma test?  Thanks!
>
> --
> Peter Xu

> From 93c534866d2c548cf193a5c17f7058a1f770df5a Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Mon, 14 Sep 2020 15:34:41 -0400
> Subject: [PATCH] mm/gup: Allow enfornced COW for FOLL_PIN
>
> FOLL_PIN may need the enforced COW mechanism as reported by Jason and analyzed
> by Linus [1].  This is a continued work based on previous patch [2], however
> there's some trivial differences.
>
> Instead of applying enforced COW everywhere, we only apply it for FOLL_PIN to
> make sure the pages that were pinned will not be COWed again later on.  In
> other words, we'll do early phase COW for pinned page along with the gup
> procedure.  And since only FOLL_PIN is affected, we don't need to introduce a
> new flag as FOLL_BREAK_COW.  However we'll still need a new fault flag as
> FAULT_FLAG_BREAK_COW inside the page fault handler.
>
> Fast gup is not affected by this because it is never used with FOLL_PIN.
>
> Now userfaultfd-wp needs to be ready with COW happening since read gup could
> trigger COW now with FOLL_PIN (which will never happen previously).  So when
> COW happens we'll need to carry over the uffd-wp bits too if it's there.
>
> Meanwhile, both userfaultfd_pte_wp() and userfaultfd_huge_pmd_wp() need to be
> smarter than before on that it needs to return true only if this is a "real"
> write fault.  With that extra check, we can identify a real write against an
> enforced COW procedure from a FOLL_PIN gup.
>
> Note: hugetlbfs is not considered throughout this patch, because it's missing
> some required bits after all (like proper setting of FOLL_COW when page fault
> retries).  Considering we may want to unbreak RDMA tests even during the rcs,
> this patch only fixes the non-hugetlbfs cases. THPs should still be in count.
>
> [1] https://lore.kernel.org/lkml/20200914143829.GA1424636@nvidia.com
> [2] https://lore.kernel.org/lkml/20200811183950.10603-1-peterx@redhat.com
>
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm.h            |  2 ++
>  include/linux/userfaultfd_k.h | 12 ++++++------
>  mm/gup.c                      | 17 ++++++++++++-----
>  mm/huge_memory.c              | 17 ++++++++++++-----
>  mm/memory.c                   | 16 +++++++++-------
>  5 files changed, 41 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ca6e6a81576b..741574bfd343 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -416,6 +416,7 @@ extern pgprot_t protection_map[16];
>   * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
>   * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
>   * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
> + * @FAULT_FLAG_BREAK_COW: Do COW explicitly for the fault (even for read).
>   *
>   * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
>   * whether we would allow page faults to retry by specifying these two
> @@ -446,6 +447,7 @@ extern pgprot_t protection_map[16];
>  #define FAULT_FLAG_REMOTE			0x80
>  #define FAULT_FLAG_INSTRUCTION  		0x100
>  #define FAULT_FLAG_INTERRUPTIBLE		0x200
> +#define FAULT_FLAG_BREAK_COW			0x400
>
>  /*
>   * The default fault flags that should be used by most of the
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index a8e5f3ea9bb2..fbcb75daf870 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -62,16 +62,16 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_UFFD_WP;
>  }
>
> -static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
> -				      pte_t pte)
> +static inline bool userfaultfd_pte_wp(struct vm_fault *vmf, pte_t pte)
>  {
> -	return userfaultfd_wp(vma) && pte_uffd_wp(pte);
> +	return (vmf->flags & FAULT_FLAG_WRITE) &&
> +	    userfaultfd_wp(vmf->vma) && pte_uffd_wp(pte);
>  }
>
> -static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
> -					   pmd_t pmd)
> +static inline bool userfaultfd_huge_pmd_wp(struct vm_fault *vmf, pmd_t pmd)
>  {
> -	return userfaultfd_wp(vma) && pmd_uffd_wp(pmd);
> +	return (vmf->flags & FAULT_FLAG_WRITE) &&
> +	    userfaultfd_wp(vmf->vma) && pmd_uffd_wp(pmd);
>  }

Don't forget to change !CONFIG_USERFAULTFD declarations too.

Thanks
