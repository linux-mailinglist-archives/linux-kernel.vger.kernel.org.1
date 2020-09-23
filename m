Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E9B275E44
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIWRIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIWRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:08:02 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0A7C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:08:02 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y11so470350qtn.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0XiY6OzElzC0nla6QB2h1ThyeNhIrvFuQcikvzuwGeQ=;
        b=QQlfNCaBqpljkpk15ITsGZIersTrfFTRcBlo4H5VaBrr0oUhZ1znKH01NyJ1cX3hhx
         EScOR3ZPin+nAyg5tPcDTiUhPDFi8yPiMJezNiC0GRiPD5E7S5M6ePUMggoSPzGqTYEL
         5Bms9ePojStKGh0UO027IhzseOKPIu9gtp2qzGm3g3lfHe+rc7mk+Mse2tAm7WCvT7I/
         E0ksJKRY8mxKzYfhO3/nwS0cSAXKh7uT/LOq7ZUJipXEgVnFczoh+xBQQQJq7rQ8+e08
         8hElmDcgcg8ksH3mMvsE4PciT8a/8efLtMqI6JJ4mGKyLqZJSOUtFuXXtTuPpU0ta3WH
         gIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0XiY6OzElzC0nla6QB2h1ThyeNhIrvFuQcikvzuwGeQ=;
        b=Sy63Fw4j8BKFhnpuJbCZSdjHq/kzAvjMTB9gQQrUdk63UogEzD/k0Dlos+zDmjfWyj
         7sgkpXoq5Yd6kWwE3xd3ZaC0uDQl5TqOYqXkKKM88WePCD9bqycbC1ww6+VwUkabroMZ
         Ajd+IFA2NXQOlf4z/Rmg5965XiAwEYbVDXYnwr56zd1vGerg5s3eHIpiPE2WtmLjXEMD
         +szGV9d+wcf56EwP1z8l0CTmQQMhwabvmWFTk+LMlp+YgV0a/b1wb5nACS5DdMs1z/iT
         +HF0C8Kz6+Ym9H9WIgKdhxof9BS1TVznY0CcX4ckde5zCAAKUa3mKTF1KNqrDW1kD2jI
         X4Wg==
X-Gm-Message-State: AOAM5326kIT6bxq+gfym+lfcMZz3CwoaNLFG7zeB4fN4/seNGG2cIzRe
        6QNkA+1z6B4pfV7mmUZKo/J/EA==
X-Google-Smtp-Source: ABdhPJzDkBPe/zYUOomY8Sp7G9lnrLwuf1Pg9UYYrdSIKXAHTzx02ysSMa/UySq3BK6wHsTLFewmuA==
X-Received: by 2002:ac8:44c2:: with SMTP id b2mr1026729qto.277.1600880881581;
        Wed, 23 Sep 2020 10:08:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s15sm370714qkj.21.2020.09.23.10.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 10:08:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kL8FL-0006KF-OT; Wed, 23 Sep 2020 14:07:59 -0300
Date:   Wed, 23 Sep 2020 14:07:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200923170759.GA9916@ziepe.ca>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923002735.GN19098@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 08:27:35PM -0400, Peter Xu wrote:
> On Tue, Sep 22, 2020 at 04:11:16PM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 22, 2020 at 01:54:15PM -0400, Peter Xu wrote:
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 8f3521be80ca..6591f3f33299 100644
> > > +++ b/mm/memory.c
> > > @@ -888,8 +888,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > >                  * Because we'll need to release the locks before doing cow,
> > >                  * pass this work to upper layer.
> > >                  */
> > > -               if (READ_ONCE(src_mm->has_pinned) && wp &&
> > > -                   page_maybe_dma_pinned(page)) {
> > > +               if (wp && page_maybe_dma_pinned(page) &&
> > > +                   READ_ONCE(src_mm->has_pinned)) {
> > >                         /* We've got the page already; we're safe */
> > >                         data->cow_old_page = page;
> > >                         data->cow_oldpte = *src_pte;
> > > 
> > > I can also add some more comment to emphasize this.
> > 
> > It is not just that, but the ptep_set_wrprotect() has to be done
> > earlier.
> 
> Now I understand your point, I think..  So I guess it's not only about
> has_pinned, but it should be a race between the fast-gup and the fork() code,
> even if has_pinned is always set.

Yes

> > The best algorithm I've thought of is something like:
> > 
> >  pte_map_lock()
> >   if (page) {
> >       if (wp) {
> > 	  ptep_set_wrprotect()
> > 	  /* Order with try_grab_compound_head(), either we see
> > 	   * page_maybe_dma_pinned(), or they see the wrprotect */
> > 	  get_page();
> 
> Is this get_page() a must to be after ptep_set_wrprotect()
> explicitly?  

No, just before page_maybe_dma_pinned()

> IIUC what we need is to order ptep_set_wrprotect() and
> page_maybe_dma_pinned() here.  E.g., would a "mb()" work?

mb() is not needed because page_maybe_dma_pinned() has an atomic
barrier too. I like to see get_page() followed immediately by
page_maybe_dma_pinned() since they are accessing the same atomic and
could be fused together someday

> Another thing is, do we need similar thing for e.g. gup_pte_range(), so that
> to guarantee ordering of try_grab_compound_head() and the pte change
> check?

gup_pte_range() is as I quoted? The gup slow path ends up in
follow_page_pte() which uses the pte lock so is OK.
> 
> Another question is, how about read fast-gup for pinning?  Because we can't use
> the write-protect mechanism to block a read gup.  I remember we've discussed
> similar things and iirc your point is "pinned pages should always be with
> WRITE".  However now I still doubt it...  Because I feel like read gup is still
> legal (as I mentioned previously - when device purely writes to the page and
> the processor only reads from it).

We need a definition for what FOLL_PIN means. After this work on fork
I propose that FOLL_PIN means:

  The page is in-use for DMA and the CPU PTE should not be changed
  without explicit involvement of the application (eg via mmap/munmap)

If GUP encounters a read-only page during FOLL_PIN the behavior should
depend on what the fault handler would do. If the fault handler would
trigger COW and replace the PTE then it violates the above. GUP should
do the COW before pinning.

If the fault handler would SIGSEGV then GUP can keep the read-only
page and allow !FOLL_WRITE access. The PTE should not be replaced for
other reasons (though I think there is work there too).

For COW related issues the idea is the mm_struct doing the pin will
never trigger a COW. When other processes hit the COW they copy the
page into their mm and don't touch the source MM's PTE.

Today we do this roughly with FOLL_FORCE and FOLL_WRITE in the users,
but a more nuanced version and documentation would be much clearer.

Unfortunately just doing simple read GUP potentially exposes things to
various COW related data corruption races.

This is a discussion beyond this series though..

Jason
