Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1267284E34
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgJFOnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgJFOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:43:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9A1C061755;
        Tue,  6 Oct 2020 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RpDXxvgo6zmfmRh0+gX7Xwh2qKG+UvHfx0rgKu5yNLg=; b=HqePj0ZbufhT1RBncg0jCOIRk6
        3838R4M31vzqnWTqtLXN7yNAhYbu/X6yehZDnZlyI5+xGwg+cZgWNs6KxMRn1W+EfoKRKxGepxhe3
        KmHq8HJzNMt0OwSPH4G4ClSpxwd+F/xxgtULmeXxxZXrsZvQM7hJuo2hEymOdiqI+4HHKM7e370ll
        jZF6c0Ld8IYcEdzokFKPkgVqBb9BkVHhfYdTDIpJrBFZV0Y5BAinavkcWfpZ1gT+RZE71JACQ4qma
        2vsMUgnTi5Xb+7GMJPu6l/f9sTu5LGPdn4lQSqJG1+Pz+cqSc1G2MGfE+MAmVTtD9RcO5rFNdy3It
        n0pmWeCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPoBE-0006nb-Nk; Tue, 06 Oct 2020 14:43:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4922B3006D0;
        Tue,  6 Oct 2020 16:43:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3333228527D6C; Tue,  6 Oct 2020 16:43:02 +0200 (CEST)
Date:   Tue, 6 Oct 2020 16:43:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
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
Message-ID: <20201006144302.GY2628@hirez.programming.kicks-ass.net>
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <3dfe7daed3c44f46a6989b6513ad7bb0@AcuMS.aculab.com>
 <20201006133115.GT2628@hirez.programming.kicks-ass.net>
 <20201006142324.GB416765@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006142324.GB416765@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 10:23:24AM -0400, stern@rowland.harvard.edu wrote:
> On Tue, Oct 06, 2020 at 03:31:15PM +0200, Peter Zijlstra wrote:

> > Only if we get the compiler people on board and have them provide means
> > are we guaranteed safe from the optimizer. Otherwise we'll just keep
> > playing whack-a-mole with fancy new optimization techniques. And given
> > how horridly painful it is to debug memory ordering problems, I feel it
> > is best to make sure we're not going to have to more than necessary.
> 
> Given that you would have to add a compiler annotation, isn't it just as 
> easy to use READ_ONCE and WRITE_ONCE?
> 
> Or are you worried that even with READ_ONCE and WRITE_ONCE, the compiler 
> might still somehow defeat the control dependency?

Yes.

Also, not all instances actually have the WRITE_ONCE() on. The one in
the perf ringbuffer for example uses local_read() for the load (which is
basically READ_ONCE()), but doesn't have WRITE_ONCE() on the inside.

Also, afaiu WRITE_ONCE() also doesn't stop the compiler from lifting it
if it thinks it can get away with it -- memory-barriers.txt has
examples.

And then there's the case where the common branch has a store, I know
ARM64 ARM isn't clear on that, but I'm thinking any actual hardware will
still have to respect it, and it's a matter of 'fixing' the ARM.


Mostly I just want the compiler people to say they'll guarantee the
behaviour if we do 'X'. If 'X' happens to be 'any dynamic branch headed
by a volatile load' that's fine by me.

If they want a new keyword or attribute, that's also fine. But I want to
have the compiler people tell me what they want and guarantee they'll
not come and wreck things.
