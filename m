Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E715275579
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIWKVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWKVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:21:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 759EE20C56;
        Wed, 23 Sep 2020 10:21:22 +0000 (UTC)
Date:   Wed, 23 Sep 2020 13:21:19 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 0/5] mm: Break COW for pinned pages during fork()
Message-ID: <20200923102119.GK1223944@unreal>
References: <20200921211744.24758-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921211744.24758-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 05:17:39PM -0400, Peter Xu wrote:
> Finally I start to post formal patches because it's growing.  And also since
> we've discussed quite some issues already, so I feel like it's clearer on what
> we need to do, and how.
>
> This series is majorly inspired by the previous discussion on the list [1],
> starting from the report from Jason on the rdma test failure.  Linus proposed
> the solution, which seems to be a very nice approach to avoid the breakage of
> userspace apps that didn't use MADV_DONTFORK properly before.  More information
> can be found in that thread too.
>
> I believe the initial plan was to consider merging something like this for
> rc7/rc8.  However now I'm not sure due to the fact that the code change in
> copy_pte_range() is probably more than expected, so it can be with some risk.
> I'll leave this question to the reviewers...
>
> I tested it myself with fork() after vfio pinning a bunch of device pages, and
> I verified that the new copy pte logic worked as expected at least in the most
> general path.  However I didn't test thp case yet because afaict vfio does not
> support thp backed dma pages.  Luckily, the pmd/pud thp patch is much more
> straightforward than the pte one, so hopefully it can be directly verified by
> some code review plus some more heavy-weight rdma tests.
>
> Patch 1:      Introduce mm.has_pinned (as single patch as suggested by Jason)
> Patch 2-3:    Some slight rework on copy_page_range() path as preparation
> Patch 4:      Early cow solution for pte copy for pinned pages
> Patch 5:      Same as above, but for thp (pmd/pud).
>
> Hugetlbfs fix is still missing, but as planned, that's not urgent so we can
> work upon.  Comments greatly welcomed.

Hi Peter,

I'm ware that this series is under ongoing review and probably not
final, but we tested anyway and it solves our RDMA failures.

Thanks

>
> Thanks.
>
> Peter Xu (5):
>   mm: Introduce mm_struct.has_pinned
>   mm/fork: Pass new vma pointer into copy_page_range()
>   mm: Rework return value for copy_one_pte()
>   mm: Do early cow for pinned pages during fork() for ptes
>   mm/thp: Split huge pmds/puds if they're pinned when fork()
>
>  include/linux/mm.h       |   2 +-
>  include/linux/mm_types.h |  10 ++
>  kernel/fork.c            |   3 +-
>  mm/gup.c                 |   6 ++
>  mm/huge_memory.c         |  26 +++++
>  mm/memory.c              | 226 +++++++++++++++++++++++++++++++++++----
>  6 files changed, 248 insertions(+), 25 deletions(-)
>
> --
> 2.26.2
>
>
