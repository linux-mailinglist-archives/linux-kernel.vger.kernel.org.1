Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDD627C304
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgI2LCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgI2LCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:02:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3DEE20848;
        Tue, 29 Sep 2020 11:02:23 +0000 (UTC)
Date:   Tue, 29 Sep 2020 14:02:19 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v2 0/4] mm: Break COW for pinned pages during fork()
Message-ID: <20200929110219.GF3094@unreal>
References: <20200925222600.6832-1-peterx@redhat.com>
 <CAHk-=whWyUg0x72nVQaCjq2xvy=S=x0=_9EuV6Qp4pTarGiaeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whWyUg0x72nVQaCjq2xvy=S=x0=_9EuV6Qp4pTarGiaeg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 12:35:59PM -0700, Linus Torvalds wrote:
> On Fri, Sep 25, 2020 at 3:26 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > This series is majorly inspired by the previous discussion on the list [1],
> > starting from the report from Jason on the rdma test failure.
>
> Ok, this is now in my git tree with the changes I outlined in the other email.
>
> > I tested it myself with fork() after vfio pinning a bunch of device pages,
>
> .. but _my_ only testing was to just add a nasty hack that said that
> all pages are pinned, and made fork() much slower, but hey, it at
> least tests the preallocation paths etc. And I'm not seeing any
> obvious failures due to taking that slow-path that is supposed to be a
> special case.
>
> Let's hope this closes the rdma issues.

Hi Linus,

We tested your tree upto commit "fb0155a09b02 Merge tag 'nfs-for-5.9-3' of
git://git.linux-nfs.org/projects/trondmy/linux-nfs" and our RDMA tests passed.

Thanks

>
>                 Linus
