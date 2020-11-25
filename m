Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82902C468A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgKYRU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:20:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:41748 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729631AbgKYRUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:20:55 -0500
IronPort-SDR: wX83mEGFMiTnKaJDvTDrqmmpU+rXzZMLSEElL/bR6gjIOfGEdsMDWrp2iw6k7CKePhP0Tk2MgY
 rcFj80vA8xpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="236303147"
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="236303147"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 09:20:54 -0800
IronPort-SDR: 4HJiEIl8aUYX6aLnIRkfMpAhMEb/WmneYMAg2WrAdNJZmDnoVYNo1VAco2uEaPTaRhBSKR/yR8
 4myg/hna8Rvg==
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="313725988"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.85.48]) ([10.212.85.48])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 09:20:53 -0800
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
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <19860f42-132d-82db-648f-d47b49af350b@intel.com>
Date:   Wed, 25 Nov 2020 09:20:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <jhjpn41v5tv.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 11/25/2020 7:01 AM, Valentin Schneider wrote:
> On 24/11/20 21:37, Reinette Chatre wrote:
>> On 11/22/2020 6:24 PM, Valentin Schneider wrote:
>>> This is a small cleanup + a fix for a race I stumbled upon while staring at
>>> resctrl stuff.
>>>
>>> Briefly tested on a Xeon Gold 5120 (m2.xlarge.x86 on Equinix) by bouncing
>>> a few tasks around control groups.
>>>
>>
>> ...
>>
>> Thank you very much for taking this on. Unfortunately this race is one
>> of a few issues with the way in which tasks moving to a new resource
>> group is handled.
>>
>> Other issues are:
>>
>> 1.
>> Until the queued work is run, the moved task runs with old (and even
>> invalid in the case when its original resource group has been removed)
>> closid and rmid.
>>
> 
> For a userspace task, that queued work should be run as soon as possible
> (& relevant). If said task is currently running, then task_work_add() will
> lead to an IPI;
> the other cases (task moving itself or not currently
> running) are covered by the return to userspace path.

At this time the work is added with the TWA_RESUME flag so the running 
task does not get a signal. I tried to follow the task_work_add() path 
if there is a change to use TWA_SIGNAL instead and (I may have 
misunderstanding) it seems to me that a sleeping task will be woken (if 
it is TASK_INTERRUPTIBLE)? That is unnecessary. The goal of this work is 
only to change the CPU register to indicate the active closid/rmid so it 
is unnecessary to wake a process to do that, it only needs to be done 
next time the task is scheduled in (which is already done with the 
resctrl_sched_in() call in __switch_to()). If a task is not running all 
that is needed is to change the closid/rmid in its task_struct to be 
used next time it is scheduled in.

In the new solution, after updating closid/rmid in the task_struct, the 
CPU register is updated via smp_call_function_single() on a CPU the task 
is running. Nothing is done for tasks not running, next time they are 
scheduled in the CPU's register will be updated to reflect the task's 
closid/rmid. Moving to the smp_call_function_xxx() API would also bring 
this update in line with how other register updates are already done in 
resctrl.

> Kernel threads however are a prickly matter because they quite explicitly
> don't have this return to userspace - they only run their task_work
> callbacks on exit. So we currently have to wait for those kthreads to go
> through a context switch to update the relevant register, but I don't
> see any other alternative that wouldn't involve interrupting every other
> CPU (the kthread could move between us triggering some remote work and its
> previous CPU receiving the IPI).

This seems ok? In the new solution the closid/rmid would be updated in 
task_struct and a smp_call_function_single() attempted on the CPU where 
the kthread is running. If the kthread is no longer running at the time 
the function is called the CPU register will not be changed. I assume 
the kthread move would include a context switch that would result in the 
register change (__switch_to()->resctrl_sched_in()) for the kthread to 
run with its new closid/rmid after the move.

>> 2.
>> Work to update the PQR_ASSOC register is queued every time the user
>> writes a task id to the "tasks" file, even if the task already belongs
>> to the resource group and in addition to any other pending work for that
>> task. This could result in multiple pending work items associated with a
>> single task even if they are all identical and even though only a single
>> update with most recent values is needed. This could result in
>> significant system resource waste, especially on tasks sleeping for a
>> long time.
>>
>> Fenghua solved these issues by replacing the callback with a synchronous
>> update, similar to how tasks are currently moved when a resource group
>> is deleted. We plan to submit this work next week.
>>
>> This new solution will make patch 1 and 2 of this series unnecessary. As
>> I understand it patch 3 would still be a welcome addition but would
>> require changes. As you prefer you could either submit patch 3 on its
>> own for the code as it is now and we will rework the task related
>> changes on top of that, or you could wait for the task related changes
>> to land first?
>>
> 
> Please do Cc me on those - I'll re-evaluate the need for patch 3 then.

Will do. I appreciate you taking a look.

Thank you very much

Reinette
