Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2221A29DF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404028AbgJ2BAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731549AbgJ1WR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:28 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E64D2242F;
        Wed, 28 Oct 2020 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603870700;
        bh=U7zzmaq/mn3S7yoFvyfQMPCSxqUHi0eJSFeubecSZWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e6Bd0mT5dq9uFWJK+Q4dqSGuad0pbXuy6mGlpnolxYdYZ8cUiokTTskwCLH5ANS0B
         RAnxr1OUU9h7owncI0Ck8Q2rUcIhVOKXL/nHUg2qJQ1jHNbTq33Z7+jMei5M4wDOzo
         jqKdKDrKE8lyXDg2VfamE8AN3CQ7HH1+Ab4EBKhk=
Date:   Wed, 28 Oct 2020 15:38:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/13] ARM: dts: imx7-tqma7: add SPI-NOR flash
Message-ID: <20201028073813.GN9880@dragon>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
 <20200918112942.1367-2-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918112942.1367-2-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 01:29:31PM +0200, Matthias Schiffer wrote:
> The SPI-NOR flash on the SoM was missing from the device tree.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  arch/arm/boot/dts/imx7-tqma7.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7-tqma7.dtsi b/arch/arm/boot/dts/imx7-tqma7.dtsi
> index 8773344b54aa..fd23f764399a 100644
> --- a/arch/arm/boot/dts/imx7-tqma7.dtsi
> +++ b/arch/arm/boot/dts/imx7-tqma7.dtsi
> @@ -160,6 +160,20 @@
>  		>;
>  	};
>  
> +	pinctrl_qspi: qspigrp {
> +		fsl,pins = <
> +			MX7D_PAD_EPDC_DATA00__QSPI_A_DATA0	0x5A
> +			MX7D_PAD_EPDC_DATA01__QSPI_A_DATA1	0x5A
> +			MX7D_PAD_EPDC_DATA02__QSPI_A_DATA2	0x5A
> +			MX7D_PAD_EPDC_DATA03__QSPI_A_DATA3	0x5A
> +			MX7D_PAD_EPDC_DATA05__QSPI_A_SCLK	0x11
> +			MX7D_PAD_EPDC_DATA06__QSPI_A_SS0_B	0x54
> +			MX7D_PAD_EPDC_DATA07__QSPI_A_SS1_B	0x54
> +			/* #QSPI_RESET */
> +			MX7D_PAD_EPDC_DATA04__GPIO2_IO4		0x40000052
> +		>;
> +	};
> +
>  	pinctrl_usdhc3: usdhc3grp {
>  		fsl,pins = <
>  			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
> @@ -217,6 +231,22 @@
>  	};
>  };
>  
> +&qspi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_qspi>;
> +	status = "okay";
> +
> +	flash0: spinor@0 {

The node name should be as generic as possible.  So suggest something
like 'flash@0'.

Shawn

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		spi-max-frequency = <29000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <4>;
> +		reg = <0>;
> +	};
> +};
> +
>  &sdma {
>  	status = "okay";
>  };
> -- 
> 2.17.1
> 
