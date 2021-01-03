Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A602E8C12
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 13:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbhACMJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 07:09:34 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45617 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725986AbhACMJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 07:09:33 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C4BA6580415;
        Sun,  3 Jan 2021 07:08:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 07:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=a
        oH+sqgGgsmW2oHyI/mduh3HVFh1UGBtc7bx1ciYxvc=; b=YKZIJtr/2GyfQwNIs
        iNERvOHdRCvsPHhZsvZ9SiIB5nNbeEsh/kFCJ1Rh5H1/qrEJj8CF4zOpRn/hU9zP
        iZUJECqj396Cvflv/ujgYlR7TjAM/y+5Y0TS/DPZUxNxxLk5hUcVm2NurH2nuiCv
        shZjXztCtwx7+NX5Ka8/mu2dAijFeftHlc3OjhBqsHzhRW/LreOkDAMylbk/VL05
        xxAK1eLdk1BIl7NWUvqg3ywhPKfECEOXstmnp1JNhqPvldImghF0kfEN80RdSVfR
        NWsfrC1bfI6jUY4UxKQ7pN7uSlYv7OGIudMaJCjjNLNIwIYLhIg0t5P71OqQB0ee
        A0fYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=aoH+sqgGgsmW2oHyI/mduh3HVFh1UGBtc7bx1ciYx
        vc=; b=odQ6cxTwf6Yx0ZmSTXSINuvQ/sAWWwJ9ahhm79wCjfjhXRMWb2DmJNAj+
        f54GaUXq5oZr5XASHy35ZRp047JjrvtV3kK6mzoZ2U415EK9qiP+oxpDNnBWfu8R
        kDnjWGLCUNzsOinYumv9xHkEVcY90yiJ3ii/+s5+DlkLEY5rKYBvgqWCCnA+86U9
        szoEuwx/dUKCbfF20v8XsGaJvmrpn03ELEK5DWoaBc7RLtZGis4QUM9rqFmmSt5z
        Xt8BMMjWR2HN4wET4tDn1kL4D+9iBDbNLzDN+eEHD8keTYhowntuuu4GVqO9uC4V
        yU3DJs/5j4aFA8sKg9MsolBz7bQ5A==
X-ME-Sender: <xms:zLPxX1ZUwKozyBsz4ALSrajxYvhOcVke72D58ewfRbdRr_GSlP8iuw>
    <xme:zLPxX8ZI5xrMAYaBmAwu2YjbKbzEmDtbx0_pn2OM-WHJpZs6AFr_infvyoF_Qtjcy
    jY0gzUojHUOA59wLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjeetledvueffvdetjeeuueeileffueffhedviefghefftedthfdt
    ffffueefveehnecuffhomhgrihhnpehlihhnuhigqdhsuhhngihirdhorhhgpdhlkhhmlh
    drohhrghenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnug
    drohhrgh
X-ME-Proxy: <xmx:zLPxX384xAF37H_JUE0psltDkVeS93WhSmymTqgvns0yRm-ROCjfVg>
    <xmx:zLPxXzqURYcd8he2xWqg9n2_e-a9S6xa8fb7ZADYoQVD0paDXitIag>
    <xmx:zLPxXwr9h0lONzk_uY28A7NPPl4G1EqRu-dHg_xazUrEqNZ7_TGQXg>
    <xmx:zbPxX1T1wsO15wSLX9wobJTQrme3vP_bc5pDpWNQw0EErtky_srQLw>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC0221080063;
        Sun,  3 Jan 2021 07:08:43 -0500 (EST)
Subject: Re: [PATCH v3 03/10] irqchip/sun6i-r: Use a stacked irqchip driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20210103103101.33603-1-samuel@sholland.org>
 <20210103103101.33603-4-samuel@sholland.org> <875z4el0p2.wl-maz@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <66a7eb24-66c7-d5e6-1235-aa6846c5eef2@sholland.org>
Date:   Sun, 3 Jan 2021 06:08:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <875z4el0p2.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/21 5:27 AM, Marc Zyngier wrote:
> On Sun, 03 Jan 2021 10:30:54 +0000,
> Samuel Holland <samuel@sholland.org> wrote:
>>
>> The R_INTC in the A31 and newer sun8i/sun50i SoCs is more similar to the
>> original sun4i interrupt controller than the sun7i/sun9i NMI controller.
>> It is used for two distinct purposes:
>>  - To control the trigger, latch, and mask for the NMI input pin
>>  - To provide the interrupt input for the ARISC coprocessor
>>
>> As this interrupt controller is not documented, information about it
>> comes from vendor-provided firmware blobs and from experimentation.
>>
>> Like the original sun4i interrupt controller, it has:
>>  - A VECTOR_REG at 0x00 (configurable via the BASE_ADDR_REG at 0x04)
>>  - A NMI_CTRL_REG, PENDING_REG, and ENABLE_REG as used by both the
>>    sun4i and sunxi-nmi drivers
>>  - A MASK_REG at 0x50
>>  - A RESP_REG at 0x60
>>
>> Differences from the sun4i interrupt controller appear to be:
>>  - It only has one or two registers of each kind (max 32 or 64 IRQs)
>>  - Multiplexing logic is added to support additional inputs
>>  - There is no FIQ-related logic
>>  - There is no interrupt priority logic
>>
>> In order to fulfill its two purposes, this hardware block combines four
>> types of IRQs. First, the NMI pin is routed to the "IRQ 0" input on this
>> chip, with a trigger type controlled by the NMI_CTRL_REG. The "IRQ 0
>> pending" output from this chip, if enabled, is then routed to a SPI IRQ
>> input on the GIC. In other words, bit 0 of IRQ_ENABLE_REG *does* affect
>> the NMI IRQ seen at the GIC.
>>
>> The NMI is followed by a contiguous block of 15 "direct" (my name for
>> them) IRQ inputs that are connected in parallel to both R_INTC and the
>> GIC. Or in other words, these bits of IRQ_ENABLE_REG *do not* affect the
>> IRQs seen at the GIC.
>>
>> Following the direct IRQs are the ARISC's copy of banked IRQs for shared
>> peripherals. These are not relevant to Linux. The remaining IRQs are
>> connected to a multiplexer and provide access to the first (up to) 128
>> SPIs from the ARISC. This range of SPIs overlaps with the direct IRQs.
>>
>> Finally, the global "IRQ pending" output from R_INTC, after being masked
>> by MASK_REG and RESP_REG, is connected to the "external interrupt" input
>> of the ARISC CPU. This path is also irrelevant to Linux.
> 
> An ASCII-art version of this would help a lot, and would look good in
> the driver code...

There is this diagram which I forgot to include in the cover letter:

  https://linux-sunxi.org/images/5/5c/R_INTC.png

I can try to come up with some ASCII art.

>> Because of the 1:1 correspondence between R_INTC and GIC inputs, this is
>> a perfect scenario for using a stacked irqchip driver. We want to hook
>> into enabling/disabling IRQs to add more features to the GIC
>> (specifically to allow masking the NMI and setting its trigger type),
>> but we don't need to actually handle the IRQ in this driver.
>>
>> And since R_INTC is in the always-on power domain, and its output is
>> connected directly in to the power management coprocessor, a stacked
>> irqchip driver provides a simple way to add wakeup support to this set
>> of IRQs. That is the next patch; for now, just the NMI is moved over.
>>
>> To allow access to all multiplexed IRQs, this driver requires a new
>> binding where the interrupt number matches the GIC interrupt number.
>> (This moves the NMI number from 0 to 32 or 96, depending on the SoC.)
>> For simplicity, copy the three-cell GIC binding; this disambiguates
>> interrupt 0 in the old binding (the NMI) from interrupt 0 in the new
>> binding (SPI 0) by the number of cells.
>>
>> This commit mostly reverts commit 173bda53b340 ("irqchip/sunxi-nmi:
>> Support sun6i-a31-r-intc compatible").
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  arch/arm/mach-sunxi/Kconfig     |   1 +
>>  arch/arm64/Kconfig.platforms    |   1 +
>>  drivers/irqchip/Makefile        |   1 +
>>  drivers/irqchip/irq-sun6i-r.c   | 267 ++++++++++++++++++++++++++++++++
>>  drivers/irqchip/irq-sunxi-nmi.c |  26 +---
>>  5 files changed, 273 insertions(+), 23 deletions(-)
>>  create mode 100644 drivers/irqchip/irq-sun6i-r.c
>>
> 
> [...]
> 
>> diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
>> new file mode 100644
>> index 000000000000..7490ade7b254
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-sun6i-r.c
>> @@ -0,0 +1,267 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +//
>> +// R_INTC driver for Allwinner A31 and newer SoCs
>> +//
>> +
>> +#include <linux/irq.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/*
>> + * The R_INTC manages between 32 and 64 IRQs, divided into four groups. Example
>> + * bit numbers are for the original variant in the A31:
>> + *
>> + *   Bit      0: The "External NMI" input, connected in series to a GIC SPI.
>> + *   Bits  1-15: "Direct" IRQs for ARISC peripherals, connected in parallel to
>> + *               the GIC and mapped 1:1 to SPIs numerically following the NMI.
>> + *   Bits 16-18: "Banked" IRQs for peripherals that have separate interfaces
>> + *               for the ARM CPUs and ARISC. These do not map to any GIC SPI.
>> + *   Bits 19-31: "Muxed" IRQs, each corresponding to a group of up to 8 SPIs.
>> + *               Later variants added a second PENDING and ENABLE register to
>> + *               make use of all 128 mux inputs (16 IRQ lines).
>> + *
>> + * Since the direct IRQs are inside the muxed IRQ range, they do not increase
>> + * the number of HWIRQs needed.
>> + */
>> +#define SUN6I_NR_IRQS			64
>> +#define SUN6I_NR_DIRECT_IRQS		16
>> +#define SUN6I_NR_MUX_INPUTS		128
>> +#define SUN6I_NR_HWIRQS			SUN6I_NR_MUX_INPUTS
>> +
>> +#define SUN6I_NMI_CTRL			(0x0c)
>> +#define SUN6I_IRQ_PENDING(n)		(0x10 + 4 * (n))
>> +#define SUN6I_IRQ_ENABLE(n)		(0x40 + 4 * (n))
>> +#define SUN6I_MUX_ENABLE(n)		(0xc0 + 4 * (n))
>> +
>> +#define SUN6I_NMI_IRQ_BIT		BIT(0)
>> +
>> +static void __iomem *base;
>> +static irq_hw_number_t nmi_hwirq;
>> +static u32 nmi_type;
>> +
>> +static struct irq_chip sun6i_r_intc_edge_chip;
>> +static struct irq_chip sun6i_r_intc_level_chip;
>> +
>> +static void sun6i_r_intc_nmi_ack(void)
>> +{
>> +	/*
>> +	 * The NMI channel has a latch separate from its trigger type.
>> +	 * This latch must be cleared to clear the signal to the GIC.
>> +	 */
>> +	writel_relaxed(SUN6I_NMI_IRQ_BIT, base + SUN6I_IRQ_PENDING(0));
>> +}
>> +
>> +static void sun6i_r_intc_irq_mask(struct irq_data *data)
>> +{
>> +	if (data->hwirq == nmi_hwirq)
>> +		sun6i_r_intc_nmi_ack();
> 
> I'm a bit worried by this. I can see it working with level interrupts
> (you can clear the input, and if the interrupt is asserted, it will
> fire again), but I'm worried that it will simply result in lost
> interrupts for edge signalling.

For edge interrupts, don't you want to ack as early as possible, before the
handler clears the source of the interrupt? That way if a second interrupt comes
in while you're handling the first one, you don't ack the second one without
handling it?

> It also begs the question: why would you want to clear the signal to
> the GIC on mask (or unmask)? The expectations are that a pending
> interrupt is preserved across a mask/unmask sequence.

I hadn't thought about anything masking the IRQ outside of the handler; but
you're right, this breaks that case. I'm trying to work within the constraints
of stacking the GIC driver, which assumes handle_fasteoi_irq, so it sounds like
I should switch back to handle_fasteoi_ack_irq and use .irq_ack. Or based on
your previous paragraph, maybe I'm missing some other consideration?

>> +
>> +	irq_chip_mask_parent(data);
>> +}
>> +
>> +static void sun6i_r_intc_irq_unmask(struct irq_data *data)
>> +{
>> +	if (data->hwirq == nmi_hwirq)
>> +		sun6i_r_intc_nmi_ack();
>> +
>> +	irq_chip_unmask_parent(data);
>> +}
>> +
>> +static int sun6i_r_intc_irq_set_type(struct irq_data *data, unsigned int type)
>> +{
>> +	/*
>> +	 * The GIC input labeled "External NMI" connects to bit 0 of the R_INTC
>> +	 * PENDING register, not to the pin directly. So the trigger type of the
>> +	 * GIC input does not depend on the trigger type of the NMI pin itself.
>> +	 *
>> +	 * Only the NMI channel is routed through this interrupt controller on
>> +	 * its way to the GIC. Other IRQs are routed to the GIC and R_INTC in
>> +	 * parallel; they must have a trigger type appropriate for the GIC.
>> +	 */
>> +	if (data->hwirq == nmi_hwirq) {
>> +		struct irq_chip *chip;
>> +		u32 nmi_src_type;
>> +
>> +		switch (type) {
>> +		case IRQ_TYPE_LEVEL_LOW:
>> +			chip = &sun6i_r_intc_level_chip;
>> +			nmi_src_type = 0;
> 
> Please add symbolic names for these types.

I removed them based on your previous comment:

https://lkml.org/lkml/2020/1/20/278
> It is unusual to use an enum for values that get directly programmed into the HW.

Do you want them to be specifically #defines?

>> +			break;
>> +		case IRQ_TYPE_EDGE_FALLING:
>> +			chip = &sun6i_r_intc_edge_chip;
>> +			nmi_src_type = 1;
>> +			break;
>> +		case IRQ_TYPE_LEVEL_HIGH:
>> +			chip = &sun6i_r_intc_level_chip;
>> +			nmi_src_type = 2;
>> +			break;
>> +		case IRQ_TYPE_EDGE_RISING:
>> +			chip = &sun6i_r_intc_edge_chip;
>> +			nmi_src_type = 3;
>> +			break;
>> +		default:
>> +			pr_err("%pOF: invalid trigger type %d for IRQ %d\n",
>> +			       irq_domain_get_of_node(data->domain), type,
>> +			       data->irq);
> 
> A failing set_type already triggers a kernel message.

I'll remove this.

>> +			return -EBADR;
> 
> That's a pretty odd error. I see it used in 3 drivers (including the
> one this driver replaces), but the canonical error code is -EINVAL.

I'll change it to -EINVAL.

>> +		}
>> +
>> +		irq_set_chip_handler_name_locked(data, chip,
>> +						 handle_fasteoi_irq, NULL);
>> +
>> +		writel_relaxed(nmi_src_type, base + SUN6I_NMI_CTRL);
>> +
>> +		/*
>> +		 * Use the trigger type from the OF node for the NMI's
>> +		 * R_INTC to GIC connection.
>> +		 */
>> +		type = nmi_type;
> 
> This looks wrong. The GIC only supports level-high and edge-rising, so
> half of the possible settings will result in an error. I assume the
> R_INTC has an inverter controlled by nmi_src_type, and only outputs
> something the GIC can grok.

nmi_type isn't the setting from the incoming IRQ. nmi_type is from the
interrupts property in the irqchip OF node itself. So this is a fwspec for
`interrupt-parent = <&gic>;`, i.e. already assumed to be GIC-compatible. I'm not
sure what you mean by "half of the possible settings".

Maybe I should remove the `interrupts` property and hardcode the number and type
connecting to the GIC? If I did that, I'm not quite sure whether it would be
high or rising. The output to the GIC is literally the bit in the pending
register: 1 for pending, 0 for not. Since that is after a latch (regardless of
the input trigger type) it sounds like it should be level-high, because a pulse
would have already been converted to a steady signal. Or does it depend on when
I clear the latch?

>> +	}
>> +
>> +	return irq_chip_set_type_parent(data, type);
>> +}
>> +
>> +static struct irq_chip sun6i_r_intc_edge_chip = {
>> +	.name			= "sun6i-r-intc",
>> +	.irq_mask		= sun6i_r_intc_irq_mask,
>> +	.irq_unmask		= irq_chip_unmask_parent,
>> +	.irq_eoi		= irq_chip_eoi_parent,
>> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>> +	.irq_set_type		= sun6i_r_intc_irq_set_type,
>> +	.irq_get_irqchip_state	= irq_chip_get_parent_state,
>> +	.irq_set_irqchip_state	= irq_chip_set_parent_state,
>> +	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
>> +	.flags			= IRQCHIP_SET_TYPE_MASKED,
>> +};
>> +
>> +static struct irq_chip sun6i_r_intc_level_chip = {
>> +	.name			= "sun6i-r-intc",
>> +	.irq_mask		= irq_chip_mask_parent,
>> +	.irq_unmask		= sun6i_r_intc_irq_unmask,
>> +	.irq_eoi		= irq_chip_eoi_parent,
>> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>> +	.irq_set_type		= sun6i_r_intc_irq_set_type,
>> +	.irq_get_irqchip_state	= irq_chip_get_parent_state,
>> +	.irq_set_irqchip_state	= irq_chip_set_parent_state,
>> +	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
>> +	.flags			= IRQCHIP_SET_TYPE_MASKED,
>> +};
>> +
>> +static int sun6i_r_intc_domain_translate(struct irq_domain *domain,
>> +					 struct irq_fwspec *fwspec,
>> +					 unsigned long *hwirq,
>> +					 unsigned int *type)
>> +{
>> +	/* Accept the old two-cell binding for the NMI only. */
>> +	if (fwspec->param_count == 2 && fwspec->param[0] == 0) {
>> +		*hwirq = nmi_hwirq;
>> +		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>> +		return 0;
>> +	}
>> +
>> +	/* Otherwise this binding should match the GIC SPI binding. */
>> +	if (fwspec->param_count < 3)
>> +		return -EINVAL;
>> +	if (fwspec->param[0] != GIC_SPI)
>> +		return -EINVAL;
>> +
>> +	*hwirq = fwspec->param[1];
>> +	*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
>> +
>> +	return 0;
>> +}
>> +
>> +static int sun6i_r_intc_domain_alloc(struct irq_domain *domain,
>> +				     unsigned int virq,
>> +				     unsigned int nr_irqs, void *arg)
>> +{
>> +	struct irq_fwspec *fwspec = arg;
>> +	struct irq_fwspec gic_fwspec;
>> +	unsigned long hwirq;
>> +	unsigned int type;
>> +	int i, ret;
>> +
>> +	ret = sun6i_r_intc_domain_translate(domain, fwspec, &hwirq, &type);
>> +	if (ret)
>> +		return ret;
>> +	if (hwirq + nr_irqs > SUN6I_NR_HWIRQS)
>> +		return -EINVAL;
>> +
>> +	/* Construct a GIC-compatible fwspec from this fwspec. */
>> +	gic_fwspec = (struct irq_fwspec) {
>> +		.fwnode      = domain->parent->fwnode,
>> +		.param_count = 3,
>> +		.param       = { GIC_SPI, hwirq, type },
>> +	};
>> +
>> +	for (i = 0; i < nr_irqs; ++i)
>> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
>> +					      &sun6i_r_intc_level_chip, NULL);
> 
> Unconditionally level, without looking at the requested type?

__setup_irq calls __irq_set_trigger if any trigger is provided, which calls
chip->irq_set_type unconditionally. So I don't think the chip here matters,
because .irq_set_type will be called before the IRQ is enabled anyway. Again,
maybe I'm missing something.

For non-NMI IRQs, the choice of chip doesn't matter, because this driver handles
nothing but .irq_set_wake for them (should I provide a third chip for this that
doesn't provide its own ack/mask/unmask?).

>> +
>> +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_fwspec);
>> +}
>> +
>> +static const struct irq_domain_ops sun6i_r_intc_domain_ops = {
>> +	.translate	= sun6i_r_intc_domain_translate,
>> +	.alloc		= sun6i_r_intc_domain_alloc,
>> +	.free		= irq_domain_free_irqs_common,
>> +};
>> +
>> +static void sun6i_r_intc_resume(void)
>> +{
>> +	int i;
>> +
>> +	/* Only the NMI is relevant during normal operation. */
>> +	writel_relaxed(SUN6I_NMI_IRQ_BIT, base + SUN6I_IRQ_ENABLE(0));
>> +	for (i = 1; i < BITS_TO_U32(SUN6I_NR_IRQS); ++i)
>> +		writel_relaxed(0, base + SUN6I_IRQ_ENABLE(i));
> 
> If only the NMI is relevant, why are the other interrupts enabled?
> Shouldn't this be moved to the following patch (I presume this is
> wake-up related...).

The other IRQs aren't enabled? I'm writing all zeroes to the enable register.

>> +}
>> +
>> +static int __init sun6i_r_intc_init(struct device_node *node,
>> +				    struct device_node *parent)
>> +{
>> +	struct irq_domain *domain, *parent_domain;
>> +	struct of_phandle_args parent_irq;
>> +	int ret;
>> +
>> +	/* Extract the NMI's R_INTC to GIC mapping from the OF node. */
>> +	ret = of_irq_parse_one(node, 0, &parent_irq);
>> +	if (ret)
>> +		return ret;
>> +	if (parent_irq.args_count < 3 || parent_irq.args[0] != GIC_SPI)
>> +		return -EINVAL;
>> +	nmi_hwirq = parent_irq.args[1];
>> +	nmi_type = parent_irq.args[2];
> 
> This looks a lot like the translate callback.

Yes, I could use that here.

>> +
>> +	parent_domain = irq_find_host(parent);
>> +	if (!parent_domain) {
>> +		pr_err("%pOF: Failed to obtain parent domain\n", node);
>> +		return -ENXIO;
>> +	}
>> +
>> +	base = of_io_request_and_map(node, 0, NULL);
>> +	if (IS_ERR(base)) {
>> +		pr_err("%pOF: Failed to map MMIO region\n", node);
>> +		return PTR_ERR(base);
>> +	}
>> +
>> +	sun6i_r_intc_nmi_ack();
>> +	sun6i_r_intc_resume();
>> +
>> +	domain = irq_domain_add_hierarchy(parent_domain, 0,
>> +					  SUN6I_NR_HWIRQS, node,
>> +					  &sun6i_r_intc_domain_ops, NULL);
>> +	if (!domain) {
>> +		pr_err("%pOF: Failed to allocate domain\n", node);
>> +		iounmap(base);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>> +IRQCHIP_DECLARE(sun6i_r_intc, "allwinner,sun6i-a31-r-intc", sun6i_r_intc_init);
> 
> Thanks,
> 
> 	M.
> 

Thank you for your (extremely quick, I must say) review!
Samuel
