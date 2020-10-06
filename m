Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3855284BFC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgJFMuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:50:16 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42834 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgJFMuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:50:16 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 096Cn7rx005828;
        Tue, 6 Oct 2020 14:49:07 +0200
Date:   Tue, 6 Oct 2020 14:49:07 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
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
Message-ID: <20201006124907.GA5822@1wt.eu>
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <3dfe7daed3c44f46a6989b6513ad7bb0@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dfe7daed3c44f46a6989b6513ad7bb0@AcuMS.aculab.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 12:37:06PM +0000, David Laight wrote:
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

I'm using exactly this in userland to prevent the compiler from guessing
what I'm doing with a variable, and it's also useful sometimes to shut up
certain warnings when I know a condition is satisfied but can hardly be
expressed in a way to please the compiler. Overall I find that it's no
big deal and forces the developer to think twice before doing it, which
is probably a good thing in general.

Willy
