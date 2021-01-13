Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FBD2F5181
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbhAMRxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:53:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbhAMRxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:53:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 002A321534;
        Wed, 13 Jan 2021 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610560370;
        bh=QIX3z2ysr8s8Asq7NOVUBpnrn77/hUqe9WzwRVOSgXA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a5UnOiYFEWqVyFbBUgEkIGW1azHdtRvHpf8MRocjd47G6aWEv/N4hnTcUowHf+7Qw
         P785XuK3RfHw6WBC/3yGxuFDUbvTp4t/G4coXttHWUGFeCxdjF0HqfGqt/FC9pLpib
         P4m02JR/uZyF90N4PUWzS9vrc3Q0h8rBR4bo01TdO/8nMB3JajY+ZDsDjuk1hYROYj
         Lz9gP696IOCTI0q32j3HOou2ILJ94wDdcKD/MC+hs3AmUqYrc8kvfdyxBOFjnQnfB3
         9qPKkfwrUYBGU/o4YiQ0aP8LPHlJPznOvswiKwPJh2KM+6ty4H4yJjcMQ50IucHRrp
         E94J3mPVMhaFA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B33703522AC3; Wed, 13 Jan 2021 09:52:49 -0800 (PST)
Date:   Wed, 13 Jan 2021 09:52:49 -0800
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
Message-ID: <20210113175249.GA27312@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210112144344.850850975@infradead.org>
 <20210112144843.849135905@infradead.org>
 <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
 <jhjturkzzv9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjturkzzv9.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 02:16:10PM +0000, Valentin Schneider wrote:
> On 13/01/21 21:28, Lai Jiangshan wrote:
> > On Tue, Jan 12, 2021 at 10:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >> @@ -4972,9 +4977,11 @@ static void rebind_workers(struct worker
> >>          * of all workers first and then clear UNBOUND.  As we're called
> >>          * from CPU_ONLINE, the following shouldn't fail.
> >>          */
> >> -       for_each_pool_worker(worker, pool)
> >> +       for_each_pool_worker(worker, pool) {
> >>                 WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> >>                                                   pool->attrs->cpumask) < 0);
> >> +               kthread_set_per_cpu(worker->task, true);
> >
> > Will the schedule break affinity in the middle of these two lines due to
> > patch4 allowing it and result in Paul's reported splat.
> >
> 
> You might be right; at this point we would still have BALANCE_PUSH set,
> so something like the below could happen
> 
>   rebind_workers()
>     set_cpus_allowed_ptr()
>       affine_move_task()
>         task_running() => stop_one_cpu()
> 
>   ... // Stopper migrates the kworker here in the meantime
> 
>   switch_to(<pcpu kworker>) // Both cpuhp thread and kworker should be enqueued
>                             // here, so one or the other could be picked
>   balance_switch()
>     balance_push()
>     ^-- no KTHREAD_IS_PER_CPU !
> 
> This should however trigger the WARN_ON_ONCE() in kthread_set_per_cpu()
> *before* the one in process_one_work(), which I haven't seen in Paul's
> mails.

The 56 instances of one-hour SRCU-P scenarios hit the WARN_ON_ONCE()
in process_one_work() once, but there is no sign of a WARN_ON_ONCE()
from kthread_set_per_cpu().  But to your point, this does appear to be
a rather low-probability race condition, once per some tens of hours
of SRCU-P.

Is there a more focused check for the race condition above?

							Thanx, Paul
