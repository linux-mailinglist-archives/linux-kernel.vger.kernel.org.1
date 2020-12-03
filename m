Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BCA2CDA6A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgLCPxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:53:41 -0500
Received: from foss.arm.com ([217.140.110.172]:43842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgLCPxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:53:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFA4B11D4;
        Thu,  3 Dec 2020 07:52:55 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BF663F575;
        Thu,  3 Dec 2020 07:52:49 -0800 (PST)
References: <20201124141449.572446-1-maz@kernel.org> <20201124141449.572446-3-maz@kernel.org> <jhj7dq8ugli.mognet@arm.com> <20201203130320.GQ3021@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 2/6] genirq: Allow an interrupt to be marked as 'raw'
In-reply-to: <20201203130320.GQ3021@hirez.programming.kicks-ass.net>
Date:   Thu, 03 Dec 2020 15:52:44 +0000
Message-ID: <jhjy2ieubsj.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/12/20 13:03, Peter Zijlstra wrote:
> On Thu, Nov 26, 2020 at 06:18:33PM +0000, Valentin Schneider wrote:
>> If I got the RCU bits right from what Thomas mentioned in
>>
>>   https://lore.kernel.org/r/87ft5q18qs.fsf@nanos.tec.linutronix.de
>>   https://lore.kernel.org/r/87lfewnmdz.fsf@nanos.tec.linutronix.de
>>
>> then we're still missing something to notify RCU in the case the IRQ hits
>> the idle task. All I see on our entry path is
>>
>>   trace_hardirqs_off();
>>   ...
>>   irq_handler()
>>     handle_domain_irq();
>>   ...
>>   trace_hardirqs_on();
>>
>> so we do currently rely on handle_domain_irq()'s irq_enter() + irq_exit()
>> for that. rcu_irq_enter() says CONFIG_RCU_EQS_DEBUG=y can detect missing
>> bits, but I don't get any warnings with your series on my Juno.
>
> The scheduler IPI really doesn't need RCU either ;-)

Because it doesn't enter any new read-side section, right?
But as with any other interrupt, we could then go through:

  preempt_schedule_irq() ~> pick_next_task_fair() -> newidle_balance()

which does enter a read-side section, so RCU would need to be
watching. Looking at kernel/entry/common.c:irqentry_exit_cond_resched(), it
seems we do check for this via rcu_irq_exit_check_preempt().

I however cannot grok why irqentry_exit() *doesn't* call into
preempt_schedule_irq() if RCU wasn't watching on IRQ entry, so I'm starting
to question everything (again).
