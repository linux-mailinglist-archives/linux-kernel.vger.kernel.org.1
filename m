Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97072CC3A6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbgLBR1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:27:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36238 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgLBR1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:27:00 -0500
Received: by mail-ed1-f66.google.com with SMTP id j14so4847620edy.3;
        Wed, 02 Dec 2020 09:26:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NZKppA2o4fStxdLjfjRZ7S2o2vOkpaIWjvkic2iBJ2o=;
        b=AwcE/gYjH38mF2/KXK02FQph+wbp26OW2IHamNKYTevRQ+HvvmSHIV+/wjgx4oamTW
         DrCH/XyQnUUCgOXbyHqUlIL1FqDTlKJ8eLh9EmRCQ5HWErhMtF5IIszLtLRrJNHY1m9H
         buhyFTDTw6lL5jwL2NO3Q5G4o6enNeiJuA+MDYTHoP4L1665fL8N77nSalWIdzayAmdf
         lpVl9FlHUcpqDw/jU/oV9nrczDG7TJOXLJs83Si418BNSNYjWzXpAt8Uc6JE9ZiqzcBI
         JyaY7oeAiYdpAMRSKXXDz9i0lxahSY0Pa0SLUm36bbE/XCZmstt8avCS7CSJyJg960aX
         OzGQ==
X-Gm-Message-State: AOAM530HYyDV278soBsf3/ajh6Izwl7WlHuagnFIWv4iAJhVc7TpdnTH
        BH+WOhv6qdkuC76y1E66iq0=
X-Google-Smtp-Source: ABdhPJxdaORGvlxmB1auKltfPkpySKQVxtcRpIMsn7/rGJ5juA54CQrEQkeOpggkaJPTCfdgu/9sUg==
X-Received: by 2002:a50:998d:: with SMTP id m13mr982165edb.143.1606929972528;
        Wed, 02 Dec 2020 09:26:12 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id g9sm405995edw.67.2020.12.02.09.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 09:26:11 -0800 (PST)
Date:   Wed, 2 Dec 2020 19:26:10 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 03/10] arm64: dts: imx: Add Engicam EDIMM2.2 Starter Kit
Message-ID: <20201202172610.GC3490@kozik-lap>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202121241.109952-4-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 05:42:34PM +0530, Jagan Teki wrote:
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
> SOM's like i.Core MX8M Mini needs to mount on top of this Evaluation
> board for creating complete i.Core MX8M Mini EDIMM2.2 Starter Kit.
> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../dts/freescale/imx8mm-engicam-common.dtsi  | 24 +++++++++++++++++++
>  .../freescale/imx8mm-engicam-edimm2.2.dtsi    |  7 ++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
> new file mode 100644
> index 000000000000..67c1a3fe26bc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Engicam srl
> + * Copyright (c) 2020 Amarula Solutions(India)
> + */
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +/* SD */
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
> +	cd-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> +	max-frequency = <50000000>;
> +	bus-width = <4>;
> +	no-1-8-v;
> +	pm-ignore-notify;
> +	keep-power-in-suspend;
> +	status = "okay";
> +};
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

A DTSI file only with UART and SD. You mentioned several features in the
commit msg but none of them are implemented here. There aren't even
CPUs... Maybe this is only a problem of your patch ordering but as of
now - this looks like bogus/empty DTSI which should not be in its own
commit.

Best regards,
Krzysztof

