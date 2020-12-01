Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36B12C94D2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgLABoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:44:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731216AbgLABoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:44:14 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA75206E0;
        Tue,  1 Dec 2020 01:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606787013;
        bh=mKicq+vRtq2g/ymLKVvBnSRiuzxijvmouli4/cl61vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVT6gwgrKychjMiLfAp1JsTSWHNOt7YQN8boeXqaGPX1iHNRuBTLKDPS+Zi6FMRbv
         8fPElPr8RRT1RCW/v1pY0DOfthp5hvbEIW1v7NWkpCyhh2CqYm0p9WBcjReKKKVBHY
         WDlI/xH22eKGY+4r6TIyFHuuNk/gMDReSIL3+KHo=
Date:   Tue, 1 Dec 2020 09:43:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mans Rullgard <mans@mansr.com>
Subject: Re: [PATCH 2/3] ARM: dts: imx28: add pinmux for USB1 overcurrent on
 pwm2
Message-ID: <20201201014325.GU4072@dragon>
References: <20201125161815.2361-1-lukma@denx.de>
 <20201125161815.2361-2-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125161815.2361-2-lukma@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 05:18:14PM +0100, Lukasz Majewski wrote:
> From: Mans Rullgard <mans@mansr.com>
> 
> Add pinmux setting for USB1 overcurrent on pwm2 pad.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Lukasz,

You need to add your SoB.

Shawn

> ---
>  arch/arm/boot/dts/imx28.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 6e7531b64bf7..6d24546f0abe 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -948,6 +948,16 @@
>  					fsl,pull-up = <MXS_PULL_DISABLE>;
>  				};
>  
> +				usb1_pins_b: usb1@1 {
> +					reg = <1>;
> +					fsl,pinmux-ids = <
> +						MX28_PAD_PWM2__USB1_OVERCURRENT
> +					>;
> +					fsl,drive-strength = <MXS_DRIVE_12mA>;
> +					fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +					fsl,pull-up = <MXS_PULL_DISABLE>;
> +				};
> +
>  				usb0_id_pins_a: usb0id@0 {
>  					reg = <0>;
>  					fsl,pinmux-ids = <
> -- 
> 2.20.1
> 
