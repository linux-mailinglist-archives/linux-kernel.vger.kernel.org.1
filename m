Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E4E2A087E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgJ3Oxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:53:33 -0400
Received: from foss.arm.com ([217.140.110.172]:36564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgJ3Oxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:53:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 548E0139F;
        Fri, 30 Oct 2020 07:53:32 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB9543F68F;
        Fri, 30 Oct 2020 07:53:31 -0700 (PDT)
Subject: Re: Queries on ARM SDEI Linux kernel code
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
References: <af00fba0-7d1f-6655-906d-1e6a5ae45ede@codeaurora.org>
 <1dcda05c-5235-fd0d-087e-a32772e05f97@arm.com>
 <f5cecf94-0c80-a37d-98a2-0596e2f0dd2e@codeaurora.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <d897cc82-4bf3-361c-06b9-64e0be6d2f36@arm.com>
Date:   Fri, 30 Oct 2020 14:53:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f5cecf94-0c80-a37d-98a2-0596e2f0dd2e@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neeraj,

On 21/10/2020 18:31, Neeraj Upadhyay wrote:
> On 10/16/2020 9:57 PM, James Morse wrote:
>> On 15/10/2020 07:07, Neeraj Upadhyay wrote:
>>> 1. Looks like interrupt bind interface (SDEI_1_0_FN_SDEI_INTERRUPT_BIND) is not available
>>> for clients to use; can you please share information on
>>> why it is not provided?
>>
>> There is no compelling use-case for it, and its very complex to support as the driver can
>> no longer hide things like hibernate.
>>
>> Last time I looked, it looked like the SDEI driver would need to ask the irqchip to
>> prevent modification while firmware re-configures the irq. I couldn't work out how this
>> would work if the irq is in-progress on another CPU.

> Got it. I will think in this direction, on how to achieve this.

I'm really not keen on supporting it! Its basically unusable.


>> The reasons to use bound-interrupts can equally be supported with an event provided by
>> firmware.
>>
>>
> Ok, I will explore in that direction.

Great!


[...]

>> Ideally the driver would register the event, and provide a call_on_cpu() helper to trigger
>> it. This should fit in with however the GIC's PMR based NMI does its PPI based
>> crash/stacktrace call so that the caller doesn't need to know if its back by IRQ, pNMI or
>> SDEI.

> Ok; I will explore how PMR based NMIs work; I thought it was SGI based. But will recheck.

This is where the recent work has been. (One of) Julien's cover-letter's describes it as
supporting PPI and SPI: https://lwn.net/Articles/755906/


>>> 3. Can kernel panic() be triggered from sdei event handler?
>>
>> Yes,
>>
>>
>>> Is it a safe operation?
>>
>> panic() wipes out the machine... did you expect it to keep running?
> 
> I wanted to check the case where panic triggers kexec/kdump path into capture kernel.
> 
>> What does safe mean here?

> I think I didn't put it correctly; I meant what possible scenarios can 
> happen in this case and you explained one below, thanks!

Ah, kdump. You will certainly get into the kdump kernel, but I think the SDEI reset calls
will fail as there is still an event in progress, so the kernel will leave it masked to
prevent any new events being taken.
This shouldn't affect kdumps work of dumping memory, and calling reset.


>> You should probably call nmi_panic() if there is the risk that the event occurred during
>> panic() on the same CPU, as it would otherwise just block.
>>
>>
>>> The spec says, synchronous exceptions should not be triggered; I think panic
>>> won't do it; but anything which triggers a WARN
>>> or other sync exception in that path can cause undefined behavior. Can you share your
>>> thoughts on this?
>>
>> What do you mean by undefined behaviour?

> I was thinking, if SDEI event preempts EL1, at the point, where EL1 has just entered an
> exception, and hasn't captured the registers like spsr_el1, elr_el1 and other registers,
> what will be the behavior?

Exceptions to/from EL3 don't affect them, so those registers keep their value until the
next exception taken by EL1 (which overwrites them), or ERET from EL1 (which makes them
UNKNOWN). Kdump may change exception level on nVHE systems to do a reset.

If you need them for kdump, they should be saved in the crash handler... they aren't
needed in the general case as we learn what those values were by unwinding the stack,
which is also true for SDEI. (it gets the original PC from firmware to build a stack frame)

[...]

>>> "The handler code should not enable asynchronous exceptions by clearing any of the
>>> PSTATE.DAIF bits, and should not cause synchronous exceptions to the client Exception
>>> level."
>>
>>
>> What are you using this thing for?

> Usecase is, a watchdog SPI interrupt, which we want to bound to a SDEI event. Below is the
> flow:
> 
> wdog expiry -> SDEI event -> HLOS panic -> trigger kexec/kdump

Having a common interface to this would be a good thing, that way firmware can hide how
its implemented.


Thanks,

James
