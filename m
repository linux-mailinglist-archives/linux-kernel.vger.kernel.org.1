Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1830B2F5054
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbhAMQrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:47:05 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:39241 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbhAMQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:47:03 -0500
Received: by mail-wr1-f49.google.com with SMTP id c5so2832907wrp.6;
        Wed, 13 Jan 2021 08:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L2q23JMI3ucNuJLrUHDTAlQX1rRDKarrrUWr9cUB7so=;
        b=iAUm4ITQPN87O6q4e9kYEUTdO/S66Be4xyNvRrQcMsvxrAtx+PQrchqSm3erZsWJ9a
         /zVVHcOl0zCLmh1pfDpwzq3uyTXqsAsyGsZ3p3g/wL1l/7kD4q9k0MYmrwacG5IOUNqi
         bdgXUzfeiBCfOIl2E9jq5vju7PCqTRQ+2HtutirqU2P9UqLZF1XIzodxKtrX+secgxas
         Twgi5wgT8OlD7xW6jSRrO0iJ5+yNqIU89EHBLrhb7LcHEEM49wACTTpVGFNfWgchOL5/
         SkfhCVbHtbTCoBBkEZhAuNRBV0llTLlYFD5t+koyaUpwwXWB6zY30U1oQsFftR5ovhoI
         DPXA==
X-Gm-Message-State: AOAM533jdTJMPslDldvGPvGW4GAn16VhTdBW1oF7nSoCz/iIMk6Tqr8I
        GyGKijI8kHPtzCTu0YKtycE=
X-Google-Smtp-Source: ABdhPJxc7oIqPqigRdH3NLgi0T8fDfL1gY0TNXCbN4K98dABPZsfbCXHUO7bCzZsCZ8KEZ1fUxvcFg==
X-Received: by 2002:adf:a495:: with SMTP id g21mr3705125wrb.198.1610556381808;
        Wed, 13 Jan 2021 08:46:21 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id r1sm4274016wrl.95.2021.01.13.08.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:46:20 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:46:19 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] arm64: dts: imx: Add i.mx8mm nitrogen8mm basic
 dts support
Message-ID: <20210113164619.GA5874@kozik-lap>
References: <20210113143443.1148506-1-adrien.grassein@gmail.com>
 <20210113143443.1148506-3-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210113143443.1148506-3-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 03:34:42PM +0100, Adrien Grassein wrote:
> Tested with a basic Build Root configuration booting from sdcard.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 364 ++++++++++++++++++
>  2 files changed, 365 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 901d80086b47..b2eb7a5e4db3 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -45,6 +45,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-nitrogen.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen8mm_rev2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-phanbell.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-pico-pi.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-thor96.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
> new file mode 100644
> index 000000000000..506e467ebf16
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
> @@ -0,0 +1,364 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree file for Boundary Devices i.MX8MMini Nitrogen8MM Rev2 board.
> + * Adrien Grassein <adrien.grassein@gmail.com.com>
> + */
> +/dts-v1/;
> +#include "imx8mm.dtsi"
> +
> +/ {
> +	model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
> +	compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
> +
> +	reg_vref_1v8: regulator-vref-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref-1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	reg_vref_3v3: regulator-vref-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref-3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};

Why do you need these two regulators? They don't do anything, there is
no control over them.

> +};
> +
> +&A53_0 {
> +	cpu-supply = <&reg_sw3>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&reg_sw3>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&reg_sw3>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&reg_sw3>;
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	pinctrl-1 = <&pinctrl_i2c1_1>;
> +	scl-gpios = <&gpio5 14 GPIO_OPEN_DRAIN>;
> +	sda-gpios = <&gpio5 15 GPIO_OPEN_DRAIN>;
> +	status = "okay";
> +
> +	pmic@8 {
> +		compatible = "nxp,pf8121a";
> +		reg = <0x8>;
> +		status = "okay";
> +
> +		regulators {
> +			reg_ldo2: ldo2 {

The PMIC regulators should be described fully, so bring them back from
the v1.

> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <5000000>;
> +				regulator-min-microvolt = <1500000>;
> +			};
> +
> +			reg_sw3: buck3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-min-microvolt =  <400000>;
> +			};
> +		};
> +	};
> +};
> +
> +&fec1 {

Please order the overridden nodes alphabetically, with iomux exception
which goes to the end (by convention in NXP). You define i2c1, then fec1
and then i2c3. Should be fec1, i2c1 and then i2c3.

Best regards,
Krzysztof
