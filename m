Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52202DFC8D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 15:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgLUOH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 09:07:28 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41484 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgLUOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 09:07:27 -0500
Received: by mail-wr1-f44.google.com with SMTP id a12so11177661wrv.8;
        Mon, 21 Dec 2020 06:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xORP8jrGUXgQBvG+agQHXIF7BRNzLoX0I+Ry6aw/+W4=;
        b=pBV1zCvUe+US0HKfIaZ4WKiBmaajN+BPwwcTFtxg1brZWr9MFgVks2BcPdbljIDxin
         ryWMeYL+v6WtPeF1M3LaN0YW0jpYcr54EXHwCU3krmnKZzjrhVUCpQhHw0oeMzVCG3Im
         km1hZ5MH8XpVbkBg8EuDgctn/2ZvZsSs3O5rygg9A+Xi4OGiH5U5mv4AxaKH2XN3rHYO
         mvxGTpoACdzIBgBqHKIA9KwGjuXcdz3aNp7QX5OkhlcThNIkv91wyLn83LCCy2rmBlrm
         aPr2ahOGTfQOpyGc+Msf3+GlLeO7frtAvjhqg1RMoO4kL7nCrjAB18riq9nQ96WGZ9M+
         nd0A==
X-Gm-Message-State: AOAM5315Jq/4aiZZP6BgPrI+Ao5upUkwdyn4PBP1oHwPyzdAapRpcPtw
        LyGqBh627VNYIS7uwvtd46Q=
X-Google-Smtp-Source: ABdhPJzQ9DHU3zo/Mi/uVUbtutH0UYWGEA5VoYHXvwKIb7zUFlovYDlFOAB+6YohHI6P531FNnJlJQ==
X-Received: by 2002:a5d:660b:: with SMTP id n11mr18853016wru.407.1608559605021;
        Mon, 21 Dec 2020 06:06:45 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id u9sm18596490wmb.32.2020.12.21.06.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 06:06:44 -0800 (PST)
Date:   Mon, 21 Dec 2020 15:06:42 +0100
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
Subject: Re: [PATCH v2 6/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 EDIMM2.2 Starter Kit
Message-ID: <20201221140642.GF31176@kozik-lap>
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
 <20201221113151.94515-7-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201221113151.94515-7-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 05:01:51PM +0530, Jagan Teki wrote:
> Engicam EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
> Evaluation Board.
> 
> Genaral features:
> - LCD 7" C.Touch
> - microSD slot
> - Ethernet 1Gb
> - Wifi/BT
> - 2x LVDS Full HD interfaces
> - 3x USB 2.0
> - 1x USB 3.0
> - HDMI Out
> - Mini PCIe
> - MIPI CSI
> - 2x CAN
> - Audio Out
> 
> i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> 
> i.Core MX8M Mini needs to mount on top of this Evaluation board for
> creating complete i.Core MX8M Mini EDIMM2.2 Starter Kit.
> 
> PCIe, DSI, CSI nodes will add it into imx8mm-engicam-edimm2.2.dtsi once
> Mainline Linux supported.
> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - updated commit message
> - dropped engicam from filename since it aligned with imx6 engicam
>   dts files naming conventions.
> 
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../freescale/imx8mm-engicam-edimm2.2.dtsi    |  7 +++++++
>  .../freescale/imx8mm-icore-mx8mm-edimm2.2.dts | 21 +++++++++++++++++++
>  3 files changed, 29 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 8d49a2c74604..43783076f856 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -33,6 +33,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
> new file mode 100644
> index 000000000000..294df07289a2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Engicam srl
> + * Copyright (c) 2020 Amarula Solutions(India)
> + */
> +
> +#include "imx8mm-engicam-common.dtsi"

It seems you ignored my comments from previous email. That's not how we
go with the process.

Don't create confusing or overcomplicated hierarchy of includes. Don't
create files which do nothing.

Best regards,
Krzysztof
