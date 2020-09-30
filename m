Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB0B27F59A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbgI3XAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:00:05 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:26701 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbgI3XAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601506802; x=1633042802;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=ERi0Pf4HQMHPa9rJT2IBPZJNeA9YKjn1VuAaepvxx8k=;
  b=JO9t2mv7JrFwm9y+28HvtjF92xDCorKAfnz3D5svaoQTuIoGiNCVptym
   PNBbfqPJcLWKYs31Fa6ssDc4H9BTvMyws/+RF8C3zsks5pEViKnS2cw2k
   yyL6DxQWuErjkglPq2bWdLp1529pjY7sK35NcDS1D4nNzS55/yuVPFN2+
   w=;
X-IronPort-AV: E=Sophos;i="5.77,322,1596499200"; 
   d="scan'208";a="57321998"
Subject: Re: [PATCH -next for tip:x86/pti] x86/tlb: drop unneeded local vars in
 enable_l1d_flush_for_task()
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-16425a8d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 30 Sep 2020 23:00:01 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-16425a8d.us-east-1.amazon.com (Postfix) with ESMTPS id 06073100F6F;
        Wed, 30 Sep 2020 22:59:55 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 30 Sep 2020 22:59:54 +0000
Received: from f8ffc2228008.ant.amazon.com (10.43.161.237) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 30 Sep 2020 22:59:51 +0000
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-safety@lists.elisa.tech" <linux-safety@lists.elisa.tech>
References: <20200928124457.27289-1-lukas.bulwahn@gmail.com>
 <20200929071211.GJ2628@hirez.programming.kicks-ass.net>
 <20200929083709.GC2651@hirez.programming.kicks-ass.net>
 <87eemji887.fsf@nanos.tec.linutronix.de>
 <20200930170316.GB2628@hirez.programming.kicks-ass.net>
 <87blhni1pg.fsf@nanos.tec.linutronix.de>
 <20200930183552.GG2628@hirez.programming.kicks-ass.net>
 <87k0wbgd2s.fsf@nanos.tec.linutronix.de>
From:   "Singh, Balbir" <sblbir@amazon.com>
Message-ID: <9b700b03-6bbd-b969-abb8-a004c813446d@amazon.com>
Date:   Thu, 1 Oct 2020 08:59:48 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <87k0wbgd2s.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D36UWB002.ant.amazon.com (10.43.161.149) To
 EX13d01UWB002.ant.amazon.com (10.43.161.136)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/20 7:38 am, Thomas Gleixner wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Wed, Sep 30 2020 at 20:35, Peter Zijlstra wrote:
>> On Wed, Sep 30, 2020 at 08:00:59PM +0200, Thomas Gleixner wrote:
>>> On Wed, Sep 30 2020 at 19:03, Peter Zijlstra wrote:
>>>> On Wed, Sep 30, 2020 at 05:40:08PM +0200, Thomas Gleixner wrote:
>>>> Also, that preempt_disable() in there doesn't actually do anything.
>>>> Worse, preempt_disable(); for_each_cpu(); is an anti-pattern. It mixes
>>>> static_cpu_has() and boot_cpu_has() in the same bloody condition and has
>>>> a pointless ret variable.
>>
>> Also, I forgot to add, it accesses ->cpus_mask without the proper
>> locking, so it could be reading intermediate state from whatever cpumask
>> operation that's in progress.
> 
> Yes. I saw that after hitting send. :(
> 
>>> I absolutely agree and I really missed it when looking at it before
>>> merging. cpus_read_lock()/unlock() is the right thing to do if at all.
>>>
>>>> It's shoddy code, that only works if you align the planets right. We
>>>> really shouldn't provide interfaces that are this bad.
>>>>
>>>> It's correct operation is only by accident.
>>>
>>> True :(
>>>
>>> I understand Balbirs problem and it makes some sense to provide a
>>> solution. We can:
>>>
>>>     1) reject set_affinity() if the task has that flush muck enabled
>>>        and user space tries to move it to a SMT enabled core
>>>
>>>     2) disable the muck if if detects that it is runs on a SMT enabled
>>>        core suddenly (hotplug says hello)
>>>
>>>        This one is nasty because there is no feedback to user space
>>>        about the wreckage.
>>
>> That's and, right, not or. because 1) deals with sched_setffinity()
>> and 2) deals wit hotplug.
> 
> It was meant as AND of course.
> 
>> Now 1) requires an arch hook in sched_setaffinity(), something I'm not
>> keen on providing, once we provide it, who knows what strange and
>> wonderful things archs will dream up.
> 
> I don't think so. We can have that magic in core:
> 
> #ifdef CONFIG_HAS_PARANOID_L1D_FLUSH
> static bool paranoid_l1d_valid(struct task_struct *tsk,
>                                const struct cpumask *msk)
> {
>         if (!test_tsk_thread_flag(tsk, TIF_SPEC_L1D_FLUSH))
>                 return true;
>         /* Do magic stuff */
>         return res;
> }
> #else
> static bool paranoid_l1d_valid(struct task_struct *tsk,
>                                const struct cpumask *msk)
> {
>         return true;
> }
> #endif
> 
> It's a pretty well defined problem and having the magic in core code
> prevents an arch hook which allows abuse of all sorts.
> 
> And the same applies to enable_l1d_flush_for_task(). The only
> architecture specific nonsense are the checks whether the CPU bug is
> there and whether the hardware supports L1D flushing.
> 
> So we can have:
> 
> #ifdef CONFIG_HAS_PARANOID_L1D_FLUSH
> int paranoid_l1d_enable(struct task_struct *tsk)
> {
>         /* Do the SMT validation under the proper locks */
>         if (!res)
>                 set_task_thread_flag(tsk, TIF_SPEC_L1D_FLUSH);
>         return res;
> }
> #endif
> 
>> And 2) also happens on hot-un-plug, when the task's affinity gets
>> forced because it became empty. No user feedback there either, and
>> information is lost.
> 
> Of course. It's both that suddenly SMT gets enabled on a core which was
> isolated and when the last isolated core in the tasks CPU mask goes
> offline.
> 
>> I suppose we can do 2) but send a signal. That would cover all cases and
>> keep it in arch code. But yes, that's pretty terrible too.
> 
> Bah. I just looked at the condition to flush:
> 
>         if (sched_smt_active() && !this_cpu_read(cpu_info.smt_active) &&
>                 (prev_mm & LAST_USER_MM_L1D_FLUSH))
>                 l1d_flush_hw();
> 
> That fails to flush when SMT is disabled globally. Balbir?

It should have been 

!sched_smt_active() || (cond)

and not

sched_smt_active && (cond)

I'll fix that up, but your simplification below works as well.




> 
> Of course this should be:
> 
>         if (!this_cpu_read(cpu_info.smt_active) && (prev_mm & LAST_USER_MM_L1D_FLUSH))
>                 l1d_flush_hw();
> 
> Now we can make this:
> 
>         if (unlikely(prev_mm & LAST_USER_MM_L1D_FLUSH)) {
>                 if (!this_cpu_read(cpu_info.smt_active))
>                         l1d_flush_hw();
>                 else
>                         task_work_add(...);
> 
> And that task work clears the flag and sends a signal. We're not going
> to send a signal from switch_mm() ....
> 

Yes, I see MCE handling uses a similar pattern, so SIGBUS for a task that migrates/moves
to a SMT disabled core?

Thanks,
Balbir

