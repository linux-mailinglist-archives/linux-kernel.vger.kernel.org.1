Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9256A20794E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405019AbgFXQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 12:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404287AbgFXQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:39:55 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A619C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:39:55 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B99702A8;
        Wed, 24 Jun 2020 18:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593016792;
        bh=9i2y89qZaWWu2JMyrE5PZsLgt57uLSAGayseCRUjOxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3zfn7ZhsQBxOEupMDREq9H9diTcc8MGjWXij5MbPCSczLcG7rou6Fsnk8ADdXUys
         9Ele22N0CnfxgKXslkakk0ROmOnl4/AyfOJwGNbThurcLQ498Vnsv/9wsEthIMu1Ty
         Ot7WMWMYyHX79qEV66YsLHhX8hlO58pB3bDh9CY8=
Date:   Wed, 24 Jun 2020 19:39:27 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v8 2/3] phy: zynqmp: Add PHY driver for the Xilinx ZynqMP
 Gigabit Transceiver
Message-ID: <20200624163927.GF5980@pendragon.ideasonboard.com>
References: <20200513172239.26444-1-laurent.pinchart@ideasonboard.com>
 <20200513172239.26444-3-laurent.pinchart@ideasonboard.com>
 <20200624151121.GF2324254@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624151121.GF2324254@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Wed, Jun 24, 2020 at 08:41:21PM +0530, Vinod Koul wrote:
> Hi Laurent,
> 
> Mostly this looks fine to me, some minor nitpicks below:
> 
> On 13-05-20, 20:22, Laurent Pinchart wrote:
> > +config PHY_XILINX_ZYNQMP
> > +	tristate "Xilinx ZynqMP PHY driver"
> > +	depends on ARCH_ZYNQMP
> 
> Can we add COMPILE_TEST here so that this driver gets wider compile
> coverage?

Sure.

> > +++ b/drivers/phy/xilinx/phy-zynqmp.c
> > @@ -0,0 +1,995 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * phy-zynqmp.c - PHY driver for Xilinx ZynqMP GT.
> > + *
> > + * Copyright (C) 2018-20 Xilinx Inc.
> 
> 2018-2020 please

OK.

> > +/* Number of GT lanes */
> > +#define NUM_LANES			4
> 
> Should this be coded in driver like this? Maybe future versions of
> hardware will have more lanes..? Why not describe this in DT?

This macro is used to avoid hardcoding 4 in the driver, to make sure
that all the code that deal with the number of lanes use a consistent
value and is readable. There's no foreseen new version of the IP that
would have more lane, so I don't think this should go in DT. Otherwise
we'd have to encode there pretty much any parameter that could one day
possibly change in a different universe :-)

Let's also note that even when parameters change between IP versions, it
doesn't always make sense to specify them explicitly in DT. It's totally
fine to have a table of parameter values in the driver, indexed by
compatible string. Whether to set a parameter explicitly in DT or handle
it in the driver usually depends on how frequently that parameter can
change, if it can vary between different integrations of the same IP
version, ...

In this specific case, as there's no foreseen change, we can't really
tell how it would change if it did one day. I thus think hardcoding the
parameter in the driver is fine, and in the worst case, we can add a
parameter in DT later and default to 4 if not specified. Same reasoning
for CONTROLLERS_PER_LANE.

> > +
> > +/* SIOU SATA control register */
> > +#define SATA_CONTROL_OFFSET		0x0100
> > +
> > +/* Total number of controllers */
> > +#define CONTROLLERS_PER_LANE		5
> 
> Same question for this as well..
> 
> > +/*
> > + * I/O Accessors
> > + */
> > +
> > +static inline u32 xpsgtr_read(struct xpsgtr_dev *gtr_dev, u32 reg)
> > +{
> > +	return readl(gtr_dev->serdes + reg);
> > +}
> > +
> > +static inline void xpsgtr_write(struct xpsgtr_dev *gtr_dev, u32 reg, u32 value)
> > +{
> > +	writel(value, gtr_dev->serdes + reg);
> > +}
> > +
> > +static inline void xpsgtr_clr_set(struct xpsgtr_dev *gtr_dev, u32 reg,
> > +				  u32 clr, u32 set)
> 
> wouldn't it be apt to rename this to xpsgtr_modify() and with args as
> value and mask, somehow I find that more simpler...

"modify" sounds more vague to me. I've also kept xpsgtr_clr_set() as
that's what the original author used.

> Also, please align second line with opening brace of preceding line

It is aligned, the first line is affected by the + and > in the mail,
while the second line uses tabs and thus isn't.

-- 
Regards,

Laurent Pinchart
