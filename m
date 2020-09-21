Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6419D271A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 07:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIUFXX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Sep 2020 01:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUFXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 01:23:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6756BC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 22:23:22 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kKEIF-0006Fc-OC; Mon, 21 Sep 2020 07:23:15 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1kKEID-0007B6-7n; Mon, 21 Sep 2020 07:23:13 +0200
Date:   Mon, 21 Sep 2020 07:23:13 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] ARM: dts: add Plymovent M2M board
Message-ID: <20200921052313.3f6b2djdrxugjicu@pengutronix.de>
References: <20200911050941.15013-1-o.rempel@pengutronix.de>
 <20200911050941.15013-4-o.rempel@pengutronix.de>
 <20200911060312.amj2ly7b3aiiwvhv@pengutronix.de>
 <20200913044944.GN25109@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200913044944.GN25109@dragon>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:16:47 up 310 days, 20:35, 303 users,  load average: 0.08, 0.06,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 12:49:45PM +0800, Shawn Guo wrote:
> On Fri, Sep 11, 2020 at 08:03:12AM +0200, Marco Felsch wrote:
> > On 20-09-11 07:09, Oleksij Rempel wrote:
> > > Plymovent M2M is a control interface produced for the Plymovent filter
> > > systems.
> > > 
> > > Signed-off-by: David Jander <david@protonic.nl>
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > >  arch/arm/boot/dts/Makefile          |   1 +
> > >  arch/arm/boot/dts/imx6dl-plym2m.dts | 394 ++++++++++++++++++++++++++++
> > >  2 files changed, 395 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/imx6dl-plym2m.dts
> > > 
> > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > > index 4572db3fa5ae..3c3811fd8613 100644
> > > --- a/arch/arm/boot/dts/Makefile
> > > +++ b/arch/arm/boot/dts/Makefile
> > > @@ -455,6 +455,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
> > >  	imx6dl-pico-hobbit.dtb \
> > >  	imx6dl-pico-nymph.dtb \
> > >  	imx6dl-pico-pi.dtb \
> > > +	imx6dl-plym2m.dtb \
> > >  	imx6dl-prtrvt.dtb \
> > >  	imx6dl-prtvt7.dtb \
> > >  	imx6dl-rex-basic.dtb \
> > > diff --git a/arch/arm/boot/dts/imx6dl-plym2m.dts b/arch/arm/boot/dts/imx6dl-plym2m.dts
> > > new file mode 100644
> > > index 000000000000..4f96e05aa03f
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/imx6dl-plym2m.dts
> > > @@ -0,0 +1,394 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > > +// SPDX-FileCopyrightText: 2014 Protonic Holland
> > > +// SPDX-FileCopyrightText: 2020 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
> > 		^
> > @shawn: I saw a few patches adding these tags. Are they used in the near
> > future?
> 
> I'm not sure.  I haven't seen this in Documentation/process/license-rules.rst,
> nor the discussion around this.

Hi Shawn,

is it a  no go? Should I send a patch with old style copyright text?


Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
