Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3DB27FA1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbgJAHWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJAHWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:22:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1439BC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 00:22:09 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kNsuk-0000iy-E1; Thu, 01 Oct 2020 09:22:06 +0200
Subject: Re: [PATCH v2 08/12] ARM: dts: imx6dl-pico: fix board compatibles
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-9-krzk@kernel.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <0a0afea6-8cbb-3e89-5a4f-89660c942ca3@pengutronix.de>
Date:   Thu, 1 Oct 2020 09:22:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200930190143.27032-9-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 9/30/20 9:01 PM, Krzysztof Kozlowski wrote:
> There are four flavors of TechNexion PICO-IMX6 boards.  They have their
> own DTSes, even though in Dwarf, Nymph and Pi are exactly the same.
> They also have their own bindings so adjust the compatibles to match the
> bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. None
> ---
>  arch/arm/boot/dts/imx6dl-pico-dwarf.dts  | 2 +-
>  arch/arm/boot/dts/imx6dl-pico-hobbit.dts | 2 +-
>  arch/arm/boot/dts/imx6dl-pico-nymph.dts  | 2 +-
>  arch/arm/boot/dts/imx6dl-pico-pi.dts     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-pico-dwarf.dts b/arch/arm/boot/dts/imx6dl-pico-dwarf.dts
> index 659a8e8714ea..d85b15a8c127 100644
> --- a/arch/arm/boot/dts/imx6dl-pico-dwarf.dts
> +++ b/arch/arm/boot/dts/imx6dl-pico-dwarf.dts
> @@ -13,5 +13,5 @@
>  
>  / {
>  	model = "TechNexion PICO-IMX6 DualLite/Solo Board and Dwarf baseboard";
> -	compatible = "technexion,imx6dl-pico", "fsl,imx6dl";
> +	compatible = "technexion,imx6dl-pico-dwarf", "fsl,imx6dl";

Could you change this to have all three compatibles ("technexion,imx6dl-pico-dwarf", "technexion,imx6dl-pico",
"fsl,imx6dl") and likewise for the other files? 
That way other firmware that reuses the Linux device tree files and match against the SoM compatible
continues to work after update.

>  };
> diff --git a/arch/arm/boot/dts/imx6dl-pico-hobbit.dts b/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
> index d7403c5c4337..08fedcbcc91b 100644
> --- a/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
> +++ b/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
> @@ -13,5 +13,5 @@
>  
>  / {
>  	model = "TechNexion PICO-IMX6 DualLite/Solo Board and Hobbit baseboard";
> -	compatible = "technexion,imx6dl-pico", "fsl,imx6dl";
> +	compatible = "technexion,imx6dl-pico-hobbit", "fsl,imx6dl";
>  };
> diff --git a/arch/arm/boot/dts/imx6dl-pico-nymph.dts b/arch/arm/boot/dts/imx6dl-pico-nymph.dts
> index b282dbf953aa..32ccfc5d41ce 100644
> --- a/arch/arm/boot/dts/imx6dl-pico-nymph.dts
> +++ b/arch/arm/boot/dts/imx6dl-pico-nymph.dts
> @@ -13,5 +13,5 @@
>  
>  / {
>  	model = "TechNexion PICO-IMX6 DualLite/Solo Board and Nymph baseboard";
> -	compatible = "technexion,imx6dl-pico", "fsl,imx6dl";
> +	compatible = "technexion,imx6dl-pico-nymph", "fsl,imx6dl";
>  };
> diff --git a/arch/arm/boot/dts/imx6dl-pico-pi.dts b/arch/arm/boot/dts/imx6dl-pico-pi.dts
> index b7b1c07f96f3..4590e8ad9a91 100644
> --- a/arch/arm/boot/dts/imx6dl-pico-pi.dts
> +++ b/arch/arm/boot/dts/imx6dl-pico-pi.dts
> @@ -13,5 +13,5 @@
>  
>  / {
>  	model = "TechNexion PICO-IMX6 DualLite/Solo Board and PI baseboard";
> -	compatible = "technexion,imx6dl-pico", "fsl,imx6dl";
> +	compatible = "technexion,imx6dl-pico-pi", "fsl,imx6dl";
>  };
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
