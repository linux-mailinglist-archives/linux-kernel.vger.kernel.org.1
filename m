Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600012C47D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbgKYSjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:39:52 -0500
Received: from foss.arm.com ([217.140.110.172]:37478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733166AbgKYSjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:39:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C95631B;
        Wed, 25 Nov 2020 10:39:51 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 163AA3F23F;
        Wed, 25 Nov 2020 10:39:49 -0800 (PST)
References: <20201123022433.17905-1-valentin.schneider@arm.com> <87be8915-21b0-5214-9742-ccc7515c298b@intel.com> <jhjpn41v5tv.mognet@arm.com> <19860f42-132d-82db-648f-d47b49af350b@intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, James Morse <James.Morse@arm.com>
Subject: Re: [PATCH v2 0/3] x86/intel_rdt: task_work vs task_struct rmid/closid write race
In-reply-to: <19860f42-132d-82db-648f-d47b49af350b@intel.com>
Date:   Wed, 25 Nov 2020 18:39:45 +0000
Message-ID: <jhjim9tuvpq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/11/20 17:20, Reinette Chatre wrote:
> Hi Valentin,
>>>
>>> Until the queued work is run, the moved task runs with old (and even
>>> invalid in the case when its original resource group has been removed)
>>> closid and rmid.
>>>
>>
>> For a userspace task, that queued work should be run as soon as possible
>> (& relevant). If said task is currently running, then task_work_add() will
>> lead to an IPI;
>> the other cases (task moving itself or not currently
>> running) are covered by the return to userspace path.
>
> At this time the work is added with the TWA_RESUME flag so the running
> task does not get a signal. I tried to follow the task_work_add() path
> if there is a change to use TWA_SIGNAL instead and (I may have
> misunderstanding) it seems to me that a sleeping task will be woken (if
> it is TASK_INTERRUPTIBLE)? That is unnecessary. The goal of this work is
> only to change the CPU register to indicate the active closid/rmid so it
> is unnecessary to wake a process to do that, it only needs to be done
> next time the task is scheduled in (which is already done with the
> resctrl_sched_in() call in __switch_to()). If a task is not running all
> that is needed is to change the closid/rmid in its task_struct to be
> used next time it is scheduled in.
>

The (default) TWA_RESUME ensures the targeted (userspace) task gets kicked
if it is currently running, and doesn't perturb any CPU otherwise;
see set_notify_resume() + exit_to_user_mode_loop() (or do_notify_resume()
on arm64)

> In the new solution, after updating closid/rmid in the task_struct, the
> CPU register is updated via smp_call_function_single() on a CPU the task
> is running. Nothing is done for tasks not running, next time they are
> scheduled in the CPU's register will be updated to reflect the task's
> closid/rmid. Moving to the smp_call_function_xxx() API would also bring
> this update in line with how other register updates are already done in
> resctrl.
>
>> Kernel threads however are a prickly matter because they quite explicitly
>> don't have this return to userspace - they only run their task_work
>> callbacks on exit. So we currently have to wait for those kthreads to go
>> through a context switch to update the relevant register, but I don't
>> see any other alternative that wouldn't involve interrupting every other
>> CPU (the kthread could move between us triggering some remote work and its
>> previous CPU receiving the IPI).
>
> This seems ok? In the new solution the closid/rmid would be updated in
> task_struct and a smp_call_function_single() attempted on the CPU where
> the kthread is running. If the kthread is no longer running at the time
> the function is called the CPU register will not be changed.

Right, if the update happens before triggering the remote work then that
should all work. I was stuck thinking about keeping the update contained
within the remote work itself to prevent any other races (i.e. patch 3).

Anywho, that's enough speculation from me, I'll just sit tight and see what
comes next!

> I assume
> the kthread move would include a context switch that would result in the
> register change (__switch_to()->resctrl_sched_in()) for the kthread to
> run with its new closid/rmid after the move.
>
