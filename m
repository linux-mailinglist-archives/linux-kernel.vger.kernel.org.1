Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6636D2CC440
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbgLBRuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:50:22 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:45312 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389239AbgLBRuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:50:21 -0500
Received: by mail-ej1-f66.google.com with SMTP id qw4so5620610ejb.12;
        Wed, 02 Dec 2020 09:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TDQjWAWmhj2xYlTiLACdO4qIK/Fg0l3r/vpySRnLe3A=;
        b=k3LAw8EvVARBmBfO+EcOce1dtnYR5r7zft3+X16g+/Bq6HxzS4I4yov4WCpAgoctD+
         KT5i/vudwwGq+Lodo+/MEHtTRVRrSoFZNy4rq+UYaYCCD+f6bcw+UQ9Btg2s88xNYTll
         SsTYw/t/vsqCl6ztXTDXNQq56Qv8p9OK0n+DzxTlwQ3CvvAF5V0MTu2yzk9hXt7RbLCS
         35bmicfzLa10EFkFlSTZ+zKqLkYe4Xcxzq50qMmEsaSjn4psZogR5clrlRdhfk8LVkf6
         X+KqJiT4wscrLbwUh2EeTyEm8Glh+Ve3TJVYGsYq2nzdBvRWsizqEWkMlHVQeaASmrWZ
         0bEQ==
X-Gm-Message-State: AOAM533GBf7YDbhijiAdV97GIpwfPjXuxse61RrUDDLEvBnC/Vm2cPDs
        SWR6G5SND9Ko1X2V2lWyEok=
X-Google-Smtp-Source: ABdhPJxIRtSrKyLfHBqLlF3OwYuA9KDGYI2zjcz/jj4YEP19WK3/PTEUN9KJafVDHg0WIUI7jfEo+g==
X-Received: by 2002:a17:906:f2c3:: with SMTP id gz3mr911054ejb.448.1606931379227;
        Wed, 02 Dec 2020 09:49:39 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j7sm473332edp.52.2020.12.02.09.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 09:49:37 -0800 (PST)
Date:   Wed, 2 Dec 2020 19:49:35 +0200
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
Subject: Re: [PATCH 10/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 C.TOUCH 2.0 10.1" OF
Message-ID: <20201202174935.GA4413@kozik-lap>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-11-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202121241.109952-11-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 05:42:41PM +0530, Jagan Teki wrote:
> i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.
> 
> C.TOUCH 2.0 is a general purpose carrier board with capacitive
> touch interface support.
> 
> 10.1" OF is a capacitive touch 10.1" Open Frame panel solutions.
> 
> i.Core MX8M Mini needs to mount on top of C.TOUCH 2.0 carrier with
> pluged 10.1" OF for creating complete i.Core MX8M Mini C.TOUCH 2.0
> 10.1" Open Frame solution board.
> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  ...mx8mm-engicam-icore-mx8mm-ctouch2-of10.dts | 21 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2-of10.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 8191db4c64fa..9725bbc0f268 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -31,6 +31,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
>  
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-ctouch2.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-ctouch2-of10.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-edimm2.2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2-of10.dts b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2-of10.dts
> new file mode 100644
> index 000000000000..0124ba5ec69c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2-of10.dts
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
> +#include "imx8mm-engicam-ctouch2.dtsi"
> +#include "imx8mm-engicam-icore-mx8mm.dtsi"
> +
> +/ {
> +	model = "Engicam i.Core MX8M Mini C.TOUCH 2.0 10.1\" Open Frame";
> +	compatible = "engicam,icore-mx8mm-ctouch2-of10", "engicam,icore-mx8mm",
> +		     "fsl,imx8mm";

No. You created 3 DTS and 3 DTSI which are all the same. The output DTB
is probably the same for all three DTS files. Only one DTSI has anything
inside, all others are just copy paste.

Best regards,
Krzysztof
