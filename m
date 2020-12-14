Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C8C2D9F58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408827AbgLNSkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:40:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:11436 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408733AbgLNSjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:39:45 -0500
IronPort-SDR: MyT16XC7SQF91cjIKRNwBVdhhx9dj9SAwb5vVZ1AirJ3zamkW08CvT3rJNvNyGn8sda/kv1QuE
 fadza7zn0kzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="153987574"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="153987574"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 10:39:00 -0800
IronPort-SDR: hZy/5jPNvSjNnkEXZkIC+n0IJ0iuhaeVeLbHyDwJxv0Ii96UhSgyBDYiv2D34ZytIdtw72xqbi
 MFYJKrNbKaYQ==
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="411361295"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.45.112]) ([10.212.45.112])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 10:38:59 -0800
Subject: Re: [PATCH 0/3] x86/resctrl: Fix a few issues in moving a task to a
 resource group
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com, kuo-lang.tseng@intel.com, shakeelb@google.com,
        mingo@redhat.com, babu.moger@amd.com, james.morse@arm.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1607036601.git.reinette.chatre@intel.com>
 <jhjk0tot6jg.mognet@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <07ccc96d-a875-af0e-5169-24b1f84c46da@intel.com>
Date:   Mon, 14 Dec 2020 10:38:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <jhjk0tot6jg.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 12/11/2020 12:46 PM, Valentin Schneider wrote:
> On 03/12/20 23:25, Reinette Chatre wrote:
>> Valentin's series in [2] ends by adding memory barriers to support the
>> updating of the task_struct from one CPU and the usage of the task_struct data
>> from another CPU. This work is still needed and as discussed with Valentin in
>> that thread the work would be re-evaluated by him after seeing how this series
>> turns out.
>>

Thank you very much for taking a look.

> 
> So the "problematic" pattern is still there: a context switch can happen
> concurrently with a write to the switching-to-tasks's {closid, rmid}.
> Accesses to these fields would thus need to be wrapped by READ_ONCE() &
> WRITE_ONCE().

ok.

> 
> Thinking a bit more (too much?) about it, we could limit ourselves to
> wrapping only reads not protected by the rdtgroup_mutex: the only two
> task_struct {closid, rmid} writers are
> - rdtgroup_move_task()
> - rdt_move_group_tasks()
> and they are both invoked while holding said mutex. Thus, a reader holding
> the mutex cannot race with a write, so load tearing ought to be safe.

The reads that are not protected by the rdtgroup_mutex can be found in 
__resctrl_sched_in(). It thus sounds to me like your proposed changes to 
this function found in your patch [1] is what is needed? It is not clear 
to me how the pairing would work in this case though. If I understand 
correctly the goal is for the  write to the closid/rmid in the functions 
you mention above to be paired with the reads in resctrl_sched_in() and 
it is not clear how adding a single READ_ONCE would accomplish this 
pairing by itself.

It is also not entirely clear to me what the problematic scenario could 
be. If I understand correctly, the risk is (as you explained in your 
commit message), that a CPU could have its {closid, rmid} fields read 
locally (resctrl_sched_in()) while they are concurrently being written 
to from another CPU (in rdtgroup_move_task() and rdt_move_group_tasks() 
as you state above). If this happens then a task being moved may be 
scheduled in with its old closid/rmid. The update of closid/rmid in 
rdtgroup_move_task()/rdt_move_group_tasks() is followed by 
smp_call_function_xx() where the registers are updated with preemption 
disabled and thus protected against __switch_to. If a task was thus 
incorrectly scheduled in with old closid/rmid, would it not be corrected 
at this point?

Thank you

Reinette


[1] 
https://lore.kernel.org/lkml/20201123022433.17905-4-valentin.schneider@arm.com/

