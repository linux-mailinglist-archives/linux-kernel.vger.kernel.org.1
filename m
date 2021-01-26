Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43118303F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405634AbhAZOBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:01:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:55868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404105AbhAZOAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:00:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611669562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JCAbd7z4tqnsZ/4DW7kFHtVQefHj8K36GoZRlW3XnSo=;
        b=ZVLCr3UY2N0PhZ0VDIfebHpRaQ/hMHCTcYTjnRQBQG3Yag66LWNdyr/5XdFhp6daJM2I3E
        x+5YvjS6MlrU8aDPbmWDJT3dE0/o5r5HoFgftOyRjNeyTPYIOud0km9wUY65Sk/ak27xq+
        1HTlodXIwUGChEPqDjTdqe0j0DyWiA4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8F26AB9F;
        Tue, 26 Jan 2021 13:59:21 +0000 (UTC)
Date:   Tue, 26 Jan 2021 14:59:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <20210126135918.GQ827@dhcp22.suse.cz>
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <20210126085243.GE827@dhcp22.suse.cz>
 <CAKfTPtAhqiHtPMUTZv8Bs3Cg5=HXLmrda=j4_HFrF=7ztYZLGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAhqiHtPMUTZv8Bs3Cg5=HXLmrda=j4_HFrF=7ztYZLGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-01-21 14:38:14, Vincent Guittot wrote:
> On Tue, 26 Jan 2021 at 09:52, Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 21-01-21 19:19:21, Vlastimil Babka wrote:
> > [...]
> > > We could also start questioning the very assumption that number of cpus should
> > > affect slab page size in the first place. Should it? After all, each CPU will
> > > have one or more slab pages privately cached, as we discuss in the other
> > > thread... So why make the slab pages also larger?
> >
> > I do agree. What is the acutal justification for this scaling?
> >         /*
> >          * Attempt to find best configuration for a slab. This
> >          * works by first attempting to generate a layout with
> >          * the best configuration and backing off gradually.
> >          *
> >          * First we increase the acceptable waste in a slab. Then
> >          * we reduce the minimum objects required in a slab.
> >          */
> >
> > doesn't speak about CPUs.  9b2cd506e5f2 ("slub: Calculate min_objects
> > based on number of processors.") does talk about hackbench "This has
> > been shown to address the performance issues in hackbench on 16p etc."
> > but it doesn't give any more details to tell actually _why_ that works.
> >
> > This thread shows that this is still somehow related to performance but
> > the real reason is not clear. I believe we should be focusing on the
> > actual reasons for the performance impact than playing with some fancy
> > math and tuning for a benchmark on a particular machine which doesn't
> > work for others due to subtle initialization timing issues.
> >
> > Fundamentally why should higher number of CPUs imply the size of slab in
> > the first place?
> 
> A 1st answer is that the activity and the number of threads involved
> scales with the number of CPUs. Regarding the hackbench benchmark as
> an example, the number of group/threads raise to a higher level on the
> server than on the small system which doesn't seem unreasonable.
> 
> On 8 CPUs, I run hackbench with up to 16 groups which means 16*40
> threads. But I raise up to 256 groups, which means 256*40 threads, on
> the 224 CPUs system. In fact, hackbench -g 1 (with 1 group) doesn't
> regress on the 224 CPUs  system.  The next test with 4 groups starts
> to regress by -7%. But the next one: hackbench -g 16 regresses by 187%
> (duration is almost 3 times longer). It seems reasonable to assume
> that the number of running threads and resources scale with the number
> of CPUs because we want to run more stuff.

OK, I do understand that more jobs scale with the number of CPUs but I
would also expect that higher order pages are generally more expensive
to get so this is not really a clear cut especially under some more
demand on the memory where allocations are smooth. So the question
really is whether this is not just optimizing for artificial conditions.
-- 
Michal Hocko
SUSE Labs
