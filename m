Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FE52725EA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgIUNmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:42:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:56646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIUNmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:42:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600695721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KvHE3U1LvO1bVCa3Khho6+5CSamK6xUOF4Y3QnJxLf0=;
        b=ELeLjLwlpBK2v6UX46KlSnK5+qpsIBAJVcb3r4tGfmzE/H0dzwknKl46MJLrI0n19/etBm
        avZE1bfe4mLUTlx2oXiOSXnaKvBOPegJ90z+F3C6UWSFZ9yTc0d6rdT9k+Ql/4sPpH/Euu
        KgCmMOsiH/WBo/NBPwkCMXLnQh44RQQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3750B1B8;
        Mon, 21 Sep 2020 13:42:37 +0000 (UTC)
Date:   Mon, 21 Sep 2020 15:42:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Xu <peterx@redhat.com>, Tejun Heo <tj@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20200921134200.GK12990@dhcp22.suse.cz>
References: <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918164032.GA5962@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Tejun and Christian - this is a part of a larger discussion which is
 not directly related to this particular question so let me trim the
 original email to the bare minimum.]

On Fri 18-09-20 12:40:32, Peter Xu wrote:
[...]
> One issue is when we charge for cgroup we probably can't do that onto the new
> mm/task, since copy_namespaces() is called after copy_mm().  I don't know
> enough about cgroup, I thought the child will inherit the parent's, but I'm not
> sure.  Or, can we change that order of copy_namespaces() && copy_mm()?  I don't
> see a problem so far but I'd like to ask first..

I suspect you are referring to CLONE_INTO_CGROUP, right? I have only now
learned about this feature so I am not deeply familiar with all the
details and I might be easily wrong. Normally all the cgroup aware
resources are accounted to the parent's cgroup. For memcg that includes
all the page tables, early CoW and other allocations with __GFP_ACCOUNT.
IIUC CLONE_INTO_CGROUP properly then this hasn't changed as the child is
associated to its new cgroup (and memcg) only in cgroup_post_fork. If
that is correct then we might have quite a lot of resources bound to
child's lifetime but accounted to the parent's memcg which can lead to
all sorts of interesting problems (e.g. unreclaimable memory - even by
the oom killer).

Christian, Tejun is this the expected semantic or I am just misreading
the code?
-- 
Michal Hocko
SUSE Labs
