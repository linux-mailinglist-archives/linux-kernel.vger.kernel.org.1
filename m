Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D005B27591E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIWNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgIWNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600869009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cBbOOKO0ucHd2rpc+S+Efks0E+NiERhRTxqZGrwQ8go=;
        b=Y84tj9eMXVqD8i/T3YD6zogW8lSVfCs1AohTHclVZOO/M0/Vyt/1nsdGZJJg6d7TzBTBDw
        VtQxMiQB5SPPxss2SiclLigq4jEPUwFPhnYlAx4GiI78WOkJEW642ctsO7OrKR2CChAya7
        JTMiUWtHVb3YDQekZbeBCY4lyIC5rn8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395--1tXGpdyMEyBuGaO7FQVuw-1; Wed, 23 Sep 2020 09:50:07 -0400
X-MC-Unique: -1tXGpdyMEyBuGaO7FQVuw-1
Received: by mail-qt1-f197.google.com with SMTP id b54so19295797qtk.17
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 06:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cBbOOKO0ucHd2rpc+S+Efks0E+NiERhRTxqZGrwQ8go=;
        b=WsAmRcHZA8G0ufS379z58f7lzWEmscRR/CXGywyS1Ddz4ZgqUAQowxsHsEB2jfKFi6
         9yo/H+kNqRK5GVVYf4yqAxbWAwiih7Oo5vTc/GmSiDF/VIaRmx+MJziyYioJ1Mb8Bc90
         iYb2gRMms4p4+8FwazxOna1sW4R1+nf+7eQBzy7to5QFyejhzhoO4FYcruK19/x50ua3
         hj2iRtN9eeonM4SPJOdS4mvSDSVCzD6ZqG85BBiAiCcHCwPc57nwtvxuFXU7/yuoEBmj
         syA+MFr/MUzVvb416JxURiZN2D41qZJCu0MgH5XWbJbzPj84WNzHh6FKQvup/YZapEnE
         /CZg==
X-Gm-Message-State: AOAM5329W++vPCLxqZNnOdizlka1kpLzkoOHSsMfEo4pvN6pqBsfAITi
        5lJpgqmBgTyL9iM3+snM3rtWKfVrZgnLVGaBgnQXI7LRyjWjnf2jgdsWQnZaGkfwoh4cTvL3a1g
        1i7iC7vXac7ljOtHCUBiCFAB0
X-Received: by 2002:ac8:4784:: with SMTP id k4mr94266qtq.266.1600869007127;
        Wed, 23 Sep 2020 06:50:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymluAocXlZKNKvjSQP1X70AcJPuQ7HzHich5liwak0L/3clODl36dmZDmKsXiVxH3joTCAnw==
X-Received: by 2002:ac8:4784:: with SMTP id k4mr94229qtq.266.1600869006828;
        Wed, 23 Sep 2020 06:50:06 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id z2sm11400qkg.40.2020.09.23.06.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 06:50:06 -0700 (PDT)
Date:   Wed, 23 Sep 2020 09:50:04 -0400
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
Message-ID: <20200923135004.GB59978@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212031.25233-1-peterx@redhat.com>
 <5e594e71-537f-3e9f-85b6-034b7f5fedbe@nvidia.com>
 <20200922103315.GD15112@quack2.suse.cz>
 <4a65586e-9282-beb0-1880-1ef8da03727c@nvidia.com>
 <20200923092205.GA6719@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923092205.GA6719@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:22:05AM +0200, Jan Kara wrote:
> On Tue 22-09-20 13:01:13, John Hubbard wrote:
> > On 9/22/20 3:33 AM, Jan Kara wrote:
> > > On Mon 21-09-20 23:41:16, John Hubbard wrote:
> > > > On 9/21/20 2:20 PM, Peter Xu wrote:
> > > > ...
> > > > > +	if (unlikely(READ_ONCE(src_mm->has_pinned) &&
> > > > > +		     page_maybe_dma_pinned(src_page))) {
> > > > 
> > > > This condition would make a good static inline function. It's used in 3
> > > > places, and the condition is quite special and worth documenting, and
> > > > having a separate function helps with that, because the function name
> > > > adds to the story. I'd suggest approximately:
> > > > 
> > > >      page_likely_dma_pinned()
> > > > 
> > > > for the name.
> > > 
> > > Well, but we should also capture that this really only works for anonymous
> > > pages. For file pages mm->has_pinned does not work because the page may be
> > > still pinned by completely unrelated process as Jann already properly
> > > pointed out earlier in the thread. So maybe anon_page_likely_pinned()?
> > > Possibly also assert PageAnon(page) in it if we want to be paranoid...
> > > 
> > > 								Honza
> > 
> > The file-backed case doesn't really change anything, though:
> > page_maybe_dma_pinned() is already a "fuzzy yes" in the same sense: you
> > can get a false positive. Just like here, with an mm->has_pinned that
> > could be a false positive for a process.
> > 
> > And for that reason, I'm also not sure an "assert PageAnon(page)" is
> > desirable. That assertion would prevent file-backed callers from being
> > able to call a function that provides a fuzzy answer, but I don't see
> > why you'd want or need to do that. The goal here is to make the fuzzy
> > answer a little bit more definite, but it's not "broken" just because
> > the result is still fuzzy, right?
> > 
> > Apologies if I'm missing a huge point here... :)
> 
> But the problem is that if you apply mm->has_pinned check on file pages,
> you can get false negatives now. And that's not acceptable...

Do you mean the case where proc A pinned page P from a file, then proc B mapped
the same page P on the file, then fork() on proc B?

If proc B didn't explicitly pinned page P in B's address space too, shouldn't
we return "false" for page_likely_dma_pinned(P)?  Because if proc B didn't pin
the page in its own address space, I'd think it's ok to get the page replaced
at any time as long as the content keeps the same.  Or couldn't we?

Thanks,

-- 
Peter Xu

