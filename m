Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EFB2F8DC1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbhAPRGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:06:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbhAPQkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 11:40:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E82C2087E;
        Sat, 16 Jan 2021 15:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610811942;
        bh=OfveYr4oEYaNENOH4nieZPzwuRhlzFLXdVKngXxsswA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=joRSRbKMQ09t+ffLEzOmbIY3Qzso3VzokwwNBzG+vImVlCqMW3MgIEZcWxPP1ScOl
         LfCHoErA88cQAL9P6UGKFLMsgElyLJ6qPofCUFGjv7iWB+Q7yzvXtZtwBLiRhThjRI
         7oDyJwM8PD5IPJpuhvjAlsRHz/nnT9WPLNSspWu0rdlG56V0lm1f/uLUKh6iHktDPq
         oXtFWpoSEY2NenrtfIRWhDZjQTtU7aLjqJvOaUt9vSkzQBU+B9fIKRP0YDjFhqFeDG
         +MiOJLbxvSsgGDfdlew+4iK+tYA0GX1wYQEudOFLHAnjCGpK4H5BtvIUOc6tCEpdqf
         J/z8ZKiVLODPA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6F4DA35225DC; Sat, 16 Jan 2021 07:45:42 -0800 (PST)
Date:   Sat, 16 Jan 2021 07:45:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH 0/8] sched: Fix hot-unplug regressions
Message-ID: <20210116154542.GQ2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210116113033.608340773@infradead.org>
 <YAMFhsXamvCT2tzM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAMFhsXamvCT2tzM@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 04:25:58PM +0100, Peter Zijlstra wrote:
> On Sat, Jan 16, 2021 at 12:30:33PM +0100, Peter Zijlstra wrote:
> > Hi,
> > 
> > These patches (no longer 4), seems to fix all the hotplug regressions as per
> > nearly a 100 18*SRCU-P runs over-night.
> > 
> > I did clean up the patches, so possibly I wrecked it again. I've started new
> > runs and will again leave them running over-night.
> 
> Hurph... I've got one splat from this version, one I've not seen before:
> 
> [   68.712848] Dying CPU not properly vacated!
> ...
> [   68.744448] CPU1 enqueued tasks (2 total):
> [   68.745018]  pid: 14, name: rcu_preempt
> [   68.745557]  pid: 18, name: migration/1
> 
> Paul, rcu_preempt, is from rcu_spawn_gp_kthread(), right? Afaict that
> doesn't even have affinity.. /me wonders HTH that ended up on the
> runqueue so late.

Yes, rcu_preempt is from rcu_spawn_gp_kthread(), and you are right that
the kernel code does not bind it anywhere.  If this is rcutorture,
there isn't enough of a userspace to do the binding there, eihter.
Wakeups for the rcu_preempt task can happen in odd places, though.

Grasping at straws...  Would Frederic's series help?  This is in
-rcu here:

cfd941c rcu/nocb: Detect unsafe checks for offloaded rdp
028d407 rcu: Remove superfluous rdp fetch
38e216a rcu: Pull deferred rcuog wake up to rcu_eqs_enter() callers
53775fd rcu/nocb: Perform deferred wake up before last idle's need_resched() check
1fbabce rcu/nocb: Trigger self-IPI on late deferred wake up before user resume
2856844 entry: Explicitly flush pending rcuog wakeup before last rescheduling points
4d959df sched: Report local wake up on resched blind zone within idle loop
2617331 entry: Report local wake up on resched blind zone while resuming to user
79acd12 timer: Report ignored local enqueue in nohz mode

I have been including these in all of my tests of your patches.

							Thanx, Paul
