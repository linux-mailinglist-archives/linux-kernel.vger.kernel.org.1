Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E65286E4B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgJHFtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgJHFtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:49:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EA420725;
        Thu,  8 Oct 2020 05:49:16 +0000 (UTC)
Date:   Thu, 8 Oct 2020 08:49:13 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20201008054913.GE13580@unreal>
References: <20200927062337.GE2280698@unreal>
 <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
 <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
 <20200928124937.GN9916@ziepe.ca>
 <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
 <20200928172256.GB59869@xz-x1>
 <CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com>
 <20200928183928.GR9916@ziepe.ca>
 <CAHk-=wgu+6Cx_=U1Vh4Fzm97JA1k76fS905uEAVK-2eJ_1KukQ@mail.gmail.com>
 <CAHk-=wiWr+gO0Ro4LvnJBMs90OiePNyrE3E+pJvc9PzdBShdmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiWr+gO0Ro4LvnJBMs90OiePNyrE3E+pJvc9PzdBShdmw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 12:50:03PM -0700, Linus Torvalds wrote:
> On Mon, Sep 28, 2020 at 12:36 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So I'll do the pte wrprotect/restore removal. Anybody willing to do
> > and test the sequence count approach?
>
> So the wrprotect removal is trivial, with most of it being about the comments.
>
> However, when I look at this, I am - once again - tempted to just add a
>
>         if (__page_mapcount(page) > 1)
>                 return 1;
>
> there too. Because we know it's a private mapping (shared mappings we
> checked for with the "is_cow_mapping()" earlier), and the only case we
> really care about is the one where the page is only mapped in the
> current mm (because that's what a write pinning will have done, and as
> mentioned, a read pinning doesn't do anything wrt fork() right now
> anyway).
>
> So if it's mapped in another mm, the COW clearly hasn't been broken by
> a pin, and a read pinned page had already gone through a fork.
>
> But the more I look at this code, the more I go "ok, I want somebody
> to actually test this with the rdma case".
>
> So I'll attach my suggested patch, but I won't actually commit it. I'd
> really like to have this tested, possibly _together_ with the sequence
> count addition..

Hi Linus,

We tested the suggested patch for last two weeks in our nightly regressions
and didn't experience any new failures. It looks like it is safe to use
it, but better to take the patch during/after merge window to minimize risk
of delaying v5.9.

Thanks

>
>                Linus


