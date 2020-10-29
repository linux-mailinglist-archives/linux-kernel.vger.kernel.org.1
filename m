Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C75629F4CB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgJ2TSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:18:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44318 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgJ2TQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:16:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id w1so3062930edv.11;
        Thu, 29 Oct 2020 12:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mmqY+Yeiy9nDKcqsSPAuyb++V3pyCtvEqsSBbBln3ps=;
        b=DRsnSExldqmnDsfmH1uuKr6KDOgzs1m1Uf68hbqQB3LRsrix4FVUmCUAdgV1+/D9G+
         VnSbzaFyc/xzUgfZn3lM4uYnyuQM7JUAizLpzUMqEjDjT2BJlX2oZSkL4QkjPFxror6+
         w/4vS6hr3zm+Ax47Cm0mGlRmwDTRZAEPr0Z8TzJJNVhGToUr1wmkK6kYDxZFJNYymVCC
         XhUR81TLljNno0FoQwZObWLMJdHVbo5F3FgCSt12twAM8UEWerJEPELkvj/2hb4NtoEo
         oKvC83bNsp98KAR7ccA4Mela3eoaT6cOHlMOxhvd0RPxqQmoFyPep1Cmu9RGG4fFt+A+
         0eJg==
X-Gm-Message-State: AOAM531YWdlZ3d5Loj93G/1q95V+wiQsvTdCW6Ffke3v9OKcDGfomUXt
        cEBsz/ExDyT9nZC81+Vb3uU=
X-Google-Smtp-Source: ABdhPJwrfkpQ2JuPFKdrfXz62k6W9divKfUT133kCeLPI66bfIuJh41eOM+GKvaMJw7/hRbB+e24/Q==
X-Received: by 2002:aa7:c98f:: with SMTP id c15mr5804762edt.200.1603999007865;
        Thu, 29 Oct 2020 12:16:47 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n3sm2033380edq.24.2020.10.29.12.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 12:16:46 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:16:45 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8mq-evk: Add spdif sound card support
Message-ID: <20201029191645.GA308501@kozik-lap>
References: <1603964844-832-1-git-send-email-shengjiu.wang@nxp.com>
 <1603964844-832-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1603964844-832-2-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 05:47:24PM +0800, Shengjiu Wang wrote:
> There are two spdif IP on imx8mq, spdif1 is for normal
> spdif device, spdif2 is for HDMI ARC interface.
> 
> Enable these spdif sound card in this patch.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 38 ++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 48 ++++++++++++++++++++
>  2 files changed, 86 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 2418cca00bc5..e4250812586b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -87,6 +87,21 @@ link_codec: simple-audio-card,codec {
>  			clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
>  		};
>  	};
> +
> +	sound-spdif {
> +		compatible = "fsl,imx-audio-spdif";
> +		model = "imx-spdif";
> +		spdif-controller = <&spdif1>;
> +		spdif-out;
> +		spdif-in;
> +	};
> +
> +	sound-hdmi-arc {
> +		compatible = "fsl,imx-audio-spdif";
> +		model = "imx-hdmi-arc";
> +		spdif-controller = <&spdif2>;
> +		spdif-in;
> +	};
>  };
>  
>  &A53_0 {
> @@ -336,6 +351,22 @@ &snvs_pwrkey {
>  	status = "okay";
>  };
>  
> +&spdif1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spdif1>;
> +	assigned-clocks = <&clk IMX8MQ_CLK_SPDIF1>;
> +	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	status = "okay";
> +};
> +
> +&spdif2 {
> +	assigned-clocks = <&clk IMX8MQ_CLK_SPDIF2>;
> +	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	status = "okay";
> +};
> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> @@ -467,6 +498,13 @@ MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8       0xd6
>  		>;
>  	};
>  
> +	pinctrl_spdif1: spdif1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SPDIF_TX_SPDIF1_OUT	0xd6
> +			MX8MQ_IOMUXC_SPDIF_RX_SPDIF1_IN		0xd6
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 49cc79246288..c94b2f80880f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -793,6 +793,30 @@ bus@30800000 { /* AIPS3 */
>  			ranges = <0x30800000 0x30800000 0x400000>,
>  				 <0x08000000 0x08000000 0x10000000>;
>  
> +			spdif1: spdif@30810000 {
> +				compatible = "fsl,imx8mq-spdif", "fsl,imx35-spdif";

This is an undocumented compatible. Checkpatch should point this out.

If this patchset depends on others, please describe it in cover letter or
after '---' separator.

Best regards,
Krzysztof
