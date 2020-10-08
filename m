Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D88287B1D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgJHRkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:40:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:50500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbgJHRku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:40:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36769ACD8;
        Thu,  8 Oct 2020 17:40:47 +0000 (UTC)
Date:   Thu, 8 Oct 2020 19:40:44 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: h2+: Enable optional SPI flash on
 Orange Pi Zero board
Message-ID: <20201008174044.GN29778@kitsune.suse.cz>
References: <20200929083025.2089-1-msuchanek@suse.de>
 <20201008151315.v3geykbs6musl4wq@gilmour.lan>
 <20201008160219.GM29778@kitsune.suse.cz>
 <20201008171454.qixrcjmhzko766su@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201008171454.qixrcjmhzko766su@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 07:14:54PM +0200, Maxime Ripard wrote:
> On Thu, Oct 08, 2020 at 06:02:19PM +0200, Michal Suchánek wrote:
> > On Thu, Oct 08, 2020 at 05:13:15PM +0200, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > On Tue, Sep 29, 2020 at 10:30:25AM +0200, Michal Suchanek wrote:
> > > > The flash is present on all new boards and users went out of their way
> > > > to add it on the old ones.
> > > > 
> > > > Enabling it makes a more reasonable default.
> > > > 
> > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > ---
> > > >  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > > > index f19ed981da9d..061d295bbba7 100644
> > > > --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > > > +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > > > @@ -163,8 +163,8 @@ &ohci1 {
> > > >  };
> > > >  
> > > >  &spi0 {
> > > > -	/* Disable SPI NOR by default: it optional on Orange Pi Zero boards */
> > > > -	status = "disabled";
> > > > +	/* Enable optional SPI NOR by default */
> > > > +	status = "okay";
> > > >  
> > > >  	flash@0 {
> > > >  		#address-cells = <1>;
> > > 
> > > Unfortunately, it's optional, so there's really no reason to enable it
> > > all the time. If it's troublesome to users, then the distros or vendors
> > > should make the changes necessary to the hardware, bootloader or their
> > > documentation to make it easier for those users.
> > 
> > I don't understand the reasoning. Why must it be disabled when optional?
> 
> Think about it the other way around. If we enable everything that is
> optional, we're going to have a multitude of conflicts everywhere, and
> without a clear decision as to who is "best" and thus how we should
> resolve it.
Conflicts with what?

The SPI0 bus is routed the the flash memory pads. Either there is the
flash mounted or there are free pads. Nothing else on the board uses
these pins. You could possily solder something else there but that's
definitely not part of the board.
> 
> On a separate platform, recently I've been using a VGA bridge for the
> RaspberryPi that takes the UART pins as well. It's definitely optional,
> should I enable it by default? At the same time, enabling by default the
> UART is just as arbitrary and will result in people using the VGA bridge
> to complain about their regression (rightfully so).

That's completely different situation. That bridge is probably not even
part of the board.

> 
> So, really, if it's optional, it means that it not always there. If it's
> not always there, it's meant to be supported by an overlay.
> 
> > By the same reasoning there is no reason to disable it all the time.
> 
> I'm not sure I follow you here. The least common denominator is that
> it's not there, so it's not enabled.

You have two options - have a flash mounted or not. You ask why enable
flash when it is not always present. By the same logic I can ask why
disable it when it is not always absent. Enabling is the more useful
option because it degrades gracefully in the case it is not present. It
does not work the other way around.

> 
> > Also the boards that do not have the flsh are either broken or
> > obsolete.
> 
> Making general statements without arguments doesn't really make it true
> though. Plenty of boards to have flash and are neither broken nor
> obsolete.
Cannot parse this.
> 
> > So most of the time enabling the flash chip is the right thing.
> > 
> > Or do we need two DTBs like sun8i-h2-plus-orangepi-zero.dts and
> > sun8i-h2-plus-orangepi-zero-no-spi-nor.dts
> 
> No, you need sun8i-h2-plus-orangepi-zero plus an overlay for the
> SPI-NOR.
The flash is part of the board. There is no need for an overlay. And
overlays don't exist.

> 
> > There is no way to change the setting on a runnig system, the pins are
> > routed to the flash pads anyway so are not usable for anything else. The
> > only thing that happens on boards that do not have the flash is kernel
> > probing it and complaining that the ID 00 00 00 is not valid SPI NOR
> > flash memory ID.
> 
> We have people reporting bugs about completely innocuous error messages
> without any side effects already. An error about a missing or broken
> storage device will surely raise some eyebrows.

I am sure poeple who have an old Orange Pi Zero know that it is missing
the flash memory.

Thanks

Michal
