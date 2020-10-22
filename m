Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B7E295C31
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896140AbgJVJsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 05:48:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40704 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896002AbgJVJsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 05:48:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id h5so1411469wrv.7;
        Thu, 22 Oct 2020 02:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oGGYYimYo6kGDWG9p0hxJF/RWR4jWQFU1rqRCopJnao=;
        b=GvuED4kPXS21NTL3M/A++jgUcPcftR90Xb6jIJ90Io4gQjn6qmFPpMAA/b530N/jZa
         idzkN+ubPSVpyaOl6GsAY7W2OrTztPufl7jFP+OKlQYc3+89OJLvYYAS9o9H0XGeL81F
         s93ninsE9qO+7gajVLGBI3Zbwwi/Rdfmxe/f4USGezGxcPF4DSXkkcXHi1US63a1pPkE
         zNN1q4T2xnpgvlDUe5bpe2SKIIN2Aw8XZB5clgA9RkPqrgYtNOf7WxJG0SJoRNOInqfN
         czuCwKPG1Z8duFJd3B+WDmU3yE2aGY0vudbB3sGwvRJPHJcvtpnqmEsm6/oNmVB+ojel
         nDHw==
X-Gm-Message-State: AOAM530DdbGuRi5Ayl8/mVCar9rG5wxr9sEwJZqF+EtosLOD419hwoqj
        /yBjnALxSE92Ss/JPEWM0vM=
X-Google-Smtp-Source: ABdhPJyRKjWFqTBCBg2Z37TF9Oqb7Q2FfTPR3AcTrKOEszK6r1mLavjHjCKR2jfZUmOvFpBFhug6sA==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr1888271wrp.179.1603360119551;
        Thu, 22 Oct 2020 02:48:39 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id h3sm2791236wrw.78.2020.10.22.02.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 02:48:38 -0700 (PDT)
Date:   Thu, 22 Oct 2020 11:48:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 3/3] ARM: dts: add Van der Laan LANMCU board
Message-ID: <20201022094836.GA93851@kozik-lap>
References: <20201022073545.29919-1-o.rempel@pengutronix.de>
 <20201022073545.29919-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022073545.29919-4-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 09:35:45AM +0200, Oleksij Rempel wrote:
> Van der Laan LANMCU is a module for the food storage rooms to control
> proper gas composition.
> 
> Co-Developed-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/Makefile          |   1 +
>  arch/arm/boot/dts/imx6dl-lanmcu.dts | 469 ++++++++++++++++++++++++++++
>  2 files changed, 470 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-lanmcu.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 2289a28c0ff6..dc2543a7b7e9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -447,6 +447,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-icore.dtb \
>  	imx6dl-icore-mipi.dtb \
>  	imx6dl-icore-rqs.dtb \
> +	imx6dl-lanmcu.dtb \
>  	imx6dl-mamoj.dtb \
>  	imx6dl-nit6xlite.dtb \
>  	imx6dl-nitrogen6x.dtb \
> diff --git a/arch/arm/boot/dts/imx6dl-lanmcu.dts b/arch/arm/boot/dts/imx6dl-lanmcu.dts
> new file mode 100644
> index 000000000000..bda2c7a304ba
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-lanmcu.dts
> @@ -0,0 +1,469 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Protonic Holland
> + * Copyright (c) 2020 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
> + */
> +

[...]

> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x17099
> +			MX6QDL_PAD_SD3_CLK__SD3_CLK			0x10099
> +			MX6QDL_PAD_SD3_DAT0__SD3_DATA0			0x17099
> +			MX6QDL_PAD_SD3_DAT1__SD3_DATA1			0x17099
> +			MX6QDL_PAD_SD3_DAT2__SD3_DATA2			0x17099
> +			MX6QDL_PAD_SD3_DAT3__SD3_DATA3			0x17099
> +			MX6QDL_PAD_SD3_DAT4__SD3_DATA4			0x17099
> +			MX6QDL_PAD_SD3_DAT5__SD3_DATA5			0x17099
> +			MX6QDL_PAD_SD3_DAT6__SD3_DATA6			0x17099
> +			MX6QDL_PAD_SD3_DAT7__SD3_DATA7			0x17099
> +			MX6QDL_PAD_SD3_RST__SD3_RESET			0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_wifi_npd: wifinpd {

I missed this one last time, I am sorry. The dtschema for IMX requires
pinctrl groups to end with "grp", so "wifinpdgrp" or just "wifigrp".

Best regards,
Krzysztof

