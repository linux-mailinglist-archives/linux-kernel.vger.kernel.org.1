Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98362990EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783751AbgJZPXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:23:07 -0400
Received: from casper.infradead.org ([90.155.50.34]:43662 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783632AbgJZPXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bip8z4aUZCGvDHwLoTkSRBUmu9biveNZBCHkBHA07+0=; b=iCCwKMTuiOiPMz9tmBkpNxQEGQ
        x2APCosl2yqUlDwL8HK2wGhkKDGtmTbfwRCChF6gyzM1BIlbIFC2Uwx3lVyM8hMunuBpmYAYt6k7+
        S3jPx/k+6TWMaGYHp2PX3a9idVpMnFhipxQvThvpbSHTZSxB7TtEizDm0SfPZHCYGSqxxshJLVxvv
        j7w24REuFkjx6NJSxrvOwZAQLLfdDk4EZadIN2bsJrEwD4Whqpqw2fMQcseSPSELjSGbCwDnIvRt/
        4t3FAwhfBgQgFTFhjq4m+VAC9TZRX3BuLEw0qNONmk0cyyQaBgsbG4b9/tSxWJNJyZjfqtpR37icG
        ZfBVGfNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX4Kp-0006bq-P7; Mon, 26 Oct 2020 15:23:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9B1C302526;
        Mon, 26 Oct 2020 16:22:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C79A7203BE3CA; Mon, 26 Oct 2020 16:22:56 +0100 (CET)
Date:   Mon, 26 Oct 2020 16:22:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>, matorola@gmail.com,
        mingo@kernel.org
Subject: Re: possible lockdep regression introduced by 4d004099a668
 ("lockdep: Fix lockdep recursion")
Message-ID: <20201026152256.GB2651@hirez.programming.kicks-ass.net>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201026114009.GN2594@hirez.programming.kicks-ass.net>
 <0c0d815c-bd5a-ff2d-1417-28a41173f2b4@suse.com>
 <20201026125524.GP2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026125524.GP2594@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 01:55:24PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 26, 2020 at 11:56:03AM +0000, Filipe Manana wrote:
> > > That smells like the same issue reported here:
> > > 
> > >   https://lkml.kernel.org/r/20201022111700.GZ2651@hirez.programming.kicks-ass.net
> > > 
> > > Make sure you have commit:
> > > 
> > >   f8e48a3dca06 ("lockdep: Fix preemption WARN for spurious IRQ-enable")
> > > 
> > > (in Linus' tree by now) and do you have CONFIG_DEBUG_PREEMPT enabled?
> > 
> > Yes, CONFIG_DEBUG_PREEMPT is enabled.
> 
> Bummer :/
> 
> > I'll try with that commit and let you know, however it's gonna take a
> > few hours to build a kernel and run all fstests (on that test box it
> > takes over 3 hours) to confirm that fixes the issue.
> 
> *ouch*, 3 hours is painful. How long to make it sick with the current
> kernel? quicker I would hope?
> 
> > Thanks for the quick reply!
> 
> Anyway, I don't think that commit can actually explain the issue :/
> 
> The false positive on lockdep_assert_held() happens when the recursion
> count is !0, however we _should_ be having IRQs disabled when
> lockdep_recursion > 0, so that should never be observable.
> 
> My hope was that DEBUG_PREEMPT would trigger on one of the
> __this_cpu_{inc,dec}(lockdep_recursion) instance, because that would
> then be a clear violation.
> 
> And you're seeing this on x86, right?
> 
> Let me puzzle moar..

So I might have an explanation for the Sparc64 fail, but that can't
explain x86 :/

I initially thought raw_cpu_read() was OK, since if it is !0 we have
IRQs disabled and can't get migrated, so if we get migrated both CPUs
must have 0 and it doesn't matter which 0 we read.

And while that is true; it isn't the whole store, on pretty much all
architectures (except x86) this can result in computing the address for
one CPU, getting migrated, the old CPU continuing execution with another
task (possibly setting recursion) and then the new CPU reading the value
of the old CPU, which is no longer 0.

I already fixed a bunch of that in:

  baffd723e44d ("lockdep: Revert "lockdep: Use raw_cpu_*() for per-cpu variables"")

but clearly this one got crossed.

Still, that leaves me puzzled over you seeing this on x86 :/

Anatoly, could you try linus+tip/locking/urgent and the below on your
Sparc, please?

---
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3e99dfef8408..a3041463e42d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -84,7 +84,7 @@ static inline bool lockdep_enabled(void)
 	if (!debug_locks)
 		return false;
 
-	if (raw_cpu_read(lockdep_recursion))
+	if (this_cpu_read(lockdep_recursion))
 		return false;
 
 	if (current->lockdep_recursion)
