Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF9C2D4165
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgLILto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbgLILtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:49:33 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF67EC06179C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 03:48:53 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id n4so1316862iow.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 03:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HvHOHaWkWz9f5uu3P40vdNt+6mzTeQgyoxLze+Dl0g=;
        b=I1eki8GcBzKwc6xYmgWPjUTM/SWL2w2UhFFkCM1ywq45hiSOF27YK1Ttq2UCWWlLep
         WRiFmxJ7zST0ftQ+RvwBCKJr3+2kGLcCqq/lUtKokZ4wtM7hXm0kZze+MnsOEHvSPRaY
         sCrSFQ24hoHl0uVoCY+9dL+jB5aamzpjmWOdcE//9+6iVXt3rndDMtB+ppknznc9pCK5
         NAn0kgH1hLrm+h/aElA7Tc/co6LaYTiBSqO3zAZdFZXofejG/GjjFNWUjDDK00Q//m0k
         yBHxuH2/vFrcU637DPm7wjocdhyLrINFue9373MoeDs2rcfCryJSZJQ8jcluQxsFR6OU
         cAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HvHOHaWkWz9f5uu3P40vdNt+6mzTeQgyoxLze+Dl0g=;
        b=SFeYvulQJwojXwHcftHf2r425ULEhhtH5cpGh9tJ6aGRPggXi+VZnYMnaWwkIi7IzB
         nwvcC/mt+hHFOc7ScdcK6tzmFOWF0FxKJT41fjNQF1TMUx5R6yNKdqd+luN64S3sOw6S
         nmET6KGA7I5ki3cMaVPmdq/P35xpf+NehmG6+WuOBs0icfi0vW3LEAcHm/cKtktJxH+h
         tYIoT+Jw0ebAx/bp1P884UwO9Invdy4bn9W7yuDSoC+aPHxXi0I6UMeBcyq7xZWpwL1G
         pGYQFP2KgJiNbG84OyBGz+UYYG0SfDKrTxeUynVbwuu7xVCln8IA89sipJMKu01smH4N
         acPA==
X-Gm-Message-State: AOAM533GqGST7d0E0/+2kTapzmakF+tUHXX28mmaE+KWOEOBEn1B7fft
        5qUvrtH5P6MSagh1XI4dSkoL+SFOmVfTQUzmZqrt9g==
X-Google-Smtp-Source: ABdhPJzDuGvTStBIZ/1Plqa1/cjaQJaRQHy1Es4XzEExZpLWTqkchkuQiCQdQ3DGAuzdUI1gqcAhktveSbV1z55+Bs0=
X-Received: by 2002:a05:6602:13c5:: with SMTP id o5mr2294111iov.46.1607514533155;
 Wed, 09 Dec 2020 03:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20201209114440.62950-1-fparent@baylibre.com> <20201209114440.62950-2-fparent@baylibre.com>
In-Reply-To: <20201209114440.62950-2-fparent@baylibre.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Wed, 9 Dec 2020 12:48:42 +0100
Message-ID: <CAOwMV_yFukOeH9k3DDWJv3RWYV3-VEgQR=xS7art2VR421Ynjw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_2=2F2=5D_=F0=9F=93=A4_arm64=3A_dts=3A_mediatek=3A_mt8516?=
        =?UTF-8?Q?=3A_add_support_for_APDMA?=
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, resending without the unicode symbol in the title

On Wed, Dec 9, 2020 at 12:44 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Add support the APDMA IP on MT8516. APDMA is a DMA controller
> for UARTs.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>
> V2: Add missing dma-names properties on uart nodes
>
>  arch/arm64/boot/dts/mediatek/mt8516.dtsi | 30 ++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> index e6e4d9d60094..b80e95574bef 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> @@ -276,6 +276,27 @@ gic: interrupt-controller@10310000 {
>                                 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>                 };
>
> +               apdma: dma-controller@11000480 {
> +                       compatible = "mediatek,mt8516-uart-dma",
> +                                    "mediatek,mt6577-uart-dma";
> +                       reg = <0 0x11000480 0 0x80>,
> +                             <0 0x11000500 0 0x80>,
> +                             <0 0x11000580 0 0x80>,
> +                             <0 0x11000600 0 0x80>,
> +                             <0 0x11000980 0 0x80>,
> +                             <0 0x11000a00 0 0x80>;
> +                       interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>,
> +                                    <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>,
> +                                    <GIC_SPI 98 IRQ_TYPE_LEVEL_LOW>,
> +                                    <GIC_SPI 99 IRQ_TYPE_LEVEL_LOW>,
> +                                    <GIC_SPI 100 IRQ_TYPE_LEVEL_LOW>,
> +                                    <GIC_SPI 101 IRQ_TYPE_LEVEL_LOW>;
> +                       dma-requests = <6>;
> +                       clocks = <&topckgen CLK_TOP_APDMA>;
> +                       clock-names = "apdma";
> +                       #dma-cells = <1>;
> +               };
> +
>                 uart0: serial@11005000 {
>                         compatible = "mediatek,mt8516-uart",
>                                      "mediatek,mt6577-uart";
> @@ -284,6 +305,9 @@ uart0: serial@11005000 {
>                         clocks = <&topckgen CLK_TOP_UART0_SEL>,
>                                  <&topckgen CLK_TOP_UART0>;
>                         clock-names = "baud", "bus";
> +                       dmas = <&apdma 0
> +                               &apdma 1>;
> +                       dma-names = "tx", "rx";
>                         status = "disabled";
>                 };
>
> @@ -295,6 +319,9 @@ uart1: serial@11006000 {
>                         clocks = <&topckgen CLK_TOP_UART1_SEL>,
>                                  <&topckgen CLK_TOP_UART1>;
>                         clock-names = "baud", "bus";
> +                       dmas = <&apdma 2
> +                               &apdma 3>;
> +                       dma-names = "tx", "rx";
>                         status = "disabled";
>                 };
>
> @@ -306,6 +333,9 @@ uart2: serial@11007000 {
>                         clocks = <&topckgen CLK_TOP_UART2_SEL>,
>                                  <&topckgen CLK_TOP_UART2>;
>                         clock-names = "baud", "bus";
> +                       dmas = <&apdma 4
> +                               &apdma 5>;
> +                       dma-names = "tx", "rx";
>                         status = "disabled";
>                 };
>
> --
> 2.29.2
>
