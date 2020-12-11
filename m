Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC662D7527
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 13:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395307AbgLKL7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 06:59:22 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42671 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgLKL6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 06:58:47 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A947CC000D;
        Fri, 11 Dec 2020 11:58:01 +0000 (UTC)
Date:   Fri, 11 Dec 2020 12:58:00 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] drivers: soc: atmel: Avoid calling at91_soc_init on non
 AT91 SoCs
Message-ID: <20201211115800.GG1781038@piout.net>
References: <20201211103143.1332302-1-sudeep.holla@arm.com>
 <20201211114515.GF1781038@piout.net>
 <20201211115055.acoezgrwh45hw6is@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211115055.acoezgrwh45hw6is@bogus>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2020 11:50:55+0000, Sudeep Holla wrote:
> On Fri, Dec 11, 2020 at 12:45:15PM +0100, Alexandre Belloni wrote:
> > Hello,
> > 
> > On 11/12/2020 10:31:43+0000, Sudeep Holla wrote:
> > > Since at91_soc_init is called unconditionally from atmel_soc_device_init,
> > > we get the following warning on all non AT91 SoCs:
> > > 	" AT91: Could not find identification node"
> > > 
> > > Fix the same by filtering with allowed AT91 SoC list.
> > > 
> > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/soc/atmel/soc.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
> > > index c4472b68b7c2..ba9fc07cd91c 100644
> > > --- a/drivers/soc/atmel/soc.c
> > > +++ b/drivers/soc/atmel/soc.c
> > > @@ -271,8 +271,19 @@ struct soc_device * __init at91_soc_init(const struct at91_soc *socs)
> > >  	return soc_dev;
> > >  }
> > >  
> > > +static const struct of_device_id at91_soc_allowed_list[] __initconst = {
> > > +	{ .compatible = "atmel,at91rm9200", },
> > > +	{ .compatible = "atmel,at91sam9260", },
> > > +	{ .compatible = "atmel,sama5d2", },
> > 
> > This is a very small subset of the supported SoCs. a proper list would
> > be:
> > 
> > atmel,at91rm9200
> > atmel,at91sam9
> > atmel,sama5
> > atmel,samv7
> > 
> 
> Sure I can update it but the existing functions at91_get_cidr_exid_from_chipid
> and at91_get_cidr_exid_from_dbgu check for following 3 compatibles and bail
> out if not found:
> "atmel,at91rm9200-dbgu"
> "atmel,at91sam9260-dbgu"
> "atmel,sama5d2-chipid"
> 
> Quick check on DTS upstream suggested only 3 platforms, hence the choice.
> 

No, atmel,at91sam9260-dbgu is used on most platforms:
$ git grep atmel,at91sam9260-dbgu arch/arm/boot/dts/
arch/arm/boot/dts/at91sam9260.dtsi:                             compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
arch/arm/boot/dts/at91sam9261.dtsi:                             compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
arch/arm/boot/dts/at91sam9263.dtsi:                             compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
arch/arm/boot/dts/at91sam9g45.dtsi:                             compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
arch/arm/boot/dts/at91sam9n12.dtsi:                             compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
arch/arm/boot/dts/at91sam9rl.dtsi:                              compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
arch/arm/boot/dts/at91sam9x5.dtsi:                              compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
arch/arm/boot/dts/sam9x60.dtsi:                         compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
arch/arm/boot/dts/sama5d3.dtsi:                         compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
arch/arm/boot/dts/sama5d4.dtsi:                         compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";


> -- 
> Regards,
> Sudeep

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
