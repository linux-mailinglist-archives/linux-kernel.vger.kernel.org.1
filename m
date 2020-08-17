Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB50245DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHQHRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:17:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgHQHRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:17:48 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D595D20716;
        Mon, 17 Aug 2020 07:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648668;
        bh=f4HewaCYievJrLRvMK/fDp2BbemnrtBLKk/Ff2OgQC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ph9xxuqG8+vsYp6/8R/Tr9wuklhpLGPk2NnuOQgrWzi0xFTW8rDIYuAS5fFTZUs8n
         h2Dgv6W9knp1DLYKhpbW2fv2a0EASTSAoufqIxPPovVorS0Z260TqkFAiEPGc5z7D1
         9zELhrsdSQeGHU1w10RYLIxUBfoUYjVRiD3poZXI=
Date:   Mon, 17 Aug 2020 15:17:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Fugang Duan <fugang.duan@nxp.com>
Cc:     s.hauer@pengutronix.de,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v1 0/5] imx6qp QuadPlus: support improved enet clocking
Message-ID: <20200817071726.GA16951@dragon>
References: <20200713002512.28742-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713002512.28742-1-TheSven73@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 08:25:07PM -0400, Sven Van Asbroeck wrote:
> On the imx6qp QuadPlus, the h/w designers have improved enet clocking.
> 
> This patchset extends the clock tree to reflect the situation on QuadPlus.
> 
> This allows board designers to choose the enet clocking method by making
> simple clocktree changes in the devicetree.
> 
> Default setting: external routing of enet_ref from pad to pad.
> 
> Example, change the default to enet_ref @ 125MHz clock routed internally:
> 
> &fec {
> 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_PTP>,
> 			  <&clks IMX6QDL_CLK_ENET_REF>;
> 	assigned-clock-parents = <&clks IMX6QDL_CLK_ENET_REF>;
> 	assigned-clock-rates = <0>, <125000000>;
> };
> 
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-clk@vger.kernel.org
> 
> Sven Van Asbroeck (5):
>   ARM: mach-imx6q: do not select enet PTP clock source on QuadPlus
>   clk: imx: add simple regmap-backed clock mux
>   dt-bindings: imx6qdl-clock: add QuadPlus enet clocks
>   clk: imx6q: support improved enet clocking on QuadPlus
>   ARM: dts: imx6qp: support improved enet clocking on QuadPlus

Hi Fugang,

Can you take a look at the series?

Shawn
