Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380B329E71E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgJ2JU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgJ2JU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:20:59 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A69C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lvxi8Vu6wbO/FcwfD8aDY+CFIZB8fqh61j5DOHy9d+E=; b=y2YHUKWuR95P87t0RVQNxm/YJE
        HVyGDf/h3XgHpM+rCodDY85S0nQaQ305mimze6Kx5M4HJv0hTujoVbpUm3OHYeZYUzdoWRLm+t4nz
        CwieevADmCUDpBOQ/xT4cxKfIaxAIvnS8A4oSMJy9O2asCxt8KT8VBuGy/+G2EXIwqxQifNP0lfAC
        /WTJ1ZBuLD3mJGk0uyUU3BHdGhAP13dZ2c7QKAEhcsf1BQDNMcXdNkEf2183DiC2413qfybI2ts0i
        S2bN+8PV9lpOUhRhDwQOUzLIpxQJziWpD8fZO9JgStYnT23JqogAZyjdrAQfQzbZa75HCRbVrrwoS
        4+Z2e0Fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY3xR-0005Bc-4H; Thu, 29 Oct 2020 09:10:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 421E03012C3;
        Thu, 29 Oct 2020 10:10:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19D7E20B28594; Thu, 29 Oct 2020 10:10:53 +0100 (CET)
Date:   Thu, 29 Oct 2020 10:10:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v3 6/6] rcu/tree: Use irq_work_queue_remote()
Message-ID: <20201029091053.GG2628@hirez.programming.kicks-ass.net>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.584884062@infradead.org>
 <20201028145428.GE2628@hirez.programming.kicks-ass.net>
 <20201028200243.GJ2651@hirez.programming.kicks-ass.net>
 <20201028201554.GE3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028201554.GE3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 01:15:54PM -0700, Paul E. McKenney wrote:
> On Wed, Oct 28, 2020 at 09:02:43PM +0100, Peter Zijlstra wrote:

> > Subject: rcu/tree: Use irq_work_queue_remote()
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Wed Oct 28 11:53:40 CET 2020
> > 
> > All sites that consume rcu_iw_gp_seq seem to have rcu_node lock held,
> > so setting it probably should too. Also the effect of self-IPI here
> > would be setting rcu_iw_gp_seq to the value we just set it to
> > (pointless) and clearing rcu_iw_pending, which we just set, so don't
> > set it.
> > 
> > Passes TREE01.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/rcu/tree.c |   10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1308,14 +1308,16 @@ static int rcu_implicit_dynticks_qs(stru
> >  			resched_cpu(rdp->cpu);
> >  			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
> >  		}
> > -#ifdef CONFIG_IRQ_WORK
> > +		raw_spin_lock_rcu_node(rnp);
> 
> The caller of rcu_implicit_dynticks_qs() already holds this lock.
> Please see the force_qs_rnp() function and its second call site,
> to which rcu_implicit_dynticks_qs() is passed as an argument.
> 
> But other than that, this does look plausible.  And getting rid of
> that #ifdef is worth something.  ;-)

Dang, clearly TREE01 didn't actually hit any of this code :/ Is there
another test I should be running?
