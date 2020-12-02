Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6689A2CC401
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgLBRkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:40:33 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:43595 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgLBRkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:40:33 -0500
Received: by mail-ej1-f68.google.com with SMTP id jx16so5590539ejb.10;
        Wed, 02 Dec 2020 09:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qJ3uuvEbiHhXtU7cEzOwlDdNa7a8WFV/vWF0yo+HYOY=;
        b=I25N82rZeg3pVpjTVHgL2jMpKL3cupwernm3PVJBGJ/VrcFr5WeYbs3RgOCctT/BBF
         v0cCkh4tOqi4N/KatUJJVgN/uhp7awSEq4zMKzNMWrkCA3xgovdQvgbVFbNNx/LwwVBD
         wEjLS8FJO2h2wE6a6f3huKXaQ7LGsE60qI3HP8V38rrhlNBG3Veh4vUsgp2Sx3QvBG3P
         WSW8MSeFekpBtwKNuh4K2BkVYmamKnrLRi4vHDuo/5XfEBw5mIG4vRGn0mZ87ktQ/w3k
         Fg7dbedswjuNO0z9kCGYAG3LHngbmNW4JQIkJL1lkr2SYqbIFNoNR8VTgku4xH2HAAP2
         6RkA==
X-Gm-Message-State: AOAM532mlvCtxlRMwtKGqtcIqwAOaKfXBJJ3OKlvRsTFBnj2dlIpYo9I
        9O3oSJsluqqYzjpPmOIAN/I=
X-Google-Smtp-Source: ABdhPJwrkN+WpICt9twgGwEgv6mx8cVz4ySNYOZVWdijPSNFUIn/QXJ6S6VzxO1o7I5LEhLoH11uTA==
X-Received: by 2002:a17:906:5c53:: with SMTP id c19mr864830ejr.31.1606930790926;
        Wed, 02 Dec 2020 09:39:50 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id m7sm320270ejo.125.2020.12.02.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 09:39:50 -0800 (PST)
Date:   Wed, 2 Dec 2020 19:39:48 +0200
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
Subject: Re: [PATCH 06/10] arm64: dts: imx: Add Engicam C.TOUCH 2.0
Message-ID: <20201202173948.GF3490@kozik-lap>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-7-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202121241.109952-7-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 05:42:37PM +0530, Jagan Teki wrote:
> Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose
> carrier board with capacitive touch interface.
> 
> Genaral features:
> - TFT 10.1" industrial, 1280x800 LVDS display
> - Ethernet 10/100
> - Wifi/BT
> - USB Type A/OTG
> - Audio Out
> - CAN
> - LVDS panel connector
> 
> SOM's like i.Core MX8M Mini needs to mount on top of this Carrier
> board for creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
> new file mode 100644
> index 000000000000..294df07289a2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Engicam srl
> + * Copyright (c) 2020 Amarula Solutions(India)
> + */
> +
> +#include "imx8mm-engicam-common.dtsi"

I don't see any point of this DTS. You have a DTSI to include a DTSI.
Please describe in details your DTS architecture...

Best regards,
Krzysztof
