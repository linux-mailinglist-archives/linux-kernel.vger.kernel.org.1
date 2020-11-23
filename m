Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3B32C0E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgKWOwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:52:34 -0500
Received: from foss.arm.com ([217.140.110.172]:52758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbgKWOwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:52:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AFBA1396;
        Mon, 23 Nov 2020 06:52:32 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 759923F718;
        Mon, 23 Nov 2020 06:52:29 -0800 (PST)
References: <20201122201904.30940-1-valentin.schneider@arm.com> <20201123141416.GO3021@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alex Shi <alex.shi@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Subject: Re: [PATCH] notifier: Make atomic_notifiers use raw_spinlock
In-reply-to: <20201123141416.GO3021@hirez.programming.kicks-ass.net>
Date:   Mon, 23 Nov 2020 14:52:23 +0000
Message-ID: <jhjr1okunvc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/11/20 14:14, Peter Zijlstra wrote:
> On Sun, Nov 22, 2020 at 08:19:04PM +0000, Valentin Schneider wrote:
[...]
>> Two points worth noting:
>>
>> 1) That this is conceptually the same issue as pointed out in:
>>    313c8c16ee62 ("PM / CPU: replace raw_notifier with atomic_notifier")
>> 2) Only the _robust() variant of atomic_notifier callchains suffer from
>>    this
>>
>> AFAICT only the cpu_pm_notifier_chain really needs to be changed, but
>> singling it out would mean introducing a new (truly) non-blocking API. At
>> the same time, callers that are fine with any blocking within the call
>> chain should use blocking notifiers, so patching up all atomic_notifier's
>> doesn't seem *too* crazy to me.
>
> How long are these notifier chains?,

On said Juno I get:

  gic_notifier()
  arch_timer_cpu_pm_notify()
  fpsimd_cpu_pm_notifier()
  cpu_pm_pmu_notify() x2
  hyp_init_cpu_pm_notifier()

(I would take a guess that there's one PMU cb per cluster due to big.LITTLE
faffery)

> and all this pcs_enter_idle_state()
> is still horribly broken vs RCU, witness the RCU_NONIDLE() there and the
> rcu_irq_enter_irqson() in the pm_notifier code.
>

Hadn't paid attention to that, that's indeed... Interesting.

> That said, we're running these notifiers from the idle path with IRQs
> disabled, so taking that spinlock isn't going to make it worse..

And it's already taken on !PREEMPT_RT.
