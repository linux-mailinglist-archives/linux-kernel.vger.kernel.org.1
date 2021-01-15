Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743002F715E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 05:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbhAOEFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 23:05:23 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59341 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729152AbhAOEFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 23:05:23 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6868F15AD;
        Thu, 14 Jan 2021 23:04:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 14 Jan 2021 23:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=m
        iv0kQgf9qxy5Btjbf60hP7klLvl7l2WrF4uzxnahAM=; b=kZSMnFmxuSthPoeAc
        1VcoCw+oPGvL8reaPBQaCogrsEGzHViOSuT8oEaelv4eYcI891LzgD8xauJeOA7/
        zSlNDc++z6AvK0zIwiLPl2Ky9DHHxgGqxtWKHXB2+l2YMcHYQ+ReKjXFedvEDKAv
        gVaTBWOwCa6pdEhRop4unAyoH+nsliXH8LKVNHHkDm77xX3VbXKXQVxT2LWlbOZV
        fa9lL4DoCvmxEWoaY/wqF3rmE0QtWqvsB9kt4NW7MQdJvgq7Tom9lJQvlCHxQiFc
        GW73PgD+i9OxN0I5177SgPZpV3iNzGJcTehyBmJ5gGkkDMNgL3vdzM3NzKskZA9X
        evelQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=miv0kQgf9qxy5Btjbf60hP7klLvl7l2WrF4uzxnah
        AM=; b=bweC5aEdpdGd2rnEfWWR3+5PuinhEfnt3fULSY6h+4+xT5Rre13jHyQZJ
        FSFST3yfvNOUXfNKErDHXh5El7X2L3J5aTymDSe/+8iNnhZKHg7LHTN+MZ0U0bYm
        yDgNxui33102hnntDUcaucgP/P2HY9AyKsXT4sQsy+2kv+iVoxHSwDiokyGfo4KJ
        3lbwLSQQFj8TC3eb8IXdt+yJ3UX+oollxP3J+mlR7n6y10n6tq9YYXoDuu7Qugaq
        MoySde2Ed9VgqMzvHznPim7uNPJg7PjCdYnbJnPP6t3uKwlvf0SbJLe5hIgIjMpq
        HUESdb2tZFbypb3hP1/SFI456FL7Q==
X-ME-Sender: <xms:PxQBYLRiZ-4-K2VE6edTUj-jHFoNGc4KmaRGUb9NQtSzqAh8YynMKw>
    <xme:PxQBYMzamMITshENZ0TBUVTgHEQnJayc9OzpNi3QQDVbaLzPLzL19k-vLj-zeL8-U
    QJCkrlO0ZAqiheYzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddugdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:PxQBYA3JGMP1OG2BLIBYswodlqiOmFrtWQwrl-lqrTbQWLdBK1ssLQ>
    <xmx:PxQBYLC0DjkQ_o5w1tfYGf8WcGkDp1NlxpdHfN6cZCfRyI8qwkrigg>
    <xmx:PxQBYEjTHPBTPT03vKdb03gBQwORbnJxMLk83s0IFKmj_N4weQ4xwA>
    <xmx:QBQBYAiwXjEHTK_RF-oEsBSr4bsfTqj6WQOdTy5PKV62oa1x5ZgjZQ>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 756711080057;
        Thu, 14 Jan 2021 23:04:15 -0500 (EST)
Subject: Re: [PATCH v4 04/10] irqchip/sun6i-r: Add wakeup support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210112055950.21209-1-samuel@sholland.org>
 <20210112055950.21209-5-samuel@sholland.org> <87sg73jirb.wl-maz@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <bb3749f1-9ebe-1b70-ba79-d72a9c04a834@sholland.org>
Date:   Thu, 14 Jan 2021 22:04:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <87sg73jirb.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/21 3:44 PM, Marc Zyngier wrote:
> On Tue, 12 Jan 2021 05:59:44 +0000,
> Samuel Holland <samuel@sholland.org> wrote:
>>
>> Maintain bitmaps of wake-enabled IRQs and mux inputs, and program them
>> to the hardware during the syscore phase of suspend and shutdown. Then
>> restore the original set of enabled IRQs (only the NMI) during resume.
>>
>> This serves two purposes. First, it lets power management firmware
>> running on the ARISC coprocessor know which wakeup sources Linux wants
>> to have enabled. That way, it can avoid turning them off when it shuts
>> down the remainder of the clock tree. Second, it preconfigures the
>> coprocessor's interrupt controller, so the firmware's wakeup logic
>> is as simple as waiting for an interrupt to arrive.
>>
>> The suspend/resume logic is not conditional on PM_SLEEP because it is
>> identical to the init/shutdown logic. Wake IRQs may be enabled during
>> shutdown to allow powering the board back on. As an example, see
>> commit a5c5e50cce9d ("Input: gpio-keys - add shutdown callback").
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  drivers/irqchip/irq-sun6i-r.c | 107 ++++++++++++++++++++++++++++++++--
>>  1 file changed, 101 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
>> index d04d067423f4..a1b58c98d6ca 100644
>> --- a/drivers/irqchip/irq-sun6i-r.c
>> +++ b/drivers/irqchip/irq-sun6i-r.c
>> @@ -39,6 +39,7 @@
>>   * set of 128 mux bits. This requires a second set of top-level registers.
>>   */
>>  
>> +#include <linux/bitmap.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/irq.h>
>>  #include <linux/irqchip.h>
>> @@ -46,6 +47,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_irq.h>
>> +#include <linux/syscore_ops.h>
>>  
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  
>> @@ -67,8 +69,17 @@
>>  #define SUN6I_NR_DIRECT_IRQS		16
>>  #define SUN6I_NR_MUX_BITS		128
>>  
>> +struct sun6i_r_intc_variant {
>> +	u32		first_mux_irq;
>> +	u32		nr_mux_irqs;
>> +	u32		mux_valid[BITS_TO_U32(SUN6I_NR_MUX_BITS)];
>> +};
>> +
>>  static void __iomem *base;
>>  static irq_hw_number_t nmi_hwirq;
>> +static DECLARE_BITMAP(wake_irq_enabled, SUN6I_NR_TOP_LEVEL_IRQS);
>> +static DECLARE_BITMAP(wake_mux_enabled, SUN6I_NR_MUX_BITS);
>> +static DECLARE_BITMAP(wake_mux_valid, SUN6I_NR_MUX_BITS);
>>  
>>  static void sun6i_r_intc_ack_nmi(void)
>>  {
>> @@ -145,6 +156,21 @@ static int sun6i_r_intc_nmi_set_irqchip_state(struct irq_data *data,
>>  	return irq_chip_set_parent_state(data, which, state);
>>  }
>>  
>> +static int sun6i_r_intc_irq_set_wake(struct irq_data *data, unsigned int on)
>> +{
>> +	unsigned long offset_from_nmi = data->hwirq - nmi_hwirq;
>> +
>> +	if (offset_from_nmi < SUN6I_NR_DIRECT_IRQS)
>> +		assign_bit(offset_from_nmi, wake_irq_enabled, on);
>> +	else if (test_bit(data->hwirq, wake_mux_valid))
>> +		assign_bit(data->hwirq, wake_mux_enabled, on);
>> +	else
>> +		/* Not wakeup capable. */
>> +		return -EPERM;
>> +
>> +	return 0;
>> +}
>> +
>>  static struct irq_chip sun6i_r_intc_nmi_chip = {
>>  	.name			= "sun6i-r-intc",
>>  	.irq_ack		= sun6i_r_intc_nmi_ack,
>> @@ -154,8 +180,19 @@ static struct irq_chip sun6i_r_intc_nmi_chip = {
>>  	.irq_set_affinity	= irq_chip_set_affinity_parent,
>>  	.irq_set_type		= sun6i_r_intc_nmi_set_type,
>>  	.irq_set_irqchip_state	= sun6i_r_intc_nmi_set_irqchip_state,
>> -	.flags			= IRQCHIP_SET_TYPE_MASKED |
>> -				  IRQCHIP_SKIP_SET_WAKE,
>> +	.irq_set_wake		= sun6i_r_intc_irq_set_wake,
>> +	.flags			= IRQCHIP_SET_TYPE_MASKED,
>> +};
>> +
>> +static struct irq_chip sun6i_r_intc_wakeup_chip = {
>> +	.name			= "sun6i-r-intc",
>> +	.irq_mask		= irq_chip_mask_parent,
>> +	.irq_unmask		= irq_chip_unmask_parent,
>> +	.irq_eoi		= irq_chip_eoi_parent,
>> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>> +	.irq_set_type		= irq_chip_set_type_parent,
>> +	.irq_set_wake		= sun6i_r_intc_irq_set_wake,
>> +	.flags			= IRQCHIP_SET_TYPE_MASKED,
> 
> Worth implementing irq_get/set_irqchip_state() using the _parent
> helper, I guess.

This is the same situation as the previous patch. Assuming it is safe to
rely on the behavior of the top-level functions, adding the callbacks
here would be redundant.

Cheers,
Samuel

> Thanks,
> 
> 	M.
> 

