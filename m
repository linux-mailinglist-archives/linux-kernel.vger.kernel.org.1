Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2143F285E7A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgJGLvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbgJGLvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:51:12 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9BC061755;
        Wed,  7 Oct 2020 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+NtOMzSyaBCbS7zD7aQsWzAVVqwd7+TzQ+IFL+Uw9xg=; b=CEHLpvg+6BMTOIwAJVnqHh3MSF
        EDLwMp/MY/Us1EItwRa7inhq/o5Rsb2qXZl441OtXuSiFbWMljuH2EoFf0LOjbEqXpWh7De2nCOCM
        rPeY6pFvS9QYX1Cs90MnFFMKVf6RI2mLhEcKbkURS5dNRthsUiHJCasIjenV13xJVmXb60+6R7jg9
        tJwSJ59dsPdbqZU7CncyuPx3jQfWRCKFDceAdHxvJNedEE6QuxnBHBYnokpEUfu8puo4ifI17MWZW
        FR48q82mBzrRz0KsnCJhTDr2N+0UKgbHVKL2jvqXpWiUhRV3O1n36HdYSweRBGpP3w9dff7KrYqB4
        svqSKp5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ7yE-0005cw-ES; Wed, 07 Oct 2020 11:50:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9ADBB3019CE;
        Wed,  7 Oct 2020 13:50:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87A5829AD6629; Wed,  7 Oct 2020 13:50:54 +0200 (CEST)
Date:   Wed, 7 Oct 2020 13:50:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-toolchains@vger.kernel.org, Will Deacon <will@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        torvalds@linux-foundation.org
Subject: Re: Control Dependencies vs C Compilers
Message-ID: <20201007115054.GD2628@hirez.programming.kicks-ass.net>
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <875z7nm4qm.fsf@oldenburg2.str.redhat.com>
 <20201007093243.GB2628@hirez.programming.kicks-ass.net>
 <87k0w2gww6.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0w2gww6.fsf@oldenburg2.str.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 12:20:41PM +0200, Florian Weimer wrote:
> * Peter Zijlstra:

> > A branch that cannot be optimized away and prohibits lifting stores
> > over. One possible suggestion would be allowing the volatile keyword as
> > a qualifier to if.
> >
> > 	x = *foo;
> > 	volatile if (x > 42)
> > 		*bar = 1;
> >
> > This would tell the compiler that the condition is special in that it
> > must emit a conditional branch instruction and that it must not lift
> > stores (or sequence points) over it.
> 
> But it's not the if statement, but the expression in it, right? 

No, it *IS* the if statement, the magic is a conditional branch
instruction and the fact that CPUs are not allowed to speculate stores
(which would lead to instant OOTA).

> So this would not be a valid transformation:
> 
>  	x = *foo;
>         bool flag = x > 42;
>  	volatile if (flag)
>  		*bar = 1;

It would be valid, it still ensures the load of *foo happens before the
store of *bar.

> And if we had this:
> 
>  	unsigned x = *foo;
>  	volatile if (x >= 17 && x < 42)
>  		*bar = 1;
> 
> Would it be valid to transform this into (assuming that I got the
> arithmetic correct):
> 
>  	unsigned x = *foo;
>  	volatile if ((x - 17) < 25)
>  		*bar = 1;
> 
> Or would this destroy the magic because arithmetic happens on the value
> before the comparison?

Nope, that'd still be good. The critical part is that the resolution of
the conditional branch depend on the load. All these transformations
preserve that.

So we use the data dependency between the load and the branch
instruction coupled with the inability to speculate stores, to generate
a LOAD to STORE ordering.

> >> But not using READ_ONCE and WRITE_ONCE?
> >
> > I'm OK with READ_ONCE(), but the WRITE_ONCE() doesn't help much, if
> > anything. The compiler is always allowed to lift stores, regardless of
> > the qualifiers used.
> 
> I would hope that with some level of formalization, it can be shown that
> no additional synchronization is necessary beyond the load/conditional
> sequence.

Agreed. Those are the critical part, the tricky bit is ensuring the
compiler doesn't lift stuff over the condition.

> >> I think in GCC, they are called __atomic_load_n(foo, __ATOMIC_RELAXED)
> >> and __atomic_store_n(foo, __ATOMIC_RELAXED).  GCC can't optimize relaxed
> >> MO loads and stores because the C memory model is defective and does not
> >> actually guarantee the absence of out-of-thin-air values (a property it
> >> was supposed to have).
> >
> > AFAIK people want to get that flaw in the C memory model fixed (which to
> > me seemd like a very good idea).
> 
> It's been a long time since people realized that this problem exists,
> with several standard releases since then.

I've been given to believe it is a hard problem. Personally I hold the
opinion that prohibiting store speculation (of all kinds) is both
necesary and sufficient to avoid OOTA. But I have 0 proof for that.
