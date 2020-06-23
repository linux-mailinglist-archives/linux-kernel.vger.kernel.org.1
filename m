Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C62204824
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 05:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbgFWD4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 23:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731114AbgFWD4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 23:56:23 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1FCA20771;
        Tue, 23 Jun 2020 03:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592884582;
        bh=gpM6eseKXzmhhIgOiEJ2kOGIRCvZ0v7etboKPXbrzUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sz0Mi/gLMqUMgqgf+Q35A6BtXL5f7uP7oukWNfmPnhewG4tIoQIUzEZ52/wKjVaI5
         Sc/U4bchRYzMTXNzvDPZzME6nCtPHfkVmgpDtvyMjAyWCFYniX0F+jfBcA79JS++Gm
         2RHnazSBvWGeSSmd/JmtVzf4KZuzXUYJ0YUB9EJU=
Date:   Tue, 23 Jun 2020 11:56:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     fabio.estevam@nxp.com, kernel@pengutronix.de, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: imx8qxp: add i2c aliases
Message-ID: <20200623035615.GN30139@dragon>
References: <1590977180-9957-1-git-send-email-peng.fan@nxp.com>
 <1590977180-9957-3-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590977180-9957-3-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 10:06:19AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The devices could be enumerated properly with aliases.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 33363c127478..8ce997110cd6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -19,6 +19,10 @@
>  	#size-cells = <2>;
>  
>  	aliases {
> +		i2c0 = &adma_i2c0;
> +		i2c1 = &adma_i2c1;
> +		i2c2 = &adma_i2c2;
> +		i2c3 = &adma_i2c3;

Had a second look.  It breaks alphabetical order.  So dropped the
series.

Shawn

>  		gpio0 = &lsio_gpio0;
>  		gpio1 = &lsio_gpio1;
>  		gpio2 = &lsio_gpio2;
> -- 
> 2.16.4
> 
