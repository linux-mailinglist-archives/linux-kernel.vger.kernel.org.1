Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F92F52A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 19:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbhAMSov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:44:51 -0500
Received: from foss.arm.com ([217.140.110.172]:40562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbhAMSov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:44:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 481291FB;
        Wed, 13 Jan 2021 10:44:05 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B623F3F66E;
        Wed, 13 Jan 2021 10:44:03 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     paulmck@kernel.org
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
In-Reply-To: <20210113175249.GA27312@paulmck-ThinkPad-P72>
References: <20210112144344.850850975@infradead.org> <20210112144843.849135905@infradead.org> <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com> <jhjturkzzv9.mognet@arm.com> <20210113175249.GA27312@paulmck-ThinkPad-P72>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 13 Jan 2021 18:43:57 +0000
Message-ID: <jhjpn28zngy.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/21 09:52, Paul E. McKenney wrote:
> On Wed, Jan 13, 2021 at 02:16:10PM +0000, Valentin Schneider wrote:
>> You might be right; at this point we would still have BALANCE_PUSH set,
>> so something like the below could happen
>>
>>   rebind_workers()
>>     set_cpus_allowed_ptr()
>>       affine_move_task()
>>         task_running() => stop_one_cpu()
>>
>>   ... // Stopper migrates the kworker here in the meantime
>>
>>   switch_to(<pcpu kworker>) // Both cpuhp thread and kworker should be enqueued
>>                             // here, so one or the other could be picked
>>   balance_switch()
>>     balance_push()
>>     ^-- no KTHREAD_IS_PER_CPU !
>>
>> This should however trigger the WARN_ON_ONCE() in kthread_set_per_cpu()
>> *before* the one in process_one_work(), which I haven't seen in Paul's
>> mails.
>
> The 56 instances of one-hour SRCU-P scenarios hit the WARN_ON_ONCE()
> in process_one_work() once, but there is no sign of a WARN_ON_ONCE()
> from kthread_set_per_cpu().

This does make me doubt the above :/ At the same time, the
process_one_work() warning hinges on POOL_DISASSOCIATED being unset,
which implies having gone through rebind_workers(), which implies
kthread_set_per_cpu(), which implies me being quite confused...

> But to your point, this does appear to be
> a rather low-probability race condition, once per some tens of hours
> of SRCU-P.
>
> Is there a more focused check for the race condition above?
>

Not that I'm aware of. I'm thinking that if the pcpu kworker were an RT
task, then this would guarantee it would get picked in favor of the cpuhp
thread upon switching out of the stopper, but that still requires the
kworker running on some CPU (for some reason) during rebind_workers().



>                                                       Thanx, Paul
