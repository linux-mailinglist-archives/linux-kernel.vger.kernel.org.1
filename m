Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAF12D2C75
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgLHN7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbgLHN7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:59:44 -0500
X-Gm-Message-State: AOAM531/rjdkMLkXtJZqVh5ndqjD594BchOThXkrKcJs18slVv3cmf9L
        oRx+KUWS7DMO98zLBub/n/4W7TgZpyDBeqTpkpM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607435943;
        bh=77HVStyyXX1Pgy5zmoyOyQEPooYc3GGLgYGD12JjNMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V7qDwVhG3gecJGhol6Ike5wg7CosFyxhl1m1sYpQdPBixF5UVNgETKJaj3Q8j0VqM
         DnSfS+iAy2AYNiMsrBDyBqDsHUcmQXdhB/88XprAJULuyhu7mSx5/nAUIVkTmU5jZb
         UoEnwyt0Phn+3MP9pbluTpxm1jjr+RsrBtFNrAGPKP+e18Cg1L8cUHPKydqO+vW7lr
         sep53IjAfdBKspkmrT8HzTaqvCKYFyPtBp6G5/hYGqA4Y25UHHtR882SSuUOtLyMT7
         YnpnnZ+xpkag+KWK2t1w2AQlIavNpBtudPADLTaEOSNZurvhzo6Q/gMnsVCT7d0pZs
         SgkPQmwVGqlFg==
X-Google-Smtp-Source: ABdhPJzbbFo39L5/f8usODzWGuXBtaIc9x6K8uqLzlRNVMHrBQiyt8ZvbtR8IVirlhP18K9q04YQVyIqIjNM4nND/bM=
X-Received: by 2002:a5d:4101:: with SMTP id l1mr7874896wrp.196.1607435941883;
 Tue, 08 Dec 2020 05:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20201207084752.1665-1-thunder.leizhen@huawei.com> <20201207084752.1665-2-thunder.leizhen@huawei.com>
In-Reply-To: <20201207084752.1665-2-thunder.leizhen@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 8 Dec 2020 14:58:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a13CdDzdPOG_2ps4dXLaZC8jUDTPJDpp8Di-u87qBpRzQ@mail.gmail.com>
Message-ID: <CAK8P3a13CdDzdPOG_2ps4dXLaZC8jUDTPJDpp8Di-u87qBpRzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ARM: dts: mmp2-olpc-xo-1-75: clear the warnings
 when make dtbs
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 9:47 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> The check_spi_bus_bridge() in scripts/dtc/checks.c requires that the node
> have "spi-slave" property must with "#address-cells = <0>" and
> "#size-cells = <0>". But currently both "#address-cells" and "#size-cells"
> properties are deleted, the corresponding default values are 2 and 1. As a
> result, the check fails and below warnings is displayed.
>
> arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): \
> /soc/apb@d4000000/spi@d4037000: incorrect #address-cells for SPI bus
>   also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
> arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): \
> /soc/apb@d4000000/spi@d4037000: incorrect #size-cells for SPI bus
>   also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
> arch/arm/boot/dts/mmp2-olpc-xo-1-75.dtb: Warning (spi_bus_reg): \
> Failed prerequisite 'spi_bus_bridge'
>
> Because the value of "#size-cells" is already defined as zero in the node
> "ssp3: spi@d4037000" in arch/arm/boot/dts/mmp2.dtsi. So we only need to
> explicitly add "#address-cells = <0>" and keep "#size-cells" no change.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Right, I already sent the same patch earlier.

Lubomir, can I apply this to the fixes branch?

>  arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
> index adde62d6fce73b9..82da44dacba7172 100644
> --- a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
> +++ b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
> @@ -224,7 +224,7 @@
>
>  &ssp3 {
>         /delete-property/ #address-cells;
> -       /delete-property/ #size-cells;
> +       #address-cells = <0>;
>         spi-slave;
>         status = "okay";
>         ready-gpios = <&gpio 125 GPIO_ACTIVE_HIGH>;
> --
> 1.8.3
>
>
