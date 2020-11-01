Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18B32A1CD1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 10:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgKAJVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 04:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgKAJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 04:21:37 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A321C0617A6;
        Sun,  1 Nov 2020 01:21:37 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id o21so7391542ejb.3;
        Sun, 01 Nov 2020 01:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHDTSg+tc1PbYLhb9blx6HIRF3vmeGh6sY6sIsdSlp0=;
        b=tPzui41TAboB257aaQlDNd1hHKj0umzp8YYABXf4qP/kK09eOfddx68WPHDxTaXRsb
         ikbjnka3rc3YNr/8x3eZGKCkcofn1UpRafLIh/oB6xYW9QexvjjoGaiehVyL0Pxvj8Ek
         x7cRD+3nXAcJ8n5MWisFZzeqQ7Yu8ufW4JoEMdL7rt7R2jg/HapqqOfyZWBsB2MGtq4Y
         fnC7rXANtVKGj0KwKjK5fgRmj1uGX/lUnZq/r/E3TXJRkXqYaib6d7uImyONrhwI6b4/
         9BAghvggQlG4mAZbkzmTdMpFmgpSCqpsHrlJH6GHFe1MniAcPjKF2SZDQfxCqGzrEaDJ
         Xluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHDTSg+tc1PbYLhb9blx6HIRF3vmeGh6sY6sIsdSlp0=;
        b=mgjHhdzbL9bN/oRKf1n7ZAVmE8c/qy4JyJTPFOgzUwFYtQUYfPUZEoB+FNm601oHw5
         A42F5myHU/2Hve7zCl4e52LKcQQ6NUl/9dp/EEWTryCrhHZ8hJ5nLcaw5HJmmKm+70Fy
         FEJld3GIQMyaqOSSiYL9x9g4i79hs43UK0On4fQbWRHAIeNs0YZuYx8LXs/EHDDjbaiI
         BGoysEFwbkg+ofuglj9SsrjA/tZWhh5WzhihykXpgqlNtDL4SIa7Ys8hAKG7C0jS8ZLy
         IZ6pUmvjGVw6psjZjiRarPBM4Ydf7HcDVmE9VGj7o2KdsNivbb9lkxuOUUX6afs/j5nL
         3N+A==
X-Gm-Message-State: AOAM5323HXZsDmE9rnvMEHH3v5MrC/B/YJjbjH8MGU2m/T1XOC4YeELe
        KoNxyd06iW/ov2UC9+WE9tCpU5lrkAgzOQ720pY=
X-Google-Smtp-Source: ABdhPJyDqpdW+3DuzVc6oHDsmUlBpYvbfOnDeHRHRO2khuEwUES9A6vcJWmWIPwPbhASnQpA1nXNjadVRyZWkjGraiQ=
X-Received: by 2002:a17:906:40cb:: with SMTP id a11mr4097673ejk.217.1604222496278;
 Sun, 01 Nov 2020 01:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20201101072609.1681891-1-jernej.skrabec@siol.net>
In-Reply-To: <20201101072609.1681891-1-jernej.skrabec@siol.net>
From:   Code Kipper <codekipper@gmail.com>
Date:   Sun, 1 Nov 2020 10:21:24 +0100
Message-ID: <CAEKpxB=o1qh4b+5KPnP51dYMb4YmpuaKixgt5nZ7CfL=A46wzQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] arm64: dts: allwinner: h6:
 orangepi-one-plus: Fix ethernet
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Nov 2020 at 08:20, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> RX/TX delay on OrangePi One Plus board is set on PHY. Reflect that in
> ethernet node.
>
> Fixes: 7ee32a17e0d6 ("arm64: dts: allwinner: h6: orangepi-one-plus: Enable ethernet")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Hi Jernej,
Tested-by: Marcus Cooper <codekipper@gmail.com>
BR,
CK
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> index fceb298bfd53..29a081e72a9b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> @@ -27,7 +27,7 @@ reg_gmac_3v3: gmac-3v3 {
>  &emac {
>         pinctrl-names = "default";
>         pinctrl-0 = <&ext_rgmii_pins>;
> -       phy-mode = "rgmii";
> +       phy-mode = "rgmii-id";
>         phy-handle = <&ext_rgmii_phy>;
>         phy-supply = <&reg_gmac_3v3>;
>         allwinner,rx-delay-ps = <200>;
> --
> 2.29.2
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20201101072609.1681891-1-jernej.skrabec%40siol.net.
