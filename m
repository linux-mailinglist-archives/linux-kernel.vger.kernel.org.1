Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDA82FF0F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbhAUP6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:58:06 -0500
Received: from foss.arm.com ([217.140.110.172]:40052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbhAUP4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:56:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5ED411D4;
        Thu, 21 Jan 2021 07:55:16 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F305D3F68F;
        Thu, 21 Jan 2021 07:55:14 -0800 (PST)
Date:   Thu, 21 Jan 2021 15:54:39 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 09/21] mfd: axp20x: Allow AXP chips without interrupt
 lines
Message-ID: <20210121155439.79f4051c@slackpad.fritz.box>
In-Reply-To: <b3d1cc46-3311-ba1a-f71a-37096ed1bfa8@sholland.org>
References: <20210118020848.11721-1-andre.przywara@arm.com>
        <20210118020848.11721-10-andre.przywara@arm.com>
        <b3d1cc46-3311-ba1a-f71a-37096ed1bfa8@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021 21:37:22 -0600
Samuel Holland <samuel@sholland.org> wrote:

Hi Samuel,

thanks for your input!

> On 1/17/21 8:08 PM, Andre Przywara wrote:
> > Currently the AXP chip requires to have its IRQ line connected to some
> > interrupt controller, and will fail probing when this is not the case.
> > 
> > On a new Allwinner SoC (H616) there is no NMI pin anymore, so the
> > interrupt functionality of the AXP chip is simply not available.
> > 
> > Check whether the DT describes the AXP chip as an interrupt controller
> > before trying to register the irqchip, to avoid probe failures on
> > setups without an interrupt.  
> 
> The AXP305 has an IRQ pin. It is still an interrupt controller, even if
> its output is not connected anywhere. And even though the NMI pin on the
> H616 is gone, the PMIC IRQ line could be connected to a GPIO. So it is
> not appropriate to remove "interrupt-controller".

That's a fair point.
 
> Per the binding, both "interrupts" and "interrupt-controller" are
> required properties. It would make more sense to make "interrupts"
> optional. Either way, you need to update the binding.

I agree.

So I will replace the explicit check for the interrupt-controller
property with a check for axp20x->irq being not 0 (which is apparently
the right check for this, according to my research).

And also adjust the binding to make "interrupts" optional.
 
> Though I'm concerned about how this may affect drivers for regmap cells
> which use interrupts (such as axp20x-pek). If the irqchip is not
> registered, requesting those interrupts will fail. While I don't
> currently know of any boards that have the AXP305 power key wired up, it
> prevents us from modelling the hardware correctly and supporting that
> configuration.

Good point! Indeed axp20x_pek_probe() crashes with a NULL pointer
dereference. I think this device is unconditionally tied to the AXP
drivers, and this is probably fine, as it looks trivial to check the
regmap_irqc pointer before passing it on to regmap_irq_get_virq(),
bailing out if this is NULL.

Will send the patch shortly, then update this patch here as well.

And I guess the outcome (power button input device not available) is
reasonable as well. The hardware power button feature (off after 6s)
would work nevertheless. If board vendors expect more functionality
from the button, they should connect the AXP IRQ pin to a GPIO.

Cheers,
Andre


> 
> Cheers,
> Samuel
> 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/mfd/axp20x.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index aa59496e4376..a52595c49d40 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -959,12 +959,17 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
> >  				     AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE);
> >  	}
> >  
> > -	ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
> > -			  IRQF_ONESHOT | IRQF_SHARED | axp20x->irq_flags,
> > -			   -1, axp20x->regmap_irq_chip, &axp20x->regmap_irqc);
> > -	if (ret) {
> > -		dev_err(axp20x->dev, "failed to add irq chip: %d\n", ret);
> > -		return ret;
> > +	if (!axp20x->dev->of_node ||
> > +	    of_property_read_bool(axp20x->dev->of_node, "interrupt-controller")) {
> > +		ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
> > +				IRQF_ONESHOT | IRQF_SHARED | axp20x->irq_flags,
> > +				-1, axp20x->regmap_irq_chip,
> > +				&axp20x->regmap_irqc);
> > +		if (ret) {
> > +			dev_err(axp20x->dev, "failed to add irq chip: %d\n",
> > +				ret);
> > +			return ret;
> > +		}
> >  	}
> >  
> >  	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
> >   
> 

