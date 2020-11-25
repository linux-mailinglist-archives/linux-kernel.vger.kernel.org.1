Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326D52C480D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgKYTGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:06:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:52097 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgKYTGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:06:37 -0500
IronPort-SDR: j+VeYPRdkJK8ViIVJmIIunEkO9OUvw440VROWi5zdTTGasLF4uwrjtjRhnB3jtByren9g2nlFl
 Hm3DDG9ZZQFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="236319420"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="236319420"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 11:06:36 -0800
IronPort-SDR: wv7Wircfq2RBt/aQJavKoNzUozwGxPGSPELhTtpcmsd0mKwZAwdebCyPrRy53U5qUjy1PwGa2v
 a1zNJS+Gm8Ag==
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="313758603"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.85.48]) ([10.212.85.48])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 11:06:36 -0800
Subject: Re: [PATCH v2 0/3] x86/intel_rdt: task_work vs task_struct
 rmid/closid write race
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, James Morse <James.Morse@arm.com>
References: <20201123022433.17905-1-valentin.schneider@arm.com>
 <87be8915-21b0-5214-9742-ccc7515c298b@intel.com> <jhjpn41v5tv.mognet@arm.com>
 <19860f42-132d-82db-648f-d47b49af350b@intel.com> <jhjim9tuvpq.mognet@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <22537adf-9280-ea1f-bac5-6c9a7a589ae9@intel.com>
Date:   Wed, 25 Nov 2020 11:06:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <jhjim9tuvpq.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 11/25/2020 10:39 AM, Valentin Schneider wrote:
> On 25/11/20 17:20, Reinette Chatre wrote:
>>>> Until the queued work is run, the moved task runs with old (and even
>>>> invalid in the case when its original resource group has been removed)
>>>> closid and rmid.
>>>>
>>>
>>> For a userspace task, that queued work should be run as soon as possible
>>> (& relevant). If said task is currently running, then task_work_add() will
>>> lead to an IPI;
>>> the other cases (task moving itself or not currently
>>> running) are covered by the return to userspace path.
>>
>> At this time the work is added with the TWA_RESUME flag so the running
>> task does not get a signal. I tried to follow the task_work_add() path
>> if there is a change to use TWA_SIGNAL instead and (I may have
>> misunderstanding) it seems to me that a sleeping task will be woken (if
>> it is TASK_INTERRUPTIBLE)? That is unnecessary. The goal of this work is
>> only to change the CPU register to indicate the active closid/rmid so it
>> is unnecessary to wake a process to do that, it only needs to be done
>> next time the task is scheduled in (which is already done with the
>> resctrl_sched_in() call in __switch_to()). If a task is not running all
>> that is needed is to change the closid/rmid in its task_struct to be
>> used next time it is scheduled in.
>>
> 
> The (default) TWA_RESUME ensures the targeted (userspace) task gets kicked
> if it is currently running, and doesn't perturb any CPU otherwise;
> see set_notify_resume() + exit_to_user_mode_loop() (or do_notify_resume()
> on arm64)

I missed that, thanks. The first issue is thus not a problem. Thank you 
very much for clearing this up. Queueing work for tasks that are not 
running remains unnecessary and simplifying this with a targeted 
smp_call_function addresses that (while also taking care of the other 
issues with using the queued work).

>> In the new solution, after updating closid/rmid in the task_struct, the
>> CPU register is updated via smp_call_function_single() on a CPU the task
>> is running. Nothing is done for tasks not running, next time they are
>> scheduled in the CPU's register will be updated to reflect the task's
>> closid/rmid. Moving to the smp_call_function_xxx() API would also bring
>> this update in line with how other register updates are already done in
>> resctrl.
>>
>>> Kernel threads however are a prickly matter because they quite explicitly
>>> don't have this return to userspace - they only run their task_work
>>> callbacks on exit. So we currently have to wait for those kthreads to go
>>> through a context switch to update the relevant register, but I don't
>>> see any other alternative that wouldn't involve interrupting every other
>>> CPU (the kthread could move between us triggering some remote work and its
>>> previous CPU receiving the IPI).
>>
>> This seems ok? In the new solution the closid/rmid would be updated in
>> task_struct and a smp_call_function_single() attempted on the CPU where
>> the kthread is running. If the kthread is no longer running at the time
>> the function is called the CPU register will not be changed.
> 
> Right, if the update happens before triggering the remote work then that
> should all work. I was stuck thinking about keeping the update contained
> within the remote work itself to prevent any other races (i.e. patch 3).

Are you saying that the task_struct update as well as register update 
should both be done in the remote work? I think I may be 
misunderstanding though. Currently, with your entire series applied, the 
update to task_struct is done before the remote work is queued that only 
changes the register. The new solution would also first update the 
task_struct and then the remote work (this time with smp_call_function) 
will just update the register.

 From what I understand your work in patch 3 would continue to be 
welcome with the new solution that will also update the task_struct and 
then trigger the remote work to just update the register.

> Anywho, that's enough speculation from me, I'll just sit tight and see what
> comes next!
> 

Reinette

>> I assume
>> the kthread move would include a context switch that would result in the
>> register change (__switch_to()->resctrl_sched_in()) for the kthread to
>> run with its new closid/rmid after the move.
>>


Reinette
