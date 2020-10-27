Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B3B29A800
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895688AbgJ0Jia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:38:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33210 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409153AbgJ0Jia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:38:30 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 97B652017E9;
        Tue, 27 Oct 2020 10:38:27 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A54320130A;
        Tue, 27 Oct 2020 10:38:27 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 74B3F202AE;
        Tue, 27 Oct 2020 10:38:27 +0100 (CET)
Date:   Tue, 27 Oct 2020 11:38:27 +0200
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
Message-ID: <20201027093827.tltw3cu2hf2jgfty@fsr-ub1664-175>
References: <20201024162016.1003041-1-aford173@gmail.com>
 <20201024202335.y3npwtgragpp5wcz@fsr-ub1664-175>
 <CAHCN7xJiygvLStO56v4xSnOEqR_5fbYQHn5juA8YeDiWh2awbg@mail.gmail.com>
 <20201025120509.r5kl76wo5mdmapo5@fsr-ub1664-175>
 <3dadade8-6e77-e27f-d5a6-307de17a4dd0@denx.de>
 <CAHCN7xLC-gKquDNS3ToQCff=g610PscQE+T4zfO=_05GpLyK4w@mail.gmail.com>
 <20201026145516.shmb55gaeh6u7oru@fsr-ub1664-175>
 <CAHCN7xJOczT1B03Am4A645Xrk6-VF_7VDgAq13F-81=oCkixjw@mail.gmail.com>
 <6274ab26d1fea5e00cea576d1e00028a4c4633af.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6274ab26d1fea5e00cea576d1e00028a4c4633af.camel@pengutronix.de>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-26 16:44:13, Lucas Stach wrote:
> Am Montag, den 26.10.2020, 10:12 -0500 schrieb Adam Ford:
> > On Mon, Oct 26, 2020 at 9:55 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> > > On 20-10-25 11:05:32, Adam Ford wrote:
> > > > On Sun, Oct 25, 2020 at 7:19 AM Marek Vasut <marex@denx.de> wrote:
> > > > > On 10/25/20 1:05 PM, Abel Vesa wrote:
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > > Together, both the GPC and the clk-blk driver should be able to pull
> > > > > > > the multimedia block out of reset.  Currently, the GPC can handle the
> > > > > > > USB OTG and the GPU, but the LCDIF and MIPI DSI appear to be gated by
> > > > > > > the clock block
> > > > > > > 
> > > > > > > My original patch RFC didn't include the imx8mn node, because it
> > > > > > > hangs, but the node I added looks like:
> > > > > > > 
> > > > > > > media_blk_ctl: clock-controller@32e28000 {
> > > > > > >      compatible = "fsl,imx8mn-media-blk-ctl", "syscon";
> > > > > > >      reg = <0x32e28000 0x1000>;
> > > > > > >      #clock-cells = <1>;
> > > > > > >      #reset-cells = <1>;
> > > > > > > };
> > > > > > > 
> > > > > > > I was hoping you might have some feedback on the 8mn clk-blk driver
> > > > > > > since you did the 8mp clk-blk drive and they appear to be very
> > > > > > > similar.
> > > > > > > 
> > > > > > 
> > > > > > I'll do you one better still. I'll apply the patch in my tree and give it
> > > > > > a test tomorrow morning.
> > > > 
> > > > I do have some more updates on how to get the system to not hang, and
> > > > to enumerate more clocks.
> > > > Looking at Marek's work on enabling clocks in the 8MM, he added a
> > > > power-domain in dispmix_blk_ctl pointing to the dispmix in the GPC.
> > > > By forcing the GPC driver to write 0x1fff  to 32e28004, 0x7f to
> > > > 32e28000 and 0x30000 to 32e28008, the i.MX8MM can bring the display
> > > > clocks out of reset.
> > > > 
> > > 
> > > Yeah, that makes sense. Basically, it was trying to disable unused clocks
> > > (see clk_disable_unused) but in order to disable the clocks from the
> > > media BLK_CTL (which I think should be renamed in display BLK_CTL) the
> > > PD need to be on. Since you initially didn't give it any PD, it was trying
> > > to blindly write/read the gate bit and therefore freeze.
> > > 
> > > > Unfortunately, the i.MX8MN needs to have 0x100 written to both
> > > > 32e28000 and 32e28004, and the values written for the 8MM are not
> > > > compatible.
> > > > By forcing the GPC to write those values, I can get  lcdif_pixel_clk
> > > > and the mipi_dsi_clkref  appearing on the Nano.
> > > 
> > > I'm trying to make a branch with all the patches for all i.MX8M so I
> > > can keep track of it all. On this branch I've also applied the
> > > following patchset from Lucas Stach:
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Farm-kernel%2Fmsg843007.html&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C02bcfb84d35f4c41a05e08d879c5fe57%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637393238611075979%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=fQnrRpGOnk0B4tFCFsfadKK2qozZwxK4ddycmv4VPls%3D&amp;reserved=0
> > > but I'm getting the folowing errors:
> > > 
> > > [   16.690885] imx-pgc imx-pgc-domain.3: failed to power up ADB400
> > > [   16.716839] imx-pgc imx-pgc-domain.3: failed to power up ADB400
> > > [   16.730500] imx-pgc imx-pgc-domain.3: failed to power up ADB400
> > > 
> > > Lucas, any thoughts?
> > > 
> > > Maybe it's something related to 8MN.
> > > 
> > I will go back and double check this now that we have both the
> > blt_crl->power-domain and the power-domain->blk_ctl.
> > 
> > > Will dig further, see what pops out.
> > 
> > I wasn't sure which direction to go with the name.  I can rename the
> > media_blk_ctl  driver to display_blk_ctl.  I used Media based on the
> > imx8mp naming convention and the fact that it's controlling both the
> > display and the camera interface, however it's depending on the
> > dispmix GPC.
> > 
> > I'll submit a RFC V2 with the cross referencing to the GPC based on
> > Marek's Mini patch set, but we'll still have an issue where the Mini
> > and Nano have different syscon values to enable the clocks, and
> > Marek's branch has it card-coded, so my patch would effectively break
> > the Mini in order to make the Nano operate until we find a better
> > solution.
> 
> The GPC should not write into the BLK_CTL region via syscon, but
> instead use the clocks and resets as exposed by the BLK_CTL driver.
> Doing it via syscon is a hack to get things going. The clocks and
> resets should properly be hooked up to the GPC domains via the clocks
> and resets DT properties.
> 

Totally agree. The syscon is there for other GPRs of any BLK_CTL which
do not fit in a clock or reset controller. So please do not ever use the
syscon for touching clocks or reset. Actually, I'm thinking of a way to
make sure the use of syscon for clocks and resets in the BLK_CTL would
be protected against.

> For the clocks there is one complication: if the clocks are controlled
> via BLK_CTL we can only enable them once the domain is powered up,
> however the earlier designs using the GPCv2 assert resets as part of
> the power up sequence, which needs the clocks to be running for the
> reset to propagate. So depending on whether we have a power domain with
> a BLK_CTL or not we need to enable the clocks before or after powering
> up the domain. I guess we need a new DT property to specify which way
> the domain needs to handled.
> 

All the BLK_CTLs have their own power domains. No question there. Now if
there are resets anc clocks that are part of the BLK_CTL and need to be
asserted/enabled on runtime resume, I think we can implement a generic
way to do that in the pm_runtime callbacks. Something similar to the 
.pm_runtime_saved_regs, maybe.

> Regards,
> Lucas
> 
