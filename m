Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F072DFC73
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 14:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgLUNxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 08:53:18 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:53226 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgLUNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 08:53:17 -0500
Received: by mail-wm1-f52.google.com with SMTP id a6so9942353wmc.2;
        Mon, 21 Dec 2020 05:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZGMHpoCRLlbOSEzZjyZVGgOPbJYrjNNdJ+KlSJquj+Q=;
        b=fVBFKEvAy4x+iU+af9o/SiLvpi02hIkA6puaSWPR6BF8qFUD116hMHZOgy7brmZ75N
         LiHbBqvs5iSsGXnr85Gp3eK7WzAWR0OaoVaPeWoG6v5TM9ISYl7+y1bnIc4u8iSNtXqR
         +0aq+V+NUbwfOd7rvCGecnt18iJKF1jKYT4T4I60VdnzEGql9gFvbUVN4EheRNApjBK9
         MfMAj1pDV739BCvLvdXytvA5exxRfjm7cun2x4HHS47vRUqi0TLN+xPbpjlRJy8jzZFh
         rrltBJZt4Xk/4r+EzeyTsZEMYgD6/ebUsHFYt2vGfP9crMQcIwf6U+r7dRVlfiAVdujP
         MeSg==
X-Gm-Message-State: AOAM5311iD1ptsvDvUJzC0hjumeWShKP2FVzopZwpU5Tx8w3Hn+SyXqs
        rl3FoRv/CBwI0vo/z4cKN/o=
X-Google-Smtp-Source: ABdhPJyn9o9z9crVuHtjXoAdSRRjx8DzRlfUgq/b6lvll+qePrGU8R5O4xYbBX9OMsmd2QtgJ8jqcQ==
X-Received: by 2002:a1c:7d94:: with SMTP id y142mr16765008wmc.105.1608558754985;
        Mon, 21 Dec 2020 05:52:34 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id z3sm27811592wrn.59.2020.12.21.05.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 05:52:33 -0800 (PST)
Date:   Mon, 21 Dec 2020 14:52:32 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 SoM
Message-ID: <20201221135232.GC31176@kozik-lap>
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
 <20201221113151.94515-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201221113151.94515-4-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 05:01:48PM +0530, Jagan Teki wrote:
> i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini
> from Engicam.
> 
> General features:
> - NXP i.MX8M Mini
> - Up to 2GB LDDR4
> - 8/16GB eMMC
> - Gigabit Ethernet
> - USB 2.0 Host/OTG
> - PCIe Gen2 interface
> - I2S
> - MIPI DSI to LVDS
> - rest of i.MX8M Mini features
> 
> i.Core MX8M Mini needs to mount on top of Engicam baseboards
> for creating complete platform solutions.
> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - updated commit message
> - add cpu nodes
> - add fec1 node
> - fixed pmic tree comments
> - dropped engicam from filename since it aligned with imx6 engicam
>   dts files naming conventions.

Thanks for the changes.

> 
>  .../dts/freescale/imx8mm-icore-mx8mm.dtsi     | 232 ++++++++++++++++++
>  1 file changed, 232 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi
> new file mode 100644
> index 000000000000..e67865fd102a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 NXP
> + * Copyright (c) 2019 Engicam srl
> + * Copyright (c) 2020 Amarula Solutons(India)
> + */
> +
> +/ {
> +	compatible = "engicam,icore-mx8mm", "fsl,imx8mm";
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&reg_buck4>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&reg_buck4>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&reg_buck4>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&reg_buck4>;
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy>;
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy: ethernet-phy@3 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <3>;
> +			reset-gpios = <&gpio3 7 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10000>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic@8 {
> +		compatible = "nxp,pf8121a";
> +		reg = <0x08>;
> +
> +		regulators {
> +			reg_ldo1: ldo1 {
> +				regulator-max-microvolt = <5000000>;
> +				regulator-min-microvolt = <1500000>;

I mentioned previously min/max hoping it will be obvious (as most or
even all of DTS follow this convention... although not example in your
regulator) but let be more specific: first min, then max. Don't reverse
the logic. See also example in the regulator.yaml.

Best regards,
Krzysztof
