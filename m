Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA21D299168
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784398AbgJZPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:49:08 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46171 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784391AbgJZPtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:49:07 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kX4ZF-00008N-Kq; Mon, 26 Oct 2020 16:37:53 +0100
Message-ID: <c976125e45e2fe46afbee1735004668677383805.camel@pengutronix.de>
Subject: Re: [RFC 0/3] clk: imx: Implement blk-ctl driver for i.MX8MN
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>, Adam Ford <aford173@gmail.com>
Cc:     Marek Vasut <marex@denx.de>,
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
Date:   Mon, 26 Oct 2020 16:37:51 +0100
In-Reply-To: <20201026145516.shmb55gaeh6u7oru@fsr-ub1664-175>
References: <20201024162016.1003041-1-aford173@gmail.com>
         <20201024202335.y3npwtgragpp5wcz@fsr-ub1664-175>
         <CAHCN7xJiygvLStO56v4xSnOEqR_5fbYQHn5juA8YeDiWh2awbg@mail.gmail.com>
         <20201025120509.r5kl76wo5mdmapo5@fsr-ub1664-175>
         <3dadade8-6e77-e27f-d5a6-307de17a4dd0@denx.de>
         <CAHCN7xLC-gKquDNS3ToQCff=g610PscQE+T4zfO=_05GpLyK4w@mail.gmail.com>
         <20201026145516.shmb55gaeh6u7oru@fsr-ub1664-175>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 26.10.2020, 16:55 +0200 schrieb Abel Vesa:
> On 20-10-25 11:05:32, Adam Ford wrote:
> > On Sun, Oct 25, 2020 at 7:19 AM Marek Vasut <marex@denx.de> wrote:
> > > On 10/25/20 1:05 PM, Abel Vesa wrote:
> > > 
> > > [...]
> > > 
> > > > > Together, both the GPC and the clk-blk driver should be able to pull
> > > > > the multimedia block out of reset.  Currently, the GPC can handle the
> > > > > USB OTG and the GPU, but the LCDIF and MIPI DSI appear to be gated by
> > > > > the clock block
> > > > > 
> > > > > My original patch RFC didn't include the imx8mn node, because it
> > > > > hangs, but the node I added looks like:
> > > > > 
> > > > > media_blk_ctl: clock-controller@32e28000 {
> > > > >      compatible = "fsl,imx8mn-media-blk-ctl", "syscon";
> > > > >      reg = <0x32e28000 0x1000>;
> > > > >      #clock-cells = <1>;
> > > > >      #reset-cells = <1>;
> > > > > };
> > > > > 
> > > > > I was hoping you might have some feedback on the 8mn clk-blk driver
> > > > > since you did the 8mp clk-blk drive and they appear to be very
> > > > > similar.
> > > > > 
> > > > 
> > > > I'll do you one better still. I'll apply the patch in my tree and give it
> > > > a test tomorrow morning.
> > 
> > I do have some more updates on how to get the system to not hang, and
> > to enumerate more clocks.
> > Looking at Marek's work on enabling clocks in the 8MM, he added a
> > power-domain in dispmix_blk_ctl pointing to the dispmix in the GPC.
> > By forcing the GPC driver to write 0x1fff  to 32e28004, 0x7f to
> > 32e28000 and 0x30000 to 32e28008, the i.MX8MM can bring the display
> > clocks out of reset.
> > 
> 
> Yeah, that makes sense. Basically, it was trying to disable unused clocks
> (see clk_disable_unused) but in order to disable the clocks from the
> media BLK_CTL (which I think should be renamed in display BLK_CTL) the
> PD need to be on. Since you initially didn't give it any PD, it was trying
> to blindly write/read the gate bit and therefore freeze.
> 
> > Unfortunately, the i.MX8MN needs to have 0x100 written to both
> > 32e28000 and 32e28004, and the values written for the 8MM are not
> > compatible.
> > By forcing the GPC to write those values, I can get  lcdif_pixel_clk
> > and the mipi_dsi_clkref  appearing on the Nano.
> 
> I'm trying to make a branch with all the patches for all i.MX8M so I
> can keep track of it all. On this branch I've also applied the 
> following patchset from Lucas Stach:
> https://www.spinics.net/lists/arm-kernel/msg843007.html
> but I'm getting the folowing errors:
> 
> [   16.690885] imx-pgc imx-pgc-domain.3: failed to power up ADB400
> [   16.716839] imx-pgc imx-pgc-domain.3: failed to power up ADB400
> [   16.730500] imx-pgc imx-pgc-domain.3: failed to power up ADB400
> 
> Lucas, any thoughts?
> 
> Maybe it's something related to 8MN.

The ADB is apparently clocked by one of the BLK_CTL clocks, so the ADB
handshake ack will only work when the BLK_CTL clocks are enabled. So I
guess the GPC driver should enable those clocks and assert the resets
at the right time in the power-up sequencing. Unfortunately this means
we can't properly put the BLK_CTL driver in the power-domain without
having a cyclic dependency in the DT. I'm still thinking about how to
solve this properly.

Regards,
Lucas

