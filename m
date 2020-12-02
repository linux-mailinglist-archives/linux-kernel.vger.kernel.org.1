Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0A2CC432
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbgLBRqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:46:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41693 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389271AbgLBRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:46:22 -0500
Received: by mail-ed1-f66.google.com with SMTP id ck29so4883755edb.8;
        Wed, 02 Dec 2020 09:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KQujH+DgczKfL4cTVLHPoonrrbdR99NcEgX+XcWOKS8=;
        b=oEfAKc4sEd4XoC0wT1yGTmRrfDBDArXHl/DHml4RS550EFLpZHQgNFZxRI44aIQGwY
         Ut/07ReyOi9Z1G22r3Q+8hBhWRoYsIi5PpL/Dat3Cp68b25PKKwD9AJ6JMwHxWGA+7fa
         HvyfUf6+u07qzmQ+cAaclcpwvm0ucagbWivRuzrch6G/zyPOhMXlXih2KSpLaEe5i6Iu
         VD2aMd5DrH7puiRmEmMgaTK41RCbM1SsL6GVR1IQyic8Jyw20V0OKw6M3yUmYDN9ydV5
         WqSngjT+fD++wKT/sPm1e5pRSUEAiXeOGcjAv96YLmEoWHk1UWnUCbg0BdrOCr/rgdYQ
         r4bg==
X-Gm-Message-State: AOAM533tacxtMqPYKnPnOGAbu1BNqI88EfWsiOwor+L1VVXW7rMgBFnF
        FrqOkTw3fFj68bdrJvLac44=
X-Google-Smtp-Source: ABdhPJxuPLbF0cdq0buzQ0cI4ciwXJndnNuVlUAc6BZuWmYu2a3yp+6MfdvNvA0vBVsRz1qFHp7YRQ==
X-Received: by 2002:a50:e18c:: with SMTP id k12mr1090339edl.58.1606931140639;
        Wed, 02 Dec 2020 09:45:40 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id be6sm471571edb.29.2020.12.02.09.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 09:45:39 -0800 (PST)
Date:   Wed, 2 Dec 2020 19:45:38 +0200
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
Subject: Re: [PATCH 08/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 C.TOUCH 2.0
Message-ID: <20201202174538.GH3490@kozik-lap>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-9-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202121241.109952-9-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 05:42:39PM +0530, Jagan Teki wrote:
> i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.
> 
> C.TOUCH 2.0 is a general purpose carrier board with capacitive
> touch interface support.
> 
> i.Core MX8M Mini needs to mount on top of this Carrier board for
> creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../imx8mm-engicam-icore-mx8mm-ctouch2.dts    | 21 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 4369d783dade..8191db4c64fa 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
>  
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-ctouch2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-edimm2.2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
> new file mode 100644
> index 000000000000..aa3c03ad3109
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 NXP
> + * Copyright (c) 2019 Engicam srl
> + * Copyright (c) 2020 Amarula Solutions(India)
> + */
> +
> +/dts-v1/;
> +#include "imx8mm.dtsi"

You have multiple DTSI files to only include one DTSI. I was trying to
follow the logic here but I failed...

This is ctouch, so it should include SoM, which you call icore. But it
also includes ctouch2 which *only* includes common DTSI. It's then
exactly the same as starter kit which includes edimm (which includes
common) and icore.

Best regards,
Krzysztof


> +#include "imx8mm-engicam-ctouch2.dtsi"
> +#include "imx8mm-engicam-icore-mx8mm.dtsi"
> +
> +/ {
