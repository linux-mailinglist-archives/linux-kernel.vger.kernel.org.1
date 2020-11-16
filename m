Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048FD2B538C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbgKPVL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:11:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33488 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbgKPVLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:11:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGL9nab126290;
        Mon, 16 Nov 2020 21:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/dJiLEXJh7wJLI4efj0/HqfPaT0+9Gv12+l7S2hOiZU=;
 b=mZ69PRubk6LEoPDZJPkW6lCKlztw2XdpS+TfrBfNu3nNjqSAbO/S2BUVKlz9SsIYtSuj
 c5Ow2XxN4camps3ms7WywhzJwfc4/ApyGcNI9fFSYe2RNolQobgzUherTX5I3Ki0dY8j
 8P2JNMHzb/54zfLDodCs4A0LCd5RNBzHPf5/JVvIHo5GEdzaP28c2uMon5oPYWfwjLV+
 0pqkRLDrbWSH+tkpnuU7/31QjxOoXL+1C87+zwN/LSOqlhmyqcVyLfz2ewNaFsm/k5Py
 CCkx9QL0EFR9wrEsS838Th0rWQ9dsTErG4viDLHU8gCingVvSjE0ZmJ7MhxZpTGwpDqA UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34t7vmya97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 21:11:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGLATBs110305;
        Mon, 16 Nov 2020 21:11:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34ts5v6jgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 21:11:35 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AGLBYtI021247;
        Mon, 16 Nov 2020 21:11:34 GMT
Received: from [10.159.255.160] (/10.159.255.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 13:11:34 -0800
Subject: Re: [PATCH] arm64: kexec: Use smp_send_stop in machine_shutdown
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com
References: <1604705148-1831-1-git-send-email-henry.willard@oracle.com>
 <a68252a0-4248-4523-da8d-0ecfc3bc207b@arm.com>
From:   Henry Willard <henry.willard@oracle.com>
Message-ID: <327a6a60-5ba8-4aa2-6a0e-e5f99e4e0bf0@oracle.com>
Date:   Mon, 16 Nov 2020 13:11:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <a68252a0-4248-4523-da8d-0ecfc3bc207b@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James

Thanks for taking the time to review this and the pointers.

On 11/11/20 10:11 AM, James Morse wrote:
> Hi Henry,
>
> On 06/11/2020 23:25, Henry Willard wrote:
>> machine_shutdown() is called by kernel_kexec() to shutdown
>> the non-boot CPUs prior to starting the new kernel. The
>> implementation of machine_shutdown() varies by architecture.
>> Many make an interprocessor call, such as smp_send_stop(),
>> to stop the non-boot CPUs. On some architectures the CPUs make
>> some sort of firmware call to stop the CPU. On some architectures
>> without the necessary firmware support to stop the CPU, the CPUs
>> go into a disabled loop, which is not suitable for supporting
>> kexec. On Arm64 systems that support PSCI, CPUs can be stopped
>> with a PSCI CPU_OFF call.
> All this variation is because we want to to get the CPU back in a sane state, as if we'd
> just come from cold boot. Without the platform firmware doing its initialisation, the only
> way we have of doing this is to run the cpuhp callbacks to take the CPU offline cleanly.
If it is unsafe to call cpu_ops.cpu_die (or cpu_die) on Arm except from 
cpuhp shouldn't something detect that?
>
>
>> Arm64 machine_shutdown() uses the CPU hotplug infrastructure via
>> smp_shutdown_nonboot_cpus() to stop each CPU. This is relatively
>> slow and takes a best case of .02 to .03 seconds per CPU which are
>> stopped sequentially.
> Hmmm, looks like cpuhp doesn't have a way to run the callbacks in parallel...
>
>
>> This can take the better part of a second for
>> all the CPUs to be stopped depending on how many CPUs are present.
>> If for some reason the CPUs are busy at the time of the kexec reboot,
>> it can take several seconds to shut them all down.
> Busy doing what?
Executing user code
>
> I assume the problem is CPUs starting work on behalf of user-space, which is now
> pointless, which prevents them from scheduling into the cpuhp work quickly.
>
> Does hoisting kexec's conditional call to freeze_processes() above the #ifdef - so that
> user-space threads are no longer schedule-able improve things here?
It might help the worst cases, but even on an idle system it takes a while.
>
>
>> Each CPU shuts itself down by calling PSCI CPU_OFF.
>> In some applications such as embedded systems, which need a very
>> fast reboot (less than a second), this may be too slow.
> Where does this requirement come from? Surely kexec is part of a software update, not
> regular operation.
The requirement comes from the owner of the larger environment of which 
this embedded system is a part. So, yes, this is part of software 
maintenance of a component during regular operation.
>> This patch reverts to using smp_send_stop() to signal all
>> CPUs to stop immediately. Currently smp_send_stop() causes each cpu
>> to call local_cpu_stop(), which goes into a disabled loop. This patch
>> modifies local_cpu_stop() to call cpu_die() when kexec_in_progress
>> is true, so that the CPU calls PSCI CPU_OFF just as in the case of
>> smp_shutdown_nonboot_cpus().
> This is appropriate for panic(), as we accept it may fail.
>
> For Kexec(), the CPU must go offline, otherwise we can't overwrite the code it was
> running. The arch code can't just call CPU_OFF in any context. See 5.5 CPU_OFF' of
> https://developer.arm.com/documentation/den0022/d
>
> 5.5.2 describes what the OS must do first, in particular interrupts must be migrated away
> from the CPU calling CPU_OFF. Currently the cpuhp notifiers do this, which after this
> patch, no longer run.
I believe this is done by irq_migrate_all_off_this_cpu(), which is 
called by take_cpu_down() scheduled on the processor to be shutdown by 
stop_machine_cpuslocked(). I missed that. While take_cpu_down() is 
running on the target processor the boot CPU is waiting, which is part 
of the reason for the latency.
>
> You're going to need some duct-tape here, but I recall the proposed
> 'ARCH_OFFLINE_CPUS_ON_REBOOT', which would help, but isn't a complete thing. From the
> discussion:
> https://lore.kernel.org/lkml/87h80vwta7.fsf@nanos.tec.linutronix.de/
> https://lore.kernel.org/lkml/alpine.DEB.2.21.1908201321200.2223@nanos.tec.linutronix.de/
>
> using cpuhp to offline these CPUs is the right thing to do.
> If the problem is its too slow, can we tackled that instead?
I think it is relatively slow because the CPUs are shutdown 
sequentially. Besides ia64, most of the architectures that support 
kexec, appear to kill them all at once. I will try again. Thanks for the 
pointers.
>
>
>> Using smp_send_stop() instead of
>> smp_shutdown_nonboot_cpus() reduces the shutdown time for 23 CPUs
>> from about .65 seconds on an idle system to less than 5 msecs. On a
>> busy system smp_shutdown_nonboot_cpus() may take several seconds,
>> while smp_send_stop() needs only the 5 msecs.
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index 4784011cecac..2568452a2417 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -142,12 +143,22 @@ void arch_cpu_idle_dead(void)
>>    * This must completely disable all secondary CPUs; simply causing those CPUs
>>    * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
>>    * kexec'd kernel to use any and all RAM as it sees fit, without having to
>> - * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
>> - * functionality embodied in smpt_shutdown_nonboot_cpus() to achieve this.
>> + * avoid any code or data used by any SW CPU pin loop. The target stop function
>> + * will call cpu_die() if kexec_in_progress is set.
>>    */
>>   void machine_shutdown(void)
>>   {
>> -	smp_shutdown_nonboot_cpus(reboot_cpu);
>> +	unsigned long timeout;
>> +
>> +	/*
>> +	 * Don't wait forever, but no longer than a second
>> +	 */
> For kexec we must wait for the CPU to exit the current kernel. If it doesn't we can't
> overwrite the current memory image with the kexec payload.
If all the CPUs haven't exited (num_online_cpus() > 1), machine_kexec() 
will panic if it isn't a crash kernel. Preferably we want to find out 
sooner rather than later if it isn't going to finish.
>
> Features like CNP allow CPUs to share TLB entries. If a CPU is left behind in the older
> kernel, the code its is executing will be overwritten and its behaviour stops being
> predictable. It may start allocating junk TLB entries, that CNP allows CPUs in the new
> kernel to use, resulting in hard to debug crashes.
>
> For kdump we avoid this problem by ensuring the old and new kernels never overlap. The old
> kernel doesn't even have the kdump carveout mapped.
>
>
>> +	timeout = USEC_PER_SEC;
>> +
>> +	smp_send_stop();
>> +	while (num_online_cpus() > 1 && timeout--)
>> +		udelay(1);
>> +	return;
>>   }
>>   
>>   /*
>
> Thanks,
>
> James
Thanks,

Henry
