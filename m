Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D402F646C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbhANPWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:22:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbhANPWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:22:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65EC023B28;
        Thu, 14 Jan 2021 15:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610637727;
        bh=lP9Rg5ur/WccpQs9eF+9HiBwQ4afk3nrnViDH0nFIbA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UuLzFEoP1jUWXxWv4BiBEertVhHHdUIsdWQXnjEhubFlWexxSjrqkGI+olnI8DPwU
         RXJ71IEsNP0wg7jr4hdtg118UDQAXPbmizxfY+Rtu9nbYaufgyfH+hPmPVSXuUCd/u
         JpiimImRv+C5k4dFH04G4YQeUCuTcGmwS4286OlxTmLXreg1YlLhYIqbvQFJpV481c
         skZS6MtdajiBcc6truOCViwkaSmgIZy6QHiRQYAIKCKB87Om+qjW4cr8dho7BgnGjA
         N+4JbewwUVRK2tkRpWwQ8R13D1pMdWufZqqBSlXvnia8CHdnze1Uj6ve1peBbTjZVZ
         B1ggHV5A457MA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3812435225DC; Thu, 14 Jan 2021 07:22:07 -0800 (PST)
Date:   Thu, 14 Jan 2021 07:22:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, jiangshanlai@gmail.com,
        cai@redhat.com, vincent.donnefort@arm.com, decui@microsoft.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH] sched/core: Print out straggler tasks in
 sched_cpu_dying()
Message-ID: <20210114152207.GI2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210113183141.11974-1-valentin.schneider@arm.com>
 <20210113220244.GC2743@paulmck-ThinkPad-P72>
 <jhjft34z84j.mognet@arm.com>
 <20210114003613.GD2743@paulmck-ThinkPad-P72>
 <jhjczy7ztw0.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjczy7ztw0.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:37:35AM +0000, Valentin Schneider wrote:
> On 13/01/21 16:36, Paul E. McKenney wrote:
> > On Thu, Jan 14, 2021 at 12:15:24AM +0000, Valentin Schneider wrote:
> >> On 13/01/21 14:02, Paul E. McKenney wrote:
> >> Thanks for giving it a spin! I think with the current series (either
> >> Lai's or Peter's) sched_cpu_dying() should go smoothly, but you never
> >> know.
> >
> > I was running the patch set having one of Lai's and three of Peter's,
> > which sounds like Peter's.
> 
> That's how I was seeing it :)

If someone can identify Lai's series to me, I would be happy to give it
a try as well.  All I see are workqueue-specific patches and patches
contributing to the discussion of possible fixes to the splats from
Peter's series.  (I figured that I would wait for the discussion to
converge a bit.)

> > If I understand which series is which,
> > Peter's has the advantage of not requiring rcutorture changes.  ;-)
> >
> >> > However, it did produce the following new-to-me splat, which will
> >> > hopefully be of some help.
> >> >
> >> >                                                       Thanx, Paul
> >> >
> >> > ------------------------------------------------------------------------
> >> >
> >> > WARNING: CPU: 2 PID: 23 at kernel/kthread.c:508 kthread_set_per_cpu+0x3b/0x50
> >>
> >> Aha, so that's that warning I was expecting to see [1].
> >> Did you also get the process_one_work() one?
> >
> > Yes.  Of 112 one-hour runs, there were five process_one_work() splats
> > and two kthread_set_per_cpu() splats.  Each splat-ridden run had exactly
> > one splat.
> 
> I was expecting to see both in one run, so am still somewhat confused.

Well, if we weren't confused in some way or another, the bug would not
exist, so I will count becoming aware of confusion as a step forward.  ;-)

							Thanx, Paul
