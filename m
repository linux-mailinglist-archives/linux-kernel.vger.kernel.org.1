Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D327288D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgIUOoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:44:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35619 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgIUOoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:06 -0400
Received: from ip5f5af089.dynamic.kabel-deutschland.de ([95.90.240.137] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kKN2q-0003YE-9b; Mon, 21 Sep 2020 14:43:56 +0000
Date:   Mon, 21 Sep 2020 16:43:55 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
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
Message-ID: <20200921144355.mrzc66lina3dkfjq@wittgenstein>
References: <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <20200921134200.GK12990@dhcp22.suse.cz>
 <20200921141830.GE5962@xz-x1>
 <20200921142834.GL12990@dhcp22.suse.cz>
 <20200921143847.GB4268@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921143847.GB4268@mtj.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 10:38:47AM -0400, Tejun Heo wrote:
> Hello,
> 
> On Mon, Sep 21, 2020 at 04:28:34PM +0200, Michal Hocko wrote:
> > Fundamentaly CLONE_INTO_CGROUP is similar to regular fork + move to the
> > target cgroup after the child gets executed. So in principle there
> > shouldn't be any big difference. Except that the move has to be explicit
> > and the the child has to have enough privileges to move itself. I am not
> 
> Yeap, they're supposed to be the same operations. We've never clearly
> defined how the accounting gets split across moves because 1. it's
> inherently blurry and difficult 2. doesn't make any practical difference for
> the recommended and vast majority usage pattern which uses migration to seed
> the new cgroup. CLONE_INTO_CGROUP doesn't change any of that.
> 
> > completely sure about CLONE_INTO_CGROUP model though. According to man
> > clone(2) it seems that O_RDONLY for the target cgroup directory is
> > sufficient. That seems much more relaxed IIUC and it would allow to fork
> > into a different cgroup while keeping a lot of resources in the parent's
> > proper.
> 
> If the man page is documenting that, it's wrong. cgroup_css_set_fork() has
> an explicit cgroup_may_write() test on the destination cgroup.
> CLONE_INTO_CGROUP should follow exactly the same rules as regular
> migrations.

Indeed!
The O_RDONLY mention on the manpage doesn't make sense but it is
explained that the semantics are exactly the same for moving via the
filesystem:

"In order to place the child process in a different cgroup, the caller
specifies CLONE_INTO_CGROUP in cl_args.flags and passes a file
descriptor  that  refers  to  a  version  2  cgroup  in  the
cl_args.cgroup  field.  (This file descriptor can be obtained by opening
a cgroup v2 directory using either the O_RDONLY or the O_PATH flag.)
Note that all of the usual restrictions (described in cgroups(7)) on
placing a process into a version 2 cgroup apply."

Christian
