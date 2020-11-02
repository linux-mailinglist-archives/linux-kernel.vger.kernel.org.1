Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211FA2A260D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgKBIYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgKBIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:24:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7C7C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 00:24:38 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kZV8i-0001Uh-F1; Mon, 02 Nov 2020 09:24:32 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1kZV8h-000871-FD; Mon, 02 Nov 2020 09:24:31 +0100
Date:   Mon, 2 Nov 2020 09:24:31 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] ARM: dts: imx7-tqma7: add SPI-NOR flash
Message-ID: <20201102082431.ww6q4x3kyr4ix72k@pengutronix.de>
References: <20201030102636.16476-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030102636.16476-1-matthias.schiffer@ew.tq-group.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:52:24 up 352 days, 23:10, 377 users,  load average: 0.09, 0.13,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 20-10-30 11:26, Matthias Schiffer wrote:
> The SPI-NOR flash on the SoM was missing from the device tree.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  arch/arm/boot/dts/imx7-tqma7.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> v2: change node name to flash@0
> 
> 
> diff --git a/arch/arm/boot/dts/imx7-tqma7.dtsi b/arch/arm/boot/dts/imx7-tqma7.dtsi
> index 8773344b54aa..22f4194322ed 100644
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

As far as I know we are using GPIO based chip selects and not the one
from the controller-IP or is this different for qspi?

> +			/* #QSPI_RESET */
> +			MX7D_PAD_EPDC_DATA04__GPIO2_IO4		0x40000052

Do you really need to mux the reset-gpio?

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
> +	flash0: flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		spi-max-frequency = <29000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <4>;
> +		reg = <0>;

Please check Documentation/devicetree/bindings/mtd/partition.txt to see
how partitions are added nowadays. With this in mind you should reorder
the node to:

	compatible = "jedec,spi-nor";
	reg = <0>;
	spi-max-frequency = <29000000>;
	spi-rx-bus-width = <4>;
	spi-tx-bus-width = <4>;


Regards,
  Marco

> +	};
> +};
> +
>  &sdma {
>  	status = "okay";
>  };
> -- 
> 2.17.1
> 
> 
> 
