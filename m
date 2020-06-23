Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7799204A36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 08:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgFWGvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 02:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730583AbgFWGvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:51:05 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BFDA20706;
        Tue, 23 Jun 2020 06:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592895065;
        bh=C5FlAHhZpaa+KxqYHKVR7HYYVpMpz8TplbMahkIcUcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FtAGu6WCswXbBBTB8IPlyFFfyRL5MVDFoH1K5g/a7zvRVhReiNWEy4eWnPbNS2XLf
         9MC96h+KDFTc4fQUxfh2IrtLkCOGSwXcj7x2r6JY53q/9+7jFEBSXuUFiNFDwnRb5V
         wrbb0+YcRn+hSiXPUDwSlB5zS1il7wgnVne0O9bg=
Date:   Tue, 23 Jun 2020 14:50:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     fabio.estevam@nxp.com, kernel@pengutronix.de, aisheng.dong@nxp.com,
        robh+dt@kernel.org, sboyd@kernel.org, linux@rempel-privat.de,
        jaswinder.singh@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH V3 2/3] arm64: dts: imx8m: add mu node
Message-ID: <20200623065057.GP30139@dragon>
References: <1590999602-29482-1-git-send-email-peng.fan@nxp.com>
 <1590999602-29482-3-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590999602-29482-3-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 04:20:01PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add mu node to let A53 could communicate with M Core.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
