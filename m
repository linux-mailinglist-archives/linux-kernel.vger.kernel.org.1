Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7E5272847
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgIUOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:41:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35548 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgIUOlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:41:47 -0400
Received: from ip5f5af089.dynamic.kabel-deutschland.de ([95.90.240.137] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kKN0Z-00037W-8i; Mon, 21 Sep 2020 14:41:35 +0000
Date:   Mon, 21 Sep 2020 16:41:34 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Peter Xu <peterx@redhat.com>, Tejun Heo <tj@kernel.org>,
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
Message-ID: <20200921144134.fuvkkv6wgrzpbwnv@wittgenstein>
References: <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <20200921134200.GK12990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921134200.GK12990@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 03:42:00PM +0200, Michal Hocko wrote:
> [Cc Tejun and Christian - this is a part of a larger discussion which is
>  not directly related to this particular question so let me trim the
>  original email to the bare minimum.]
> 
> On Fri 18-09-20 12:40:32, Peter Xu wrote:
> [...]
> > One issue is when we charge for cgroup we probably can't do that onto the new
> > mm/task, since copy_namespaces() is called after copy_mm().  I don't know
> > enough about cgroup, I thought the child will inherit the parent's, but I'm not
> > sure.  Or, can we change that order of copy_namespaces() && copy_mm()?  I don't
> > see a problem so far but I'd like to ask first..
> 
> I suspect you are referring to CLONE_INTO_CGROUP, right? I have only now
> learned about this feature so I am not deeply familiar with all the
> details and I might be easily wrong. Normally all the cgroup aware
> resources are accounted to the parent's cgroup. For memcg that includes
> all the page tables, early CoW and other allocations with __GFP_ACCOUNT.
> IIUC CLONE_INTO_CGROUP properly then this hasn't changed as the child is
> associated to its new cgroup (and memcg) only in cgroup_post_fork. If
> that is correct then we might have quite a lot of resources bound to
> child's lifetime but accounted to the parent's memcg which can lead to
> all sorts of interesting problems (e.g. unreclaimable memory - even by
> the oom killer).
> 
> Christian, Tejun is this the expected semantic or I am just misreading
> the code?

Hey Michal,

Thanks for the Cc!

If I understand your question correctly, then you are correct. The logic
is split in three simple parts:
1. Child gets created and doesn't live in any cset
   - This should mean that resources are still charged against the
     parent's memcg which is what you're asking afiu.
1. cgroup_can_fork()
   - create new or find existing matching cset for the child
3. cgroup_post_fork()
   - move/attach child to the new or found cset

_Purely from a CLONE_INTO_CGROUP perspective_ you should be ok to
reverse the order of copy_mm() and copy_namespaces().

Christian
