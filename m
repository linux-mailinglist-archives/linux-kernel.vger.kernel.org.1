Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3952F7159
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 05:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbhAOECv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 23:02:51 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:47155 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732821AbhAOECu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 23:02:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id EFB6B13C9;
        Thu, 14 Jan 2021 23:02:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 14 Jan 2021 23:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=y
        CBsbbIUgUY+VKKhj2BGPNlSP1bj0827xEGAxuWLWcc=; b=PZMKBwY1gNHSQJZLo
        akElT2kCqksVQ/lvO5FtNjEqa80ytPUrCRQaJ+M2qfmMS3/auSzfKUU7YB2DqGGx
        4lifCPoB5OgWNxcMo7qDksq5gDkClgBVwJxQMQ+CM4m3fSqDIUkzTUqC5JG5IODg
        mforC12V9uYoambRWYGAId/h60EvjOR1J3mkMwsas0gD1ELV5SW9HYmE0auUcy2p
        1y42HXzcuph4RYEpr+WCoi6EQ4iz1sbOV0huJT6MNAtr2/GbZY3So+5ged0sPz7F
        GHQL49VQTB4YiHiqjk0ZgFYyiKukWnLFwMB2UfUYNuiZOEBMOltZ82axZAoiPdur
        kq0dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=yCBsbbIUgUY+VKKhj2BGPNlSP1bj0827xEGAxuWLW
        cc=; b=fJ9TtgD3Fnh1juVdSp4Xq9bBgY/dq+Ph6073aErTbKrTi/6qiB6nO0Y2y
        Xo9p/k35+qK8J5mV19NzcYr92t0JA8BiblBt1rQ1ej13xQy/DtzHd2dTPlkgXKi1
        f4ViUeCmwrHIAFYT5Hpdu6lgsytLe7gbKQS2bLM5Feic/pZMGjb12B9Dv7U1nPsF
        Pcz8WDECWBzQkwTPUr9+08vbVumQHN2qwcfUNcVaDZYzGzxKn4i4rZoNUuWCK8jY
        LJ1TbG8jXRQdvm//tTwG+MKq4llrUqzE2lsD5T2LpOmvUEn126rkaHrevOxZaP4m
        QScjLwUXMv6114mHV2AkzIOqtuIwg==
X-ME-Sender: <xms:uBMBYLW-oX5kQGOK8T7ecnzgnoCwzOEM5MPSUpyXYbasWpE334Crpg>
    <xme:uBMBYDntBknKE3rvgGDjaq4WoN7PZW2ZGbTgb9SuYIvPd2lnnu6db6LY6kTJCRxQv
    84ucjpEEjIf0BmRgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddugdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefvfhfhuffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedvtddtjeeiuddugfffveetkeffgeffgedutdfgfeekudevudekffeh
    tdefveeuvdenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:uBMBYHaPAGcLmZuQkzH2ROhXeBM5nPGL1u33CY5M6MDqp71VFQStCg>
    <xmx:uBMBYGWFzDW5ubZ-RpdflzRAj_pJaltdQ1C9uV6bxRZm6nwRm8b5dQ>
    <xmx:uBMBYFlOTXOUmnq5yx3X62kOzgGzvnAFppkgbqlam073BMPQRwKopA>
    <xmx:uxMBYLU32mh7ywdH1f50jWYmvfvkuVcO8j2RR8gktHEHR1VfyUgIBw>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B9B511080059;
        Thu, 14 Jan 2021 23:01:59 -0500 (EST)
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210112055950.21209-1-samuel@sholland.org>
 <20210112055950.21209-4-samuel@sholland.org> <87turjjkjr.wl-maz@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 03/10] irqchip/sun6i-r: Use a stacked irqchip driver
Message-ID: <495f71d0-9dbf-23d2-45a1-f27b15138bb2@sholland.org>
Date:   Thu, 14 Jan 2021 22:01:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <87turjjkjr.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 1/14/21 3:06 PM, Marc Zyngier wrote:
> Hi Samuel,
> 
> On 2021-01-12 05:59, Samuel Holland wrote:
> 
> [...]
> 
>> +static void sun6i_r_intc_ack_nmi(void)
>> +{
>> +	writel(SUN6I_NMI_BIT, base + SUN6I_IRQ_PENDING(0));
> 
> writel_relaxed()

irq_chip_unmask_parent(), which calls gic_unmask_irq(), is called
immediately after this in .irq_unmask. Since gic_unmask_irq() also uses
writel_relaxed(), the GIC write could be ordered before the write here.

I was getting occasional spurious interrupts (1 out of each 20-25) when
using a level trigger, which were resolved by switching to writel() here.

I mentioned this in the changelog, but it probably deserves a comment in
the code as well. Or maybe I should use an explicit barrier somewhere?

>> +}
>> +
>> +static void sun6i_r_intc_nmi_ack(struct irq_data *data)
>> +{
>> +	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
>> +		sun6i_r_intc_ack_nmi();
>> +	else
>> +		data->chip_data = SUN6I_NMI_NEEDS_ACK;
>> +}
>> +
>> +static void sun6i_r_intc_nmi_eoi(struct irq_data *data)
>> +{
>> +	/* For oneshot IRQs, delay the ack until the IRQ is unmasked. */
>> +	if (data->chip_data == SUN6I_NMI_NEEDS_ACK && !irqd_irq_masked(data)) 
>> {
>> +		sun6i_r_intc_ack_nmi();
>> +		data->chip_data = 0;
> 
> nit: NULL rather than 0?

NULL seemed less appropriate since I'm not using the field as a pointer,
but I don't have a strong opinion about it.

> [...]
> 
>> +static struct irq_chip sun6i_r_intc_nmi_chip = {
>> +	.name			= "sun6i-r-intc",
>> +	.irq_ack		= sun6i_r_intc_nmi_ack,
>> +	.irq_mask		= irq_chip_mask_parent,
>> +	.irq_unmask		= sun6i_r_intc_nmi_unmask,
>> +	.irq_eoi		= sun6i_r_intc_nmi_eoi,
>> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>> +	.irq_set_type		= sun6i_r_intc_nmi_set_type,
>> +	.irq_set_irqchip_state	= sun6i_r_intc_nmi_set_irqchip_state,
> 
> You probably also want to wire irq_get_irqchip_state(), while
> you're at it.

I thought if the interrupt was pending here, it would necessarily also
be pending at the GIC, so adding a separate layer would be redundant.

irq_set_vcpu_affinity(), __irq_get_irqchip_state(), and
irq_set_irqchip_state() [the functions, not the callbacks] have the
interesting property that they search up the irqdomain hierarchy for the
first irqdomain with the callback. So if all the callback would do is
defer to its parent, it doesn't need to be provided at all*.

*except in case this irqdomain has a child which calls
irq_chip_get_parent_state(), which does not look past its immediate
parent. But I did not think that case was worth worrying about.

Cheers,
Samuel

> Otherwise, looks pretty good now.
> 
> Thanks,
> 
> 	M.
> 

