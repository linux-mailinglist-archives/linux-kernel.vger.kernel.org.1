Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F0029818F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 13:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415598AbgJYMFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 08:05:13 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37752 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415587AbgJYMFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 08:05:11 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A34AF2006C3;
        Sun, 25 Oct 2020 13:05:09 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A03F620069D;
        Sun, 25 Oct 2020 13:05:09 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8BCEC202B0;
        Sun, 25 Oct 2020 13:05:09 +0100 (CET)
Date:   Sun, 25 Oct 2020 14:05:09 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [RFC 0/3] clk: imx: Implement blk-ctl driver for i.MX8MN
Message-ID: <20201025120509.r5kl76wo5mdmapo5@fsr-ub1664-175>
References: <20201024162016.1003041-1-aford173@gmail.com>
 <20201024202335.y3npwtgragpp5wcz@fsr-ub1664-175>
 <CAHCN7xJiygvLStO56v4xSnOEqR_5fbYQHn5juA8YeDiWh2awbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xJiygvLStO56v4xSnOEqR_5fbYQHn5juA8YeDiWh2awbg@mail.gmail.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-24 16:03:17, Adam Ford wrote:
> On Sat, Oct 24, 2020 at 3:23 PM Abel Vesa <abel.vesa@nxp.com> wrote:
> >
> > On 20-10-24 11:20:12, Adam Ford wrote:
> > > There are some less-documented registers which control clocks and
> > > resets for the multimedia block which controls the LCDIF, ISI, MIPI
> > > CSI, and MIPI DSI.
> > >
> > > The i.Mx8M Nano appears to have a subset of the i.MX8MP registers with
> > > a couple shared registers with the i.MX8MM.  This series builds on the
> > > series that have been submitted for both of those other two platforms.
> > >
> > > This is an RFC because when enabling the corresponding DTS node, the
> > > system freezes on power on.  There are a couple of clocks that don't
> > > correspond to either the imx8mp nor the imx8mm, so I might have something
> > > wrong, and I was hoping for some constructive feedback in order to get
> > > the imx8m Nano to a similar point of the Mini and Plus.
> > >
> >
> > Thanks for the effort.
> 
> Sure thing!
> 
> >
> > I'm assuming this relies on the following patchset, right ?
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F10%2F24%2F139&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C00007fdffcb44af4bbe808d8786044cf%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637391702150893977%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=RIdR4O2Qx3q7ovfAO7O3kc%2BpXXMPzLQJWPoUAH305%2Bs%3D&amp;reserved=0
> Abell,
> 
> Your link points right back to this e-mail.  ;-)

Sorry about that. Was kinda late here yesterday.

> 
> I based this work off:
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Farm-kernel%2Fmsg843906.html&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C00007fdffcb44af4bbe808d8786044cf%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637391702150893977%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6B3UHZNULMB%2FtMzdWHckIOFlqFxEYwYdQclzqDtJ%2FNQ%3D&amp;reserved=0  from Marek
> which I beleive is based on
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Farm-kernel%2Fmsg836165.html&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C00007fdffcb44af4bbe808d8786044cf%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637391702150893977%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=I%2FfgIjzqwnjuSGOPfVKa%2BPbx950Be008sOon%2FDwSO1o%3D&amp;reserved=0 from you.
> 
> I also have a GPC patch series located:
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Farm-kernel%2Fmsg847925.html&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C00007fdffcb44af4bbe808d8786044cf%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637391702150893977%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=dF%2Bgth7dwopoB2rvQ8IqspTZ7kWxvMYGS0dY%2F0gWgXE%3D&amp;reserved=0
> 
> Together, both the GPC and the clk-blk driver should be able to pull
> the multimedia block out of reset.  Currently, the GPC can handle the
> USB OTG and the GPU, but the LCDIF and MIPI DSI appear to be gated by
> the clock block
> 
> My original patch RFC didn't include the imx8mn node, because it
> hangs, but the node I added looks like:
> 
> media_blk_ctl: clock-controller@32e28000 {
>      compatible = "fsl,imx8mn-media-blk-ctl", "syscon";
>      reg = <0x32e28000 0x1000>;
>      #clock-cells = <1>;
>      #reset-cells = <1>;
> };
> 
> I was hoping you might have some feedback on the 8mn clk-blk driver
> since you did the 8mp clk-blk drive and they appear to be very
> similar.
> 

I'll do you one better still. I'll apply the patch in my tree and give it
a test tomorrow morning.

> adam
> 
> 
> >
> > > Adam Ford (3):
> > >   dt-bindings: clock: imx8mn: Add media blk_ctl clock IDs
> > >   dt-bindings: reset: imx8mn: Add media blk_ctl reset IDs
> > >   clk: imx: Add blk-ctl driver for i.MX8MN
> > >
> > >  drivers/clk/imx/clk-blk-ctl-imx8mn.c     | 80 ++++++++++++++++++++++++
> > >  include/dt-bindings/clock/imx8mn-clock.h | 11 ++++
> > >  include/dt-bindings/reset/imx8mn-reset.h | 22 +++++++
> > >  3 files changed, 113 insertions(+)
> > >  create mode 100644 drivers/clk/imx/clk-blk-ctl-imx8mn.c
> > >  create mode 100644 include/dt-bindings/reset/imx8mn-reset.h
> > >
> > > --
> > > 2.25.1
> > >
