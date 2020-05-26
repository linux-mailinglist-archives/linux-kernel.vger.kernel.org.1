Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D871A4969
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 19:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDJRlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 13:41:50 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37963 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:41:49 -0400
Received: by mail-ot1-f67.google.com with SMTP id d18so2526769otc.5;
        Fri, 10 Apr 2020 10:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tMw0W+47LDJMikvn2rQTXBZsiV0m5ltXOLpqbxXXBe8=;
        b=CcPlbc8BD40u83hDW1h1TwGhT5vetBG6xL2cfTUgKUKmC+J6wNpxXyZykbCufgcc4w
         539Py6lZoMENkfiMmoiePHVMdz73Dl4YhHzGkIb3a6N4XjkfbCzSCsyLTG1xO1ODRk5Q
         Xvw7W2uPzR/Iv2C/st94hlEExdlyDTQ3GCFdoVyFtoKjkRjoCjDhXihwfJ4YZHb3/x/3
         DD1pJ8XG5fhtcLCUu20OpHIh6EAp4j7Mw11ch+obPvH+tX2+i6G552iZx6GanvHv+/XI
         3Y8LcHyvfAjQvylR6NgPeONCluu680xK7/FYwmF6P+W5hNaIx7A4SV2DMuaWiaclZKi0
         OudA==
X-Gm-Message-State: AGi0Pube6Bsr/rTWCZLpvuCVJcl/FZ+Rlb3r5fWxdo70xVh3ysmK7pd4
        5CHgQ1QksjB/v70uqGWJtA==
X-Google-Smtp-Source: APiQypL1Q8OW0KhaDBV7H/NhQYZXEaiJ3p6c2oPjgF0ss6RcxZ5C0z+vtiAJ30p/BTeXTvlUmJp1xg==
X-Received: by 2002:a4a:848e:: with SMTP id n14mr2388840oog.44.1586540509468;
        Fri, 10 Apr 2020 10:41:49 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id b2sm1566683oii.20.2020.04.10.10.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:41:48 -0700 (PDT)
Received: (nullmailer pid 18630 invoked by uid 1000);
        Fri, 10 Apr 2020 17:18:52 -0000
Date:   Fri, 10 Apr 2020 12:18:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v4 2/5] ARM: dts: add Protonic PRTI6Q board
Message-ID: <20200410171852.GA11889@bogus>
References: <20200330120640.9810-1-o.rempel@pengutronix.de>
 <20200330120640.9810-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330120640.9810-3-o.rempel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 02:06:37PM +0200, Oleksij Rempel wrote:
> Protonic PRTI6Q is a development board and a base class for different
> specific customer application boards based on the i.MX6 family of SoCs,
> developed by Protonic Holland.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/imx6q-prti6q.dts            | 551 ++++++++++++++++++
>  arch/arm/boot/dts/imx6qdl-prti6q.dtsi         | 185 ++++++
>  4 files changed, 738 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-prti6q.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-prti6q.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index a8e0b4a813ed..3b52b582efdf 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -119,6 +119,7 @@ properties:
>                - fsl,imx6q-sabreauto
>                - fsl,imx6q-sabrelite
>                - fsl,imx6q-sabresd
> +              - prt,prti6q                      # Protonic PRTI6Q board
>                - technologic,imx6q-ts4900
>                - technologic,imx6q-ts7970
>                - toradex,apalis_imx6q            # Apalis iMX6 Module
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d6546d2676b9..3f500a9e88a9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -530,6 +530,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-phytec-mira-rdk-nand.dtb \
>  	imx6q-phytec-pbab01.dtb \
>  	imx6q-pistachio.dtb \
> +	imx6q-prti6q.dtb \
>  	imx6q-rex-pro.dtb \
>  	imx6q-sabreauto.dtb \
>  	imx6q-sabrelite.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-prti6q.dts b/arch/arm/boot/dts/imx6q-prti6q.dts
> new file mode 100644
> index 000000000000..46a455e20fa3
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-prti6q.dts
> @@ -0,0 +1,551 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2014 Protonic Holland
> + */
> +
> +/dts-v1/;
> +#include "imx6q.dtsi"
> +#include "imx6qdl-prti6q.dtsi"
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/sound/fsl-imx-audmux.h>
> +
> +/ {
> +	model = "Protonic PRTI6Q board";
> +	compatible = "prt,prti6q", "fsl,imx6q";
> +
> +	memory@10000000 {
> +		device_type = "memory";
> +		reg = <0x10000000 0xf0000000>;
> +	};
> +
> +	backlight_lcd: backlight-lcd {
> +		compatible = "pwm-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_backlight>;
> +		pwms = <&pwm1 0 5000000>;
> +		brightness-levels = <0 16 64 255>;
> +		num-interpolated-steps = <16>;
> +		default-brightness-level = <16>;
> +		power-supply = <&reg_3v3>;
> +		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
> +		status = "okay";

Don't need status.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
