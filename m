Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610792A1413
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 08:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgJaHui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 03:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgJaHui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 03:50:38 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA69120720;
        Sat, 31 Oct 2020 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604130637;
        bh=FShfaONHN2MtJoKkncPAHJZcCd0fJTGqHwgM6U02FVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pvuqzv4g5qIdf38wiDKQXNzjG3+55P5OVqtlQsfEDmU1LBj7FDQoMyAl63xTNxbq7
         TPMSpfAECankY+ILeh5/t8hXwi+5x1v8ailgaDZSyNXe2zyCVpZwn4AfoHDUmzFU6s
         Fb8CK+0k7WIJgSnhTYzb3gnDx96OagSNlb+FZwuY=
Date:   Sat, 31 Oct 2020 15:50:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de
Subject: Re: [PATCH] ARM: dts: imx: add usb alias
Message-ID: <20201031075030.GS28755@dragon>
References: <1602638861-20278-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602638861-20278-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:27:41AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add usb alias for bootloader emulator the controller in correct order.

emulator?  Not sure what that means.

Shawn

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 4 ++++
>  arch/arm/boot/dts/imx6sl.dtsi  | 3 +++
>  arch/arm/boot/dts/imx6sll.dtsi | 2 ++
>  arch/arm/boot/dts/imx6sx.dtsi  | 3 +++
>  arch/arm/boot/dts/imx6ul.dtsi  | 2 ++
>  arch/arm/boot/dts/imx7d.dtsi   | 6 ++++++
>  arch/arm/boot/dts/imx7s.dtsi   | 2 ++
>  7 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 7a8837cbe21b..947584b40b1f 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -45,6 +45,10 @@ aliases {
>  		spi1 = &ecspi2;
>  		spi2 = &ecspi3;
>  		spi3 = &ecspi4;
> +		usb0 = &usbotg;
> +		usb1 = &usbh1;
> +		usb2 = &usbh2;
> +		usb3 = &usbh3;
>  		usbphy0 = &usbphy1;
>  		usbphy1 = &usbphy2;
>  	};
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 91a8c54d5e11..997b96c1c47b 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -39,6 +39,9 @@ aliases {
>  		spi1 = &ecspi2;
>  		spi2 = &ecspi3;
>  		spi3 = &ecspi4;
> +		usb0 = &usbotg1;
> +		usb1 = &usbotg2;
> +		usb2 = &usbh;
>  		usbphy0 = &usbphy1;
>  		usbphy1 = &usbphy2;
>  	};
> diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
> index 0b622201a1f3..04f8d637a501 100644
> --- a/arch/arm/boot/dts/imx6sll.dtsi
> +++ b/arch/arm/boot/dts/imx6sll.dtsi
> @@ -36,6 +36,8 @@ aliases {
>  		spi1 = &ecspi2;
>  		spi3 = &ecspi3;
>  		spi4 = &ecspi4;
> +		usb0 = &usbotg1;
> +		usb1 = &usbotg2;
>  		usbphy0 = &usbphy1;
>  		usbphy1 = &usbphy2;
>  	};
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index dfdca1804f9f..343f2a3170bb 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -49,6 +49,9 @@ aliases {
>  		spi2 = &ecspi3;
>  		spi3 = &ecspi4;
>  		spi4 = &ecspi5;
> +		usb0 = &usbotg1;
> +		usb1 = &usbotg2;
> +		usb2 = &usbh;
>  		usbphy0 = &usbphy1;
>  		usbphy1 = &usbphy2;
>  	};
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index d7d9f3e46b92..09021a35c266 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -47,6 +47,8 @@ aliases {
>  		spi1 = &ecspi2;
>  		spi2 = &ecspi3;
>  		spi3 = &ecspi4;
> +		usb0 = &usbotg1;
> +		usb1 = &usbotg2;
>  		usbphy0 = &usbphy1;
>  		usbphy1 = &usbphy2;
>  	};
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index cff875b80b60..b0bcfa9094a3 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -7,6 +7,12 @@
>  #include <dt-bindings/reset/imx7-reset.h>
>  
>  / {
> +	aliases {
> +		usb0 = &usbotg1;
> +		usb1 = &usbotg2;
> +		usb2 = &usbh;
> +	};
> +
>  	cpus {
>  		cpu0: cpu@0 {
>  			clock-frequency = <996000000>;
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 84d9cc13afb9..358ef453ce14 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -47,6 +47,8 @@ aliases {
>  		spi1 = &ecspi2;
>  		spi2 = &ecspi3;
>  		spi3 = &ecspi4;
> +		usb0 = &usbotg1;
> +		usb1 = &usbh;
>  	};
>  
>  	cpus {
> -- 
> 2.28.0
> 
