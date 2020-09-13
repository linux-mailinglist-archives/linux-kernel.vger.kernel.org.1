Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBDF267DF9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 06:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgIMEt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 00:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgIMEtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 00:49:51 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AF2E20829;
        Sun, 13 Sep 2020 04:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599972590;
        bh=MUfxq507vwCBD5gGL0JdZNjDVFOjzTIhvb9PLUh7TLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6PXeR3nlIb8o4uS0FiqiJb07nXJ8cYrLx184IiEDZHh0QYZSumbf+giIzzUiB/j1
         oI4Y/3Za/Ev3vjTK3f6jUivc19OhbYky8pQBTEb1lf0yZFrLDizwyNPCJVPajFwQB1
         Y8hEorNnB7Bzs/oy4Q6EFH4U0TKT7pcFDxFkkfME=
Date:   Sun, 13 Sep 2020 12:49:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
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
Message-ID: <20200913044944.GN25109@dragon>
References: <20200911050941.15013-1-o.rempel@pengutronix.de>
 <20200911050941.15013-4-o.rempel@pengutronix.de>
 <20200911060312.amj2ly7b3aiiwvhv@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911060312.amj2ly7b3aiiwvhv@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 08:03:12AM +0200, Marco Felsch wrote:
> On 20-09-11 07:09, Oleksij Rempel wrote:
> > Plymovent M2M is a control interface produced for the Plymovent filter
> > systems.
> > 
> > Signed-off-by: David Jander <david@protonic.nl>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/Makefile          |   1 +
> >  arch/arm/boot/dts/imx6dl-plym2m.dts | 394 ++++++++++++++++++++++++++++
> >  2 files changed, 395 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx6dl-plym2m.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 4572db3fa5ae..3c3811fd8613 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -455,6 +455,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
> >  	imx6dl-pico-hobbit.dtb \
> >  	imx6dl-pico-nymph.dtb \
> >  	imx6dl-pico-pi.dtb \
> > +	imx6dl-plym2m.dtb \
> >  	imx6dl-prtrvt.dtb \
> >  	imx6dl-prtvt7.dtb \
> >  	imx6dl-rex-basic.dtb \
> > diff --git a/arch/arm/boot/dts/imx6dl-plym2m.dts b/arch/arm/boot/dts/imx6dl-plym2m.dts
> > new file mode 100644
> > index 000000000000..4f96e05aa03f
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6dl-plym2m.dts
> > @@ -0,0 +1,394 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +// SPDX-FileCopyrightText: 2014 Protonic Holland
> > +// SPDX-FileCopyrightText: 2020 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
> 		^
> @shawn: I saw a few patches adding these tags. Are they used in the near
> future?

I'm not sure.  I haven't seen this in Documentation/process/license-rules.rst,
nor the discussion around this.

Shawn
