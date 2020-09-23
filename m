Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD5E275C42
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgIWPoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgIWPoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600875863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+DuC7lq68It6bf8N8+4h/Du8Hn8l1j2ilbaVQGr77aw=;
        b=bsh6usdItJw8SQFaKmDwLJGihXLQe4g5z6tjnRKWtS7grVyd5gR3CTGOchIFaSykVVcq8M
        BypFP1353U0JmWUnDwVfK7/QGGPBjcGxV1ghXCalOTvHa7sR+HLjpn3zSN9+aEkfxo4v2c
        5R4/GEMDOdmGHL46Iy0bv7+qEMU05rA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-oTVthZ34O0uao5_-mWg79Q-1; Wed, 23 Sep 2020 11:44:21 -0400
X-MC-Unique: oTVthZ34O0uao5_-mWg79Q-1
Received: by mail-qk1-f200.google.com with SMTP id 205so17020092qkd.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+DuC7lq68It6bf8N8+4h/Du8Hn8l1j2ilbaVQGr77aw=;
        b=ZL1hcs3i4ut+g9kysynSnWTjSnW9XNdqXZp1PTiz7z80CaIg+9RBvLN6onGRQ6yIiR
         g8ekbZzdC8jx04bIOEi4AtdndXzlrIFZ+0CUhBH7se50QuMofREQLrTA31/fkkaw4Nut
         C4/3SgpqupBW5Roq9VOoOgLjtApM1/EMXdk3wS4RarldOfAtr0d5OUPp3pZMywn3bWK2
         tNZ4eVdB5Jqmrl3HqtnD1PR5zdDKyrzPeckgOJCeObouw7mWYyXOjgdoKdXndIktvg1y
         82NmJJgI+NkocQOWAWfZDbw+QvPB3QdXOtZ6w8xKmMBGABj3SRYOf3XgA83pfnYk6Po7
         Wedg==
X-Gm-Message-State: AOAM5336xmbywP3RqIPYoES+c30PLgJsmV3KtjgIew26h2KOszpkg04X
        MNamca13ECY1cSTLoJ0yO6H+SAgjPnKaEOv4ulKuLxdCwDFG4p3/KWuup0/goKlpi4eRbh1nmnG
        Ar9qQ73xZLODlCeeOEbCeMn1Q
X-Received: by 2002:ac8:5d14:: with SMTP id f20mr704340qtx.104.1600875861204;
        Wed, 23 Sep 2020 08:44:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEEQs77/sk/rd1u/Y6BbPbkBwZIyOk8AtTRRxaLQbazk8HtifvBJqlo82hUU4l21aLDgrX2Q==
X-Received: by 2002:ac8:5d14:: with SMTP id f20mr704299qtx.104.1600875860896;
        Wed, 23 Sep 2020 08:44:20 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id f64sm199019qkj.124.2020.09.23.08.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:44:20 -0700 (PDT)
Date:   Wed, 23 Sep 2020 11:44:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 5/5] mm/thp: Split huge pmds/puds if they're pinned when
 fork()
Message-ID: <20200923154418.GE59978@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212031.25233-1-peterx@redhat.com>
 <5e594e71-537f-3e9f-85b6-034b7f5fedbe@nvidia.com>
 <20200922103315.GD15112@quack2.suse.cz>
 <4a65586e-9282-beb0-1880-1ef8da03727c@nvidia.com>
 <20200923092205.GA6719@quack2.suse.cz>
 <20200923135004.GB59978@xz-x1>
 <20200923140114.GA15875@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923140114.GA15875@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 04:01:14PM +0200, Jan Kara wrote:
> On Wed 23-09-20 09:50:04, Peter Xu wrote:
> > On Wed, Sep 23, 2020 at 11:22:05AM +0200, Jan Kara wrote:
> > > On Tue 22-09-20 13:01:13, John Hubbard wrote:
> > > > On 9/22/20 3:33 AM, Jan Kara wrote:
> > > > > On Mon 21-09-20 23:41:16, John Hubbard wrote:
> > > > > > On 9/21/20 2:20 PM, Peter Xu wrote:
> > > > > > ...
> > > > > > > +	if (unlikely(READ_ONCE(src_mm->has_pinned) &&
> > > > > > > +		     page_maybe_dma_pinned(src_page))) {
> > > > > > 
> > > > > > This condition would make a good static inline function. It's used in 3
> > > > > > places, and the condition is quite special and worth documenting, and
> > > > > > having a separate function helps with that, because the function name
> > > > > > adds to the story. I'd suggest approximately:
> > > > > > 
> > > > > >      page_likely_dma_pinned()
> > > > > > 
> > > > > > for the name.
> > > > > 
> > > > > Well, but we should also capture that this really only works for anonymous
> > > > > pages. For file pages mm->has_pinned does not work because the page may be
> > > > > still pinned by completely unrelated process as Jann already properly
> > > > > pointed out earlier in the thread. So maybe anon_page_likely_pinned()?
> > > > > Possibly also assert PageAnon(page) in it if we want to be paranoid...
> > > > > 
> > > > > 								Honza
> > > > 
> > > > The file-backed case doesn't really change anything, though:
> > > > page_maybe_dma_pinned() is already a "fuzzy yes" in the same sense: you
> > > > can get a false positive. Just like here, with an mm->has_pinned that
> > > > could be a false positive for a process.
> > > > 
> > > > And for that reason, I'm also not sure an "assert PageAnon(page)" is
> > > > desirable. That assertion would prevent file-backed callers from being
> > > > able to call a function that provides a fuzzy answer, but I don't see
> > > > why you'd want or need to do that. The goal here is to make the fuzzy
> > > > answer a little bit more definite, but it's not "broken" just because
> > > > the result is still fuzzy, right?
> > > > 
> > > > Apologies if I'm missing a huge point here... :)
> > > 
> > > But the problem is that if you apply mm->has_pinned check on file pages,
> > > you can get false negatives now. And that's not acceptable...
> > 
> > Do you mean the case where proc A pinned page P from a file, then proc B
> > mapped the same page P on the file, then fork() on proc B?
> 
> Yes.
> 
> > If proc B didn't explicitly pinned page P in B's address space too,
> > shouldn't we return "false" for page_likely_dma_pinned(P)?  Because if
> > proc B didn't pin the page in its own address space, I'd think it's ok to
> > get the page replaced at any time as long as the content keeps the same.
> > Or couldn't we?
> 
> So it depends on the reason why you call page_likely_dma_pinned(). For your
> COW purposes the check is correct but e.g. for "can filesystem safely
> writeback this page" the page_likely_dma_pinned() would be wrong. So I'm
> not objecting to the mechanism as such. I'm mainly objecting to the generic
> function name which suggests something else than what it really checks and
> thus it could be used in wrong places in the future... That's why I'd
> prefer to restrict the function to PageAnon pages where there's no risk of
> confusion what the check actually does.

How about I introduce the helper as John suggested, but rename it to

  page_maybe_dma_pinned_by_mm()

?

Then we also don't need to judge on which is more likely to happen (between
"maybe" and "likely", since that will confuse me if I only read these words..).

I didn't use any extra suffix like "cow" because I think it might be useful for
things besides cow.  Fundamentally the new helper will be mm-based, so "by_mm"
seems to suite better to me.

Does that sound ok?

-- 
Peter Xu

