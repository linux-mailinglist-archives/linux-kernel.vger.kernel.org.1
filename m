Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9968D27F448
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgI3ViW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgI3ViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:38:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA14FC061755;
        Wed, 30 Sep 2020 14:38:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601501900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6E7rSUIBVCJugx0T9Vuji43R9ZFkmGP5/w3wntstorY=;
        b=bkS2E0y0MlzWGA6pA28NTcdKfLABfMU71UbxP3zzVdGO7xGTup6aI/gr+R0fqRkuL8lIrM
        rt3ebBC44vXB2Vrmk77dONx07d0GfOWarYpHFh2GrQW8WBBuypzcDIWZm8pmk3xL3HTR1S
        FaATDutnAAXVKo3Pn8CMKUKe6+J4YcR7vO0qoiakBZjkYvoUd4pJWTTonUXeV+K389Npe/
        MAtCzcpLDcClbtd3IqXKmy3Ig/4PCl5iQ1GxSFTimfvShTY0pY1+6ysOzrF42qQoC6G2Tv
        iYvFBAE895gc5v99eF0xLWkRUhElVd+ilrMfVlzxY+iJ01PWOLuCbDyeoVYpJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601501900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6E7rSUIBVCJugx0T9Vuji43R9ZFkmGP5/w3wntstorY=;
        b=RZNlRRxLJ9pRMXZENSVanXWmjaMV405d6WJuzxmX216yg+7seJgMuqS/CuBSmjwNKBEwOn
        pnbSGUAKHyIl1CCg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Balbir Singh <sblbir@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH -next for tip:x86/pti] x86/tlb: drop unneeded local vars in enable_l1d_flush_for_task()
In-Reply-To: <20200930183552.GG2628@hirez.programming.kicks-ass.net>
References: <20200928124457.27289-1-lukas.bulwahn@gmail.com> <20200929071211.GJ2628@hirez.programming.kicks-ass.net> <20200929083709.GC2651@hirez.programming.kicks-ass.net> <87eemji887.fsf@nanos.tec.linutronix.de> <20200930170316.GB2628@hirez.programming.kicks-ass.net> <87blhni1pg.fsf@nanos.tec.linutronix.de> <20200930183552.GG2628@hirez.programming.kicks-ass.net>
Date:   Wed, 30 Sep 2020 23:38:19 +0200
Message-ID: <87k0wbgd2s.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30 2020 at 20:35, Peter Zijlstra wrote:
> On Wed, Sep 30, 2020 at 08:00:59PM +0200, Thomas Gleixner wrote:
>> On Wed, Sep 30 2020 at 19:03, Peter Zijlstra wrote:
>> > On Wed, Sep 30, 2020 at 05:40:08PM +0200, Thomas Gleixner wrote:
>> > Also, that preempt_disable() in there doesn't actually do anything.
>> > Worse, preempt_disable(); for_each_cpu(); is an anti-pattern. It mixes
>> > static_cpu_has() and boot_cpu_has() in the same bloody condition and has
>> > a pointless ret variable.
>
> Also, I forgot to add, it accesses ->cpus_mask without the proper
> locking, so it could be reading intermediate state from whatever cpumask
> operation that's in progress.

Yes. I saw that after hitting send. :(

>> I absolutely agree and I really missed it when looking at it before
>> merging. cpus_read_lock()/unlock() is the right thing to do if at all.
>> 
>> > It's shoddy code, that only works if you align the planets right. We
>> > really shouldn't provide interfaces that are this bad.
>> >
>> > It's correct operation is only by accident.
>> 
>> True :(
>> 
>> I understand Balbirs problem and it makes some sense to provide a
>> solution. We can:
>> 
>>     1) reject set_affinity() if the task has that flush muck enabled
>>        and user space tries to move it to a SMT enabled core
>> 
>>     2) disable the muck if if detects that it is runs on a SMT enabled
>>        core suddenly (hotplug says hello)
>> 
>>        This one is nasty because there is no feedback to user space
>>        about the wreckage.
>
> That's and, right, not or. because 1) deals with sched_setffinity()
> and 2) deals wit hotplug.

It was meant as AND of course.

> Now 1) requires an arch hook in sched_setaffinity(), something I'm not
> keen on providing, once we provide it, who knows what strange and
> wonderful things archs will dream up.

I don't think so. We can have that magic in core:

#ifdef CONFIG_HAS_PARANOID_L1D_FLUSH
static bool paranoid_l1d_valid(struct task_struct *tsk,
                               const struct cpumask *msk)
{
	if (!test_tsk_thread_flag(tsk, TIF_SPEC_L1D_FLUSH))
        	return true;
        /* Do magic stuff */
        return res;
}
#else
static bool paranoid_l1d_valid(struct task_struct *tsk,
                               const struct cpumask *msk)
{
	return true;
}
#endif

It's a pretty well defined problem and having the magic in core code
prevents an arch hook which allows abuse of all sorts.

And the same applies to enable_l1d_flush_for_task(). The only
architecture specific nonsense are the checks whether the CPU bug is
there and whether the hardware supports L1D flushing.

So we can have:

#ifdef CONFIG_HAS_PARANOID_L1D_FLUSH
int paranoid_l1d_enable(struct task_struct *tsk)
{
        /* Do the SMT validation under the proper locks */
        if (!res)
        	set_task_thread_flag(tsk, TIF_SPEC_L1D_FLUSH);
        return res;
}
#endif

> And 2) also happens on hot-un-plug, when the task's affinity gets
> forced because it became empty. No user feedback there either, and
> information is lost.

Of course. It's both that suddenly SMT gets enabled on a core which was
isolated and when the last isolated core in the tasks CPU mask goes
offline.

> I suppose we can do 2) but send a signal. That would cover all cases and
> keep it in arch code. But yes, that's pretty terrible too.

Bah. I just looked at the condition to flush:

        if (sched_smt_active() && !this_cpu_read(cpu_info.smt_active) &&
                (prev_mm & LAST_USER_MM_L1D_FLUSH))
                l1d_flush_hw();

That fails to flush when SMT is disabled globally. Balbir?

Of course this should be:

        if (!this_cpu_read(cpu_info.smt_active) && (prev_mm & LAST_USER_MM_L1D_FLUSH))
                l1d_flush_hw();

Now we can make this:

        if (unlikely(prev_mm & LAST_USER_MM_L1D_FLUSH)) {
        	if (!this_cpu_read(cpu_info.smt_active))
                	l1d_flush_hw();
                else
                	task_work_add(...);

And that task work clears the flag and sends a signal. We're not going
to send a signal from switch_mm() ....

Thanks,

        tglx
