Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03121296BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461102AbgJWJF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461096AbgJWJF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:05:29 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29696C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:05:28 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a7so1179362lfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=11FP7yalsP50Ez/WueamNfeyE2agUkdlErUqg/OXuMw=;
        b=W/sERpTP4lxb2ggRoioWFZlxUIepyCZ97ubq2C5VUOng+ES1C6TQBSBc0id96c9gzh
         G7VwvHRMNYYQ7+r9jaR9TWrxOIMagAiqZJePOcazaVo1ewFNE6d/2tL7xx6p1O0pikfH
         nO5o1nEMnDizIqoZeCwfBRTguc7tJcJcBWHszOkeisHj/oVesrIX7dxYeNVxG2OWyYag
         KwZsTiFzBu/c7UHJ9i5eIDBt/hyQFfBjxS1kg1JgbNEOKINRU5BUKht5Gd+6Qlsy8Pw1
         xI46qw2UFX2qOLP1xe0ykKc6vrd/JscbXLkU2Hzfqy3lTmCcE026YhTNz0/j9rbzxNS5
         zARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=11FP7yalsP50Ez/WueamNfeyE2agUkdlErUqg/OXuMw=;
        b=TOM817/AcwPXJvU0kD6+D0osxV2Y2F0Ak+tSNWjIAydWmr6FSivZ5bn58bkUh4DQPa
         UXUb1BO+ofOW1vbRWCNmmoS8klcA2Y1EwyYB26JKjDU1ojknliY4fxsmvK5e+NKYGJfa
         ZTeHQTpd9YtgE+cEtSZ4Jffvp0S1bvUC2l7c5PqnZ5xS3RQoEtVBasI1Dc52oVb/2MyY
         OxmFFVXukDQGtsA6kpnQL4TE8ERiF9atwS/wvyt20J1G/htFXae9bK0mkTARxAMu9YHX
         NZ6qwpEbAxVU/WFqP/YLoxhHqGuywxM/XhKCFEGI8ggK2BkRPVITv4M/j1qC054ZdyLS
         eb5Q==
X-Gm-Message-State: AOAM533dok2x3DsTYI2cBoAK3tAoRICBs+pF66eMz3z+wLQPbGv3G+i8
        IbfOKpB1CBoRawbXTFMM6QAVKw==
X-Google-Smtp-Source: ABdhPJwPYhQ0wJjoyfbQl/e5iUtqMSAHb3mWoLpwYBweHjq/SMbEM2HSHb+NBsdypLcOig6o6+NPlg==
X-Received: by 2002:a19:24c2:: with SMTP id k185mr476316lfk.46.1603443926584;
        Fri, 23 Oct 2020 02:05:26 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id m29sm78448lfj.144.2020.10.23.02.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:05:25 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:05:24 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: renesas: Add support for MIPI Adapter
 V2.1 connected to HiHope RZ/G2H
Message-ID: <20201023090524.GD2158081@oden.dyn.berto.se>
References: <20201020125134.22625-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201020125134.22625-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201020125134.22625-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

Thanks for your work.

On 2020-10-20 13:51:32 +0100, Lad Prabhakar wrote:
> Add support for AISTARVISION MIPI Adapter V2.1 board connected to HiHope
> RZ/G2H board.
> 
> Common file hihope-rzg2-ex-aistarvision-mipi-adapter-2.1.dtsi is created
> which will be used by RZ/G2{HMN}, by default the CSI20 node is tied to
> ov5645 camera endpoint and the imx219 camera endpoint is tied to CSI40.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

I have not reviewed the schematics but the patch in itself looks good,

Acked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> v1->v2 - No change
> ---
>  arch/arm64/boot/dts/renesas/Makefile          |   1 +
>  ...rzg2-ex-aistarvision-mipi-adapter-2.1.dtsi | 109 ++++++++++++++++++
>  .../r8a774e1-hihope-rzg2h-ex-mipi-2.1.dts     |  16 +++
>  3 files changed, 126 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/hihope-rzg2-ex-aistarvision-mipi-adapter-2.1.dtsi
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dts
> 
> diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
> index dffefe030a76..f98e9e2e520d 100644
> --- a/arch/arm64/boot/dts/renesas/Makefile
> +++ b/arch/arm64/boot/dts/renesas/Makefile
> @@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-ek874-mipi-2.1.dtb
>  dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h.dtb
>  dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h-ex.dtb
>  dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb
> +dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h-ex-mipi-2.1.dtb
>  
>  dtb-$(CONFIG_ARCH_R8A77950) += r8a77950-salvator-x.dtb
>  dtb-$(CONFIG_ARCH_R8A77950) += r8a77950-ulcb.dtb
> diff --git a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex-aistarvision-mipi-adapter-2.1.dtsi b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex-aistarvision-mipi-adapter-2.1.dtsi
> new file mode 100644
> index 000000000000..c62ddb9b2ba5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex-aistarvision-mipi-adapter-2.1.dtsi
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the HiHope RZ/G2[HMN] MIPI common parts
> + *
> + * Copyright (C) 2020 Renesas Electronics Corp.
> + */
> +
> +#define MIPI_OV5645_PARENT_I2C i2c2
> +#define MIPI_IMX219_PARENT_I2C i2c3
> +#include "aistarvision-mipi-adapter-2.1.dtsi"
> +
> +&csi20 {
> +	status = "okay";
> +
> +	ports {
> +		port@0 {
> +			reg = <0>;
> +			csi20_in: endpoint {
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +				remote-endpoint = <&ov5645_ep>;
> +			};
> +		};
> +	};
> +};
> +
> +&csi40 {
> +	status = "okay";
> +
> +	ports {
> +		port@0 {
> +			reg = <0>;
> +			csi40_in: endpoint {
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +				remote-endpoint = <&imx219_ep>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	pinctrl-0 = <&i2c3_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&imx219 {
> +	port {
> +		imx219_ep: endpoint {
> +			clock-lanes = <0>;
> +			data-lanes = <1 2>;
> +			link-frequencies = /bits/ 64 <456000000>;
> +			remote-endpoint = <&csi40_in>;
> +		};
> +	};
> +};
> +
> +&ov5645 {
> +	enable-gpios = <&gpio6 4 GPIO_ACTIVE_HIGH>;
> +	reset-gpios = <&gpio6 8 GPIO_ACTIVE_LOW>;
> +
> +	port {
> +		ov5645_ep: endpoint {
> +			clock-lanes = <0>;
> +			data-lanes = <1 2>;
> +			remote-endpoint = <&csi20_in>;
> +		};
> +	};
> +};
> +
> +&pfc {
> +	i2c3_pins: i2c3 {
> +		groups = "i2c3";
> +		function = "i2c3";
> +	};
> +};
> +
> +&vin0 {
> +	status = "okay";
> +};
> +
> +&vin1 {
> +	status = "okay";
> +};
> +
> +&vin2 {
> +	status = "okay";
> +};
> +
> +&vin3 {
> +	status = "okay";
> +};
> +
> +&vin4 {
> +	status = "okay";
> +};
> +
> +&vin5 {
> +	status = "okay";
> +};
> +
> +&vin6 {
> +	status = "okay";
> +};
> +
> +&vin7 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dts b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dts
> new file mode 100644
> index 000000000000..46adb6efb5e6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the HiHope RZ/G2H board
> + * connected with aistarvision-mipi-v2-adapter board
> + *
> + * Copyright (C) 2020 Renesas Electronics Corp.
> + */
> +
> +/dts-v1/;
> +#include "r8a774e1-hihope-rzg2h-ex.dts"
> +#include "hihope-rzg2-ex-aistarvision-mipi-adapter-2.1.dtsi"
> +
> +/ {
> +	model = "HopeRun HiHope RZ/G2H with sub board connected with aistarvision-mipi-v2-adapter board";
> +	compatible = "hoperun,hihope-rzg2h", "renesas,r8a774e1";
> +};
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
