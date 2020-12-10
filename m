Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3C12D55C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbgLJIwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbgLJIvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:51:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77965C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 00:51:05 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1knHfB-0007mt-QM; Thu, 10 Dec 2020 09:51:01 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1knHfA-0000BB-DO; Thu, 10 Dec 2020 09:51:00 +0100
Date:   Thu, 10 Dec 2020 09:51:00 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/5] dt-bindings: arm: fsl: add Kverneland UT1, UT1Q
 and UI1P boards
Message-ID: <20201210085100.5l4ltbpeemuwvgwp@pengutronix.de>
References: <20201201072449.28600-1-o.rempel@pengutronix.de>
 <20201201072449.28600-3-o.rempel@pengutronix.de>
 <20201209154308.GA495323@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209154308.GA495323@robh.at.kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:49:28 up 7 days, 22:55, 23 users,  load average: 0.00, 0.01, 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 09:43:08AM -0600, Rob Herring wrote:
> On Tue, Dec 01, 2020 at 08:24:45AM +0100, Oleksij Rempel wrote:
> > Add Kverneland UT1 (imx6dl), UT1Q (imx6q) and UT1P (imx6dp) based boards
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 490cbc75b18a..7b2f83bb56cb 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -210,6 +210,7 @@ properties:
> >                - kiebackpeter,imx6q-tpc    # K+P i.MX6 Quad TPC Board
> >                - kontron,imx6q-samx6i      # Kontron i.MX6 Dual/Quad SMARC Module
> >                - kosagi,imx6q-novena       # Kosagi Novena Dual/Quad
> > +              - kvg,vicut1q               # Kverneland UT1Q board
> >                - logicpd,imx6q-logicpd
> >                - lwn,display5              # Liebherr Display5 i.MX6 Quad Board
> >                - lwn,mccmon6               # Liebherr Monitor6 i.MX6 Quad Board
> > @@ -331,6 +332,7 @@ properties:
> >                - fsl,imx6qp-sabreauto      # i.MX6 Quad Plus SABRE Automotive Board
> >                - fsl,imx6qp-sabresd        # i.MX6 Quad Plus SABRE Smart Device Board
> >                - karo,imx6qp-tx6qp         # Ka-Ro electronics TX6QP-8037 Module
> > +              - kvg,vicutp                # Kverneland UT1P board
> 
> Should be kvg,vicut1p?

No. At least it is consequent with boot loader and existing products.

> >                - prt,prtwd3                # Protonic WD3 board
> >                - wand,imx6qp-wandboard     # Wandboard i.MX6 QuadPlus Board
> >                - zii,imx6qp-zii-rdu2       # ZII RDU2+ Board
> > @@ -364,6 +366,7 @@ properties:
> >                - fsl,imx6dl-sabresd        # i.MX6 DualLite SABRE Smart Device Board
> >                - karo,imx6dl-tx6dl         # Ka-Ro electronics TX6U Modules
> >                - kontron,imx6dl-samx6i     # Kontron i.MX6 Solo SMARC Module
> > +              - kvg,vicut1                # Kverneland UT1 board
> >                - ply,plybas                # Plymovent BAS board
> >                - ply,plym2m                # Plymovent M2M board
> >                - poslab,imx6dl-savageboard # Poslab SavageBoard Dual
> > -- 
> > 2.29.2
> > 

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
