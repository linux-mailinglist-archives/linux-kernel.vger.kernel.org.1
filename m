Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AD629A7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895613AbgJ0JbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:31:13 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50994 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895587AbgJ0JbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:31:12 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AD9592017F9;
        Tue, 27 Oct 2020 10:31:10 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F9192017EC;
        Tue, 27 Oct 2020 10:31:10 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A343202AE;
        Tue, 27 Oct 2020 10:31:10 +0100 (CET)
Date:   Tue, 27 Oct 2020 11:31:10 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
        devicetree <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 0/3] clk: imx: Implement blk-ctl driver for i.MX8MN
Message-ID: <20201027093110.jaslelqecwudn22k@fsr-ub1664-175>
References: <20201024162016.1003041-1-aford173@gmail.com>
 <20201024202335.y3npwtgragpp5wcz@fsr-ub1664-175>
 <CAHCN7xJiygvLStO56v4xSnOEqR_5fbYQHn5juA8YeDiWh2awbg@mail.gmail.com>
 <20201025120509.r5kl76wo5mdmapo5@fsr-ub1664-175>
 <3dadade8-6e77-e27f-d5a6-307de17a4dd0@denx.de>
 <CAHCN7xLC-gKquDNS3ToQCff=g610PscQE+T4zfO=_05GpLyK4w@mail.gmail.com>
 <20201026145516.shmb55gaeh6u7oru@fsr-ub1664-175>
 <c976125e45e2fe46afbee1735004668677383805.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c976125e45e2fe46afbee1735004668677383805.camel@pengutronix.de>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-26 16:37:51, Lucas Stach wrote:
> Am Montag, den 26.10.2020, 16:55 +0200 schrieb Abel Vesa:
> > On 20-10-25 11:05:32, Adam Ford wrote:
> > > On Sun, Oct 25, 2020 at 7:19 AM Marek Vasut <marex@denx.de> wrote:
> > > > On 10/25/20 1:05 PM, Abel Vesa wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > Together, both the GPC and the clk-blk driver should be able to pull
> > > > > > the multimedia block out of reset.  Currently, the GPC can handle the
> > > > > > USB OTG and the GPU, but the LCDIF and MIPI DSI appear to be gated by
> > > > > > the clock block
> > > > > > 
> > > > > > My original patch RFC didn't include the imx8mn node, because it
> > > > > > hangs, but the node I added looks like:
> > > > > > 
> > > > > > media_blk_ctl: clock-controller@32e28000 {
> > > > > >      compatible = "fsl,imx8mn-media-blk-ctl", "syscon";
> > > > > >      reg = <0x32e28000 0x1000>;
> > > > > >      #clock-cells = <1>;
> > > > > >      #reset-cells = <1>;
> > > > > > };
> > > > > > 
> > > > > > I was hoping you might have some feedback on the 8mn clk-blk driver
> > > > > > since you did the 8mp clk-blk drive and they appear to be very
> > > > > > similar.
> > > > > > 
> > > > > 
> > > > > I'll do you one better still. I'll apply the patch in my tree and give it
> > > > > a test tomorrow morning.
> > > 
> > > I do have some more updates on how to get the system to not hang, and
> > > to enumerate more clocks.
> > > Looking at Marek's work on enabling clocks in the 8MM, he added a
> > > power-domain in dispmix_blk_ctl pointing to the dispmix in the GPC.
> > > By forcing the GPC driver to write 0x1fff  to 32e28004, 0x7f to
> > > 32e28000 and 0x30000 to 32e28008, the i.MX8MM can bring the display
> > > clocks out of reset.
> > > 
> > 
> > Yeah, that makes sense. Basically, it was trying to disable unused clocks
> > (see clk_disable_unused) but in order to disable the clocks from the
> > media BLK_CTL (which I think should be renamed in display BLK_CTL) the
> > PD need to be on. Since you initially didn't give it any PD, it was trying
> > to blindly write/read the gate bit and therefore freeze.
> > 
> > > Unfortunately, the i.MX8MN needs to have 0x100 written to both
> > > 32e28000 and 32e28004, and the values written for the 8MM are not
> > > compatible.
> > > By forcing the GPC to write those values, I can get  lcdif_pixel_clk
> > > and the mipi_dsi_clkref  appearing on the Nano.
> > 
> > I'm trying to make a branch with all the patches for all i.MX8M so I
> > can keep track of it all. On this branch I've also applied the 
> > following patchset from Lucas Stach:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Farm-kernel%2Fmsg843007.html&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7Cc930b0f523c44946a93f08d879c51c3f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637393234789815116%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ZzzUpEiEVcWqQQ5azAx8dkjHgiSMwkK04tqi32uLKbU%3D&amp;reserved=0
> > but I'm getting the folowing errors:
> > 
> > [   16.690885] imx-pgc imx-pgc-domain.3: failed to power up ADB400
> > [   16.716839] imx-pgc imx-pgc-domain.3: failed to power up ADB400
> > [   16.730500] imx-pgc imx-pgc-domain.3: failed to power up ADB400
> > 
> > Lucas, any thoughts?
> > 
> > Maybe it's something related to 8MN.
> 
> The ADB is apparently clocked by one of the BLK_CTL clocks, so the ADB
> handshake ack will only work when the BLK_CTL clocks are enabled. So I
> guess the GPC driver should enable those clocks and assert the resets
> at the right time in the power-up sequencing. Unfortunately this means
> we can't properly put the BLK_CTL driver in the power-domain without
> having a cyclic dependency in the DT. I'm still thinking about how to
> solve this properly.
> 

I remember we had something similar in our internal tree with the
bus_blk_clk on 8MP, which was added by the media BLK_CTL. What I did was to
just drop the registration of that clock entirely. My rationale was that if
the clock is part of the BLK_CTL but also needed by the BLK_CTL to work,
I can leave it alone (that is, enabled by default) since when the PD will be
powered off the clock will gated too. I guess another option would be to 
mark it as critical, that way, it will never be disabled (will be left alone
by the clk_disable_unused too) but at the same time will be visible in the
clock hierarchy.

> Regards,
> Lucas
> 
