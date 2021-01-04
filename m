Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F95A2E9312
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbhADKEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbhADKEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:04:30 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D5D020769;
        Mon,  4 Jan 2021 10:03:49 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kwMiJ-005Blr-DU; Mon, 04 Jan 2021 10:03:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Jan 2021 10:03:47 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] irqchip/sun6i-r: Use a stacked irqchip driver
In-Reply-To: <8c1eaddd-577b-9c2a-aa6a-9ee716178d4a@sholland.org>
References: <20210103103101.33603-1-samuel@sholland.org>
 <20210103103101.33603-4-samuel@sholland.org> <875z4el0p2.wl-maz@kernel.org>
 <66a7eb24-66c7-d5e6-1235-aa6846c5eef2@sholland.org>
 <8735zikvyq.wl-maz@kernel.org>
 <8c1eaddd-577b-9c2a-aa6a-9ee716178d4a@sholland.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <a9359739794dc803723c9a6750a96474@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: samuel@sholland.org, tglx@linutronix.de, robh+dt@kernel.org, mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net, linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, megous@megous.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-04 03:46, Samuel Holland wrote:
> On 1/3/21 7:10 AM, Marc Zyngier wrote:
>> On Sun, 03 Jan 2021 12:08:43 +0000,
>> Samuel Holland <samuel@sholland.org> wrote:
>>> 
>>> On 1/3/21 5:27 AM, Marc Zyngier wrote:

[...]

>>> For edge interrupts, don't you want to ack as early as possible,
>>> before the handler clears the source of the interrupt? That way if a
>>> second interrupt comes in while you're handling the first one, you
>>> don't ack the second one without handling it?
>> 
>> It completely depends on what this block does. If, as I expect, it
>> latches the interrupt, then it needs clearing after the GIC has acked
>> the incoming interrupt.
> 
> Yes, there is an internal S/R latch.
>  - For edge interrupts, the latch is set once for each pulse.
>  - For level interrupts, it gets set continuously as long as the
>    pin is high/low.
>  - Writing a "1" to bit 0 of PENDING resets the latch.
>  - The output of the latch goes to the GIC.
> 
>>>> It also begs the question: why would you want to clear the signal to
>>>> the GIC on mask (or unmask)? The expectations are that a pending
>>>> interrupt is preserved across a mask/unmask sequence.
>>> 
>>> I hadn't thought about anything masking the IRQ outside of the
>>> handler; but you're right, this breaks that case. I'm trying to work
>>> within the constraints of stacking the GIC driver, which assumes
>>> handle_fasteoi_irq, so it sounds like I should switch back to
>>> handle_fasteoi_ack_irq and use .irq_ack. Or based on your previous
>>> paragraph, maybe I'm missing some other consideration?
>> 
>> handle_fasteoi_ack_irq() sounds like a good match for edge
>> interrupts. Do you actually need to do anything for level signals? If
>> you do, piggybacking on .irq_eoi would do the trick.
> 
> For level interrupts, I have to reset the latch (see above) after the 
> source of
> the interrupt is cleared.

Right, so that is definitely to be done in .irq_eoi, at least in the
non-threaded case (as it doesn't involve masking/unmasking).

> That was the bug with v2: I set IRQ_EOI_THREADED so .irq_eoi would run 
> after the
> thread. But with GICv2 EOImode==0, that blocked other interrupts from 
> being
> received during the IRQ thread. Which is why I moved it to .irq_unmask 
> and
> removed the flag: so .irq_eoi runs at the end of the hardirq 
> (unblocking further
> interrupts at the GIC), and .irq_unmask resets the latch at the end of
> the thread.
> 
> With the flag removed, but still clearing the latch in .irq_eoi, every 
> edge IRQ

edge? Didn't you mean level here? Edge interrupts really should clear
the latch in .irq_ack.

> was followed by a second, spurious IRQ after the thread finished.
> 
> Does that make sense?

It does. It is a bit of a kludge, but hey, silly HW (if only this could 
be
turned into a bypass, it'd all be simpler).

To sum it up, this is what I'd expect to see:

For edge interrupts:
- clear latch in .irq_ack and .irq_set_irqchip_state(PENDING)
- interrupt flow set to fasteoi_ack

For level interrupts
- clear latch in .irq_eoi (non-threaded) and .irq_unmask (threaded)
- interrupt flow set to fasteoi (though leaving to the _ack version
   should not hurt).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
