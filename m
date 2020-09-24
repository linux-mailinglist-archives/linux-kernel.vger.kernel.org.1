Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC162778B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgIXSto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728707AbgIXStn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600973382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XtEnp20rlhLwsWsIBELxeQUjAOInolF5ll32kJfBQNc=;
        b=TepVTg5MFB7bGbnp5f9aSTc9FMjThJpGC1iH788bOH/gtjmb7gHpSFUb7pYqv1H4azp4GO
        iy4TZXBbw0H20q1B68y/4kCXdbd2LgErjyurV7xZvYCfGo7xWdNKkAtATE3CrPtJaRnukV
        loiMH6qdIJa0l9IxBXN2NW3fcGB6aME=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-nvhw-ZJbNNGT9VnL3JAc2A-1; Thu, 24 Sep 2020 14:49:40 -0400
X-MC-Unique: nvhw-ZJbNNGT9VnL3JAc2A-1
Received: by mail-qk1-f198.google.com with SMTP id m203so280380qke.16
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XtEnp20rlhLwsWsIBELxeQUjAOInolF5ll32kJfBQNc=;
        b=r1xLspnecPJMpYrMlqCSLXLO1/QVyI3hNvDeyy9/8H3a3s01tYokJEGbySDDW/MoSg
         SvnCjhTWrG8Yxmt0qV9ZYQLTCvmYFYEHBCGqCCZpnCpmkW/7NxQ7pflCIabH1lmyS+vT
         a0MXQeLPn5XQCqHbnAilvH3cQl+obMbN5A+tGin6qFaEecs9DVnqTOYeuH0TAqqAw0YB
         lUW+uQUwif/76mTHeF8D6i15FRuURMWjwjRj1w9AhqT4lI1diUp6c/sbVpooYk8CZtuV
         a4iAID6wbQ9aBxtojuxfgvBten9P31EI09CXlpI3EyjEBTFe8RD6WNYPqZ4NwJLvvmdJ
         f12A==
X-Gm-Message-State: AOAM532USAVjjQqybZdVdITCZYUg1elT5awO/INLARgFCLvhIv6EyVgq
        pQ/Nk7FMKwKTlo4PwOEYzwVa89oL8JNAFC+5pp7beugQwpCUDdRi0kbJUHvaKPSYRfzW03wu37F
        vrGnDNQVcXAT4GU+Jb8fEZcqu
X-Received: by 2002:ac8:5317:: with SMTP id t23mr562875qtn.354.1600973379895;
        Thu, 24 Sep 2020 11:49:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymPUpe7nv5fBAQLKetJacV27ezUU4s/tjW7RrHSORRJ4fxMpgEArQt9AtYEHKSz8Y71wmyDw==
X-Received: by 2002:ac8:5317:: with SMTP id t23mr562854qtn.354.1600973379627;
        Thu, 24 Sep 2020 11:49:39 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id g5sm261530qtx.43.2020.09.24.11.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 11:49:38 -0700 (PDT)
Date:   Thu, 24 Sep 2020 14:49:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
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
Message-ID: <20200924184937.GK79898@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212031.25233-1-peterx@redhat.com>
 <5e594e71-537f-3e9f-85b6-034b7f5fedbe@nvidia.com>
 <20200922103315.GD15112@quack2.suse.cz>
 <4a65586e-9282-beb0-1880-1ef8da03727c@nvidia.com>
 <20200923092205.GA6719@quack2.suse.cz>
 <20200923135004.GB59978@xz-x1>
 <20200923140114.GA15875@quack2.suse.cz>
 <20200923154418.GE59978@xz-x1>
 <c77a99e6-c13d-a881-eb70-e0d12083dab9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c77a99e6-c13d-a881-eb70-e0d12083dab9@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 01:19:08PM -0700, John Hubbard wrote:
> On 9/23/20 8:44 AM, Peter Xu wrote:
> > On Wed, Sep 23, 2020 at 04:01:14PM +0200, Jan Kara wrote:
> > > On Wed 23-09-20 09:50:04, Peter Xu wrote:
> ...
> > > > > But the problem is that if you apply mm->has_pinned check on file pages,
> > > > > you can get false negatives now. And that's not acceptable...
> > > > 
> > > > Do you mean the case where proc A pinned page P from a file, then proc B
> > > > mapped the same page P on the file, then fork() on proc B?
> > > 
> > > Yes.
> 
> aha, thanks for spelling out the false negative problem.
> 
> > > 
> > > > If proc B didn't explicitly pinned page P in B's address space too,
> > > > shouldn't we return "false" for page_likely_dma_pinned(P)?  Because if
> > > > proc B didn't pin the page in its own address space, I'd think it's ok to
> > > > get the page replaced at any time as long as the content keeps the same.
> > > > Or couldn't we?
> > > 
> > > So it depends on the reason why you call page_likely_dma_pinned(). For your
> > > COW purposes the check is correct but e.g. for "can filesystem safely
> > > writeback this page" the page_likely_dma_pinned() would be wrong. So I'm
> > > not objecting to the mechanism as such. I'm mainly objecting to the generic
> > > function name which suggests something else than what it really checks and
> > > thus it could be used in wrong places in the future... That's why I'd
> > > prefer to restrict the function to PageAnon pages where there's no risk of
> > > confusion what the check actually does.
> > 
> > How about I introduce the helper as John suggested, but rename it to
> > 
> >    page_maybe_dma_pinned_by_mm()
> > 
> > ?
> > 
> > Then we also don't need to judge on which is more likely to happen (between
> > "maybe" and "likely", since that will confuse me if I only read these words..).
> > 
> 
> You're right, it is too subtle of a distinction after all. I agree that sticking
> with "_maybe_" avoids that confusion.
> 
> 
> > I didn't use any extra suffix like "cow" because I think it might be useful for
> > things besides cow.  Fundamentally the new helper will be mm-based, so "by_mm"
> > seems to suite better to me.
> > 
> > Does that sound ok?
> > 
> 
> Actually, Jan nailed it. I just wasn't understanding his scenario, but now that
> I do, and considering your other point about wording, I think we end up with:
> 
>     anon_page_maybe_pinned()
> 
> as a pretty good name for a helper function. (We don't want "_mm" because that
> refers more to the mechanism used internally, rather than the behavior of the
> function. "anon_" adds more meaning.)

Actually it was really my intention when I suggested "_by_mm", because IMHO the
new helper actually means "whether this page may be pinned by _this mm_ (not
any other address space)".  IOW, the case that Jan mentioned on the share page
can be reflected in this case, because although that page was pinned, however
it was not pinned "by this mm" for e.g. proc B above.

Though I've no strong opinion either. I'll start with anon_page_maybe_pinned().
To me it's probably more important to prepare the next spin first and see
whether we'd still like it for this release.

Thanks,

-- 
Peter Xu

