Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8882A439D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgKCK7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgKCK7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:59:31 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8187E208B6;
        Tue,  3 Nov 2020 10:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604401170;
        bh=qeFHNu/TjXZ28G/HeWCLlB9Rs2ZplrmupeH3I17qMMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HadCM52Fwbr7Bx14vtSn0XROrJ8NOI4lvGa9Z6yvwyCKfe+iRQQWW8v0fsMhNGO9z
         thkVfnxg5XVNLXsTNQ9KHORuVy+F1v9yW+TjXsMRCcxq+KqT9mXwIgLzLJdEuF0pC5
         a2s0kWuQWNQm1m8bOASANQwMaao/XBwOpy/ZkVkA=
Date:   Tue, 3 Nov 2020 18:59:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V3] clk: imx8m: fix bus critical clk registration
Message-ID: <20201103105924.GD31601@dragon>
References: <1604229834-25594-1-git-send-email-peng.fan@nxp.com>
 <20201103000657.GA31601@dragon>
 <DB6PR0402MB2760920568B1FC6A9F993EFB88110@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB2760920568B1FC6A9F993EFB88110@DB6PR0402MB2760.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 01:03:44AM +0000, Peng Fan wrote:
> Shawn,
> 
> > Subject: Re: [PATCH V3] clk: imx8m: fix bus critical clk registration
> > 
> > On Sun, Nov 01, 2020 at 07:23:54PM +0800, peng.fan@nxp.com wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > noc/axi/ahb are bus clk, not peripheral clk.
> > > Since peripheral clk has a limitation that for peripheral clock slice,
> > > IP clock slices must be stopped to change the clock source.
> > >
> > > However if the bus clk is marked as critical clk peripheral, the
> > > assigned clock parent operation will fail.
> > >
> > > So we added CLK_SET_PARENT_GATE flag to avoid glitch.
> > >
> > > And add imx8m_clk_hw_composite_bus_critical for bus critical clock
> > > usage
> > >
> > > Fixes: 936c383673b9e ("clk: imx: fix composite peripheral flags")
> > > Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> > > Reported-by: Abel Vesa <abel.vesa@nxp.com>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > 
> > Do you want this be picked up as a fix for 5.10-rc or non-critical stuff for
> > -next?
> 
> Please take this as a fix for 5.10-rc.

Okay, I will leave this to Stephen then.

Shawn
