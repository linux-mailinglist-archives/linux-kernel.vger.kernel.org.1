Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27A22D8357
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 01:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407303AbgLLARB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 19:17:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38742 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407296AbgLLAQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 19:16:54 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607732172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hqbFRYPDhcqtawXKx6n1the+OBNiDCmjIGiR3orx8EA=;
        b=MTPSXyZNel+TcIxeSv7g6YdamWqolsj/qDRvreakkhpOYBYPCRI3agFKCkGqPzYpjuxtGW
        /XMj+aBU2MdHIshyWBw4GG+CBsTgLbL4Yy9Q/7oZxL1nSrwOFAY98cmzMRuCwCu/Ts5c3a
        t+JXgFw1KcxCDIyZ2GqwF102khftPh0IN7B8TdcZ+zTLjDnkQkFvBrhD97FZ7LEI7+IxLO
        2Mqow/TANashMI4a4tFcdy21nCsl/L6cGtVUicC1KX5O5FpEMrQ42HUzQHhcz03EZMXAu0
        ElqFkv4oINJhOBzC7wSZZwvWfOBP2x72JchABTDw4teO6Evk3nPYA3u7zvW6aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607732172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hqbFRYPDhcqtawXKx6n1the+OBNiDCmjIGiR3orx8EA=;
        b=aKblQ0K5egUgfE4Cwdrg2BCOdlNYyE6qdQOf0JtBJ6zjaX70IDTx8gP8JQirGni6AaeMZZ
        oEIiD4s7rXk795CA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [patch 1/3] tick: Remove pointless cpu valid check in hotplug code
In-Reply-To: <20201211222104.GB595642@lothringen>
References: <20201206211253.919834182@linutronix.de> <20201206212002.582579516@linutronix.de> <20201211222104.GB595642@lothringen>
Date:   Sat, 12 Dec 2020 01:16:12 +0100
Message-ID: <87v9d7g9pv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11 2020 at 23:21, Frederic Weisbecker wrote:
> On Sun, Dec 06, 2020 at 10:12:54PM +0100, Thomas Gleixner wrote:
>> tick_handover_do_timer() which is invoked when a CPU is unplugged has a
>> @@ -407,17 +407,13 @@ EXPORT_SYMBOL_GPL(tick_broadcast_oneshot
>>  /*
>>   * Transfer the do_timer job away from a dying cpu.
>>   *
>> - * Called with interrupts disabled. Not locking required. If
>> + * Called with interrupts disabled. No locking required. If
>>   * tick_do_timer_cpu is owned by this cpu, nothing can change it.
>>   */
>>  void tick_handover_do_timer(void)
>>  {
>> -	if (tick_do_timer_cpu == smp_processor_id()) {
>> -		int cpu = cpumask_first(cpu_online_mask);
>> -
>> -		tick_do_timer_cpu = (cpu < nr_cpu_ids) ? cpu :
>> -			TICK_DO_TIMER_NONE;
>> -	}
>> +	if (tick_do_timer_cpu == smp_processor_id())
>> +		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
>
> I was about to whine that this randomly chosen CPU may be idle and leave
> the timekeeping stale until I realized that stop_machine() is running at that
> time. Might be worth adding a comment about that.
>
> Also why not just setting it to TICK_DO_TIMER_NONE and be done with it? Perhaps
> to avoid that all the CPUs to compete and contend on jiffies update after stop
> machine?

No. Because we'd need to add the NONE magic to NOHZ=n kernels which does
not make sense.

Thanks,

        tglx
