Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C3F2FD373
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390706AbhATO4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:56:52 -0500
Received: from inva020.nxp.com ([92.121.34.13]:37674 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390910AbhATOpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:45:43 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5675F1A14BC;
        Wed, 20 Jan 2021 15:44:55 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3DCF51A14B4;
        Wed, 20 Jan 2021 15:44:55 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 296092039A;
        Wed, 20 Jan 2021 15:44:55 +0100 (CET)
Date:   Wed, 20 Jan 2021 16:44:54 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] clk: imx: Fix reparenting of UARTs not associated
 with sdout
Message-ID: <20210120144454.f6b72lnasw4q3bde@fsr-ub1664-175>
References: <20210115182909.314756-1-aford173@gmail.com>
 <20210118125204.hxsanoohwvdtdvym@fsr-ub1664-175>
 <CAHCN7x+CXUuPN7upiv3D+REOU4d_=i30no+SkRzUjWY58o=uUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7x+CXUuPN7upiv3D+REOU4d_=i30no+SkRzUjWY58o=uUQ@mail.gmail.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-18 08:00:43, Adam Ford wrote:
> On Mon, Jan 18, 2021 at 6:52 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> >
> > On 21-01-15 12:29:08, Adam Ford wrote:
> >
> > ...
> >
> > > diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
> > > index a66cabfbf94f..66192fe0a898 100644
> > > --- a/drivers/clk/imx/clk-imx25.c
> > > +++ b/drivers/clk/imx/clk-imx25.c
> > > @@ -73,16 +73,6 @@ enum mx25_clks {
> > >
> > >  static struct clk *clk[clk_max];
> > >
> > > -static struct clk ** const uart_clks[] __initconst = {
> > > -     &clk[uart_ipg_per],
> > > -     &clk[uart1_ipg],
> > > -     &clk[uart2_ipg],
> > > -     &clk[uart3_ipg],
> > > -     &clk[uart4_ipg],
> > > -     &clk[uart5_ipg],
> > > -     NULL
> > > -};
> > > -
> >
> > I'm assuming there is another patch that updates the dts files. Right ?
> 
> I have only been able to test this on an i.MX8M Mini.  I need to set
> the parent clock of the i.MX8M Mini to an 80 MHz clock in order to run
> the UART at 4Mbps.   With this patch, I can stop enabling the all the
> UART clocks early and allow the clock parent configuration to occur.
> From what I can tell, the remaining clocks should get activated as
> they are needed, because I was able to use Bluetooth connected to
> UART1 running at 4MBps using a 80MHz clock source with this patch, and
> the clk_summary shows the clock is running at the proper speed.
> Without this patch, the UART fails to re-parent, so I'm stuck at lower
> speeds and that means choppy Bluetooth audio.
> 
> The Kernel that NXP hosts on Code Aurora that they use for Yocto
> attempts scan through stdout to only enable those clocks [1].  I
> attempted to push it upstream, but it was rejected [2].  Sascha
> suggested creating an array which could be filled when the clocks are
> enabled and that array would be used to deactivate the clocks at
> shutdown.  That's what I attempted to do here.
> 
> I don't have older imx boards to know if their device trees are
> configured in such a way without modifications to the device tree or
> not, but since it appears to work for NXP in [2], I assumed it would
> work here.
> 
> [1] - https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.codeaurora.org%2Fexternal%2Fimx%2Flinux-imx%2Fcommit%2Fdrivers%2Fclk%2Fimx%2Fclk.c%3Fh%3Dimx_5.4.47_2.2.0%26id%3D754ae82cc55b7445545fc2f092a70e0f490e9c1b&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7Cf8922e76fa85485b86c508d8bbb97c47%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637465752633257569%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=bVmPaM1nN7Sm%2BISVvlIBoWYozfJE96fHpw431IEuggk%3D&amp;reserved=0
> [2] - https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20201229145130.2680442-1-aford173%40gmail.com%2F&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7Cf8922e76fa85485b86c508d8bbb97c47%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637465752633257569%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=226HwbeVhZUW%2FJ3hsCSaVIxghOsPBH9EWeF8vFxaTWE%3D&amp;reserved=0
> 
> >
> > TBH, I'm against the idea of having to call consumer API from a clock provider driver.
> > I'm still investigating a way of moving the uart clock control calls in drivers/serial/imx,
> > where they belong.
> 
> That makes sense.
> 

Just a thought. The uart clock used for console remains on from u-boot,
so maybe it's enough to just add the CLK_IGNORE_UNUSED flag to all the
uart root clocks and remove the prepare/enable calls for uart clocks 
for good. I don't really have a way to test it right now, but maybe
you could give it a try.

