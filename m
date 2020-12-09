Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FA92D493D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbgLISlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:41:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732158AbgLISlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:41:36 -0500
Date:   Wed, 9 Dec 2020 18:40:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607539255;
        bh=AKh72l/qCDJ+OF5xZaRceF1XEBCreajcbzaT7M4kvfw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iy9itZlx7gE6PT6ZwwhQ01TtLlW69FypnHVNorFWzLp395LNO8/HID27Ch0/MMQM8
         Az9qi7eDLyKJyf8vX9699KLigiwiHWtneFKfKmqUemRzmmaCb/DR4udaUyuOenUe8W
         eTdBAT+5NBALSn5vn4MntkmvYfl3CQz0MPlt8ZzHQCwQ50OtdMhFkXhDXhiaiekZ16
         JpVUXG7SGNwW8UqHtbvbr1taBWRHsWHdLmKHk2CeFyf6P34yQS1SXCLO6LET52ObEm
         u/08UTlpiTrfMorXbW2oLJEcdPxfokupyFc6iSBjhc4i9Vn+lJZzDQqYveTW93GFis
         O+S36NFLObA9A==
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries
 when prefaulting
Message-ID: <20201209184049.GA8778@willie-the-truck>
References: <20201209163950.8494-1-will@kernel.org>
 <20201209163950.8494-2-will@kernel.org>
 <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 09:58:12AM -0800, Linus Torvalds wrote:
> On Wed, Dec 9, 2020 at 8:40 AM Will Deacon <will@kernel.org> wrote:
> >
> > @@ -3978,8 +3994,17 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
> >
> >         /* check if the page fault is solved */
> >         vmf->pte -= (vmf->address >> PAGE_SHIFT) - (address >> PAGE_SHIFT);
> > -       if (!pte_none(*vmf->pte))
> > -               ret = VM_FAULT_NOPAGE;
> > +       if (pte_none(*vmf->pte))
> > +               goto out_unlock;
> > +
> > +       if (vmf->flags & FAULT_FLAG_PREFAULT_OLD) {
> > +               pte_t pte = pte_mkyoung(*vmf->pte);
> > +               if (ptep_set_access_flags(vmf->vma, address, vmf->pte, pte, 0))
> > +                       update_mmu_cache(vmf->vma, address, vmf->pte);
> > +       }
> 
> Oh, please dear God no.
> 
> First you incorrectly set it old, and then you conditionally make it
> young again and as a result force an atomic rwm update and another TLB
> flush for no good reason.

There shouldn't be a TLB flush here, but I agree that it would have to
go and nobble the hash for PowerPC if they wanted to enable this.

> Just make sure that the FAULT_FLAG_PREFAULT_OLD never sets the
> *actual* address to old.
> 
> And yes, that probably means that you need to change "alloc_set_pte()"
> to actually pass in the real address, and leave "vmf->address" alone -
> so that it can know which ones are prefaulted and which one is real,
> but that sounds like a good idea anyway.

Right, I deliberately avoided that based on the feedback from Jan on an
older version [1], but I can certainly look at it again.

> Then you can just make alloc_set_pte() do the right thing in the first
> place, instead of doing this nasty "lets do it wrong and fix it up
> later" horror.

I'll have a crack at this in v2.

Cheers,

Will

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/1511845670-12133-1-git-send-email-vinmenon@codeaurora.org/
