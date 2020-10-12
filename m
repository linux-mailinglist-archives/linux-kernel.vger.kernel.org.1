Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C56928BE98
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390741AbgJLRDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:03:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:59454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390681AbgJLRDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:03:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99DCDAC6C;
        Mon, 12 Oct 2020 17:03:27 +0000 (UTC)
Date:   Mon, 12 Oct 2020 19:03:25 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: h2+: Enable optional SPI flash on
 Orange Pi Zero board
Message-ID: <20201012170325.GS29778@kitsune.suse.cz>
References: <20200929083025.2089-1-msuchanek@suse.de>
 <20201008151315.v3geykbs6musl4wq@gilmour.lan>
 <20201008160219.GM29778@kitsune.suse.cz>
 <20201008171454.qixrcjmhzko766su@gilmour.lan>
 <20201008174044.GN29778@kitsune.suse.cz>
 <20201012153507.ft77jgaprpendpne@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201012153507.ft77jgaprpendpne@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 05:35:07PM +0200, Maxime Ripard wrote:
> On Thu, Oct 08, 2020 at 07:40:44PM +0200, Michal Suchánek wrote:
> > On Thu, Oct 08, 2020 at 07:14:54PM +0200, Maxime Ripard wrote:
> > > On Thu, Oct 08, 2020 at 06:02:19PM +0200, Michal Suchánek wrote:
> > > > On Thu, Oct 08, 2020 at 05:13:15PM +0200, Maxime Ripard wrote:
> > > > > Hi,
> > > > > 
> > > > > On Tue, Sep 29, 2020 at 10:30:25AM +0200, Michal Suchanek wrote:
> > > > > > The flash is present on all new boards and users went out of their way
> > > > > > to add it on the old ones.
> > > > > > 
> > > > > > Enabling it makes a more reasonable default.
> > > > > > 
> > > > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > > > ---
> > > > > >  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > > > > > index f19ed981da9d..061d295bbba7 100644
> > > > > > --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > > > > > +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > > > > > @@ -163,8 +163,8 @@ &ohci1 {
> > > > > >  };
> > > > > >  
> > > > > >  &spi0 {
> > > > > > -	/* Disable SPI NOR by default: it optional on Orange Pi Zero boards */
> > > > > > -	status = "disabled";
> > > > > > +	/* Enable optional SPI NOR by default */
> > > > > > +	status = "okay";
> > > > > >  
> > > > > >  	flash@0 {
> > > > > >  		#address-cells = <1>;
> > > > > 
> > > > > Unfortunately, it's optional, so there's really no reason to enable it
> > > > > all the time. If it's troublesome to users, then the distros or vendors
> > > > > should make the changes necessary to the hardware, bootloader or their
> > > > > documentation to make it easier for those users.
> > > > 
> > > > I don't understand the reasoning. Why must it be disabled when optional?
> > > 
> > > Think about it the other way around. If we enable everything that is
> > > optional, we're going to have a multitude of conflicts everywhere, and
> > > without a clear decision as to who is "best" and thus how we should
> > > resolve it.
> > Conflicts with what?
> > 
> > The SPI0 bus is routed the the flash memory pads. Either there is the
> > flash mounted or there are free pads. Nothing else on the board uses
> > these pins. You could possily solder something else there but that's
> > definitely not part of the board.
> > > 
> > > On a separate platform, recently I've been using a VGA bridge for the
> > > RaspberryPi that takes the UART pins as well. It's definitely optional,
> > > should I enable it by default? At the same time, enabling by default the
> > > UART is just as arbitrary and will result in people using the VGA bridge
> > > to complain about their regression (rightfully so).
> > 
> > That's completely different situation. That bridge is probably not even
> > part of the board.
> > 
> > > 
> > > So, really, if it's optional, it means that it not always there. If it's
> > > not always there, it's meant to be supported by an overlay.
> > > 
> > > > By the same reasoning there is no reason to disable it all the time.
> > > 
> > > I'm not sure I follow you here. The least common denominator is that
> > > it's not there, so it's not enabled.
> > 
> > You have two options - have a flash mounted or not. You ask why enable
> > flash when it is not always present. By the same logic I can ask why
> > disable it when it is not always absent. Enabling is the more useful
> > option because it degrades gracefully in the case it is not present. It
> > does not work the other way around.
> > 
> > > 
> > > > Also the boards that do not have the flsh are either broken or
> > > > obsolete.
> > > 
> > > Making general statements without arguments doesn't really make it true
> > > though. Plenty of boards to have flash and are neither broken nor
> > > obsolete.
> >
> > Cannot parse this.
> 
> "Plenty of boards do not have flash and are neither broken nor obsolete"
The product description of Orange Pi Zero clearly states there is a
flash memory: http://www.orangepi.org/orangepizero/

When you order an Orange Pi Zero it comes with a flash memory. That is
not what the device tree describes. The device tree is supposed to
descrbe the hardware. If it does not it is broken.

If you have a board without a flash memory I do not know what it is but
it is clearly not an Orange Pi Zero because it comes with one.
> 
> > > 
> > > > So most of the time enabling the flash chip is the right thing.
> > > > 
> > > > Or do we need two DTBs like sun8i-h2-plus-orangepi-zero.dts and
> > > > sun8i-h2-plus-orangepi-zero-no-spi-nor.dts
> > > 
> > > No, you need sun8i-h2-plus-orangepi-zero plus an overlay for the
> > > SPI-NOR.
> >
> > The flash is part of the board.
> 
> Not always though.
No, it always comes with one. You must be speaking of a different board
then.
> 
> > There is no need for an overlay.
> 
> Overlays are here to deal with the "not always though" situation...
There are no overlays in the kernel. Please show me tho code in the
kernel for handling overlays.
> 
> > And overlays don't exist.
> 
> If you want to believe that, please go ahead.
> 
> But there's support for it in libfdt, and you can either apply them
> directly through the U-Boot command line, or bundle them in a FIT image.
And as you state the user ususally does not know which version of the Pi
they have. How are they supposed to know that they should apply an
overlay through u-boot commandline (if they even get to see one) or
bundle them in a FIT image (if they are even using a FIT image).

I am doing neither. I boot a standard distribution kernel from EFI grub.

I understand that it would be nice to support two almost identical
boards with a single device tree. However, if an error about missing
flash memory is not acceptable, and the kernel does not support enabling
the flash memory dynamically we need two device trees then.
> 
> Plenty of support for something that doesn't exist.
> 
> > > 
> > > > There is no way to change the setting on a runnig system, the pins are
> > > > routed to the flash pads anyway so are not usable for anything else. The
> > > > only thing that happens on boards that do not have the flash is kernel
> > > > probing it and complaining that the ID 00 00 00 is not valid SPI NOR
> > > > flash memory ID.
> > > 
> > > We have people reporting bugs about completely innocuous error messages
> > > without any side effects already. An error about a missing or broken
> > > storage device will surely raise some eyebrows.
> > 
> > I am sure poeple who have an old Orange Pi Zero know that it is missing
> > the flash memory.
> 
> Do you really expect every single user on an Orange Pi Zero to know
> exactly the revision it has and whether or not it's been bundled with a
> SPI flash if it's the older ones (with the proper definition of older
> ones)?

And how is the user supposed to tell when the flash is disabled and thre
is no way to enable it?

Thanks

Michal
