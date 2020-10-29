Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A18629EC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgJ2NEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgJ2NEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:04:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F0DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:04:05 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kY7av-0003gY-5d; Thu, 29 Oct 2020 14:03:57 +0100
Message-ID: <ea7162d355d429401cbcf10d34cc31b6264aabc7.camel@pengutronix.de>
Subject: Re: [RFC 0/3] clk: imx: Implement blk-ctl driver for i.MX8MN
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>, Marek Vasut <marex@denx.de>,
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
Date:   Thu, 29 Oct 2020 14:03:55 +0100
In-Reply-To: <CAHCN7xKSs9z1_ryXX3xOcJn7FfWXBE+zTzDYJT3pA1LCbHyOBw@mail.gmail.com>
References: <20201024162016.1003041-1-aford173@gmail.com>
         <20201024202335.y3npwtgragpp5wcz@fsr-ub1664-175>
         <CAHCN7xJiygvLStO56v4xSnOEqR_5fbYQHn5juA8YeDiWh2awbg@mail.gmail.com>
         <20201025120509.r5kl76wo5mdmapo5@fsr-ub1664-175>
         <3dadade8-6e77-e27f-d5a6-307de17a4dd0@denx.de>
         <CAHCN7xLC-gKquDNS3ToQCff=g610PscQE+T4zfO=_05GpLyK4w@mail.gmail.com>
         <20201026145516.shmb55gaeh6u7oru@fsr-ub1664-175>
         <CAHCN7xJOczT1B03Am4A645Xrk6-VF_7VDgAq13F-81=oCkixjw@mail.gmail.com>
         <6274ab26d1fea5e00cea576d1e00028a4c4633af.camel@pengutronix.de>
         <CAHCN7xK1Stx=dzbDE6dKtRHuWGgca54bwQf=JSGNFVmHJ_fSig@mail.gmail.com>
         <55a33659d6faeb5677f4f3e4809bc426c1a4fc88.camel@pengutronix.de>
         <CAHCN7xKSs9z1_ryXX3xOcJn7FfWXBE+zTzDYJT3pA1LCbHyOBw@mail.gmail.com>
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

Am Donnerstag, den 29.10.2020, 07:18 -0500 schrieb Adam Ford:
> On Thu, Oct 29, 2020 at 6:55 AM Lucas Stach <l.stach@pengutronix.de>
> wrote:
> > Am Montag, den 26.10.2020, 11:23 -0500 schrieb Adam Ford:
> > > On Mon, Oct 26, 2020 at 10:44 AM Lucas Stach <
> > > l.stach@pengutronix.de> wrote:
> > > > Am Montag, den 26.10.2020, 10:12 -0500 schrieb Adam Ford:
> > > > > On Mon, Oct 26, 2020 at 9:55 AM Abel Vesa <abel.vesa@nxp.com>
> > > > > wrote:
> > > > > > On 20-10-25 11:05:32, Adam Ford wrote:
> > > > > > > On Sun, Oct 25, 2020 at 7:19 AM Marek Vasut <
> > > > > > > marex@denx.de> wrote:
> > > > > > > > On 10/25/20 1:05 PM, Abel Vesa wrote:
> > > > > > > > 
> > > > > > > > [...]
> > > > > > > > 
> > > > > > > > > > Together, both the GPC and the clk-blk driver
> > > > > > > > > > should be able to pull
> > > > > > > > > > the multimedia block out of reset.  Currently, the
> > > > > > > > > > GPC can handle the
> > > > > > > > > > USB OTG and the GPU, but the LCDIF and MIPI DSI
> > > > > > > > > > appear to be gated by
> > > > > > > > > > the clock block
> > > > > > > > > > 
> > > > > > > > > > My original patch RFC didn't include the imx8mn
> > > > > > > > > > node, because it
> > > > > > > > > > hangs, but the node I added looks like:
> > > > > > > > > > 
> > > > > > > > > > media_blk_ctl: clock-controller@32e28000 {
> > > > > > > > > >      compatible = "fsl,imx8mn-media-blk-ctl",
> > > > > > > > > > "syscon";
> > > > > > > > > >      reg = <0x32e28000 0x1000>;
> > > > > > > > > >      #clock-cells = <1>;
> > > > > > > > > >      #reset-cells = <1>;
> > > > > > > > > > };
> > > > > > > > > > 
> > > > > > > > > > I was hoping you might have some feedback on the
> > > > > > > > > > 8mn clk-blk driver
> > > > > > > > > > since you did the 8mp clk-blk drive and they appear
> > > > > > > > > > to be very
> > > > > > > > > > similar.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > I'll do you one better still. I'll apply the patch in
> > > > > > > > > my tree and give it
> > > > > > > > > a test tomorrow morning.
> > > > > > > 
> > > > > > > I do have some more updates on how to get the system to
> > > > > > > not hang, and
> > > > > > > to enumerate more clocks.
> > > > > > > Looking at Marek's work on enabling clocks in the 8MM, he
> > > > > > > added a
> > > > > > > power-domain in dispmix_blk_ctl pointing to the dispmix
> > > > > > > in the GPC.
> > > > > > > By forcing the GPC driver to write 0x1fff  to 32e28004,
> > > > > > > 0x7f to
> > > > > > > 32e28000 and 0x30000 to 32e28008, the i.MX8MM can bring
> > > > > > > the display
> > > > > > > clocks out of reset.
> > > > > > > 
> > > > > > 
> > > > > > Yeah, that makes sense. Basically, it was trying to disable
> > > > > > unused clocks
> > > > > > (see clk_disable_unused) but in order to disable the clocks
> > > > > > from the
> > > > > > media BLK_CTL (which I think should be renamed in display
> > > > > > BLK_CTL) the
> > > > > > PD need to be on. Since you initially didn't give it any
> > > > > > PD, it was trying
> > > > > > to blindly write/read the gate bit and therefore freeze.
> > > > > > 
> > > > > > > Unfortunately, the i.MX8MN needs to have 0x100 written to
> > > > > > > both
> > > > > > > 32e28000 and 32e28004, and the values written for the 8MM
> > > > > > > are not
> > > > > > > compatible.
> > > > > > > By forcing the GPC to write those values, I can
> > > > > > > get  lcdif_pixel_clk
> > > > > > > and the mipi_dsi_clkref  appearing on the Nano.
> > > > > > 
> > > > > > I'm trying to make a branch with all the patches for all
> > > > > > i.MX8M so I
> > > > > > can keep track of it all. On this branch I've also applied
> > > > > > the
> > > > > > following patchset from Lucas Stach:
> > > > > > https://www.spinics.net/lists/arm-kernel/msg843007.html
> > > > > > but I'm getting the folowing errors:
> > > > > > 
> > > > > > [   16.690885] imx-pgc imx-pgc-domain.3: failed to power up
> > > > > > ADB400
> > > > > > [   16.716839] imx-pgc imx-pgc-domain.3: failed to power up
> > > > > > ADB400
> > > > > > [   16.730500] imx-pgc imx-pgc-domain.3: failed to power up
> > > > > > ADB400
> > > > > > 
> > > > > > Lucas, any thoughts?
> > > > > > 
> > > > > > Maybe it's something related to 8MN.
> > > > > > 
> > > > > I will go back and double check this now that we have both
> > > > > the
> > > > > blt_crl->power-domain and the power-domain->blk_ctl.
> > > > > 
> > > > > > Will dig further, see what pops out.
> > > > > 
> > > > > I wasn't sure which direction to go with the name.  I can
> > > > > rename the
> > > > > media_blk_ctl  driver to display_blk_ctl.  I used Media based
> > > > > on the
> > > > > imx8mp naming convention and the fact that it's controlling
> > > > > both the
> > > > > display and the camera interface, however it's depending on
> > > > > the
> > > > > dispmix GPC.
> > > > > 
> > > > > I'll submit a RFC V2 with the cross referencing to the GPC
> > > > > based on
> > > > > Marek's Mini patch set, but we'll still have an issue where
> > > > > the Mini
> > > > > and Nano have different syscon values to enable the clocks,
> > > > > and
> > > > > Marek's branch has it card-coded, so my patch would
> > > > > effectively break
> > > > > the Mini in order to make the Nano operate until we find a
> > > > > better
> > > > > solution.
> > > > 
> > > > The GPC should not write into the BLK_CTL region via syscon,
> > > > but
> > > > instead use the clocks and resets as exposed by the BLK_CTL
> > > > driver.
> > > > Doing it via syscon is a hack to get things going. The clocks
> > > > and
> > > > resets should properly be hooked up to the GPC domains via the
> > > > clocks
> > > > and resets DT properties.
> > > > 
> > > > For the clocks there is one complication: if the clocks are
> > > > controlled
> > > > via BLK_CTL we can only enable them once the domain is powered
> > > > up,
> > > > however the earlier designs using the GPCv2 assert resets as
> > > > part of
> > > > the power up sequence, which needs the clocks to be running for
> > > > the
> > > > reset to propagate. So depending on whether we have a power
> > > > domain with
> > > > a BLK_CTL or not we need to enable the clocks before or after
> > > > powering
> > > > up the domain. I guess we need a new DT property to specify
> > > > which way
> > > > the domain needs to handled.
> > > 
> > > So in the case of Nano, could we create two blocks instead of
> > > one?
> > > The first block would enable the bus clock and reset that
> > > correspond
> > > to writing 0x100 to avoid writing to syscon.  From there, we
> > > reference
> > > that reset and clock from the GPC displaymix_pd to enable the
> > > access.
> > > Once that's done, we point the 2nd block power-domain to the
> > > dispmix_pd to unlock the remaining clocks.
> > > 
> > > Would that work?  I can try it later today, but I'm not near the
> > > hardware now.
> > 
> > Splitting the PD into 2 staged domains might actually work well to
> > get
> > around the cyclic dependency between GPC and BLK_CTL. It's not
> > totally
> > to my liking, as the DT description doesn't map 1:1 to hardware
> > anymore, but it seems to be the most elegant solution to get around
> > the
> > dependency.
> > 
> > I'll try to implement this on the i.MX8MM today or tomorrow to see
> > if
> > it holds up in reality or if there are some hidden warts.
> 
> I tried it last night on the Nano without success.  :-(
> 
> I was just getting ready to e-mail the group when I saw this come in.

I was thinking the other way around, keeping a single BLK_CTL, but
splitting the PD to reflect the power-up sequence requirement. I'll let
you know how this works out.

Regards,
Lucas

