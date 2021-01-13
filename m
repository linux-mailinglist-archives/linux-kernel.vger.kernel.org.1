Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F9C2F4CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbhAMORD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:17:03 -0500
Received: from foss.arm.com ([217.140.110.172]:36970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbhAMORC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:17:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B1A9101E;
        Wed, 13 Jan 2021 06:16:17 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA1023F70D;
        Wed, 13 Jan 2021 06:16:15 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
In-Reply-To: <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
References: <20210112144344.850850975@infradead.org> <20210112144843.849135905@infradead.org> <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 13 Jan 2021 14:16:10 +0000
Message-ID: <jhjturkzzv9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/21 21:28, Lai Jiangshan wrote:
> On Tue, Jan 12, 2021 at 10:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
>> @@ -4972,9 +4977,11 @@ static void rebind_workers(struct worker
>>          * of all workers first and then clear UNBOUND.  As we're called
>>          * from CPU_ONLINE, the following shouldn't fail.
>>          */
>> -       for_each_pool_worker(worker, pool)
>> +       for_each_pool_worker(worker, pool) {
>>                 WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
>>                                                   pool->attrs->cpumask) < 0);
>> +               kthread_set_per_cpu(worker->task, true);
>
> Will the schedule break affinity in the middle of these two lines due to
> patch4 allowing it and result in Paul's reported splat.
>

You might be right; at this point we would still have BALANCE_PUSH set,
so something like the below could happen

  rebind_workers()
    set_cpus_allowed_ptr()
      affine_move_task()
        task_running() => stop_one_cpu()

  ... // Stopper migrates the kworker here in the meantime

  switch_to(<pcpu kworker>) // Both cpuhp thread and kworker should be enqueued
                            // here, so one or the other could be picked
  balance_switch()
    balance_push()
    ^-- no KTHREAD_IS_PER_CPU !

This should however trigger the WARN_ON_ONCE() in kthread_set_per_cpu()
*before* the one in process_one_work(), which I haven't seen in Paul's
mails.

>> +       }
>>
>>         raw_spin_lock_irq(&pool->lock);
>>
>>
>>
