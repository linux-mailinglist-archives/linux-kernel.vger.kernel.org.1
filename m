Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D4275285
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIWHxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:53:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIWHxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:53:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600847610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CuHUMp2i3TRP7V8scoazcWiRgaPQjjBjBbbJZmwakt8=;
        b=er+muJI71Xard5EO7GqXt1gwtHwqYgVtxN6WAIy2EocdMMAYI7jTm8vyYdPCK8zXvHzxUm
        84lqDh/YaVIQPW29KGk24fGId98opcrqh6ac1oxf+24m6mHUwGSOiA79xdf7/7OjRdnTHD
        c/47TeDNosuJJW0DFDqYNU5ajsqHL8c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BE171AE0D;
        Wed, 23 Sep 2020 07:54:07 +0000 (UTC)
Date:   Wed, 23 Sep 2020 09:53:29 +0200
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
Message-ID: <20200923075329.GC4887@dhcp22.suse.cz>
References: <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <20200921134200.GK12990@dhcp22.suse.cz>
 <20200921141830.GE5962@xz-x1>
 <20200921142834.GL12990@dhcp22.suse.cz>
 <20200921143847.GB4268@mtj.duckdns.org>
 <20200921144355.mrzc66lina3dkfjq@wittgenstein>
 <20200921145537.GM12990@dhcp22.suse.cz>
 <20200921150450.3mjjb3p3jwgatn4v@wittgenstein>
 <20200921160643.GP12990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921160643.GP12990@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-09-20 18:06:44, Michal Hocko wrote:
[...]
> Thanks a lot for this clarification! So I believe the only existing bug
> is in documentation which should be explicit that the cgroup fd read
> access is not sufficient because it also requires to have a write access
> for cgroup.procs in the same directory at the time of fork. I will send
> a patch if I find some time for that.

I have reread the man page and concluded that the current wording is
not bugy. It is referring to cgroups(7) which has all the information
but it takes quite some to drill down to the important point. On the
other hand there are many details (like delegation, namespaces) which
makes it quite complex to be concise in clone(2) so it is very likely
better to leave as it is.

-- 
Michal Hocko
SUSE Labs
