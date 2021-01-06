Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000F22EBFCC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbhAFOrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:47:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbhAFOrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:47:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CA7323100;
        Wed,  6 Jan 2021 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609944382;
        bh=VDYduDZ2hYzgBR2lAzOGuFpTrOM22sbWMH0q5980R7o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bb2QQWnkMIfGcV6jACTTjibZJuLKMNz+CgcJhVbTadUtcbc4pUTIEyNhT7Mi7tm4v
         LNTxWhcEbl4cPzoicZOdBf6IA5MaomPwPWRBiYdMCHf/Pm0JjABrAPljY9JYG22dNL
         181H/DQWYOfWmRX2tvr4kDS9STTX8AYxVWVtbTD2OE6fFf/mAydUUX8W3CAor9ljZg
         rIlzkEMOgLCxDQ4fZqyxgVx/lBS2PC2+QDxpZZmjb0jM43Vu0kPSQaGQxomSCIrVJb
         6DVvlvfaQb2LE9mF1qcm7KEw/Ajeb61kCfyCrbl32vWWBjCcJYzWj+jFobM+J3FISm
         x0X+YZRpusqUg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B877135225EC; Wed,  6 Jan 2021 06:46:21 -0800 (PST)
Date:   Wed, 6 Jan 2021 06:46:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, bristot@redhat.com, frederic@kernel.org
Subject: Re: lockdep splat in v5.11-rc1 involving console_sem and rq locks
Message-ID: <20210106144621.GJ17086@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210105220115.GA27357@paulmck-ThinkPad-P72>
 <X/WITr5JuNvuMH+p@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/WITr5JuNvuMH+p@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 10:52:14AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 05, 2021 at 02:01:15PM -0800, Paul E. McKenney wrote:
> > Hello!
> > 
> > The RUDE01 rcutorture scenario (and less often, the TASKS01 scenario)
> > results in occasional lockdep splats on v5.11-rc1 on x86.  This failure
> > is probabalistic, sometimes happening as much as 30% of the time, but
> > sometimes happening quite a bit less frequently.  (And yes, this did
> > result in a false bisection.  Why do you ask?)  The problem seems to
> > happen more frequently shortly after boot, so for fastest reproduction
> > run lots of 10-minute RUDE01 runs, which did eventually result in a
> > good bisection.  (Yes, I did hammer the last good commit for awhile.)
> > 
> > The first bad commit is 1cf12e08bc4d ("sched/hotplug: Consolidate task
> > migration on CPU unplug").  An example splat is shown below.
> > 
> > Thoughts?
> 
> The splat is because you hit a WARN, we're working on that.

Huh.  The WARN does not always generate the lockdep complaint.  But
fair enough.

>   https://lkml.kernel.org/r/20201226025117.2770-1-jiangshanlai@gmail.com

Thomas pointed me at this one a couple of weeks ago.  Here is an
additional fix for rcutorture: f67e04bb0695 ("torture: Break affinity
of kthreads last running on outgoing CPU").  I am still getting WARNs
and lockdep splats with both applied.

What would break if I made the code dump out a few entries in the
runqueue if the warning triggered?

						Thanx, Paul
