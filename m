Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FDF277441
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgIXOpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:45:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:38920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgIXOpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:45:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 94DDFAB0E;
        Thu, 24 Sep 2020 14:45:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3E8711E12DD; Thu, 24 Sep 2020 16:45:31 +0200 (CEST)
Date:   Thu, 24 Sep 2020 16:45:31 +0200
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
Message-ID: <20200924144531.GA2364@quack2.suse.cz>
References: <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1>
 <20200923131043.GA59978@xz-x1>
 <20200923142003.GB15875@quack2.suse.cz>
 <20200923171207.GB9916@ziepe.ca>
 <20200924074409.GB27019@quack2.suse.cz>
 <20200924140237.GD9916@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924140237.GD9916@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-09-20 11:02:37, Jason Gunthorpe wrote:
> On Thu, Sep 24, 2020 at 09:44:09AM +0200, Jan Kara wrote:
> > > After the page is pinned it is prevented from being freed and
> > > recycled. After GUP has the pin it must check that the PTE still
> > > points at the same page, otherwise it might have pinned a page that is
> > > alreay free'd - and that would be a use-after-free issue.
> > 
> > I don't think a page use-after-free is really the reason - we add page
> > reference through page_ref_add_unless(page, x, 0) - i.e., it will fail for
> > already freed page. 
> 
> I mean, the page could have been freed and already reallocated with a
> positive refcount, so the add_unless check isn't protective.
>
> The add_unless prevents the page from being freed. The 2nd pte read
> ensures it wasn't already freed/reassigned before the pin.

Ah, right!

> If something drives the page refcount to zero then it is already
> synchronized with GUP fast because of the atomic add_unless, no need
> to re-check the pte for that case?? But I don't know what the DAX case
> is you mentioned.

DAX needs to make sure no new references (including GUP-fast) can be created
for a page before truncating page from a file and freeing it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
