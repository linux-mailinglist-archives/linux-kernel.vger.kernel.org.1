Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7D2CFE59
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 20:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgLETZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 14:25:05 -0500
Received: from foss.arm.com ([217.140.110.172]:44870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgLETZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 14:25:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B46830E;
        Sat,  5 Dec 2020 11:24:19 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BED653F575;
        Sat,  5 Dec 2020 11:24:17 -0800 (PST)
References: <20201124141449.572446-1-maz@kernel.org> <20201124141449.572446-3-maz@kernel.org> <jhj7dq8ugli.mognet@arm.com> <20201203130320.GQ3021@hirez.programming.kicks-ass.net> <jhjy2ieubsj.mognet@arm.com>
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
In-reply-to: <jhjy2ieubsj.mognet@arm.com>
Date:   Sat, 05 Dec 2020 19:24:15 +0000
Message-ID: <jhjv9dgt5sw.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/12/20 15:52, Valentin Schneider wrote:
> On 03/12/20 13:03, Peter Zijlstra wrote:
[...]
>> The scheduler IPI really doesn't need RCU either ;-)
[...]
> But as with any other interrupt, we could then go through:
>
>   preempt_schedule_irq() ~> pick_next_task_fair() -> newidle_balance()
>
> which does enter a read-side section, so RCU would need to be
> watching. Looking at kernel/entry/common.c:irqentry_exit_cond_resched(), it
> seems we do check for this via rcu_irq_exit_check_preempt().
>
> I however cannot grok why irqentry_exit() *doesn't* call into
> preempt_schedule_irq() if RCU wasn't watching on IRQ entry

RCU wasn't watching on IRQ entry:
  -> we should be on the idle task
  -> no unvoluntary preemption for the idle task, scheduling always happens
     at the tail of the idle loop
  -> ignore what I've been saying, current patch is fine
