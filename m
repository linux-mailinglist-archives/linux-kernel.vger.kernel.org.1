Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94035302BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbhAYTi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:38:59 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:35043 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbhAYTUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:20:42 -0500
Received: by mail-wm1-f53.google.com with SMTP id e15so602989wme.0;
        Mon, 25 Jan 2021 11:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9J1fjDoECtAEX54iT8gOtMcZFBoy3aSp1IkHbOxFr8Y=;
        b=US3njgDcuwrc3kzKvQHySjDDm2LZzpNkRS6EezkfouRfbztzYiqXy35SjeyXbgyTTC
         x52yVqq4RVZCafHWr9j2DoAkUMbvpqL/fDuWpzKrGTc9/h1z6CUcZQ+YbrYJYROSWjed
         4mMTlZ6bTrtKrBYC/OKsg+3mZaVP8cr8+LEAc681G969HlyaT0ZVErYM+p7HnlenWj/1
         7g+y/4KQiOVhnyQTG3PjwTYHx8ysGNp5Cm32aACNxXF6zgyCm/8fyr4BZ2Aogzgqxh/Q
         M/O/vg3kDw8knF2zCqIgJUu7WLXLx3OCiFL9/4NAGYcry0i71nwwS66klDjZL46CWrxH
         ISWQ==
X-Gm-Message-State: AOAM530EFnVaOpc/Aey+LGo3EOvKzi7pdijJ5gij4hGVP1quJp5xyt7F
        iR1b4ht6tA2+mWAjcMTBJO0=
X-Google-Smtp-Source: ABdhPJzxDnybmXi/gidk5uvLkyd7uOmYrWowYJaxWlB0aK2RQfYrenNjL5HbhRghKru/jguqqc1dCw==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr1454545wme.101.1611602400704;
        Mon, 25 Jan 2021 11:20:00 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id l7sm272497wmg.41.2021.01.25.11.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:59 -0800 (PST)
Date:   Mon, 25 Jan 2021 20:19:57 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8mn-beacon-som: Enable QSPI on SOM
Message-ID: <20210125191957.nrc2saxqebt6tjic@kozik-lap>
References: <20210119134258.774480-1-aford173@gmail.com>
 <20210119134258.774480-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119134258.774480-2-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 07:42:58AM -0600, Adam Ford wrote:
> There is a QSPI chip connected to the FlexSPI bus.  Enable it.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
> index 2120e6485393..9f575184d899 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
> @@ -7,6 +7,7 @@ / {
>  	aliases {
>  		rtc0 = &rtc;
>  		rtc1 = &snvs_rtc;
> +		spi0 = &flexspi;
>  	};
>  
>  	usdhc1_pwrseq: usdhc1_pwrseq {
> @@ -89,6 +90,22 @@ ethphy0: ethernet-phy@0 {
>  	};
>  };
>  
> +&flexspi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexspi>;
> +	status = "okay";
> +
> +	flash@0 {
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		spi-max-frequency = <80000000>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +	};
> +};
> +
>  &i2c1 {
>  	clock-frequency = <400000>;
>  	pinctrl-names = "default";
> @@ -318,6 +335,18 @@ MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
>  		>;
>  	};
>  
> +	pinctrl_flexspi: flexspigrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_NAND_ALE_QSPI_A_SCLK               0x1c2
> +			MX8MN_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B            0x82
> +			MX8MN_IOMUXC_NAND_DATA00_QSPI_A_DATA0           0x82
> +			MX8MN_IOMUXC_NAND_DATA01_QSPI_A_DATA1           0x82
> +			MX8MN_IOMUXC_NAND_DATA02_QSPI_A_DATA2           0x82
> +			MX8MN_IOMUXC_NAND_DATA03_QSPI_A_DATA3           0x82
> +		>;
> +	};
> +
> +

Double line break. Beside that:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
