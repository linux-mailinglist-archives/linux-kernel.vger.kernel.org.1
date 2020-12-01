Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379AD2CAB94
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbgLATP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbgLATP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:15:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E86C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sif7xpo+9DZS5lSh1n+V/cNaHPoORMh1IMOhQKE3/bs=; b=yc++PysDYobx4Wm4DVCp4JZP5/
        7txzgTA/LqLzcYnMbS1puql5WLyJ6Uka2p/lw4FjV5x2WKSH9iGcZdClfQJdAvKbTFXT6e5qO04K3
        of2OhqzI5vaUQ9kE0/pZyA0EDpO+1zA5PA+OkGnbhyHcxQPYZCjphucAq3gFfWlBinATD3C8ZcwPd
        gcpsiMseT/sh+U1jkycXN6sbfUkhJNX+Gahl3qWq3xd7mtBN1Y+h3pZRWsnFWqQ7q8b4kq1LYjlZ8
        /0y5gXJWYKL6CrY61P3oTzR15Wmf+ntSr4VmlpvK9R58e0Vk0a90Bd8mPRpbkl7dFm3ozOMpDZ/Hf
        13GI1iYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkB6o-00033m-SV; Tue, 01 Dec 2020 19:14:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A11AD3003E1;
        Tue,  1 Dec 2020 20:14:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 856962BFCEB5F; Tue,  1 Dec 2020 20:14:41 +0100 (CET)
Date:   Tue, 1 Dec 2020 20:14:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201201191441.GW3040@hirez.programming.kicks-ass.net>
References: <20201130125211.GN2414@hirez.programming.kicks-ass.net>
 <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
 <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
 <dcdb13e3-36a0-031d-6ec3-3ab5ee4a69cb@de.ibm.com>
 <20201201080734.GQ2414@hirez.programming.kicks-ass.net>
 <20201201110724.GL3092@hirez.programming.kicks-ass.net>
 <20201201144644.GF1437@paulmck-ThinkPad-P72>
 <20201201145519.GY2414@hirez.programming.kicks-ass.net>
 <20201201181506.GM3092@hirez.programming.kicks-ass.net>
 <20201201185737.GA93208@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201185737.GA93208@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 06:57:37PM +0000, Mark Rutland wrote:
> On Tue, Dec 01, 2020 at 07:15:06PM +0100, Peter Zijlstra wrote:
> > On Tue, Dec 01, 2020 at 03:55:19PM +0100, Peter Zijlstra wrote:
> > > On Tue, Dec 01, 2020 at 06:46:44AM -0800, Paul E. McKenney wrote:
> > > 
> > > > > So after having talked to Sven a bit, the thing that is happening, is
> > > > > that this is the one place where we take interrupts with RCU being
> > > > > disabled. Normally RCU is watching and all is well, except during idle.
> > > > 
> > > > Isn't interrupt entry supposed to invoke rcu_irq_enter() at some point?
> > > > Or did this fall victim to recent optimizations?
> > > 
> > > It does, but the problem is that s390 is still using
> > 
> > I might've been too quick there, I can't actually seem to find where
> > s390 does rcu_irq_enter()/exit().
> > 
> > Also, I'm thinking the below might just about solve the current problem.
> > The next problem would then be it calling TRACE_IRQS_ON after it did
> > rcu_irq_exit()... :/
> 
> I gave this patch a go under QEMU TCG atop v5.10-rc6 s390 defconfig with
> PROVE_LOCKING and DEBUG_ATOMIC_SLEEP. It significantly reduces the
> number of lockdep splats, but IIUC we need to handle the io_int_handler
> path in addition to the ext_int_handler path, and there's a remaining
> lockdep splat (below).

I'm amazed it didn't actually make things worse, given how I failed to
spot do_IRQ() was arch code etc..

> If this ends up looking like we'll need more point-fixes, I wonder if we
> should conditionalise the new behaviour of the core idle code under a
> new CONFIG symbol for now, and opt-in x86 and arm64, then transition the
> rest once they've had a chance to test. They'll still be broken in the
> mean time, but no more so than they previously were.

We can do that I suppose... :/
