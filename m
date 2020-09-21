Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C749272AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgIUQGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:06:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:33304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbgIUQGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:06:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600704404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SABUEUknBHJI8XlIA/l+ZHp7zAzU1dU+58RVw/KjEuw=;
        b=SWJS4DLzBr1XYJsbzXBHxVnp3x0jngu5ZA9hjkytnwNEadMKiwGVK+863dDFiMMpweVD0j
        A30wgvwy9Ezspe+Jhctgg1TetRY+U//5LLP8Hk3YmRR5XfqHxXgxUlAMy1jlMu+FdbuCfF
        4MHltGl/TtTmsBsRFH0q8WyeECFzuOw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 036E5B2A7;
        Mon, 21 Sep 2020 16:07:21 +0000 (UTC)
Date:   Mon, 21 Sep 2020 18:06:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Tejun Heo <tj@kernel.org>, Peter Xu <peterx@redhat.com>,
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
Message-ID: <20200921160643.GP12990@dhcp22.suse.cz>
References: <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <20200921134200.GK12990@dhcp22.suse.cz>
 <20200921141830.GE5962@xz-x1>
 <20200921142834.GL12990@dhcp22.suse.cz>
 <20200921143847.GB4268@mtj.duckdns.org>
 <20200921144355.mrzc66lina3dkfjq@wittgenstein>
 <20200921145537.GM12990@dhcp22.suse.cz>
 <20200921150450.3mjjb3p3jwgatn4v@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921150450.3mjjb3p3jwgatn4v@wittgenstein>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-09-20 17:04:50, Christian Brauner wrote:
> On Mon, Sep 21, 2020 at 04:55:37PM +0200, Michal Hocko wrote:
> > On Mon 21-09-20 16:43:55, Christian Brauner wrote:
> > > On Mon, Sep 21, 2020 at 10:38:47AM -0400, Tejun Heo wrote:
> > > > Hello,
> > > > 
> > > > On Mon, Sep 21, 2020 at 04:28:34PM +0200, Michal Hocko wrote:
> > > > > Fundamentaly CLONE_INTO_CGROUP is similar to regular fork + move to the
> > > > > target cgroup after the child gets executed. So in principle there
> > > > > shouldn't be any big difference. Except that the move has to be explicit
> > > > > and the the child has to have enough privileges to move itself. I am not
> > > > 
> > > > Yeap, they're supposed to be the same operations. We've never clearly
> > > > defined how the accounting gets split across moves because 1. it's
> > > > inherently blurry and difficult 2. doesn't make any practical difference for
> > > > the recommended and vast majority usage pattern which uses migration to seed
> > > > the new cgroup. CLONE_INTO_CGROUP doesn't change any of that.
> > > > 
> > > > > completely sure about CLONE_INTO_CGROUP model though. According to man
> > > > > clone(2) it seems that O_RDONLY for the target cgroup directory is
> > > > > sufficient. That seems much more relaxed IIUC and it would allow to fork
> > > > > into a different cgroup while keeping a lot of resources in the parent's
> > > > > proper.
> > > > 
> > > > If the man page is documenting that, it's wrong. cgroup_css_set_fork() has
> > > > an explicit cgroup_may_write() test on the destination cgroup.
> > > > CLONE_INTO_CGROUP should follow exactly the same rules as regular
> > > > migrations.
> > > 
> > > Indeed!
> > > The O_RDONLY mention on the manpage doesn't make sense but it is
> > > explained that the semantics are exactly the same for moving via the
> > > filesystem:
> > 
> > OK, if the semantic is the same as for the task migration then I do not
> > see any (new) problems. Care to point me where the actual check is
> > enforced? For the migration you need a write access to cgroup.procs but
> > if the API expects directory fd then I am not sure how that would expose
> > the same behavior.
> 
> kernel/cgroup/cgroup.c:cgroup_csset_fork()
> 
> So there's which is the first check for inode_permission() essentially:
> 
> 	/*
> 	 * Verify that we the target cgroup is writable for us. This is
> 	 * usually done by the vfs layer but since we're not going through
> 	 * the vfs layer here we need to do it "manually".
> 	 */
> 	ret = cgroup_may_write(dst_cgrp, sb);
> 	if (ret)
> 		goto err;
> 
> and what you're referring to is checked right after in:
> 
> 	ret = cgroup_attach_permissions(cset->dfl_cgrp, dst_cgrp, sb,
> 					!(kargs->flags & CLONE_THREAD));
> 	if (ret)
> 		goto err;
> 
> which calls:
> 
> 	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp, sb);
> 	if (ret)
> 		return ret;
> 
> That should be what you're looking for. I've also added selftests as
> always that verify this behavior under:
> 
> tools/testing/selftests/cgroup/
> 
> as soon as CLONE_INTO_CGROUP is detected on the kernel than all the
> usual tests are exercised using CLONE_INTO_CGROUP so we should've seen
> any regression hopefully.

Thanks a lot for this clarification! So I believe the only existing bug
is in documentation which should be explicit that the cgroup fd read
access is not sufficient because it also requires to have a write access
for cgroup.procs in the same directory at the time of fork. I will send
a patch if I find some time for that.

Thanks!
-- 
Michal Hocko
SUSE Labs
