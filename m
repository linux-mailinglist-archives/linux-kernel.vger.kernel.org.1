Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8011E27741D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgIXOf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728088AbgIXOfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600958123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvhmXdurMqfIrlufAAPJfQcazZ/8TT7PFFG3tysOQUc=;
        b=H9hXmr4AZAeDPeIhNSYWtR2rqFtspOtdtx0gZxd2/5QlDorswpLwzdwr7P0bV1zCbjQmx1
        mBqy4XJ8RKZOQjPQ9caFahkzHCbZWEztALL1TZ4ZLh2vUfCsYcPh33IIzIkEJIzujaEV+Y
        Di0JpD1W2pOYSFGnXwvOfTheIsox4hc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-I8MfxvijMP6eEttnneecIw-1; Thu, 24 Sep 2020 10:35:21 -0400
X-MC-Unique: I8MfxvijMP6eEttnneecIw-1
Received: by mail-qv1-f72.google.com with SMTP id a20so2206788qvk.17
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zvhmXdurMqfIrlufAAPJfQcazZ/8TT7PFFG3tysOQUc=;
        b=Zc6JhISkFd4Io0tEcTFyGzMjdLbYfQkR6mVNZCHZXQ+2LlHoWTfQzn2uYAsAgrYQuc
         UFh6/umT+yeBsHn/elkuKrfwgoUpG6vSxdYaYbzveNF3l9foXgG30a+YrDrO1kBXFlh+
         7qZVoV/Q8GH5WuqPlg7raivO2yN8dgFVmTt7ocXhHZiHw/orcfwjN937PPXMGxwOV4lN
         UHuvAos3lT4lKFURTsMqjTGH8q68n7uf/nW+wlpvc359bRR1S85rrXR7wLWq5IMTBdeG
         w5iwykkh2RqWQRD4MgbJC03OeKFcEomXeyoIHiu3LBh6fZ7KOJoq7bhM5wkzWI7Qo24d
         s12Q==
X-Gm-Message-State: AOAM53083AJKOTMXaIclLHrj+xL85XGFtfx2Rkq6OTcDAfATWvKNeBo6
        18dQnQeXyjaE6VGylSSzsFjqYz6+8eSfXxsN/kTREi8oTzv2H0hT6eVMgGud3nTQSnjTzwZwlg0
        m+MyyX+KhRzdaWK82635Gr0YA
X-Received: by 2002:ae9:f701:: with SMTP id s1mr5256068qkg.446.1600958120814;
        Thu, 24 Sep 2020 07:35:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/n7SJnWJZzZBSNTparOQ6wMGNiV1kVJQwLJonregx+J8ZQSUFVAhRN6bKAXZ3EEGQYF8Vew==
X-Received: by 2002:ae9:f701:: with SMTP id s1mr5256036qkg.446.1600958120399;
        Thu, 24 Sep 2020 07:35:20 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id m6sm2108265qkh.106.2020.09.24.07.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 07:35:19 -0700 (PDT)
Date:   Thu, 24 Sep 2020 10:35:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <20200924143517.GD79898@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1>
 <20200923170759.GA9916@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923170759.GA9916@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 02:07:59PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 22, 2020 at 08:27:35PM -0400, Peter Xu wrote:
> > On Tue, Sep 22, 2020 at 04:11:16PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Sep 22, 2020 at 01:54:15PM -0400, Peter Xu wrote:
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index 8f3521be80ca..6591f3f33299 100644
> > > > +++ b/mm/memory.c
> > > > @@ -888,8 +888,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > > >                  * Because we'll need to release the locks before doing cow,
> > > >                  * pass this work to upper layer.
> > > >                  */
> > > > -               if (READ_ONCE(src_mm->has_pinned) && wp &&
> > > > -                   page_maybe_dma_pinned(page)) {
> > > > +               if (wp && page_maybe_dma_pinned(page) &&
> > > > +                   READ_ONCE(src_mm->has_pinned)) {
> > > >                         /* We've got the page already; we're safe */
> > > >                         data->cow_old_page = page;
> > > >                         data->cow_oldpte = *src_pte;
> > > > 
> > > > I can also add some more comment to emphasize this.
> > > 
> > > It is not just that, but the ptep_set_wrprotect() has to be done
> > > earlier.
> > 
> > Now I understand your point, I think..  So I guess it's not only about
> > has_pinned, but it should be a race between the fast-gup and the fork() code,
> > even if has_pinned is always set.
> 
> Yes
> 
> > > The best algorithm I've thought of is something like:
> > > 
> > >  pte_map_lock()
> > >   if (page) {
> > >       if (wp) {
> > > 	  ptep_set_wrprotect()
> > > 	  /* Order with try_grab_compound_head(), either we see
> > > 	   * page_maybe_dma_pinned(), or they see the wrprotect */
> > > 	  get_page();
> > 
> > Is this get_page() a must to be after ptep_set_wrprotect()
> > explicitly?  
> 
> No, just before page_maybe_dma_pinned()
> 
> > IIUC what we need is to order ptep_set_wrprotect() and
> > page_maybe_dma_pinned() here.  E.g., would a "mb()" work?
> 
> mb() is not needed because page_maybe_dma_pinned() has an atomic
> barrier too. I like to see get_page() followed immediately by
> page_maybe_dma_pinned() since they are accessing the same atomic and
> could be fused together someday

If so, I'd hope you won't disagree that I still move the get_page() out of the
"if (wp)".  Not only it's a shared operation no matter whether "if (wp)" or
not, but I'm afraid it would confuse future readers on a special ordering on
the get_page() and the wrprotect(), especially with the comment above.

> 
> > Another thing is, do we need similar thing for e.g. gup_pte_range(), so that
> > to guarantee ordering of try_grab_compound_head() and the pte change
> > check?
> 
> gup_pte_range() is as I quoted? The gup slow path ends up in
> follow_page_pte() which uses the pte lock so is OK.
> > 
> > Another question is, how about read fast-gup for pinning?  Because we can't use
> > the write-protect mechanism to block a read gup.  I remember we've discussed
> > similar things and iirc your point is "pinned pages should always be with
> > WRITE".  However now I still doubt it...  Because I feel like read gup is still
> > legal (as I mentioned previously - when device purely writes to the page and
> > the processor only reads from it).
> 
> We need a definition for what FOLL_PIN means. After this work on fork
> I propose that FOLL_PIN means:
> 
>   The page is in-use for DMA and the CPU PTE should not be changed
>   without explicit involvement of the application (eg via mmap/munmap)
> 
> If GUP encounters a read-only page during FOLL_PIN the behavior should
> depend on what the fault handler would do. If the fault handler would
> trigger COW and replace the PTE then it violates the above. GUP should
> do the COW before pinning.
> 
> If the fault handler would SIGSEGV then GUP can keep the read-only
> page and allow !FOLL_WRITE access. The PTE should not be replaced for
> other reasons (though I think there is work there too).
> 
> For COW related issues the idea is the mm_struct doing the pin will
> never trigger a COW. When other processes hit the COW they copy the
> page into their mm and don't touch the source MM's PTE.
> 
> Today we do this roughly with FOLL_FORCE and FOLL_WRITE in the users,
> but a more nuanced version and documentation would be much clearer.
> 
> Unfortunately just doing simple read GUP potentially exposes things to
> various COW related data corruption races.
> 
> This is a discussion beyond this series though..

Yes.  It's kind of related here on whether we can still use wrprotect() to
guard against fast-gup, though.  So my understanding is that we should still at
least need the other patch [1] that I proposed in the other thread to force
break-cow for read-only gups (that patch is not only for fast-gup, of course).

But I agree that should be another bigger topic.  I hope we don't need to pick
that patch up someday by another dma report on read-only pinned pages...

Regarding the solution here, I think we can also cover read-only fast-gup too
in the future - IIUC what we need to do is to make it pte_protnone() instead of
pte_wrprotect(), then in the fault handler we should identify this special
pte_protnone() against numa balancing (change_prot_numa()).  I think it should
work fine too, iiuc, because I don't think we should migrate a page at all if
it's pinned for any reason...

So I think I'll focus on the wrprotect() solution for now.  Thanks!

[1] https://lore.kernel.org/lkml/20200915151746.GB2949@xz-x1/

-- 
Peter Xu

