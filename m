Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F962A1CA4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 08:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgKAHzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 02:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgKAHzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 02:55:02 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47DC7208E4;
        Sun,  1 Nov 2020 07:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604217301;
        bh=yj5pMSzl7V46/9m55tvsNpReH2clXrKDTUY44VMJZhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OtndF2VmCI+7s6+Oe6YBemVui/mKi6HAJ+INHirs6n+imWBi4v9A565j2ovt9DXHA
         VooRz/j0kV0shgCloUVsmhK9nDY8XyBSQQbXFXdxttMUl+VJJe/ahdlkvh+jJe/gB9
         E7PLReceAQIs+rZ3OnKPjYTLkJTpsPeIAwheNCa8=
Date:   Sun, 1 Nov 2020 15:54:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     sboyd@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, kernel@pengutronix.de, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com
Subject: Re: [PATCH V2 0/5] clk: imx: fix bus critical clk registration
Message-ID: <20201101075449.GG31601@dragon>
References: <1603285820-30196-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603285820-30196-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 09:10:15PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>   Add missed Reported-by tag
>   Add R-b tag

I do not see either tag on any of the patches.

> 
> The issue is exposed by
> https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/
> linux.git/commit/?h=for-next&id=936c383673b9e3007432f17140ac62de53d87db9
> 
> Since the upper patch not in Linus tree, I not add Fixed tag.

It should be landed now.

Shawn

> 
> The issue is bus clk should be registered using bus composite api, not
> peripheral api. Otherwise we will met failed to assigned clock parents error log.
> Because peripheral critical clk has CLK_SET_PARENT_GATE and CLK_IS_CRITICAL,
> you will not able to set clk parents.
> 
> We need use bus critical clk api to register the clks, so introduce
> a new helper and use it.
> 
> Peng Fan (5):
>   clk: imx: add imx8m_clk_hw_composite_bus_critical
>   clk: imx8mq: fix noc and noc_io registration
>   clk: imx8mm: fix bus critical clk registration
>   clk: imx8mn: fix bus critical clk registration
>   clk: imx8mp: fix bus critical clk registration
> 
>  drivers/clk/imx/clk-imx8mm.c | 10 +++++-----
>  drivers/clk/imx/clk-imx8mn.c |  6 +++---
>  drivers/clk/imx/clk-imx8mp.c | 10 +++++-----
>  drivers/clk/imx/clk-imx8mq.c |  8 ++++----
>  drivers/clk/imx/clk.h        |  5 +++++
>  5 files changed, 22 insertions(+), 17 deletions(-)
> 
> -- 
> 2.28.0
> 
