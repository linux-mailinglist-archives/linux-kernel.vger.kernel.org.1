Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81662D7565
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 13:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405913AbgLKMPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 07:15:40 -0500
Received: from foss.arm.com ([217.140.110.172]:53508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395393AbgLKMOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:14:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F7F11FB;
        Fri, 11 Dec 2020 04:14:09 -0800 (PST)
Received: from bogus (unknown [10.57.54.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A2613F68F;
        Fri, 11 Dec 2020 04:14:07 -0800 (PST)
Date:   Fri, 11 Dec 2020 12:14:05 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] drivers: soc: atmel: Avoid calling at91_soc_init on non
 AT91 SoCs
Message-ID: <20201211121405.xhk7kz3khbut7uuw@bogus>
References: <20201211103143.1332302-1-sudeep.holla@arm.com>
 <20201211114515.GF1781038@piout.net>
 <20201211115055.acoezgrwh45hw6is@bogus>
 <20201211115800.GG1781038@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211115800.GG1781038@piout.net>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 12:58:00PM +0100, Alexandre Belloni wrote:
> On 11/12/2020 11:50:55+0000, Sudeep Holla wrote:
> > On Fri, Dec 11, 2020 at 12:45:15PM +0100, Alexandre Belloni wrote:
> > > Hello,
> > > 
> > > On 11/12/2020 10:31:43+0000, Sudeep Holla wrote:
> > > > Since at91_soc_init is called unconditionally from atmel_soc_device_init,
> > > > we get the following warning on all non AT91 SoCs:
> > > > 	" AT91: Could not find identification node"
> > > > 
> > > > Fix the same by filtering with allowed AT91 SoC list.
> > > > 
> > > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >  drivers/soc/atmel/soc.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > > 
> > > > diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
> > > > index c4472b68b7c2..ba9fc07cd91c 100644
> > > > --- a/drivers/soc/atmel/soc.c
> > > > +++ b/drivers/soc/atmel/soc.c
> > > > @@ -271,8 +271,19 @@ struct soc_device * __init at91_soc_init(const struct at91_soc *socs)
> > > >  	return soc_dev;
> > > >  }
> > > >  
> > > > +static const struct of_device_id at91_soc_allowed_list[] __initconst = {
> > > > +	{ .compatible = "atmel,at91rm9200", },
> > > > +	{ .compatible = "atmel,at91sam9260", },
> > > > +	{ .compatible = "atmel,sama5d2", },
> > > 
> > > This is a very small subset of the supported SoCs. a proper list would
> > > be:
> > > 
> > > atmel,at91rm9200
> > > atmel,at91sam9
> > > atmel,sama5
> > > atmel,samv7
> > > 
> > 
> > Sure I can update it but the existing functions at91_get_cidr_exid_from_chipid
> > and at91_get_cidr_exid_from_dbgu check for following 3 compatibles and bail
> > out if not found:
> > "atmel,at91rm9200-dbgu"
> > "atmel,at91sam9260-dbgu"
> > "atmel,sama5d2-chipid"
> > 
> > Quick check on DTS upstream suggested only 3 platforms, hence the choice.
> > 
> 
> No, atmel,at91sam9260-dbgu is used on most platforms:
> $ git grep atmel,at91sam9260-dbgu arch/arm/boot/dts/
> arch/arm/boot/dts/at91sam9260.dtsi:                             compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> arch/arm/boot/dts/at91sam9261.dtsi:                             compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> arch/arm/boot/dts/at91sam9263.dtsi:                             compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> arch/arm/boot/dts/at91sam9g45.dtsi:                             compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> arch/arm/boot/dts/at91sam9n12.dtsi:                             compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> arch/arm/boot/dts/at91sam9rl.dtsi:                              compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> arch/arm/boot/dts/at91sam9x5.dtsi:                              compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> arch/arm/boot/dts/sam9x60.dtsi:                         compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> arch/arm/boot/dts/sama5d3.dtsi:                         compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> arch/arm/boot/dts/sama5d4.dtsi:                         compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> 

Ah, I must have messed up my grep then for sure. Also not familiar with
AT91 series of platforms. I will respin with the list you suggested. Thanks!

--
Regards,
Sudeep
