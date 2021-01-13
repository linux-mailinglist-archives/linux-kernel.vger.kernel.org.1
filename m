Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0932F52EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 20:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbhAMTA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 14:00:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbhAMTA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 14:00:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7CBB207B5;
        Wed, 13 Jan 2021 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610564385;
        bh=5TubtKUQ3xlnetDjZKybRFIIA/P5ZC49JfmXgAVmaNc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nGvy/0Aj07u40gjwVGda2LTfh8M9+WGZhBR7tKFlKm4xXJQS7McA5VT13RA4KsBbt
         qlcrc7e4OR72nW+4ebAOwzlh42lcaXf4TEBVPkuC5qvufWzlALVCP4aLgUTGsNhryT
         gRVoJloB7+WpEABuHcXpZ8A2Df13D8p2Tvdg51dZj+wSYFEBY9k/u66+d3RpT+2myP
         TzenKlLDDpfAtO219Rd/hqbRAxQrbzSrIbp2R83EYNbKzDlcuxYX6AFzEh5RPeGIQ2
         TlqSKUK/3n36GptwgsVwQjMAglRJ0NOPdJfgD2yT3kCQtoHLuseDkao+dEfUiNNp+V
         kszcFKS0RduIw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 66D623522AC3; Wed, 13 Jan 2021 10:59:45 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:59:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
Message-ID: <20210113185945.GZ2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210112144344.850850975@infradead.org>
 <20210112144843.849135905@infradead.org>
 <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
 <jhjturkzzv9.mognet@arm.com>
 <20210113175249.GA27312@paulmck-ThinkPad-P72>
 <jhjpn28zngy.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjpn28zngy.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 06:43:57PM +0000, Valentin Schneider wrote:
> On 13/01/21 09:52, Paul E. McKenney wrote:
> > On Wed, Jan 13, 2021 at 02:16:10PM +0000, Valentin Schneider wrote:
> >> You might be right; at this point we would still have BALANCE_PUSH set,
> >> so something like the below could happen
> >>
> >>   rebind_workers()
> >>     set_cpus_allowed_ptr()
> >>       affine_move_task()
> >>         task_running() => stop_one_cpu()
> >>
> >>   ... // Stopper migrates the kworker here in the meantime
> >>
> >>   switch_to(<pcpu kworker>) // Both cpuhp thread and kworker should be enqueued
> >>                             // here, so one or the other could be picked
> >>   balance_switch()
> >>     balance_push()
> >>     ^-- no KTHREAD_IS_PER_CPU !
> >>
> >> This should however trigger the WARN_ON_ONCE() in kthread_set_per_cpu()
> >> *before* the one in process_one_work(), which I haven't seen in Paul's
> >> mails.
> >
> > The 56 instances of one-hour SRCU-P scenarios hit the WARN_ON_ONCE()
> > in process_one_work() once, but there is no sign of a WARN_ON_ONCE()
> > from kthread_set_per_cpu().
> 
> This does make me doubt the above :/ At the same time, the
> process_one_work() warning hinges on POOL_DISASSOCIATED being unset,
> which implies having gone through rebind_workers(), which implies
> kthread_set_per_cpu(), which implies me being quite confused...
> 
> > But to your point, this does appear to be
> > a rather low-probability race condition, once per some tens of hours
> > of SRCU-P.
> >
> > Is there a more focused check for the race condition above?
> 
> Not that I'm aware of. I'm thinking that if the pcpu kworker were an RT
> task, then this would guarantee it would get picked in favor of the cpuhp
> thread upon switching out of the stopper, but that still requires the
> kworker running on some CPU (for some reason) during rebind_workers().

Well, I did use the rcutree.softirq=0 boot parameter, which creates
per-CPU rcuc kthreads to do what RCU_SOFTIRQ normally does.  But these
rcuc kthreads use the normal park/unpark discipline, so should be safe,
for some value of "should".

							Thanx, Paul
