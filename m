Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA7E2FE7A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbhAUKaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:30:23 -0500
Received: from inva020.nxp.com ([92.121.34.13]:37830 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728910AbhAUKZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:25:44 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 705431A0CC1;
        Thu, 21 Jan 2021 11:24:50 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 628901A01EC;
        Thu, 21 Jan 2021 11:24:50 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4DD2A203A1;
        Thu, 21 Jan 2021 11:24:50 +0100 (CET)
Date:   Thu, 21 Jan 2021 12:24:50 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
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
Message-ID: <20210121102450.lisl3mzqczdsmzda@fsr-ub1664-175>
References: <20210115182909.314756-1-aford173@gmail.com>
 <20210118125204.hxsanoohwvdtdvym@fsr-ub1664-175>
 <CAHCN7x+CXUuPN7upiv3D+REOU4d_=i30no+SkRzUjWY58o=uUQ@mail.gmail.com>
 <20210120144454.f6b72lnasw4q3bde@fsr-ub1664-175>
 <20210120151305.GC19063@pengutronix.de>
 <20210120152813.x2pbs5vprevkly23@fsr-ub1664-175>
 <20210120155001.GD19063@pengutronix.de>
 <20210120161421.h3yng57m3fetwwih@fsr-ub1664-175>
 <20210121095617.GI19063@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121095617.GI19063@pengutronix.de>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-21 10:56:17, Sascha Hauer wrote:
> On Wed, Jan 20, 2021 at 06:14:21PM +0200, Abel Vesa wrote:
> > On 21-01-20 16:50:01, Sascha Hauer wrote:
> > > On Wed, Jan 20, 2021 at 05:28:13PM +0200, Abel Vesa wrote:
> > > > On 21-01-20 16:13:05, Sascha Hauer wrote:
> > > > > Hi Abel,
> > > > > 
> > > > > On Wed, Jan 20, 2021 at 04:44:54PM +0200, Abel Vesa wrote:
> > > > > > On 21-01-18 08:00:43, Adam Ford wrote:
> > > > > > > On Mon, Jan 18, 2021 at 6:52 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> > > > 
> > > > ...
> > > > 
> > > > > > > 
> > > > > > > >
> > > > > > > > TBH, I'm against the idea of having to call consumer API from a clock provider driver.
> > > > > > > > I'm still investigating a way of moving the uart clock control calls in drivers/serial/imx,
> > > > > > > > where they belong.
> > > > > > > 
> > > > > > > That makes sense.
> > > > > > > 
> > > > > > 
> > > > > > Just a thought. The uart clock used for console remains on from u-boot,
> > > > > > so maybe it's enough to just add the CLK_IGNORE_UNUSED flag to all the
> > > > > > uart root clocks and remove the prepare/enable calls for uart clocks 
> > > > > > for good. I don't really have a way to test it right now, but maybe
> > > > > > you could give it a try.
> > > > > 
> > > > > That would mean that UART clocks will never be disabled, regardless of
> > > > > whether they are used for console or not. That doesn't sound very
> > > > > appealing.
> > > > 
> > > > AFAIK, the only uart clock that is enabled by u-boot is the one used for
> > > > the console. Later on, when the serial driver probes, it will enable it itself.
> > > > 
> > > > Unless I'm missing something, this is exactly what we need.
> > > 
> > > It might enable it, but with CLK_IGNORE_UNUSED the clock won't be
> > > disabled again when a port is closed after usage
> > 
> > OK, tell me what I'm getting wrong in the following scenario:
> > 
> > U-boot leaves the console uart clock enabled. All the other ones are disabled.
> > 
> > Kernel i.MX clk driver registers the uart clocks with flag CLK_IGNORE_UNUSED.
> 
> I was wrong at that point. I originally thought the kernel will never
> disable these clocks, but in fact it only leaves them enabled during the
> clk_disable_unused call.
> 
> However, when CLK_IGNORE_UNUSED becomes relevant it's too late already.
> I just chatted with Lucas and he told me what the original problem was
> that his patch solved.
> 
> The problem comes when an unrelated device and the earlycon UART have
> the same parent clocks. The parent clock is enabled, but it's reference
> count is zero. Now when the unrelated device probes and toggles its
> clocks then the shared parent clock will be disabled due to the
> reference count being zero. Next time earlycon prints a character the
> system hangs because the UART gates are still enabled, but their parent
> clocks no longer are.
> 

Hmm, that is indeed a problem. That's why I think there should be some
kind of NOCACHE flag for almost all the types of clocks. For example,
in this case, it makes sense for the core to check the bit in the register
and then disable the parent based on that instead of relying on the refcount.
Anyway, that's something that needs to be added in the CCF.

> Overall I think Lucas' patches are still valid and relevant and with
> Adams patches we even no longer have to enable all UART clocks, but
> only the ones which are actually needed.

Yeah, for now, I think we can go with Adam's patches. But longterm, I would
like to remove the special case of the uart clocks we have right now in all
the i.MX clock drivers.

> 
> Sascha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.pengutronix.de%2F&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7Ceed68987c68f4aeaa63408d8bdf2d051%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637468197861821302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=X1J8KgxFquNin80zKVz0Ao22vv1MuTMWf91BUTczh9Y%3D&amp;reserved=0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
