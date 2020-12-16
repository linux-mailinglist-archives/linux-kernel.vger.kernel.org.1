Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8CA2DBCE7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgLPIqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 03:46:37 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2094 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLPIqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:46:37 -0500
Received: from dggeme761-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CwpbP6N4MzVfx0;
        Wed, 16 Dec 2020 16:44:49 +0800 (CST)
Received: from [10.174.177.7] (10.174.177.7) by dggeme761-chm.china.huawei.com
 (10.3.19.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 16
 Dec 2020 16:45:52 +0800
Subject: Re: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <hewenliang4@huawei.com>, <hushiyuan@huawei.com>,
        <luolongjun@huawei.com>, <hejingxian@huawei.com>
References: <87eejqu5q5.fsf@nanos.tec.linutronix.de>
From:   "shenkai (D)" <shenkai8@huawei.com>
Message-ID: <f2a4d172-fa17-9f98-ad8f-d69f84ad0df5@huawei.com>
Date:   Wed, 16 Dec 2020 16:45:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87eejqu5q5.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.7]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggeme761-chm.china.huawei.com (10.3.19.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2020/12/16 5:20, Thomas Gleixner Ð´µÀ:
> On Tue, Dec 15 2020 at 08:31, Andy Lutomirski wrote:
>> On Tue, Dec 15, 2020 at 6:46 AM shenkai (D) <shenkai8@huawei.com> wrote:
>>> From: shenkai <shenkai8@huawei.com>
>>> Date: Tue, 15 Dec 2020 01:58:06 +0000
>>> Subject: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
>>>
>>> In kexec reboot on x86 machine, APs will be halted and then waked up
>>> by the apic INIT and SIPI interrupt. Here we can let APs spin instead
>>> of being halted and boot APs by writing to specific address. In this way
>>> we can accelerate smp_init procedure for we don't need to pull APs up
>>> from a deep C-state.
>>>
>>> This is meaningful in many situations where users are sensitive to reboot
>>> time cost.
>> I like the concept.
> No. This is the wrong thing to do. We are not optimizing for _one_
> special case.
>
> We can optimize it for all operations where all the non boot CPUs have
> to brought up, be it cold boot, hibernation resume or kexec.
>
> Aside of that this is not a magic X86 special problem. Pretty much all
> architectures have the same issue and it can be solved very simple,
> which has been discussed before and I outlined the solution years ago,
> but nobody sat down and actually made it work.
>
> Since the rewrite of the CPU hotplug infrastructure to a state machine
> it's pretty obvious that the bringup of APs can changed from the fully
> serialized:
>
>       for_each_present_cpu(cpu) {
>       	if (!cpu_online(cpu))
>             cpu_up(cpu, CPUHP_ONLINE);
>       }
>
> to
>
>       for_each_present_cpu(cpu) {
>       	if (!cpu_online(cpu))
>             cpu_up(cpu, CPUHP_KICK_CPU);
>       }
>
>       for_each_present_cpu(cpu) {
>       	if (!cpu_active(cpu))
>             cpu_up(cpu, CPUHP_ONLINE);
>       }
>
> The CPUHP_KICK_CPU state does not exist today, but it's just the logical
> consequence of the state machine. It's basically splitting __cpu_up()
> into:
>
> __cpu_kick()
> {
>      prepare();
>      arch_kick_remote_cpu();     -> Send IPI/NMI, Firmware call .....
> }
>      
> __cpu_wait_online()
> {
>      wait_until_cpu_online();
>      do_further_stuff();
> }
>
> There is some more to it than just blindly splitting it up at the
> architecture level.
>
> All __cpu_up() implementations across arch/ have a lot of needlessly
> duplicated and pointlessly differently implemented code which can move
> completely into the core.
>
> So actually we want to split this further up:
>
>     CPUHP_PREPARE_CPU_UP:	Generic preparation step where all
>                                  the magic cruft which is duplicated
>                                  across architectures goes to
>
>     CPUHP_KICK_CPU:		Architecture specific prepare and kick
>
>     CPUHP_WAIT_ONLINE:           Generic wait function for CPU coming
>                                  online: wait_for_completion_timeout()
>                                  which releases the upcoming CPU and
>                                  invokes an optional arch_sync_cpu_up()
>                                  function which finalizes the bringup.
> and on the AP side:
>
>     CPU comes up, does all the low level setup, sets online, calls
>     complete() and the spinwaits for release.
>
> Once the control CPU comes out of the completion it releases the
> spinwait.
>
> That works for all bringup situations and not only for kexec and the
> simple trick is that by the time the last CPU has been kicked in the
> first step, the first kicked CPU is already spinwaiting for release.
>
> By the time the first kicked CPU has completed the process, i.e. reached
> the active state, then the next CPU is spinwaiting and so on.
>
> If you look at the provided time saving:
>
>     Mainline:		210ms
>     Patched:		 80ms
> -----------------------------
>     Delta                130ms
>
> i.e. it takes ~ 1.8ms to kick and wait for the AP to come up and ~ 1.1ms
> per CPU for the whole bringup. It does not completly add up, but it has
> a clear benefit for everything.
>
> Also the changelog says that the delay is related to CPUs in deep
> C-states. If CPUs are brought down for kexec then it's trivial enough to
> limit the C-states or just not use mwait() at all.
>
> It would be interesting to see the numbers just with play_dead() using
> hlt() or mwait(eax=0, 0) for the kexec case and no other change at all.
>
> Thanks,
>
>          tglx
>
Thanks for your and Andy's precious comments. I would like to take a try on

reconstructing this patch to make it more decent and generic.


Thanks again

Kai
