Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7321CFBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 08:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgGMGd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 02:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgGMGd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:33:29 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 999DC2067D;
        Mon, 13 Jul 2020 06:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594622009;
        bh=bVP0kqOjBb7yc4VbMsPyXj/p1GIRDdmOqU2CJ/tpabE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpDnQNzEdC4zS0nU0V00HdU63VxbfTUhY38uQZjq/Gg9OUB/rGFiBxTS9c6O55xC9
         1ZAPUBZiWZ0fePHDs/hu0TgAoJAtKarYDvz84nmqe7VXAg/HG6m4aCeBuA81xhroFo
         jU3GyusbQBKcvTgQfVlxPUiWgDxkRZYgxElxEVf4=
Date:   Mon, 13 Jul 2020 14:33:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] ARM: dts: vfxxx: Add node for CAAM
Message-ID: <20200713063323.GE12113@dragon>
References: <CAFXsbZoeTyRp7bwjBUcXT5H2GhrTmNeeoQSFcgiS9aNRFw6V_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFXsbZoeTyRp7bwjBUcXT5H2GhrTmNeeoQSFcgiS9aNRFw6V_g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 06:40:43PM -0700, Chris Healy wrote:
> Add node for CAAM device in NXP Vybrid SoC.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Signed-off-by: Chris Healy <cphealy@gmail.com>
> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 2d547e7b21ad..0fe03aa0367f 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -729,6 +729,28 @@
>                  dma-names = "rx","tx";
>                  status = "disabled";
>              };
> +
> +            crypto: crypto@400f0000 {
> +                compatible = "fsl,sec-v4.0";

Please use tab for indentation.

Shawn

> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +                reg = <0x400f0000 0x9000>;
> +                ranges = <0 0x400f0000 0x9000>;
> +                clocks = <&clks VF610_CLK_CAAM>;
> +                clock-names = "ipg";
> +
> +                sec_jr0: jr0@1000 {
> +                    compatible = "fsl,sec-v4.0-job-ring";
> +                    reg = <0x1000 0x1000>;
> +                    interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
> +                };
> +
> +                sec_jr1: jr1@2000 {
> +                    compatible = "fsl,sec-v4.0-job-ring";
> +                    reg = <0x2000 0x1000>;
> +                    interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
> +                };
> +            };
>          };
>      };
>  };
> --
> 2.21.3
