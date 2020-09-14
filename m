Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843BB268FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgINPS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:18:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:56690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgINPRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:17:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B45CB527;
        Mon, 14 Sep 2020 15:17:52 +0000 (UTC)
Date:   Mon, 14 Sep 2020 17:17:36 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Chunxin Zang <zangchunxin@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [External] Re: [PATCH v2] mm/vmscan: fix infinite loop in
 drop_slab_node
Message-ID: <20200914151736.GA16999@dhcp22.suse.cz>
References: <20200909152047.27905-1-zangchunxin@bytedance.com>
 <20200914093032.GG16999@dhcp22.suse.cz>
 <CAKRVAeP1yPDTcdcW+H6EnMrDHsWGNkooGcSyeYWHi8CXCc+u4Q@mail.gmail.com>
 <20200914134713.GS16999@dhcp22.suse.cz>
 <CAKRVAeOejq8D63FC=Vhhu7VcRba__d-m8OGUQoRDvcUuh7L2ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKRVAeOejq8D63FC=Vhhu7VcRba__d-m8OGUQoRDvcUuh7L2ZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 23:02:15, Chunxin Zang wrote:
> On Mon, Sep 14, 2020 at 9:47 PM Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Mon 14-09-20 21:25:59, Chunxin Zang wrote:
> > > On Mon, Sep 14, 2020 at 5:30 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > > The subject is misleading because this patch doesn't fix an infinite
> > > > loop, right? It just allows the userspace to interrupt the operation.
> > > >
> > > >
> > > Yes,  so we are making a separate patch follow Vlastimil's
> > recommendations.
> > > Use double of threshold to end the loop.
> >
> > That still means the changelog needs an update
> >
> 
> The patch is already merged in Linux-next branch.  Can I update the
> changelog now?

Yes. Andrew will refresh it. He doesn't have a git tree which would
prevent rewriting the patch.

> This is my first patch, please forgive me :)

No worries. The mm patch workflow is rather different from others.

> > > On Thu, Sep 10, 2020 at 1:59 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > > > From: Chunxin Zang <zangchunxin@bytedance.com>
> > > > >
> > > > ...
> > > > - IMHO it's still worth to bail out in your scenario even without a
> > > > signal, e.g.
> > > > by the doubling of threshold. But it can be a separate patch.
> > > > Thanks!
> > > > ...
> > >
> > >
> > >
> > > On Wed 09-09-20 23:20:47, zangchunxin@bytedance.com wrote:
> > > > > From: Chunxin Zang <zangchunxin@bytedance.com>
> > > > >
> > > > > On our server, there are about 10k memcg in one machine. They use
> > memory
> > > > > very frequently. When I tigger drop caches，the process will infinite
> > loop
> > > > > in drop_slab_node.
> > > >
> > > > Is this really an infinite loop, or it just takes a lot of time to
> > > > process all the metadata in that setup? If this is really an infinite
> > > > loop then we should look at it. My current understanding is that the
> > > > operation would finish at some time it just takes painfully long to get
> > > > there.
> > > >
> > >
> > > Yes,  it's really an infinite loop.  Every loop spends a lot of time. In
> > > this time,
> > > memcg will alloc/free memory,  so the next loop, the total of  'freed'
> > > always bigger than 10.
> >
> > I am still not sure I follow. Do you mean that there is somebody
> > constantly generating more objects to reclaim?
> >
> 
> Yes, this is my meaning. :)
> 
> 
> > Maybe we are just not agreeing on the definition of an infinite loop but
> > in my book that means that the final condition can never be met. While a
> > busy adding new object might indeed cause drop caches to loop for a long
> > time this is to be expected from that interface as it is supposed to
> > drop all the cache and that can grow during the operation.
> > --
> >
> 
> Because I have 10k memcg , all of them are heavy users of memory.
> During each loop, there are always more than 10 reclaimable objects
> generating, so the
> condition is never met.

10k or any number of memcgs shouldn't really make much of a difference.
Except for the time the scan adds. Fundamentally we are talking about
freed objects and whether they are on the global or per memcg lists
should result in a similar behavior.

> The drop cache process has no chance to exit the
> loop.
> Although the purpose of the 'drop cache' interface is to release all
> caches, we still need a
> way to terminate it, e.g. in this case, the process took too long to run .

Yes, this is perfectly understandable. Having a bail out on fatal signal
is a completely reasonable thing to do. I am mostly confused by your
infinite loop claims and what the relation of this patch to it. I would
propose this wording instead

"
We have observed that drop_caches can take a considerable amount of
time (<put data here>). Especially when there are many memcgs involved
because they are adding an additional overhead.

It is quite unfortunate that the operation cannot be interrupted by a
signal currently. Add a check for fatal signals into the main loop
so that userspace can control early bailout.
"

or something along those lines.

> 
>   root  357956 ... R    Aug25 21119854:55 echo 3 > /proc/sys/vm/drop_caches

-- 
Michal Hocko
SUSE Labs
