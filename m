Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60246230C73
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 16:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgG1ObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgG1ObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:31:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59547C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:31:10 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1k0QdH-0005d1-7u; Tue, 28 Jul 2020 16:31:07 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1k0QdG-0004du-1g; Tue, 28 Jul 2020 16:31:06 +0200
Date:   Tue, 28 Jul 2020 16:31:06 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (EXT) Re: [PATCH] arm: dts: imx7: add QSPI
Message-ID: <20200728143105.ckc55z6j64e5hiun@pengutronix.de>
References: <20200728112814.14158-1-matthias.schiffer@ew.tq-group.com>
 <20200728135155.aqz3xkcwpgqmvzro@pengutronix.de>
 <8ea0b3f655b60be02384f22c0aa4dfee9d788d71.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ea0b3f655b60be02384f22c0aa4dfee9d788d71.camel@ew.tq-group.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:22:55 up 256 days,  5:41, 241 users,  load average: 0.08, 0.05,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-28 16:05, Matthias Schiffer wrote:
> On Tue, 2020-07-28 at 15:51 +0200, Marco Felsch wrote:
> > Hi Matthias,
> > 
> > thanks for the patch.
> > 
> > On 20-07-28 13:28, Matthias Schiffer wrote:
> > > In preparation for an update of the TQ-Systems TQMa7x/MBa7x DTS,
> > > add the
> > > QSPI controller to imx7s.dtsi.
> > > 
> > > Based-on-patch-by: Han Xu <han.xu@nxp.com>
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > > >
> > > ---
> > >  arch/arm/boot/dts/imx7s.dtsi | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/imx7s.dtsi
> > > b/arch/arm/boot/dts/imx7s.dtsi
> > > index 1cfaf410aa43..e45683e61593 100644
> > > --- a/arch/arm/boot/dts/imx7s.dtsi
> > > +++ b/arch/arm/boot/dts/imx7s.dtsi
> > > @@ -1162,6 +1162,19 @@
> > >  				status = "disabled";
> > >  			};
> > >  
> > > +			qspi1: spi@30bb0000 {
> > 
> > Are there more controllers and why not using "qspi@30bb0000" as node
> > name?
> 
> The vast majority of QSPI controllers use spi@ node names, qspi@ only
> appears in a single example in Documentation/devicetree/bindings/, and
> in no actual DTS(I) files.

IMHO using spi as node name is incorrect because this inherits the
assumption to connect 'normal' spi devices to these controllers. But
this is absolutly not the case since in most cases the qspi controllers
are state-machines optimized for qspi memory devices. So all dts(i)
files using spi as node name are incorrect IMHO. But we can't change
that due to the backward compability.

> There is only one controller. The label "qspi1" is chosen as this has
> been in use in the linux-imx vendor kernels for years; IMHO, switching
> to "qspi" would just cause unnecessary churn for dependent device
> trees. I have no strong opinions on this though.

Why? There is no _mainline_ imx7s devicetree using this node currently.
I would drop the number since we have only one instance.

Regards,
  Marco


> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +				compatible = "fsl,imx7d-qspi";
> > > +				reg = <0x30bb0000 0x10000>, <0x60000000
> > > 0x10000000>;
> > > +				reg-names = "QuadSPI", "QuadSPI-
> > > memory";
> > 
> > The node should begin with compatible, reg, reg-names properties.
> > Pls check the current .dtsi file for examples.
> 
> Thanks, will fix.
> 
> > 
> > > +				interrupts = <GIC_SPI 107
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX7D_QSPI_ROOT_CLK>,
> > > +					<&clks IMX7D_QSPI_ROOT_CLK>;
> > > +				clock-names = "qspi_en", "qspi";
> > > +				status = "disabled";
> > > +			};
> > > +
> > >  			sdma: sdma@30bd0000 {
> > >  				compatible = "fsl,imx7d-sdma",
> > > "fsl,imx35-sdma";
> > >  				reg = <0x30bd0000 0x10000>;
> > 
> > Regards,
> >   Marco
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
