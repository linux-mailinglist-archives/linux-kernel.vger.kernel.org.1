Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DCF2CE5C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgLDCk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:40:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33046 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgLDCk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:40:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id t22so4929499ljk.0;
        Thu, 03 Dec 2020 18:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUIaE3HrpMZoU5b6Uamr3FqDYfPfXMVixD+//IxLNmo=;
        b=gu9+9N6pDWCQZy1hE3kjqa7G6VIHlvnmyOxO/RkHxbcVEVMbwN0ns0sJRD8SA3v7D1
         9F97ycxDuVFz7wx+59H3DJSqf7VtGlN3TXAlz4xYBPlXWhbnYPGfcwj/tYfhOqgaKiSM
         o1kdh7RbOlqTIATEBqhl4jVuoavPrtuBooRg3Gl6X2XRdYR6bg7Y1So59nxEFurS0oSA
         G9Js5ga2st25357ohJjm1oFNTEwZMWYeakSlf2o9+t/93wztRkbIU3as/tI79YvEUj1D
         1GsuEEaV4Jqe17ZPbOPV7h1olNIt7KJULhE+CixVNPseJ6a0EIIw5A5vSjsYTqray+3I
         0FuA==
X-Gm-Message-State: AOAM530tDyyeRBdAtZA9V43+YK3mW2Dq4WW6Pjg4MU3QcC0XCAVC4iG5
        mDIWHYyuwwGYSyyHleIPAz/IBtzZucib4A==
X-Google-Smtp-Source: ABdhPJxTZzbWk4rei5jpb/+fB2l2tUwUuI97GjTm0F8/LsDu6Sp1BnqMZeayNLb1F47avQo/QIl7wA==
X-Received: by 2002:a2e:8909:: with SMTP id d9mr2544291lji.399.1607049609717;
        Thu, 03 Dec 2020 18:40:09 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a30sm1089048ljd.91.2020.12.03.18.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 18:40:09 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id r24so5667692lfm.8;
        Thu, 03 Dec 2020 18:40:09 -0800 (PST)
X-Received: by 2002:ac2:483b:: with SMTP id 27mr2659205lft.551.1607049609342;
 Thu, 03 Dec 2020 18:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20201203181454.13389-1-m.cerveny@computer.org>
In-Reply-To: <20201203181454.13389-1-m.cerveny@computer.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 4 Dec 2020 10:39:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v67-QwUpy5ca6CPBgzAYcEVRPT6O1f6+XrgOQyEeF+B1aQ@mail.gmail.com>
Message-ID: <CAGb2v67-QwUpy5ca6CPBgzAYcEVRPT6O1f6+XrgOQyEeF+B1aQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: sun8i: v3s: SRAM_C real mapping
To:     Martin Cerveny <m.cerveny@computer.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 2:15 AM Martin Cerveny <m.cerveny@computer.org> wrote:
>
> VideoEngine (cedrus) needs assign dedicated SRAM for decoding.
> SRAM_C1 is usually used for Allwinner platforms.
> Allwinner V3s scale down chip has not SRAM_C1 but only small SRAM_C (44kB).
>
> Result of additional testing:
>
> SRAM_C is mapped in two regions 0x0000_4000 (primary location,
> by Datasheet) (size is 0xb000, probably exact size is 0xb0c0
> and it is mapped to 4k boundary (to 0x0000_ffff))
> and to 0x01d0_4000 (traditional SRAM_C1 region from 0x01d0_0000).
>
> Rest of 0x01d0_0000 are discontinuously filled with R/W register sets
> (probably some internals registers from VE) that I thought to be SRAM too.
>
> Programming register SRAM_CTRL_REG0 (0x01c00_0000) with value 0x7fff_ffff
> switch out whole region 0x01d0_0000-0x01df_ffff and 0x0000_4000-0x0000_ffff
> (dedicate access to VE).
>
> VE/cedrus code use this SRAM region indirectly
> (VE_AVC_SRAM_PORT_OFFSET/VE_AVC_SRAM_PORT_DATA...)
> and it is not influenced by "real" SRAM mapping or size
> so it is working even without this patch.
>
> Signed-off-by: Martin Cerveny <m.cerveny@computer.org>
> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
> index e8f304125e2d..bc4b4a0200cb 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -162,17 +162,17 @@ syscon: system-control@1c00000 {
>                         #size-cells = <1>;
>                         ranges;
>
> -                       sram_c: sram@1d00000 {
> +                       sram_c: sram@4000 {
>                                 compatible = "mmio-sram";
> -                               reg = <0x01d00000 0x80000>;
> +                               reg = <0x4000 0xb000>;
>                                 #address-cells = <1>;
>                                 #size-cells = <1>;
> -                               ranges = <0 0x01d00000 0x80000>;
> +                               ranges = <0 0x4000 0xb000>;
>
>                                 ve_sram: sram-section@0 {
>                                         compatible = "allwinner,sun8i-v3s-sram-c1",

Using C1 in the compatible string is confusing at this point, as the
name is never mentioned in the manual.

Please change it to sram-ve instead. Please also update the binding.

Since the DT patches this depends on haven't been merged yet, please
just do another version of the remaining patches with the changes
included.


ChenYu


>                                                      "allwinner,sun4i-a10-sram-c1";
> -                                       reg = <0x000000 0x80000>;
> +                                       reg = <0x0 0xb000>;
>                                 };
>                         };
>                 };
> --
> 2.25.1
>
