Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1EB284D8D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgJFOXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:23:25 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58207 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725996AbgJFOXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:23:25 -0400
Received: (qmail 417956 invoked by uid 1000); 6 Oct 2020 10:23:24 -0400
Date:   Tue, 6 Oct 2020 10:23:24 -0400
From:   "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: Control Dependencies vs C Compilers
Message-ID: <20201006142324.GB416765@rowland.harvard.edu>
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <3dfe7daed3c44f46a6989b6513ad7bb0@AcuMS.aculab.com>
 <20201006133115.GT2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006133115.GT2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 03:31:15PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 06, 2020 at 12:37:06PM +0000, David Laight wrote:
> > From: Peter Zijlstra
> > > Sent: 06 October 2020 12:47
> > > Hi,
> > > 
> > > Let's give this linux-toolchains thing a test-run...
> > > 
> > > As some of you might know, there's a bit of a discrepancy between what
> > > compiler and kernel people consider 'valid' use of the compiler :-)
> > > 
> > > One area where this shows up is in implicit (memory) ordering provided
> > > by the hardware, which we kernel people would like to use to avoid
> > > explicit fences (expensive) but which the compiler is unaware of and
> > > could ruin (bad).
> > ...
> > > 
> > > In short, the control dependency relies on the hardware never
> > > speculating stores (instant OOTA) to provide a LOAD->STORE ordering.
> > > That is, a LOAD must be completed to resolve a conditional branch, the
> > > STORE is after the branch and cannot be made visible until the branch is
> > > determined (which implies the load is complete).
> > > 
> > > However, our 'dear' C language has no clue of any of this.
> > > 
> > > So given code like:
> > > 
> > > 	x = *foo;
> > > 	if (x > 42)
> > > 		*bar = 1;
> > > 
> > > Which, if literally translated into assembly, would provide a
> > > LOAD->STORE order between foo and bar, could, in the hands of an
> > > evil^Woptimizing compiler, become:
> > > 
> > > 	x = *foo;
> > > 	*bar = 1;
> > > 
> > > because it knows, through value tracking, that the condition must be
> > > true.
> > > 
> > > Our Documentation/memory-barriers.txt has a Control Dependencies section
> > > (which I shall not replicate here for brevity) which lists a number of
> > > caveats. But in general the work-around we use is:
> > > 
> > > 	x = READ_ONCE(*foo);
> > > 	if (x > 42)
> > > 		WRITE_ONCE(*bar, 1);
> > 
> > An alternative is to 'persuade' the compiler that
> > any 'tracked' value for a local variable is invalid.
> > Rather like the way that barrier() 'invalidates' memory.
> > So you generate:
> > 
> > 	x = *foo
> > 	asm ("" : "+r" (x));
> > 	if (x > 42)
> > 		*bar = 1;
> > 
> > Since the "+r" constraint indicates that the value of 'x'
> > might have changed it can't optimise based on any
> > presumed old value.
> > (Unless it looks inside the asm opcodes...)
> 
> The compiler can still try and lift the store out of the block, possibly
> by inventing more stores.
> 
> Please go read memory-barriers.txt for a bunch of other examples.
> 
> This thread is not to collect work-arounds that might convince a
> compiler to emit the desired code as a side effect, but to get the
> compiler people involved and get control-dependencies recognised such
> that correct code gen is guaranteed.
> 
> Only if we get the compiler people on board and have them provide means
> are we guaranteed safe from the optimizer. Otherwise we'll just keep
> playing whack-a-mole with fancy new optimization techniques. And given
> how horridly painful it is to debug memory ordering problems, I feel it
> is best to make sure we're not going to have to more than necessary.

Given that you would have to add a compiler annotation, isn't it just as 
easy to use READ_ONCE and WRITE_ONCE?

Or are you worried that even with READ_ONCE and WRITE_ONCE, the compiler 
might still somehow defeat the control dependency?

Alan
