Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5482FD4AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbhATP5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391069AbhATPuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:50:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A238BC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 07:50:12 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l2FkA-0004PH-K3; Wed, 20 Jan 2021 16:50:02 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l2Fk9-0005Fx-LJ; Wed, 20 Jan 2021 16:50:01 +0100
Date:   Wed, 20 Jan 2021 16:50:01 +0100
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
Message-ID: <20210120155001.GD19063@pengutronix.de>
References: <20210115182909.314756-1-aford173@gmail.com>
 <20210118125204.hxsanoohwvdtdvym@fsr-ub1664-175>
 <CAHCN7x+CXUuPN7upiv3D+REOU4d_=i30no+SkRzUjWY58o=uUQ@mail.gmail.com>
 <20210120144454.f6b72lnasw4q3bde@fsr-ub1664-175>
 <20210120151305.GC19063@pengutronix.de>
 <20210120152813.x2pbs5vprevkly23@fsr-ub1664-175>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120152813.x2pbs5vprevkly23@fsr-ub1664-175>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:48:32 up 49 days,  4:15, 92 users,  load average: 0.30, 0.38,
 0.23
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 05:28:13PM +0200, Abel Vesa wrote:
> On 21-01-20 16:13:05, Sascha Hauer wrote:
> > Hi Abel,
> > 
> > On Wed, Jan 20, 2021 at 04:44:54PM +0200, Abel Vesa wrote:
> > > On 21-01-18 08:00:43, Adam Ford wrote:
> > > > On Mon, Jan 18, 2021 at 6:52 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> 
> ...
> 
> > > > 
> > > > >
> > > > > TBH, I'm against the idea of having to call consumer API from a clock provider driver.
> > > > > I'm still investigating a way of moving the uart clock control calls in drivers/serial/imx,
> > > > > where they belong.
> > > > 
> > > > That makes sense.
> > > > 
> > > 
> > > Just a thought. The uart clock used for console remains on from u-boot,
> > > so maybe it's enough to just add the CLK_IGNORE_UNUSED flag to all the
> > > uart root clocks and remove the prepare/enable calls for uart clocks 
> > > for good. I don't really have a way to test it right now, but maybe
> > > you could give it a try.
> > 
> > That would mean that UART clocks will never be disabled, regardless of
> > whether they are used for console or not. That doesn't sound very
> > appealing.
> 
> AFAIK, the only uart clock that is enabled by u-boot is the one used for
> the console. Later on, when the serial driver probes, it will enable it itself.
> 
> Unless I'm missing something, this is exactly what we need.

It might enable it, but with CLK_IGNORE_UNUSED the clock won't be
disabled again when a port is closed after usage

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
