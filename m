Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BE82DC672
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgLPS10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 13:27:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:51082 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgLPS1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:27:25 -0500
IronPort-SDR: XI86h9jLnaqss0KbrOomXvMHtrfLfqc/TVo+JmwBE+VlsEKnuOWmBbrWYGqDmeUmsokOHPHm3g
 JKE/416lAzQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="174342727"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="174342727"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 10:26:44 -0800
IronPort-SDR: wKRlpu3j+If2DzeYRuEa/sU71hmLlkF5LLoO7O2WHbOcTeXNCwExXWmLuQm7mAV/vMkwIPMPz/
 hyjnzMMfKG/w==
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="352711658"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.209.155.249]) ([10.209.155.249])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 10:26:43 -0800
Subject: Re: [PATCH 0/3] x86/resctrl: Fix a few issues in moving a task to a
 resource group
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com, kuo-lang.tseng@intel.com, shakeelb@google.com,
        mingo@redhat.com, babu.moger@amd.com, james.morse@arm.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1607036601.git.reinette.chatre@intel.com>
 <jhjk0tot6jg.mognet@arm.com> <07ccc96d-a875-af0e-5169-24b1f84c46da@intel.com>
 <jhj3605tzr1.mognet@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <2ff6b87f-3b1f-7b5e-2b4c-050192a12d4f@intel.com>
Date:   Wed, 16 Dec 2020 10:26:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <jhj3605tzr1.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 12/16/2020 9:41 AM, Valentin Schneider wrote:
> 
> On 14/12/20 18:38, Reinette Chatre wrote:
>>> Thinking a bit more (too much?) about it, we could limit ourselves to
>>> wrapping only reads not protected by the rdtgroup_mutex: the only two
>>> task_struct {closid, rmid} writers are
>>> - rdtgroup_move_task()
>>> - rdt_move_group_tasks()
>>> and they are both invoked while holding said mutex. Thus, a reader holding
>>> the mutex cannot race with a write, so load tearing ought to be safe.
>>
>> The reads that are not protected by the rdtgroup_mutex can be found in
>> __resctrl_sched_in(). It thus sounds to me like your proposed changes to
>> this function found in your patch [1] is what is needed?
> 
> Right.
> 
>> It is not clear
>> to me how the pairing would work in this case though. If I understand
>> correctly the goal is for the  write to the closid/rmid in the functions
>> you mention above to be paired with the reads in resctrl_sched_in() and
>> it is not clear how adding a single READ_ONCE would accomplish this
>> pairing by itself.
>>
> 
> So all the writes would need WRITE_ONCE(), but not all reads would require
> a READ_ONCE() (those that can't race with writes shouldn't need them).

Got it. I misunderstood your previous response, mistakenly thinking that 
it stated that there would be only READ_ONCE() reads without being 
paired with WRITE_ONCE() writes. Thanks for clearing that up.

> I'll go and update that patch so that you can bundle it with v2 of this
> series.

Thank you so much.

>> It is also not entirely clear to me what the problematic scenario could
>> be. If I understand correctly, the risk is (as you explained in your
>> commit message), that a CPU could have its {closid, rmid} fields read
>> locally (resctrl_sched_in()) while they are concurrently being written
>> to from another CPU (in rdtgroup_move_task() and rdt_move_group_tasks()
>> as you state above). If this happens then a task being moved may be
>> scheduled in with its old closid/rmid.
> 
> Worse, it may be scheduled with a mangled closid/rmid if the read in
> resctrl_sched_in() is torn (i.e. compiled as a sequence of multiple
> smaller-sized loads). This one of the things READ_ONCE() / WRITE_ONCE()
> try to address.

I see. This area is unfamiliar to me, thank you very much for catching 
this and helping to get it right.

> 
>> The update of closid/rmid in
>> rdtgroup_move_task()/rdt_move_group_tasks() is followed by
>> smp_call_function_xx() where the registers are updated with preemption
>> disabled and thus protected against __switch_to. If a task was thus
>> incorrectly scheduled in with old closid/rmid, would it not be corrected
>> at this point?
>>
> 
> Excluding load/store tearing, then yes, the above works fine.
> 

Thank you for this sanity check.

Reinette

