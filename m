Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BDC304EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391819AbhA0BTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbhAZSYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:24:41 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F2C0613D6;
        Tue, 26 Jan 2021 10:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YfHIjNrro/6Ndfv7PgpQ110GyRrmBfAnVLlcT8hzI1U=; b=a7rLZkeSffCmOnGTcEyuEmvq87
        RUfbGPdv45K7uTWPrPsHWyYiSewuIaTMZPZM9cO4qy9kSU7sUKZq4TNT5xbIzJrQAAyQSA40DsP6H
        uMS9loZxg3QNOmxJqo8I+UHcYpXN8YQkc70GzB57+85f9mOapcqFdjkW/+B7YqAMDQ3M=;
Received: from p200300ccff1467001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff14:6700:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1l4T0N-00062m-PJ; Tue, 26 Jan 2021 19:23:56 +0100
Date:   Tue, 26 Jan 2021 19:23:55 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Armin Preiml <apreiml@strohwolke.at>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dts: ARM: add kobo glo hd ebook reader
Message-ID: <20210126192355.567b0140@aktux>
In-Reply-To: <20210126173130.45427-1-apreiml@strohwolke.at>
References: <20210126173130.45427-1-apreiml@strohwolke.at>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 26 Jan 2021 18:31:31 +0100
Armin Preiml <apreiml@strohwolke.at> wrote:

> This patch adds basic support for the kobo glo hd reader. It defines CPU, 
> memory, UART and storage.Also add pin control settings for i2c and sdhc. 
> 
> All values where extracted from the vendor kernel and u-boot sources.
> 
> Signed-off-by: Armin Preiml <apreiml@strohwolke.at>
> 
> ---
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/imx6sl-kobo-glo-hd.dts | 164 +++++++++++++++++++++++
>  2 files changed, 165 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6sl-kobo-glo-hd.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 3d1ea0b25..ba608414e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -598,6 +598,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6qp-zii-rdu2.dtb
>  dtb-$(CONFIG_SOC_IMX6SL) += \
>  	imx6sl-evk.dtb \
> +	imx6sl-kobo-glo-hd.dtb \
>  	imx6sl-tolino-shine2hd.dtb \
>  	imx6sl-tolino-shine3.dtb \
>  	imx6sl-warp.dtb
> diff --git a/arch/arm/boot/dts/imx6sl-kobo-glo-hd.dts b/arch/arm/boot/dts/imx6sl-kobo-glo-hd.dts
> new file mode 100644
> index 000000000..759699e9e
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6sl-kobo-glo-hd.dts
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: (GPL-2.0)
> +/*
> + * Device tree for the Kobo Glo HD ebook reader.
> + *
> + * Name on mainboard is: 37NB-E60Q90+4A1
> + * Board name in uboot sources: E60Q90  
> + *
> + * Copyright 2021 Armin Preiml
> + * based on works
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "imx6sl.dtsi"
> +
> +/ {
> +	model = "Kobo Glo HD";
> +	compatible = "kobo,glohd", "fsl,imx6sl";
> +

kobo,glohd should be added to
Documentation/devicetree/bindings/arm/fsl.yaml
[...]
> +        pinctrl_uart1: uart1grp {
> +                fsl,pins = <
> +			MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
> +			MX6SL_PAD_UART1_RXD__UART1_RX_DATA 0x1b0b1
> +		>;
> +	};
> +
hmm, pictures (we are talking about FCC ID NOIKBN437, right?) show two
uarts, next to each other. Which one is this? 
The other uart might be the same as in the tolino2-shinehd.

> +	pinctrl_usdhc1: usdhc1grp { /* 50MHZ (>50MHZ: 0x1f0f9) */
> +                fsl,pins = <
> +			MX6SL_PAD_SD1_CLK__SD1_CLK 0x1f071
> +			MX6SL_PAD_SD1_CMD__SD1_CMD 0x1f071
> +			MX6SL_PAD_SD1_DAT0__SD1_DATA0 0x1f071
> +			MX6SL_PAD_SD1_DAT1__SD1_DATA1 0x1f071
> +			MX6SL_PAD_SD1_DAT2__SD1_DATA2 0x1f071
> +			MX6SL_PAD_SD1_DAT3__SD1_DATA3 0x1f071
> +			MX6SL_PAD_SD1_DAT4__SD1_DATA4 0x1f071
> +			MX6SL_PAD_SD1_DAT5__SD1_DATA5 0x1f071
> +			MX6SL_PAD_SD1_DAT6__SD1_DATA6 0x1f071
> +			MX6SL_PAD_SD1_DAT7__SD1_DATA7 0x1f071
> +		>;
> +	};
> +
That is for emmc? And it is not populated, so probably better not
enable that here.

[...]

> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	status = "okay";
> +};
> +
and also not add this.

I guess it might be a good idea to really compare it to the tolino2
shine hd. The boards seem to look similar, but not identical. Hmm,
different number of buttons?
The question is how similar they are. I think the Kobo Glo HD has a
good driver situation. 
The main PMIC RC5T619 (the rn5t618 driver supports that) is well
supported in mainline kernel. It should give regulators, RTC and battery
information.
The touchscreen (driver zforce_ts) should alse be supported. So
you might go further forward.

If you are really brave, you could add a complete devicetree on top
of my branch
kobo/drm-merged-5.10 of github.com/akemnade/linux. Besides of backlight,
it should give full hardware support (including a drm driver for the
display), so we can see what is different and whether we can use
a .dtsi file to define common things.
Picture of the Tolino2 internals:
https://misc.andi.de1.cc/tolino2.jpg

Regards,
Andreas
