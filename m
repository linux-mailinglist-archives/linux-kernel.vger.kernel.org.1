Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19142F7576
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbhAOJbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:31:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbhAOJaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:30:55 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6144323436;
        Fri, 15 Jan 2021 09:30:12 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l0LQo-007hoL-BW; Fri, 15 Jan 2021 09:30:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Jan 2021 09:30:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/10] irqchip/sun6i-r: Use a stacked irqchip driver
In-Reply-To: <495f71d0-9dbf-23d2-45a1-f27b15138bb2@sholland.org>
References: <20210112055950.21209-1-samuel@sholland.org>
 <20210112055950.21209-4-samuel@sholland.org> <87turjjkjr.wl-maz@kernel.org>
 <495f71d0-9dbf-23d2-45a1-f27b15138bb2@sholland.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <36edee16d9ee630d9f0034fb824b1b52@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: samuel@sholland.org, tglx@linutronix.de, robh+dt@kernel.org, mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net, megous@megous.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-15 04:01, Samuel Holland wrote:
> Hello,
> 
> On 1/14/21 3:06 PM, Marc Zyngier wrote:
>> Hi Samuel,
>> 
>> On 2021-01-12 05:59, Samuel Holland wrote:
>> 
>> [...]
>> 
>>> +static void sun6i_r_intc_ack_nmi(void)
>>> +{
>>> +	writel(SUN6I_NMI_BIT, base + SUN6I_IRQ_PENDING(0));
>> 
>> writel_relaxed()
> 
> irq_chip_unmask_parent(), which calls gic_unmask_irq(), is called
> immediately after this in .irq_unmask. Since gic_unmask_irq() also uses
> writel_relaxed(), the GIC write could be ordered before the write here.

That's odd. writel() places a barrier *before* the actual write,
ensuring that this write is ordered w.r.t. previous accesses.
If you are trying to ensure ordering with what follows, you need
an explicit barrier after this access.

I guess that in the end, you may need both, as what you have orders
the access to GICC_AIR to take place before the write to this pending
register, and you also need to provide the ordering you just described.

> 
> I was getting occasional spurious interrupts (1 out of each 20-25) when
> using a level trigger, which were resolved by switching to writel() 
> here.
> 
> I mentioned this in the changelog, but it probably deserves a comment 
> in
> the code as well. Or maybe I should use an explicit barrier somewhere?

Please document it in the code. This is subtle enough to warrant a good
description.

>>> +}
>>> +
>>> +static void sun6i_r_intc_nmi_ack(struct irq_data *data)
>>> +{
>>> +	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
>>> +		sun6i_r_intc_ack_nmi();
>>> +	else
>>> +		data->chip_data = SUN6I_NMI_NEEDS_ACK;
>>> +}
>>> +
>>> +static void sun6i_r_intc_nmi_eoi(struct irq_data *data)
>>> +{
>>> +	/* For oneshot IRQs, delay the ack until the IRQ is unmasked. */
>>> +	if (data->chip_data == SUN6I_NMI_NEEDS_ACK && 
>>> !irqd_irq_masked(data))
>>> {
>>> +		sun6i_r_intc_ack_nmi();
>>> +		data->chip_data = 0;
>> 
>> nit: NULL rather than 0?
> 
> NULL seemed less appropriate since I'm not using the field as a 
> pointer,
> but I don't have a strong opinion about it.

chip_data *is* a pointer, which is why we conventionally use NULL rather
than an integer value. Up to you.

> 
>> [...]
>> 
>>> +static struct irq_chip sun6i_r_intc_nmi_chip = {
>>> +	.name			= "sun6i-r-intc",
>>> +	.irq_ack		= sun6i_r_intc_nmi_ack,
>>> +	.irq_mask		= irq_chip_mask_parent,
>>> +	.irq_unmask		= sun6i_r_intc_nmi_unmask,
>>> +	.irq_eoi		= sun6i_r_intc_nmi_eoi,
>>> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>>> +	.irq_set_type		= sun6i_r_intc_nmi_set_type,
>>> +	.irq_set_irqchip_state	= sun6i_r_intc_nmi_set_irqchip_state,
>> 
>> You probably also want to wire irq_get_irqchip_state(), while
>> you're at it.
> 
> I thought if the interrupt was pending here, it would necessarily also
> be pending at the GIC, so adding a separate layer would be redundant.
> 
> irq_set_vcpu_affinity(), __irq_get_irqchip_state(), and
> irq_set_irqchip_state() [the functions, not the callbacks] have the
> interesting property that they search up the irqdomain hierarchy for 
> the
> first irqdomain with the callback. So if all the callback would do is
> defer to its parent, it doesn't need to be provided at all*.

Ah, of course... I even wrote that code!

Thanks,

          M.
-- 
Jazz is not dead. It just smells funny...
