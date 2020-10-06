Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50AB284C91
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgJFNbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFNbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:31:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9411C061755;
        Tue,  6 Oct 2020 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O3EWqYk+iCYFGfEpVJGDX+3mmor+Zzy4SSzmYtlNgNM=; b=JbzkWDu/5QAaGHZnDmRJa+sIw3
        kqd/HaSCUfqkEHljgxx6j8vM/8H8L1yPJApFRqM2COj+kmVqiSuzRp6kcqwo1b+HL9BzWRM+W0WmT
        pwJvxtk+WtDs6VoQh87qElveWqeOqviJEGe4n8dSl+rremfIQHh3PHxn1LYvWhMzsyjUSTVzM0Zaf
        iW4HmtMBhw7y4P5SOEaX4XWLbMV26M0MUgRbgxtrKADB3owiTeMIulsYU/QoclL5zOjgTkjbbpeX/
        cixSHrItvf0GwhiWdfVUsccBAlD97kmrYnWbPP1fsex3ymnfkO7tZ5NdjyWmddYBmUcDT2taG9v/a
        cJyT94wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPn3k-0001vB-G7; Tue, 06 Oct 2020 13:31:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A39453006D0;
        Tue,  6 Oct 2020 15:31:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8226928297408; Tue,  6 Oct 2020 15:31:15 +0200 (CEST)
Date:   Tue, 6 Oct 2020 15:31:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
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
Message-ID: <20201006133115.GT2628@hirez.programming.kicks-ass.net>
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <3dfe7daed3c44f46a6989b6513ad7bb0@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dfe7daed3c44f46a6989b6513ad7bb0@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 12:37:06PM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 06 October 2020 12:47
> > Hi,
> > 
> > Let's give this linux-toolchains thing a test-run...
> > 
> > As some of you might know, there's a bit of a discrepancy between what
> > compiler and kernel people consider 'valid' use of the compiler :-)
> > 
> > One area where this shows up is in implicit (memory) ordering provided
> > by the hardware, which we kernel people would like to use to avoid
> > explicit fences (expensive) but which the compiler is unaware of and
> > could ruin (bad).
> ...
> > 
> > In short, the control dependency relies on the hardware never
> > speculating stores (instant OOTA) to provide a LOAD->STORE ordering.
> > That is, a LOAD must be completed to resolve a conditional branch, the
> > STORE is after the branch and cannot be made visible until the branch is
> > determined (which implies the load is complete).
> > 
> > However, our 'dear' C language has no clue of any of this.
> > 
> > So given code like:
> > 
> > 	x = *foo;
> > 	if (x > 42)
> > 		*bar = 1;
> > 
> > Which, if literally translated into assembly, would provide a
> > LOAD->STORE order between foo and bar, could, in the hands of an
> > evil^Woptimizing compiler, become:
> > 
> > 	x = *foo;
> > 	*bar = 1;
> > 
> > because it knows, through value tracking, that the condition must be
> > true.
> > 
> > Our Documentation/memory-barriers.txt has a Control Dependencies section
> > (which I shall not replicate here for brevity) which lists a number of
> > caveats. But in general the work-around we use is:
> > 
> > 	x = READ_ONCE(*foo);
> > 	if (x > 42)
> > 		WRITE_ONCE(*bar, 1);
> 
> An alternative is to 'persuade' the compiler that
> any 'tracked' value for a local variable is invalid.
> Rather like the way that barrier() 'invalidates' memory.
> So you generate:
> 
> 	x = *foo
> 	asm ("" : "+r" (x));
> 	if (x > 42)
> 		*bar = 1;
> 
> Since the "+r" constraint indicates that the value of 'x'
> might have changed it can't optimise based on any
> presumed old value.
> (Unless it looks inside the asm opcodes...)

The compiler can still try and lift the store out of the block, possibly
by inventing more stores.

Please go read memory-barriers.txt for a bunch of other examples.

This thread is not to collect work-arounds that might convince a
compiler to emit the desired code as a side effect, but to get the
compiler people involved and get control-dependencies recognised such
that correct code gen is guaranteed.

Only if we get the compiler people on board and have them provide means
are we guaranteed safe from the optimizer. Otherwise we'll just keep
playing whack-a-mole with fancy new optimization techniques. And given
how horridly painful it is to debug memory ordering problems, I feel it
is best to make sure we're not going to have to more than necessary.
