Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E422DC57F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 18:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgLPRmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 12:42:15 -0500
Received: from foss.arm.com ([217.140.110.172]:37754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbgLPRmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 12:42:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15F541FB;
        Wed, 16 Dec 2020 09:41:29 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AE3E3F66E;
        Wed, 16 Dec 2020 09:41:27 -0800 (PST)
References: <cover.1607036601.git.reinette.chatre@intel.com> <jhjk0tot6jg.mognet@arm.com> <07ccc96d-a875-af0e-5169-24b1f84c46da@intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com, kuo-lang.tseng@intel.com, shakeelb@google.com,
        mingo@redhat.com, babu.moger@amd.com, james.morse@arm.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] x86/resctrl: Fix a few issues in moving a task to a resource group
In-reply-to: <07ccc96d-a875-af0e-5169-24b1f84c46da@intel.com>
Date:   Wed, 16 Dec 2020 17:41:22 +0000
Message-ID: <jhj3605tzr1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/12/20 18:38, Reinette Chatre wrote:
>> Thinking a bit more (too much?) about it, we could limit ourselves to
>> wrapping only reads not protected by the rdtgroup_mutex: the only two
>> task_struct {closid, rmid} writers are
>> - rdtgroup_move_task()
>> - rdt_move_group_tasks()
>> and they are both invoked while holding said mutex. Thus, a reader holding
>> the mutex cannot race with a write, so load tearing ought to be safe.
>
> The reads that are not protected by the rdtgroup_mutex can be found in
> __resctrl_sched_in(). It thus sounds to me like your proposed changes to
> this function found in your patch [1] is what is needed?

Right.

> It is not clear
> to me how the pairing would work in this case though. If I understand
> correctly the goal is for the  write to the closid/rmid in the functions
> you mention above to be paired with the reads in resctrl_sched_in() and
> it is not clear how adding a single READ_ONCE would accomplish this
> pairing by itself.
>

So all the writes would need WRITE_ONCE(), but not all reads would require
a READ_ONCE() (those that can't race with writes shouldn't need them).

I'll go and update that patch so that you can bundle it with v2 of this
series.

> It is also not entirely clear to me what the problematic scenario could
> be. If I understand correctly, the risk is (as you explained in your
> commit message), that a CPU could have its {closid, rmid} fields read
> locally (resctrl_sched_in()) while they are concurrently being written
> to from another CPU (in rdtgroup_move_task() and rdt_move_group_tasks()
> as you state above). If this happens then a task being moved may be
> scheduled in with its old closid/rmid.

Worse, it may be scheduled with a mangled closid/rmid if the read in
resctrl_sched_in() is torn (i.e. compiled as a sequence of multiple
smaller-sized loads). This one of the things READ_ONCE() / WRITE_ONCE()
try to address.

> The update of closid/rmid in
> rdtgroup_move_task()/rdt_move_group_tasks() is followed by
> smp_call_function_xx() where the registers are updated with preemption
> disabled and thus protected against __switch_to. If a task was thus
> incorrectly scheduled in with old closid/rmid, would it not be corrected
> at this point?
>

Excluding load/store tearing, then yes, the above works fine.

> Thank you
>
> Reinette
>
>
> [1]
> https://lore.kernel.org/lkml/20201123022433.17905-4-valentin.schneider@arm.com/
