Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD402F5EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbhANKi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:38:27 -0500
Received: from foss.arm.com ([217.140.110.172]:47446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbhANKi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:38:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 402451FB;
        Thu, 14 Jan 2021 02:37:42 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FCE93F70D;
        Thu, 14 Jan 2021 02:37:40 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, jiangshanlai@gmail.com,
        cai@redhat.com, vincent.donnefort@arm.com, decui@microsoft.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH] sched/core: Print out straggler tasks in sched_cpu_dying()
In-Reply-To: <20210114003613.GD2743@paulmck-ThinkPad-P72>
References: <20210113183141.11974-1-valentin.schneider@arm.com> <20210113220244.GC2743@paulmck-ThinkPad-P72> <jhjft34z84j.mognet@arm.com> <20210114003613.GD2743@paulmck-ThinkPad-P72>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 14 Jan 2021 10:37:35 +0000
Message-ID: <jhjczy7ztw0.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/21 16:36, Paul E. McKenney wrote:
> On Thu, Jan 14, 2021 at 12:15:24AM +0000, Valentin Schneider wrote:
>> On 13/01/21 14:02, Paul E. McKenney wrote:
>> Thanks for giving it a spin! I think with the current series (either
>> Lai's or Peter's) sched_cpu_dying() should go smoothly, but you never
>> know.
>
> I was running the patch set having one of Lai's and three of Peter's,
> which sounds like Peter's.

That's how I was seeing it :)

> If I understand which series is which,
> Peter's has the advantage of not requiring rcutorture changes.  ;-)
>
>> > However, it did produce the following new-to-me splat, which will
>> > hopefully be of some help.
>> >
>> >                                                       Thanx, Paul
>> >
>> > ------------------------------------------------------------------------
>> >
>> > WARNING: CPU: 2 PID: 23 at kernel/kthread.c:508 kthread_set_per_cpu+0x3b/0x50
>>
>> Aha, so that's that warning I was expecting to see [1].
>> Did you also get the process_one_work() one?
>
> Yes.  Of 112 one-hour runs, there were five process_one_work() splats
> and two kthread_set_per_cpu() splats.  Each splat-ridden run had exactly
> one splat.
>

I was expecting to see both in one run, so am still somewhat confused.
