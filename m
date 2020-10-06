Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CBA284FB6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgJFQTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:19:48 -0400
Received: from foss.arm.com ([217.140.110.172]:51516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFQTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:19:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BF6611B3;
        Tue,  6 Oct 2020 09:19:47 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C6A33F66B;
        Tue,  6 Oct 2020 09:19:45 -0700 (PDT)
References: <20201005145717.346020688@infradead.org> <20201005150922.458081448@infradead.org> <jhjv9fnmwhg.mognet@arm.com> <20201006134850.GV2628@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
In-reply-to: <20201006134850.GV2628@hirez.programming.kicks-ass.net>
Date:   Tue, 06 Oct 2020 17:19:43 +0100
Message-ID: <jhjr1qbmin4.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/10/20 14:48, Peter Zijlstra wrote:
> On Tue, Oct 06, 2020 at 12:20:43PM +0100, Valentin Schneider wrote:
>>
>> An alternative I could see would be to prevent those piles from forming
>> altogether, say by issuing a similar push_cpu_stop() on migrate_disable()
>> if the next pushable task is already migrate_disable(); but that's a
>> proactive approach whereas yours is reactive, so I'm pretty sure that's
>> bound to perform worse.
>
> I think it is always possible to form pileups. Just start enough tasks
> such that newer, higher priority, tasks have to preempt existing tasks.
>
> Also, we might not be able to place the task elsewhere, suppose we have
> all our M CPUs filled with an RT task, then when the lowest priority
> task has migrate_disable(), wake the highest priority task.
>
> Per the SMP invariant, this new highest priority task must preempt the
> lowest priority task currently running, otherwise we would not be
> running the M highest prio tasks.
>

Right, and it goes the other way around for the migrate_disable() task: if
it becomes one of the M highest prio tasks, then it *must* run, and
push/pulling its CPU's current away is the only way to do so...

> That's not to say it might not still be beneficial from trying to avoid
> them, but we must assume a pilup will occur, therefore my focus was on
> dealing with them as best we can first.

"Funny" all that... Thanks!
