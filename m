Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5881C2C297A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388919AbgKXOZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388682AbgKXOZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:25:54 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EA5C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:25:53 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id m6so4804321vkl.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCesLYQPvcEflyfIUi3Jzcp8cmSSQAR6auenD/1XJUc=;
        b=k0RKmm3+Avs9KAotfN8HlMi+V5Uf/OM7WwUHNctM5x/DwImooVJdkD8YnZTbbnbWUi
         /UBIy53tGX7ZQHMKlDFWFJF95GBh2IoWCBz1cZIKUPXm1eukhDIv/kqKx++LRaOrRcrL
         4qfXQkhqHknSpOqq2qXCwwFNuSP33id6GdRaqPhNinbm7TNrI60erMgKozIBGd7WXZ+j
         Xrz/Frr2n2yUgn0SdpSmv9aH4sqg+YubtQK+M9HdU6h1YwjToRJKiNqZ5j/VWqyI079s
         l+oUaN9ZwTYKaT4Euj5ZN6riIji3/cQGiiiAUFLnhxpDwGGXen8zRq7UZX/FejD7b6Rx
         6d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCesLYQPvcEflyfIUi3Jzcp8cmSSQAR6auenD/1XJUc=;
        b=gEGWzz3kwuR43np1kXgCVG2pt0TjMEDloKQmVRSp1v3FLuk06oyR2ZZIOIIYgdxaPi
         gmaLIFqjxxufB65HuCmPNPipyuTVe8lx/tvakQBWgo3Oik5ncsN4jlUqyMbAt6FyZOdp
         i3WZTC0iX/z1wd2JNAw3HFvOAapv2VtXkmNL/6w2WoMoNlTIPKyhFKQHA47f28DRYnKI
         cBk7GjBeoh16rGJw43YNs0LwhdOQMOzcvj8Ir71P+ckRZG22J299sOpxpEqKgqPKIg53
         DGPXxgGFp2GA9GAT8nhcrJPV2n6h9SMnaoJ91QHFou59YHmm2MD9xqZdlq3EfND0CTzg
         nSww==
X-Gm-Message-State: AOAM533ziqaotizKLxXLUxzWq8+p0R1YmuG/G1/uTTJKWspAEOU+OyT0
        826GBtAd5PJn+hroa8B+J8bS6ZHgWTBabKYkvswRFw==
X-Google-Smtp-Source: ABdhPJzGbprwOOPsKb4waIjuvGsDDrtzIVrKJDs5hFpHm85kEr+oGt/ZWkeOKdeHSbO3ywPEKgrJU5kHBVxR8SJV9YU=
X-Received: by 2002:a1f:9889:: with SMTP id a131mr3881342vke.15.1606227952297;
 Tue, 24 Nov 2020 06:25:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com> <0556399f1ce8b1255d1f7961f04fcb95c96ab928.1605823502.git.cristian.ciocaltea@gmail.com>
In-Reply-To: <0556399f1ce8b1255d1f7961f04fcb95c96ab928.1605823502.git.cristian.ciocaltea@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:15 +0100
Message-ID: <CAPDyKFrBaiqmHbx0MKTv0uusDdLeeAwQuN8NMiVKgaAQBK0x1w@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] arm: dts: owl-s500: Add MMC support
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 at 00:56, Cristian Ciocaltea
<cristian.ciocaltea@gmail.com> wrote:
>
> Add MMC controller nodes for Actions Semi S500 SoC, in order to
> facilitate access to SD/EMMC/SDIO cards.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  arch/arm/boot/dts/owl-s500.dtsi | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> index b16172615db0..7af7c9e1119d 100644
> --- a/arch/arm/boot/dts/owl-s500.dtsi
> +++ b/arch/arm/boot/dts/owl-s500.dtsi
> @@ -241,5 +241,38 @@ dma: dma-controller@b0260000 {
>                         clocks = <&cmu CLK_DMAC>;
>                         power-domains = <&sps S500_PD_DMA>;
>                 };
> +
> +               mmc0: mmc@b0230000 {
> +                       compatible = "actions,s500-mmc", "actions,owl-mmc";
> +                       reg = <0xb0230000 0x38>;
> +                       interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cmu CLK_SD0>;
> +                       resets = <&cmu RESET_SD0>;
> +                       dmas = <&dma 2>;
> +                       dma-names = "mmc";
> +                       status = "disabled";
> +               };
> +
> +               mmc1: mmc@b0234000 {
> +                       compatible = "actions,s500-mmc", "actions,owl-mmc";
> +                       reg = <0xb0234000 0x38>;
> +                       interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cmu CLK_SD1>;
> +                       resets = <&cmu RESET_SD1>;
> +                       dmas = <&dma 3>;
> +                       dma-names = "mmc";
> +                       status = "disabled";
> +               };
> +
> +               mmc2: mmc@b0238000 {
> +                       compatible = "actions,s500-mmc", "actions,owl-mmc";
> +                       reg = <0xb0238000 0x38>;
> +                       interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cmu CLK_SD2>;
> +                       resets = <&cmu RESET_SD2>;
> +                       dmas = <&dma 4>;
> +                       dma-names = "mmc";
> +                       status = "disabled";
> +               };
>         };
>  };
> --
> 2.29.2
>
