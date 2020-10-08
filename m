Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CED52879A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 18:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgJHQCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 12:02:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:43352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgJHQCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 12:02:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0E993ABF4;
        Thu,  8 Oct 2020 16:02:22 +0000 (UTC)
Date:   Thu, 8 Oct 2020 18:02:19 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: h2+: Enable optional SPI flash on
 Orange Pi Zero board
Message-ID: <20201008160219.GM29778@kitsune.suse.cz>
References: <20200929083025.2089-1-msuchanek@suse.de>
 <20201008151315.v3geykbs6musl4wq@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008151315.v3geykbs6musl4wq@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 05:13:15PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Sep 29, 2020 at 10:30:25AM +0200, Michal Suchanek wrote:
> > The flash is present on all new boards and users went out of their way
> > to add it on the old ones.
> > 
> > Enabling it makes a more reasonable default.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > index f19ed981da9d..061d295bbba7 100644
> > --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > @@ -163,8 +163,8 @@ &ohci1 {
> >  };
> >  
> >  &spi0 {
> > -	/* Disable SPI NOR by default: it optional on Orange Pi Zero boards */
> > -	status = "disabled";
> > +	/* Enable optional SPI NOR by default */
> > +	status = "okay";
> >  
> >  	flash@0 {
> >  		#address-cells = <1>;
> 
> Unfortunately, it's optional, so there's really no reason to enable it
> all the time. If it's troublesome to users, then the distros or vendors
> should make the changes necessary to the hardware, bootloader or their
> documentation to make it easier for those users.

I don't understand the reasoning. Why must it be disabled when optional?

By the same reasoning there is no reason to disable it all the time.
Also the boards that do not have the flsh are either broken or obsolete.
So most of the time enabling the flash chip is the right thing.

Or do we need two DTBs like sun8i-h2-plus-orangepi-zero.dts and
sun8i-h2-plus-orangepi-zero-no-spi-nor.dts

There is no way to change the setting on a runnig system, the pins are
routed to the flash pads anyway so are not usable for anything else. The
only thing that happens on boards that do not have the flash is kernel
probing it and complaining that the ID 00 00 00 is not valid SPI NOR
flash memory ID.

Thanks

Michal

Thanks

Michal
