Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01F0272AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgIUQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:03:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:58288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgIUQDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:03:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600704199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ltLMHo8mqz5GoZ6lqc2SgPYV21CASPBptZBtk9bwlA=;
        b=kXHdjAeJr+2wQw+dd9MPLRVpAvmxx1000cDa1jOidrybBPZk8C607Eky/QZN5L9KCG3wKM
        Y/gAXeT+x/WWRgo759rM/gW4UefRoAlgvBhCYbMwnTDgb68nkpyPS1YZsQvo4GnDmBGB3d
        W9/++PwMx1z6USStYNsSooKYSdCQYLU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B363AFE1;
        Mon, 21 Sep 2020 16:03:55 +0000 (UTC)
Date:   Mon, 21 Sep 2020 18:03:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200921160318.GO12990@dhcp22.suse.cz>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921154558.GD29330@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-09-20 08:45:58, Paul E. McKenney wrote:
> On Mon, Sep 21, 2020 at 09:47:16AM +0200, Michal Hocko wrote:
> > On Fri 18-09-20 21:48:15, Uladzislau Rezki (Sony) wrote:
> > [...]
> > > Proposal
> > > ========
> > > Introduce a lock-free function that obtain a page from the per-cpu-lists
> > > on current CPU. It returns NULL rather than acquiring any non-raw spinlock.
> > 
> > I was not happy about this solution when we have discussed this
> > last time and I have to say I am still not happy. This is exposing
> > an internal allocator optimization and allows a hard to estimate
> > consumption of pcp free pages. IIUC this run on pcp cache can be
> > controled directly from userspace (close(open) loop IIRC) which makes it
> > even bigger no-no.
> 
> Yes, I do well remember that you are unhappy with this approach.
> Unfortunately, thus far, there is no solution that makes all developers
> happy.  You might be glad to hear that we are also looking into other
> solutions, each of which makes some other developers unhappy.  So we
> are at least not picking on you alone.  :-/

No worries I do not feel like a whipping boy here. But do expect me to
argue against the approach. I would also appreciate it if there was some
more information on other attempts, why they have failed. E.g. why
pre-allocation is not an option that works well enough in most
reasonable workloads. I would also appreciate some more thoughts why we
need to optimize for heavy abusers of RCU (like close(open) extremes).

> > I strongly agree with Thomas http://lkml.kernel.org/r/87tux4kefm.fsf@nanos.tec.linutronix.de
> > that this optimization is not aiming at reasonable workloads. Really, go
> > with pre-allocated buffer and fallback to whatever slow path you have
> > already. Exposing more internals of the allocator is not going to do any
> > good for long term maintainability.
> 
> I suggest that you carefully re-read the thread following that email.

I clearly remember Thomas not being particularly happy that you optimize
for a corner case. I do not remember there being a consensus that this
is the right approach. There was some consensus that this is better than
a gfp flag. Still quite bad though if you ask me.

> Given a choice between making users unhappy and making developers
> unhappy, I will side with the users each and every time.

Well, let me rephrase. It is not only about me (as a developer) being
unhappy but also all the side effects this would have for users when
performance of their favorite workload declines for no apparent reason
just because pcp caches are depleted by an unrelated process.
-- 
Michal Hocko
SUSE Labs
