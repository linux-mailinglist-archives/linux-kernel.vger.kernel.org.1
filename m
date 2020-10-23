Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC42296C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461748AbgJWJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:52:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37432 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461695AbgJWJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:52:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id o18so948700edq.4;
        Fri, 23 Oct 2020 02:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f/8HDITGONi7lAEbL49t2FC11Ajj2yI5i/0Rt6na+KA=;
        b=EZYcJIGTWkF4yZDVh19fALOIY0vxj7imgzuU2MlDye/2l8O7fUPfUeBQQ1luvyDPNq
         2+tHFsWHDSxyz4rN+Wp9uT6yxSwqqEp9VaxVbKMmwijI/Nf+k7F3hsm5v7pkk1onx4PU
         UNHKzdpjqRf3fsPadnteDNqZF5Tfb21+ygkYWkf/6fgkz7ux+UntRIInYvfmMnoz6UBQ
         ubU1vcbCNaGa8Iijp9XhyQnZTf6q2NwlgW/HUROMd4wlXyZHDV556O20BmqpzTkBy1gi
         HRSbFs57JuuNgq1Mb0owIBdHpb7bK2YVdx0SocPVF0oWLBDcUaI+Fk2gjFPpit0GA8mx
         uetA==
X-Gm-Message-State: AOAM531aS5K02IGwsFr4DAGPDyoiF6RBqJiYShBka3zNNZGs2ohkZ/Mm
        ntXF9chpsqug4pLsm7aO2ac=
X-Google-Smtp-Source: ABdhPJxhP5ZH0S6JjeUHoDspfvyjzZ8blspiDaUFFPFJf+E2anXpyPAszr6BAwe+rS9ZvVI1Mni2yw==
X-Received: by 2002:a50:fb0d:: with SMTP id d13mr1361390edq.85.1603446751699;
        Fri, 23 Oct 2020 02:52:31 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id p4sm506224eji.105.2020.10.23.02.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:52:30 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:52:27 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, marex@denx.de,
        l.stach@pengutronix.de, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: imx8mn: add GPC node and power domains
Message-ID: <20201023095227.GE42872@kozik-lap>
References: <20201022150808.763082-1-aford173@gmail.com>
 <20201022150808.763082-4-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022150808.763082-4-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 10:08:06AM -0500, Adam Ford wrote:
> This adds the DT nodes to describe the power domains available on the
> i.MX8MN. There are four power domains, but the displaymix and mipi
> power domains need a separate clock block controller which is also
> pending for 8MP and 8MM. Once the path for those is clear, Nano will
> need something similar, but the registers for Nano differ.  For now,
> the dispmix and mipi are placeholders.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 9b4baf7bdfb1..27733fbe87e9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -596,6 +596,55 @@ src: reset-controller@30390000 {
>  				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
>  				#reset-cells = <1>;
>  			};
> +
> +			gpc: gpc@303a0000 {
> +				compatible = "fsl,imx8mn-gpc";
> +				reg = <0x303a0000 0x10000>;
> +				interrupt-parent = <&gic>;
> +				interrupt-controller;
> +				#interrupt-cells = <3>;

Missing interrupts.

> +
> +				pgc {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					pgc_hsiomix: power-domain@0 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8MN_POWER_DOMAIN_HSIOMIX>;
> +						clocks = <&clk IMX8MN_CLK_USB_BUS>;
> +					};
> +
> +					pgc_otg1: power-domain@1 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8MN_POWER_DOMAIN_OTG1>;
> +						power-domains = <&pgc_hsiomix>;
> +					};
> +
> +					pgc_gpumix: power-domain@2 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8MN_POWER_DOMAIN_GPUMIX>;
> +						clocks = <&clk IMX8MN_CLK_GPU_CORE_ROOT>,
> +							 <&clk IMX8MN_CLK_GPU_SHADER_DIV>,
> +							 <&clk IMX8MN_CLK_GPU_BUS_ROOT>,
> +							 <&clk IMX8MN_CLK_GPU_AHB>;
> +						resets = <&src IMX8MQ_RESET_GPU_RESET>;

Does it compile without include? Did the include come via dependencies
of this patch?

Best regards,
Krzysztof

