Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE796287AA3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbgJHRJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:09:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35878 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730738AbgJHRJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:09:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id l16so6608855eds.3;
        Thu, 08 Oct 2020 10:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZVaDCSgDeBgB1H5Omrb/9frcxsipDouyHZifrCkh+Sw=;
        b=fmev4me0ShENbFA+Zcl5PPBvQ3gRjIrf3LXjJL3ivIa3cPkUC04xo/uwxbeJR3yBW0
         WTK8Ig8yZUCL6vvFXp2vdpsprHejq2sAkJ2LZogUpGq0d6tdjQ5J87IS4wMrgqO6KAie
         br6I3y3NEAKW7vh5wqhx7jOdTcC5vJS4JJaVivyX7TsIWXVuIl/Vg4eMLcz2aAz2zPUi
         iOe1auM/HNjbirzx97e4NdxNJtIv7bq/wtS5f0HHzvBRpUMq3S1g970Gj1lObiNSiT1Q
         ONyyVtuSwxIQuCFykt7BLmSx275AWzx6qj55W1qXG/pOVXC3gwniNeb/YaadwOfnLn3v
         9OmQ==
X-Gm-Message-State: AOAM530R5Mffxj/OdgQCjAWPjqAd3Nr2eRgYCqrnqKHzSLOZN+/X4cPN
        BNbOIUlga2GMEe7whwIsmwc=
X-Google-Smtp-Source: ABdhPJw66lM1R8BwIi7JkKSnzQV2QXJ4Nuv9rO43LE1wG0YEQnC8ei3WTVcH5e9wQq7kI1rmbEFyIw==
X-Received: by 2002:a50:b063:: with SMTP id i90mr10323394edd.187.1602176973402;
        Thu, 08 Oct 2020 10:09:33 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id ba6sm4439757edb.61.2020.10.08.10.09.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Oct 2020 10:09:32 -0700 (PDT)
Date:   Thu, 8 Oct 2020 19:09:29 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts imx8mn: Remove non-existent USB OTG2
Message-ID: <20201008170929.GA6018@kozik-lap>
References: <20201008151933.716363-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008151933.716363-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 10:19:33AM -0500, Adam Ford wrote:
> According to the i.MX8MN TRM, there is only one OTG port.  The
> address for OTG2 is reserved on Nano.
> 
> This patch removes the non-existent OTG2.
> 
> Fixes: 6c3debcbae47 ("arm64: dts: freescale: Add i.MX8MN dtsi support")
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 746faf1cf2fb..ac206e1f2dad 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -791,21 +791,6 @@ usbmisc1: usbmisc@32e40200 {
>  				reg = <0x32e40200 0x200>;
>  			};
>  
> -			usbotg2: usb@32e50000 {
> -				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb";
> -				reg = <0x32e50000 0x200>;
> -				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;
> -				clock-names = "usb1_ctrl_root_clk";
> -				assigned-clocks = <&clk IMX8MN_CLK_USB_BUS>,
> -						  <&clk IMX8MN_CLK_USB_CORE_REF>;
> -				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>,
> -							 <&clk IMX8MN_SYS_PLL1_100M>;
> -				fsl,usbphy = <&usbphynop2>;
> -				fsl,usbmisc = <&usbmisc2 0>;
> -				status = "disabled";
> -			};
> -
>  			usbmisc2: usbmisc@32e50200 {
>  				compatible = "fsl,imx8mn-usbmisc", "fsl,imx7d-usbmisc";
>  				#index-cells = <1>;

Good catch but please also remove usbmisc2 and the usbphy nodes.

Best regards,
Krzysztof
