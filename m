Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF9E272701
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgIUO2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:28:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:40230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgIUO2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:28:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600698519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1RdoYXKwEjK4J3d1DYrl5vaMGQPhf2n+JMMWMOYRwtU=;
        b=kTgxnzS7teOS36PrXh0wm+C0EApapZblNjjrebqXoJ5ChnxL4I+xPE9HMdxVW9xlGYz6eg
        rK0EppRHDdkJma4AyUvZAvg18F2k2CLiiNFPHUNLRyPeGGLStbtax09rA13XWRpQXwxuZy
        /tlacC6+W7gvF48ZV17gPjianbo/3Fk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28DB2B12E;
        Mon, 21 Sep 2020 14:29:15 +0000 (UTC)
Date:   Mon, 21 Sep 2020 16:28:34 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200921142834.GL12990@dhcp22.suse.cz>
References: <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <20200921134200.GK12990@dhcp22.suse.cz>
 <20200921141830.GE5962@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921141830.GE5962@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-09-20 10:18:30, Peter Xu wrote:
> Hi, Michal,
> 
> On Mon, Sep 21, 2020 at 03:42:00PM +0200, Michal Hocko wrote:
[...]
> > I have only now
> > learned about this feature so I am not deeply familiar with all the
> > details and I might be easily wrong. Normally all the cgroup aware
> > resources are accounted to the parent's cgroup. For memcg that includes
> > all the page tables, early CoW and other allocations with __GFP_ACCOUNT.
> > IIUC CLONE_INTO_CGROUP properly then this hasn't changed as the child is
> > associated to its new cgroup (and memcg) only in cgroup_post_fork. If
> > that is correct then we might have quite a lot of resources bound to
> > child's lifetime but accounted to the parent's memcg which can lead to
> > all sorts of interesting problems (e.g. unreclaimable memory - even by
> > the oom killer).
> 
> Right that's one of the things that I'm confused too, on that if we always
> account to the parent, then when the child quits whether we uncharge them or
> not, and how..  Not sure whether the accounting of the parent could steadily
> grow as it continues the fork()s.
> 
> So is it by design that we account all these to the parents?

Let me try to clarify a bit further my concern.  Without CLONE_INTO_CGROUP
this makes some sense. Because both parent and child will live in
the same cgroup. All the charges are reference counted so they will
be released when the respective resource gets freed (e.g. page table
released or the backing page dropped) irrespective of the current cgroup
the owner is living in.

Fundamentaly CLONE_INTO_CGROUP is similar to regular fork + move to the
target cgroup after the child gets executed. So in principle there
shouldn't be any big difference. Except that the move has to be explicit
and the the child has to have enough privileges to move itself. I am not
completely sure about CLONE_INTO_CGROUP model though. According to man
clone(2) it seems that O_RDONLY for the target cgroup directory is
sufficient. That seems much more relaxed IIUC and it would allow to fork
into a different cgroup while keeping a lot of resources in the parent's
proper.
-- 
Michal Hocko
SUSE Labs
