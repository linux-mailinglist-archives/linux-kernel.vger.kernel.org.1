Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113C0273C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgIVHuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:50:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:55928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIVHuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:50:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600761013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fdj/dqT3AFMbHqIduByccECZMraB9WPLBQ+Z7g3LqHc=;
        b=l7Zp6HEgaCFjdmMl7mvcx9R0gLlCrJIuj12JU20xDRF/pQr3RI1kQ0xyrpwSos/i6I47iy
        Dmm/rYMj+jufTduwGtCMUPzLIZ244tdMf27e69EOonA5GuedAPmvYyTRcNNY7b22sn0+rX
        PBGBv9afIOkupxXeg96xdGm0y/eZT64=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19D0DACC8;
        Tue, 22 Sep 2020 07:50:50 +0000 (UTC)
Date:   Tue, 22 Sep 2020 09:50:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200922075002.GU12990@dhcp22.suse.cz>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921194819.GA24236@pc636>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Mel - the thread starts http://lkml.kernel.org/r/20200918194817.48921-1-urezki@gmail.com]

On Mon 21-09-20 21:48:19, Uladzislau Rezki wrote:
> Hello, Michal.
> 
> > >
> > > Yes, I do well remember that you are unhappy with this approach.
> > > Unfortunately, thus far, there is no solution that makes all developers
> > > happy.  You might be glad to hear that we are also looking into other
> > > solutions, each of which makes some other developers unhappy.  So we
> > > are at least not picking on you alone.  :-/
> > 
> > No worries I do not feel like a whipping boy here. But do expect me to
> > argue against the approach. I would also appreciate it if there was some
> > more information on other attempts, why they have failed. E.g. why
> > pre-allocation is not an option that works well enough in most
> > reasonable workloads.
> Pre-allocating has some drawbacks:
> 
> a) It is impossible to predict how many pages will be required to
>    cover a demand that is controlled by different workloads on
>    various systems.

Yes, this is not trivial but not a rocket science either. Remember that
you are relying on a very dumb watermark based pcp pool from the
allocator. Mimicing a similar implementation shouldn't be all that hard
and you will get your own pool which doesn't affect other page allocator
users as much as a bonus.

> b) Memory overhead since we do not know how much pages should be
>    preloaded: 100, 200 or 300

Does anybody who really needs this optimization actually cares about 300
pages?

> As for memory overhead, it is important to reduce it because of
> embedded devices like phones, where a low memory condition is a
> big issue. In that sense pre-allocating is something that we strongly
> would like to avoid.

How big "machines" are we talking about here? I would expect that really
tiny machines would have hard times to really fill up thousands of pages
with pointers to free...

Would a similar scaling as the page allocator feasible. Really I mostly
do care about shared nature of the pcp allocator list that one user can
easily monopolize with this API.

> > I would also appreciate some more thoughts why we
> > need to optimize for heavy abusers of RCU (like close(open) extremes).
> > 
> I think here is a small misunderstanding. Please note, that is not only
> about performance and corner cases. There is a single argument support
> of the kvfree_rcu(ptr), where maintaining an array in time is needed.
> The fallback of the single argument case is extrimely slow.

This should be part of the changelog.
> 
> Single-argument details is here: https://lkml.org/lkml/2020/4/28/1626

Error 501

> > > > I strongly agree with Thomas http://lkml.kernel.org/r/87tux4kefm.fsf@nanos.tec.linutronix.de
> > > > that this optimization is not aiming at reasonable workloads. Really, go
> > > > with pre-allocated buffer and fallback to whatever slow path you have
> > > > already. Exposing more internals of the allocator is not going to do any
> > > > good for long term maintainability.
> > > 
> > > I suggest that you carefully re-read the thread following that email.
> > 
> > I clearly remember Thomas not being particularly happy that you optimize
> > for a corner case. I do not remember there being a consensus that this
> > is the right approach. There was some consensus that this is better than
> > a gfp flag. Still quite bad though if you ask me.
> > 
> > > Given a choice between making users unhappy and making developers
> > > unhappy, I will side with the users each and every time.
> > 
> > Well, let me rephrase. It is not only about me (as a developer) being
> > unhappy but also all the side effects this would have for users when
> > performance of their favorite workload declines for no apparent reason
> > just because pcp caches are depleted by an unrelated process.
> >
> If depleted, we have a special worker that charge it. From the other hand,
> the pcplist can be depleted by its nature, what _is_ not wrong. But just
> in case we secure it since you had a concern about it.

pcp free lists should ever get empty when we run out of memory and need
to reclaim. Otherwise they are constantly refilled/rebalanced on demand.
The fact that you are refilling them from outside just suggest that you
are operating on a wrong layer. Really, create your own pool of pages
and rebalance them based on the workload.

> Could you please specify a real test case or workload you are talking about?

I am not a performance expert but essentially any memory allocator heavy
workload might notice. I am pretty sure Mel would tell you more.

-- 
Michal Hocko
SUSE Labs
