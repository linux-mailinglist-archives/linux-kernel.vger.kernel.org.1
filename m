Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411C92F0A97
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 01:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbhAKA0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 19:26:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbhAKA0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 19:26:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DDA122AAF;
        Mon, 11 Jan 2021 00:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610324736;
        bh=YiolvVj0Oj06MeZfYfFnFfa1VQSCBHbzONJiZ8RUYJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eE/WBLA3kC4awatr4XFtpL+PKzGJs9k33Fc8R1LfZdCc4JGYicUXtjR5LQd2U9SEu
         KujHRJGJ91/ThIcdsQ3xdsstwKnhKJUvzJiKThlKaQGFCBg7wpWO0zY8QDT2KEsQ6R
         YuQPoUahqOfYqgiRvk032y/9l6I0+lFpcejNDhx9xx1VsdPJ63u+CkhH8cFzmVtCBs
         hVv4qchh3XJ9HR+Mln7Mm6fm9HrKq4VPh9ogJE1ewK3rF4CGntNdTq2doI/m3GEqS8
         iqwa0sUbgSHesHD30UXMDWVoaz4fqjbn6yVaFIPPrdkg6dp1Jx0WgW4kDPle1O1M93
         Gjr+NXsQj7u6A==
Date:   Mon, 11 Jan 2021 08:25:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mq: Add clock parents for mipi dphy
Message-ID: <20210111002530.GQ28365@dragon>
References: <bc2da4ab8322d5e8a44018633e0220e08d70e72e.1610297714.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc2da4ab8322d5e8a44018633e0220e08d70e72e.1610297714.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 05:55:51PM +0100, Guido Günther wrote:
> This makes sure the clock tree setup for the dphy is not dependent on
> other components.
> 
> Without this change bringing up the display can fail like
> 
>   kernel: phy phy-30a00300.dphy.2: Invalid CM/CN/CO values: 165/217/1
>   kernel: phy phy-30a00300.dphy.2: for hs_clk/ref_clk=451656000/593999998 ~ 165/217
> 
> if LCDIF doesn't set up that part of the clock tree first. This was
> noticed when testing the Librem 5 devkit with defconfig. It doesn't
> happen when modules are built in.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Applied, thanks.
