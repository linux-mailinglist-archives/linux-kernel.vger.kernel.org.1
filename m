Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5507F2C4B96
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 00:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbgKYXYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 18:24:04 -0500
Received: from foss.arm.com ([217.140.110.172]:51270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgKYXYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 18:24:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDED931B;
        Wed, 25 Nov 2020 15:24:03 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98A8E3F70D;
        Wed, 25 Nov 2020 15:24:02 -0800 (PST)
References: <20201123022433.17905-1-valentin.schneider@arm.com> <87be8915-21b0-5214-9742-ccc7515c298b@intel.com> <jhjpn41v5tv.mognet@arm.com> <19860f42-132d-82db-648f-d47b49af350b@intel.com> <jhjim9tuvpq.mognet@arm.com> <22537adf-9280-ea1f-bac5-6c9a7a589ae9@intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, James Morse <James.Morse@arm.com>
Subject: Re: [PATCH v2 0/3] x86/intel_rdt: task_work vs task_struct rmid/closid write race
In-reply-to: <22537adf-9280-ea1f-bac5-6c9a7a589ae9@intel.com>
Date:   Wed, 25 Nov 2020 23:23:57 +0000
Message-ID: <jhjh7pduik2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/11/20 19:06, Reinette Chatre wrote:
> Hi Valentin,
>
> On 11/25/2020 10:39 AM, Valentin Schneider wrote:
>> The (default) TWA_RESUME ensures the targeted (userspace) task gets kicked
>> if it is currently running, and doesn't perturb any CPU otherwise;
>> see set_notify_resume() + exit_to_user_mode_loop() (or do_notify_resume()
>> on arm64)
>
> I missed that, thanks. The first issue is thus not a problem. Thank you
> very much for clearing this up. Queueing work for tasks that are not
> running remains unnecessary and simplifying this with a targeted
> smp_call_function addresses that (while also taking care of the other
> issues with using the queued work).
>

Right.

>>> In the new solution, after updating closid/rmid in the task_struct, the
>>> CPU register is updated via smp_call_function_single() on a CPU the task
>>> is running. Nothing is done for tasks not running, next time they are
>>> scheduled in the CPU's register will be updated to reflect the task's
>>> closid/rmid. Moving to the smp_call_function_xxx() API would also bring
>>> this update in line with how other register updates are already done in
>>> resctrl.
>>>
>>>> Kernel threads however are a prickly matter because they quite explicitly
>>>> don't have this return to userspace - they only run their task_work
>>>> callbacks on exit. So we currently have to wait for those kthreads to go
>>>> through a context switch to update the relevant register, but I don't
>>>> see any other alternative that wouldn't involve interrupting every other
>>>> CPU (the kthread could move between us triggering some remote work and its
>>>> previous CPU receiving the IPI).
>>>
>>> This seems ok? In the new solution the closid/rmid would be updated in
>>> task_struct and a smp_call_function_single() attempted on the CPU where
>>> the kthread is running. If the kthread is no longer running at the time
>>> the function is called the CPU register will not be changed.
>>
>> Right, if the update happens before triggering the remote work then that
>> should all work. I was stuck thinking about keeping the update contained
>> within the remote work itself to prevent any other races (i.e. patch 3).
>
> Are you saying that the task_struct update as well as register update
> should both be done in the remote work? I think I may be
> misunderstanding though.

It would simplify the concurrency aspect - if the {closid, rmid} update is
always done on the targeted task' context, then there can be no races
between an update (write) and a context switch (read). Sadly I don't see a
nice way to do this for kthreads, so I think it'll have to be update +
smp_call.


> Currently, with your entire series applied, the
> update to task_struct is done before the remote work is queued that only
> changes the register. The new solution would also first update the
> task_struct and then the remote work (this time with smp_call_function)
> will just update the register.
>
>  From what I understand your work in patch 3 would continue to be
> welcome with the new solution that will also update the task_struct and
> then trigger the remote work to just update the register.
>

That's how I see it as well ATM.

>> Anywho, that's enough speculation from me, I'll just sit tight and see what
>> comes next!
>>
>
> Reinette
>
>>> I assume
>>> the kthread move would include a context switch that would result in the
>>> register change (__switch_to()->resctrl_sched_in()) for the kthread to
>>> run with its new closid/rmid after the move.
>>>
>
>
> Reinette
