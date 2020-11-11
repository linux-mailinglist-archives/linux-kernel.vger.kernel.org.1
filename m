Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9A82AFB50
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 23:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgKKWUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 17:20:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:32808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbgKKWUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:20:43 -0500
Received: from localhost (unknown [176.177.123.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C067208B8;
        Wed, 11 Nov 2020 22:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605133242;
        bh=Bv4A+bRD/T4eOXdF8wCDv3XJTagFMcQiGk677O4ZYRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUHf5lG0NA5Y2lLh8pbb/4lnME3RxG0bYhRUw/hlDhZFakXWdy/09JQ0naFLk6zGT
         pUOoOpFGg5xyuo2UGH5MZ18UwwsTcFKra2l8dKIafkE2PLW4voe/prplppACyTlwEw
         RCTbierUAIAffVTwVxgy5KjXWy2J6yCqode7mGsA=
Date:   Wed, 11 Nov 2020 23:20:39 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 2/5] context_tracking:  Don't implement
 exception_enter/exit() on CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK
Message-ID: <20201111222039.GA73739@lothringen>
References: <20201027150827.148821-1-frederic@kernel.org>
 <20201027150827.148821-3-frederic@kernel.org>
 <20201111143218.GU2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111143218.GU2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 03:32:18PM +0100, Peter Zijlstra wrote:
> On Tue, Oct 27, 2020 at 04:08:24PM +0100, Frederic Weisbecker wrote:
> > An architecture that provides this Kconfig feature doesn't need to
> > store the context tracking state on the task stack because its entry
> > code has been sanitized such that fragile path aren't preemptible
> > and special use of tracing and RCU read side critical sections in these
> > areas have been explicitly annotated.
> > 
> > Hence the exception_enter()/exception_exit() couple doesn't need to be
> > implemented in this case.
> 
> Could you please explain what exception_{enter,exit}() actually do, then
> explain what is required to make it superfluous? Because as is, I don't
> have enough information to verify the claims made.

So, the typical steps with context tracking are:

1) Task runs in userspace
2) Task enters the kernel (syscall/exception/IRQ)
3) Task switches from context tracking state CONTEXT_USER to CONTEXT_KERNEL (user_exit())
4) Task does stuff in kernel
5) Task switches from context tracking state CONTEXT_KERNEL to CONTEXT_USER (user_enter())
6) Task exits the kernel

If an exception fires between 5) and 6), the pt_regs and the context tracking disagree
on the context of the origin. We must set CONTEXT_KERNEL before the exception handler,
that's unconditional for those that want to call into schedule, but we must restore
CONTEXT_USER when we exit the exception while pt_regs tells us that we are resuming to
kernel space.

We can't fix that with storing the context tracking state in a per-cpu or per-task variable
since another exception may fire onto the current one and overwrite the saved state. Also
the task can schedule. So it has to be stored in a per task stack.

This is how exception_enter()/exception_exit() papers over the problem:

5) Task switches from context tracking state CONTEXT_KERNEL to CONTEXT_USER (user_enter())
5.1) Exception fires
5.2) prev_state = exception_enter() // save CONTEXT_USER to prev_state and set CONTEXT_KERNEL
5.3) Exception handler
5.4) exception_enter(prev_state) // restore CONTEXT_USER
5.5) Exception resumes
6) Task exits the kernel

What is required to make it superfluous is to forbid exceptions and IRQs between 2) and 3)
and between 5) and 6), or if we allow any, they won't call into context tracking, eg: NMIs,
and they won't schedule.

I can add that in the changelog if that makes it any clearer.

Thanks.
