Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9665285BEE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 11:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgJGJdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 05:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgJGJdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 05:33:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1FCC061755;
        Wed,  7 Oct 2020 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wJw+mYxMBc2rvtR6UN+0ruN6R+ddnjNDsA3uZmB1vw8=; b=FxUvfYCiCDUvPo9hhkqOiLChgK
        TyILl8/GAWxTdUIx+Kd/Cs/IrpSKTYNxrGo7jIQzw1IwaGkAXhBEA0p2JrIXC3t3P7kUHYRqSBPX7
        LGZtCsYc07vLY5nLMlGzoRgXxJ2NrSDDgtEQwtCGt66FWS9WaL9b233kxLUMC1xVIxkNRN4DcWD38
        kzefyyBOktLIn89gsJdFuNZBcb8vK910zDRl+MtSO0VMT65IG3FqYhpbgzvZSA/+rNRXrR2Cpvycp
        fdQu8QDPurqS8fwdCO1BXjKqWyXgHpPtbrZc+dMXFZ/QzVA+rhSMOBPIjLoiEtc2pZta72ywsb4+C
        mTvQ97lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ5oV-0004hf-0P; Wed, 07 Oct 2020 09:32:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8EC7A3006D0;
        Wed,  7 Oct 2020 11:32:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 778D42B9E34E4; Wed,  7 Oct 2020 11:32:43 +0200 (CEST)
Date:   Wed, 7 Oct 2020 11:32:43 +0200
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
Message-ID: <20201007093243.GB2628@hirez.programming.kicks-ass.net>
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <875z7nm4qm.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z7nm4qm.fsf@oldenburg2.str.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 11:20:01PM +0200, Florian Weimer wrote:
> * Peter Zijlstra:
> 
> > Our Documentation/memory-barriers.txt has a Control Dependencies section
> > (which I shall not replicate here for brevity) which lists a number of
> > caveats. But in general the work-around we use is:
> >
> > 	x = READ_ONCE(*foo);
> > 	if (x > 42)
> > 		WRITE_ONCE(*bar, 1);
> >
> > Where READ/WRITE_ONCE() cast the variable volatile. The volatile
> > qualifier dissuades the compiler from assuming it knows things and we
> > then hope it will indeed emit the branch like we'd expect.
> >
> >
> > Now, hoping the compiler generates correct code is clearly not ideal and
> > very dangerous indeed. Which is why my question to the compiler folks
> > assembled here is:
> >
> >   Can we get a C language extention for this?
> 
> For what exactly?

A branch that cannot be optimized away and prohibits lifting stores
over. One possible suggestion would be allowing the volatile keyword as
a qualifier to if.

	x = *foo;
	volatile if (x > 42)
		*bar = 1;

This would tell the compiler that the condition is special in that it
must emit a conditional branch instruction and that it must not lift
stores (or sequence points) over it.

> Do you want a compiler that never simplifies conditional expressions
> (like some people want compilers that never re-associate floating point
> operations)?

No. I'm fine with optimizing things in general, I just want to be able
to control/limit it for a few specific cases.

> > And while we have a fair number (and growing) existing users of this in
> > the kernel, I'd not be adverse to having to annotate them.
> 
> But not using READ_ONCE and WRITE_ONCE?

I'm OK with READ_ONCE(), but the WRITE_ONCE() doesn't help much, if
anything. The compiler is always allowed to lift stores, regardless of
the qualifiers used.

> I think in GCC, they are called __atomic_load_n(foo, __ATOMIC_RELAXED)
> and __atomic_store_n(foo, __ATOMIC_RELAXED).  GCC can't optimize relaxed
> MO loads and stores because the C memory model is defective and does not
> actually guarantee the absence of out-of-thin-air values (a property it
> was supposed to have).

AFAIK people want to get that flaw in the C memory model fixed (which to
me seemd like a very good idea).

Also, AFAIK the compiler would be allowed to lift __atomic_store_n(foo,
__ATOMIC_RELAXED) out of a branch.

> A different way of annotating this would be a variant of _Atomic where
> plain accesses have relaxed MO, not seq-cst MO.

So Linux isn't going to use _Atomic, we disagree with the C memory model
too much. Also, volatile is perfectly sufficient for things.

I know there's a bunch of people in the C committee that want to get rid
of volatile, but that's just not going to happen in the real world,
there's too much volatile out there.

More to the point, Linux already relies on this without the later stores
being annotated, and it works because lifting those stores just really
doesn't make sense (and it's further constrained by sequence points,
although I'm not sure what, if anything, the effect of LTO optimization
is on sequence points -- inline for example removes sequence points,
which is sometimes scary as heck).
