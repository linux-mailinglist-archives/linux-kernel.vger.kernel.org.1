Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD172EA3A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbhAEDD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:03:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbhAEDDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:03:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0827B22573;
        Tue,  5 Jan 2021 03:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609815794;
        bh=XE7SuiACZOYW31EJ7aMHbmMzUK72rlo4KYN550Ay5Sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZZ8fJNlHnK4samldEl3EzVlUjJCO85NFtExNA4y3dQXmeqGpUL2+JfHNW2cZU6zQ
         C2+fxKTyk4VgeKYPrTT8CA4If/qRg5YhtOYEdWVADzp6+IsOqyS2aRRFtXNFpLPnTu
         rhYkWfmkXWNAKAJjQoiKVnUQ4U9aC7yPhi2ZeFAtVnCBj7ILqTRGeTaXE0uFVQxH2b
         aD9raFLUtN/uO2a9jOJcJ7CxyiOS0ByB+ZxJVGexBlxjuY/zRAfPadCEfSJMnCm91l
         uxuHaGvAQFkfQnSIJwxBdz1avcEeaz2F7QzzPs2npNvBqoWRQRkU2YA2d1CI6LfG9b
         BEp4ardsdgjCg==
Date:   Tue, 5 Jan 2021 11:03:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon: Fix WiFi Pinmuxing
Message-ID: <20210105030308.GK4142@dragon>
References: <20201202135950.22164-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202135950.22164-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 07:59:50AM -0600, Adam Ford wrote:
> The WiFi chip is capable of communication at SDR104 speeds, and
> the pinmux was configured to support this, but the sdhc1 controller
> didn't properly reference the pinmux.  Enable 100Mhz and 200MHz pinmux
> as was originally intended.
> 
> Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")

This looks more like an improvement than bug fix.

Shawn

> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> index 6de86a4f0ec4..90fd15e95798 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> @@ -217,8 +217,10 @@
>  &usdhc1 {
>  	#address-cells = <1>;
>  	#size-cells = <0>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>  	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
>  	bus-width = <4>;
>  	non-removable;
>  	cap-power-off-card;
> -- 
> 2.17.1
> 
