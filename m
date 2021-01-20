Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E572FD3BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390429AbhATPSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390747AbhATPPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:15:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36628C061786
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 07:13:18 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l2FAQ-00006V-Iw; Wed, 20 Jan 2021 16:13:06 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l2FAP-0003uY-Cr; Wed, 20 Jan 2021 16:13:05 +0100
Date:   Wed, 20 Jan 2021 16:13:05 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Adam Ford <aford173@gmail.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] clk: imx: Fix reparenting of UARTs not associated
 with sdout
Message-ID: <20210120151305.GC19063@pengutronix.de>
References: <20210115182909.314756-1-aford173@gmail.com>
 <20210118125204.hxsanoohwvdtdvym@fsr-ub1664-175>
 <CAHCN7x+CXUuPN7upiv3D+REOU4d_=i30no+SkRzUjWY58o=uUQ@mail.gmail.com>
 <20210120144454.f6b72lnasw4q3bde@fsr-ub1664-175>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120144454.f6b72lnasw4q3bde@fsr-ub1664-175>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:11:27 up 49 days,  3:38, 84 users,  load average: 0.30, 0.19,
 0.12
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Wed, Jan 20, 2021 at 04:44:54PM +0200, Abel Vesa wrote:
> On 21-01-18 08:00:43, Adam Ford wrote:
> > On Mon, Jan 18, 2021 at 6:52 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> > >
> > > On 21-01-15 12:29:08, Adam Ford wrote:
> > >
> > > ...
> > >
> > > > diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
> > > > index a66cabfbf94f..66192fe0a898 100644
> > > > --- a/drivers/clk/imx/clk-imx25.c
> > > > +++ b/drivers/clk/imx/clk-imx25.c
> > > > @@ -73,16 +73,6 @@ enum mx25_clks {
> > > >
> > > >  static struct clk *clk[clk_max];
> > > >
> > > > -static struct clk ** const uart_clks[] __initconst = {
> > > > -     &clk[uart_ipg_per],
> > > > -     &clk[uart1_ipg],
> > > > -     &clk[uart2_ipg],
> > > > -     &clk[uart3_ipg],
> > > > -     &clk[uart4_ipg],
> > > > -     &clk[uart5_ipg],
> > > > -     NULL
> > > > -};
> > > > -
> > >
> > > I'm assuming there is another patch that updates the dts files. Right ?
> > 
> > I have only been able to test this on an i.MX8M Mini.  I need to set
> > the parent clock of the i.MX8M Mini to an 80 MHz clock in order to run
> > the UART at 4Mbps.   With this patch, I can stop enabling the all the
> > UART clocks early and allow the clock parent configuration to occur.
> > From what I can tell, the remaining clocks should get activated as
> > they are needed, because I was able to use Bluetooth connected to
> > UART1 running at 4MBps using a 80MHz clock source with this patch, and
> > the clk_summary shows the clock is running at the proper speed.
> > Without this patch, the UART fails to re-parent, so I'm stuck at lower
> > speeds and that means choppy Bluetooth audio.
> > 
> > The Kernel that NXP hosts on Code Aurora that they use for Yocto
> > attempts scan through stdout to only enable those clocks [1].  I
> > attempted to push it upstream, but it was rejected [2].  Sascha
> > suggested creating an array which could be filled when the clocks are
> > enabled and that array would be used to deactivate the clocks at
> > shutdown.  That's what I attempted to do here.
> > 
> > I don't have older imx boards to know if their device trees are
> > configured in such a way without modifications to the device tree or
> > not, but since it appears to work for NXP in [2], I assumed it would
> > work here.
> > 
> > [1] - https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.codeaurora.org%2Fexternal%2Fimx%2Flinux-imx%2Fcommit%2Fdrivers%2Fclk%2Fimx%2Fclk.c%3Fh%3Dimx_5.4.47_2.2.0%26id%3D754ae82cc55b7445545fc2f092a70e0f490e9c1b&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7Cf8922e76fa85485b86c508d8bbb97c47%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637465752633257569%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=bVmPaM1nN7Sm%2BISVvlIBoWYozfJE96fHpw431IEuggk%3D&amp;reserved=0
> > [2] - https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20201229145130.2680442-1-aford173%40gmail.com%2F&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7Cf8922e76fa85485b86c508d8bbb97c47%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637465752633257569%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=226HwbeVhZUW%2FJ3hsCSaVIxghOsPBH9EWeF8vFxaTWE%3D&amp;reserved=0
> > 
> > >
> > > TBH, I'm against the idea of having to call consumer API from a clock provider driver.
> > > I'm still investigating a way of moving the uart clock control calls in drivers/serial/imx,
> > > where they belong.
> > 
> > That makes sense.
> > 
> 
> Just a thought. The uart clock used for console remains on from u-boot,
> so maybe it's enough to just add the CLK_IGNORE_UNUSED flag to all the
> uart root clocks and remove the prepare/enable calls for uart clocks 
> for good. I don't really have a way to test it right now, but maybe
> you could give it a try.

That would mean that UART clocks will never be disabled, regardless of
whether they are used for console or not. That doesn't sound very
appealing.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
