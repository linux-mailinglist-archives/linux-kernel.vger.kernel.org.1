Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9EF2A375D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgKBX4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgKBX4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:56:33 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33800206D5;
        Mon,  2 Nov 2020 23:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604361393;
        bh=SbWcJCQynBHG4XsxePYAlvHG+75wUs2DWCABffaNUjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lHdd0M2Ml2EjUYlKXTQpxGGu6wPBtCoRaWx2fI2p9Oc4FkhZ/7Ibn47ZwzZ7mr7RX
         81zyDV+To1S6PvgdUeV0Hyg5NeaA++8tnYGT5NOQ86i48+toTZQbpCJDtpqy4EWNcJ
         qdwz34+HomzZVr7wpP8ZNY5bK1h7AUDxDWO1SGZ4=
Date:   Tue, 3 Nov 2020 07:56:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Fix the gate2 and make it more flexible
Message-ID: <20201102235625.GZ31601@dragon>
References: <1603889942-27026-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603889942-27026-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:58:57PM +0200, Abel Vesa wrote:
> First version here: https://lkml.org/lkml/2020/10/26/988
> 
> Changes since v1:
>  * split the work in multiple iterative patches
> 
> Abel Vesa (5):
>   clk: imx: gate2: Remove the IMX_CLK_GATE2_SINGLE_BIT special case
>   clk: imx: gate2: Keep the register writing in on place
>   clk: imx: gate2: Check if clock is enabled against cgr_val
>   clk: imx: gate2: Add cgr_mask for more flexible number of control bits
>   clk: imx: gate2: Add locking in is_enabled op

Applied all, thanks.
