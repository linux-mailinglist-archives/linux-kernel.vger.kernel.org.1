Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9182E294B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410090AbgJUKj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:39:59 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48408 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410044AbgJUKj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:39:57 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E1B461A11EF;
        Wed, 21 Oct 2020 12:39:54 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D477D1A0C5B;
        Wed, 21 Oct 2020 12:39:54 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BFE312033F;
        Wed, 21 Oct 2020 12:39:54 +0200 (CEST)
Date:   Wed, 21 Oct 2020 13:39:54 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     peng.fan@nxp.com
Cc:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com
Subject: Re: [PATCH 0/5] clk: imx: fix bus critical clk registration
Message-ID: <20201021103954.ugjgs5ze2uriojgk@fsr-ub1664-175>
References: <1603269094-29367-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603269094-29367-1-git-send-email-peng.fan@nxp.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-21 16:31:29, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The issue is exposed by
> https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/
> linux.git/commit/?h=for-next&id=936c383673b9e3007432f17140ac62de53d87db9
> 
> Since the upper patch not in Linus tree, I not add Fixed tag.
> 
> The issue is bus clk should be registered using bus composite api, not
> peripheral api. Otherwise we will met failed to assigned clock parents error log.
> Because peripheral critical clk has CLK_SET_PARENT_GATE and CLK_IS_CRITICAL,
> you will not able to set clk parents.
> 
> We need use bus critical clk api to register the clks, so introduce
> a new helper and use it.
> 

I already had this change in the devfreq+icc tree.

Thanks for speeding up this work.

After our discussion yesterday, there is a further change needed for the bus
clocks and that is the 'right' to reparent on rate change. I'll probably send
that myself.

For this entire series:

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

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
