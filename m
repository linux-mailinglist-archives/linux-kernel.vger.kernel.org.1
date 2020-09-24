Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD622772BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgIXNkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:40:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:55254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbgIXNkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:40:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9297AE44;
        Thu, 24 Sep 2020 13:40:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 667671E12E9; Thu, 24 Sep 2020 09:44:09 +0200 (CEST)
Date:   Thu, 24 Sep 2020 09:44:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jan Kara <jack@suse.cz>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20200924074409.GB27019@quack2.suse.cz>
References: <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1>
 <20200923131043.GA59978@xz-x1>
 <20200923142003.GB15875@quack2.suse.cz>
 <20200923171207.GB9916@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923171207.GB9916@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-09-20 14:12:07, Jason Gunthorpe wrote:
> On Wed, Sep 23, 2020 at 04:20:03PM +0200, Jan Kara wrote:
> 
> > I'd hate to take spinlock in the GUP-fast path. Also I don't think this is
> > quite correct because GUP-fast-only can be called from interrupt context
> > and page table locks are not interrupt safe. 
> 
> Yes, IIRC, that is a key element of GUP-fast. Was it something to do
> with futexes?

Honestly, I'm not sure.

> > and then checking page_may_be_dma_pinned() during fork(). That should work
> > just fine AFAICT... BTW note that GUP-fast code is (and this is deliberated
> > because e.g. DAX depends on this) first updating page->_refcount and then
> > rechecking PTE didn't change and the page->_refcount update is actually
> > done using atomic_add_unless() so that it cannot be reordered wrt the PTE
> > check. So the fork() code only needs to add barriers to pair with this.
> 
> It is not just DAX, everything needs this check.
> 
> After the page is pinned it is prevented from being freed and
> recycled. After GUP has the pin it must check that the PTE still
> points at the same page, otherwise it might have pinned a page that is
> alreay free'd - and that would be a use-after-free issue.

I don't think a page use-after-free is really the reason - we add page
reference through page_ref_add_unless(page, x, 0) - i.e., it will fail for
already freed page. It's more about being able to make sure page is not
accessible anymore - and for that modifying pte and then checking page
refcount it *reliable* way to synchronize with GUP-fast...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
