Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18F2909B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 18:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410412AbgJPQ3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 12:29:55 -0400
Received: from foss.arm.com ([217.140.110.172]:40636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408431AbgJPQ3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:29:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E68613D5;
        Fri, 16 Oct 2020 09:29:55 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E702C3F719;
        Fri, 16 Oct 2020 09:29:54 -0700 (PDT)
Subject: Re: Queries on ARM SDEI Linux kernel code
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
References: <af00fba0-7d1f-6655-906d-1e6a5ae45ede@codeaurora.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <1dcda05c-5235-fd0d-087e-a32772e05f97@arm.com>
Date:   Fri, 16 Oct 2020 17:27:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <af00fba0-7d1f-6655-906d-1e6a5ae45ede@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neeraj,

On 15/10/2020 07:07, Neeraj Upadhyay wrote:
> 1. Looks like interrupt bind interface (SDEI_1_0_FN_SDEI_INTERRUPT_BIND) is not available
> for clients to use; can you please share information on
> why it is not provided?

There is no compelling use-case for it, and its very complex to support as the driver can
no longer hide things like hibernate.

Last time I looked, it looked like the SDEI driver would need to ask the irqchip to
prevent modification while firmware re-configures the irq. I couldn't work out how this
would work if the irq is in-progress on another CPU.

The reasons to use bound-interrupts can equally be supported with an event provided by
firmware.


> While trying to dig information on this, I saw  that [1] says:
>   Now the hotplug callbacks save  nothing, and restore the OS-view of registered/enabled.
> This makes bound-interrupts harder to work with.

> Based on this comment, the changes from v4 [2], which I could understand is, cpu down path
> does not save the current event enable status, and we rely on the enable status
> `event->reenable', which is set, when register/unregister, enable/disable calls are made;
> this enable status is used during cpu up path, to decide whether to reenable the interrupt.

> Does this make, bound-interrupts harder to work with? how? Can you please explain? Or
> above save/restore is not the reason and you meant something else?

If you bind a level-triggered interrupt, how does firmware know how to clear the interrupt
from whatever is generating it?

What happens if the OS can't do this either, as it needs to allocate memory, or take a
lock, which it can't do in nmi context?


The people that wrote the SDEI spec's answer to this was that the handler can disable the
event from inside the handler... and firmware will do, something, to stop the interrupt
screaming.

So now an event can become disabled anytime its registered, which makes it more
complicated to save/restore.


> Also, does shared bound interrupts 

Shared-interrupts as an NMI made me jump. But I think you mean a bound interrupt as a
shared event. i.e. and SPI not a PPI.


> also have the same problem, as save/restore behavior
> was only for private events?

See above, the problem is the event disabling itself.

Additionally those changes to unregister the private-event mean the code can't tell the
difference between cpuhp and hibernate... only hibernate additionally loses the state in
firmware.


> 2. SDEI_EVENT_SIGNAL api is not provided? What is the reason for it? Its handling has the
> same problems, which are there for bound interrupts?

Its not supported as no-one showed up with a use-case.
While firmware is expected to back it with a PPI, its doesn't have the same problems as
bound-interrupts as its not an interrupt the OS ever knows about.


> Also, if it is provided, clients need to register event 0 ? Vendor events or other event
> nums are not supported, as per spec.

Ideally the driver would register the event, and provide a call_on_cpu() helper to trigger
it. This should fit in with however the GIC's PMR based NMI does its PPI based
crash/stacktrace call so that the caller doesn't need to know if its back by IRQ, pNMI or
SDEI.


> 3. Can kernel panic() be triggered from sdei event handler?

Yes,


> Is it a safe operation?

panic() wipes out the machine... did you expect it to keep running?
What does safe mean here?

You should probably call nmi_panic() if there is the risk that the event occurred during
panic() on the same CPU, as it would otherwise just block.


> The spec says, synchronous exceptions should not be triggered; I think panic
> won't do it; but anything which triggers a WARN
> or other sync exception in that path can cause undefined behavior. Can you share your
> thoughts on this?

What do you mean by undefined behaviour?

SDEI was originally to report external abort to the OS in regions where the OS can't take
an exception because the exception-registers are live, just after and exception and just
before eret.

If you take another exception from the NMI handler, chances are you're going to go back
round the loop again, only this time firmware can't inject the SDEI event, so it has to
reboot.

If you know it might cause an exception, you shouldn't do it in NMI context.


> "The handler code should not enable asynchronous exceptions by clearing any of the
> PSTATE.DAIF bits, and should not cause synchronous exceptions to the client Exception level."


What are you using this thing for?


Thanks,

James
