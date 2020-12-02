Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F352CC3F8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbgLBRjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:39:01 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40475 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgLBRjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:39:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id d18so4850000edt.7;
        Wed, 02 Dec 2020 09:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8nI+6gnsqA0IBuGLzSn2crkcyrZrwcKzwQx02XE2RqY=;
        b=WH4I4OwtEMU4Qs22y1pKfiqIgiqSnh2JxrrMydK+snC0yRKd7NDS5Sh5luhThYTrU3
         JVmThH4E7Ass20jnYYh5lPlnlcki/Qhom930nBh1qblO0nIrAjoYHBfZK1pvxhvaHzsL
         TwsW1CWl1NjespQUjmdhyBHOACcynVe9etTUCuvX5y/9MZRiVW4NqnSbfxD2VBHGZg+V
         0cuFkUXgvV/WJzfIkW5H2uOv0Nu5fAEabQtrFtMQ4AwfKxw140FJn5S+peuJOSNcbf8b
         lXdg+2q9ylyfDD9KNV6dArySd6XnjNNVMNQL0tTbAfQKn+l00rAAAMvWWseO95Rbu/Fb
         nZcA==
X-Gm-Message-State: AOAM533x/7BAvr8hOxy7s4Gtd97mEf1MSKhRU7aeH7lYZ6McX8LrTrhV
        7vLDufpIX3k353hIYt/DQwM=
X-Google-Smtp-Source: ABdhPJxqi50UI8aLSgEmGsBtJDWUOzEayK9dobVLiJzYbWqPzNM3fIkbreMmbb/vpGeMA6cPWJugpg==
X-Received: by 2002:a50:e68a:: with SMTP id z10mr1089522edm.66.1606930692913;
        Wed, 02 Dec 2020 09:38:12 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 91sm505977edy.45.2020.12.02.09.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 09:38:11 -0800 (PST)
Date:   Wed, 2 Dec 2020 19:38:09 +0200
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
Subject: Re: [PATCH 05/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 EDIMM2.2 Starter Kit
Message-ID: <20201202173809.GE3490@kozik-lap>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-6-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202121241.109952-6-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 05:42:36PM +0530, Jagan Teki wrote:
> i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.
> 
> EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
> Evaluation Board from Engicam.
> 
> i.Core MX8M Mini needs to mount on top of this Evaluation board for
> creating complete i.Core MX8M Mini EDIMM2.2 Starter Kit.
> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../imx8mm-engicam-icore-mx8mm-edimm2.2.dts   | 21 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-edimm2.2.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 6f0777ee6cd6..4369d783dade 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
>  
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-edimm2.2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-edimm2.2.dts b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-edimm2.2.dts
> new file mode 100644
> index 000000000000..a8afc0998fcd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-edimm2.2.dts
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

imx8mm should be included in the SoM, not here. It's really wrong that
you override some nodes in imx8mm-engicam-icore-mx8mm.dtsi which do not
exist there (not included).

> +#include "imx8mm-engicam-edimm2.2.dtsi"
> +#include "imx8mm-engicam-icore-mx8mm.dtsi"
> +
> +/ {
> +	model = "Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit";
> +	compatible = "engicam,icore-mx8mm-edimm2.2", "engicam,icore-mx8mm",

This won't validate against your own bindings. Please fix either the DTS
or the bindings. Then run dtbs_check.

Best regards,
Krzysztof
