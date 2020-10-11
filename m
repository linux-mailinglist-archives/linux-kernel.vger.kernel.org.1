Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB628AAAF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 23:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbgJKVWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 17:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgJKVWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 17:22:33 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2971C0613CE;
        Sun, 11 Oct 2020 14:22:33 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l16so14073809ilt.13;
        Sun, 11 Oct 2020 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FNSDZv4Xfi/5U2u1YBkI79tA/iicVEMuevucpXCwbiQ=;
        b=ha9RpJq419tlXF06Q9G8o2xmUPohsC0+1RDjHlOGEVgN7lLVKoIXhqoqobEHNd2s05
         LZDCkaRzytNZE0cjSbCKuNthtJk8+Ob58CO/aYzMasv2wwvt50hm8uMDLKAEItyVgOou
         nEkZNiG3N8gbmn7nefBQzdDDgUd0YAMkQjRYH2V1RzLAEaWgkNsUeapSz0iIXcpbeG8f
         jgxsZ7cxIl60mlnna1IziKYQ8/Ly+143SuC1p635Bj3rEDaqlSBQsrdlr49YBIwnIYHJ
         PKlB6pypEyQ2xSwVmtx/NK9pL+9Q4Ilysdvak+bsuVB4D/lT50kX93YDTtP4hPhoKpJF
         zvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FNSDZv4Xfi/5U2u1YBkI79tA/iicVEMuevucpXCwbiQ=;
        b=s/9yiwNmp8GjdoXg8jwoy+uvcxbvuf/rot8qjxNZuR8dNGKwI94h4PyQsw/AutD7l6
         H7bNWGpAo0TQQkPSCJCwfuHPChoIYfPUBjUCRCGswyaizCbpTlKC5/puyghhdoKvvDpR
         CbneOOCsKPQOPtMpzdOS/Q8zVNHPN8zaHjcw0+84+vQqd/b3KTQs8RSFZlhWxNlWGusa
         oJ1zNfqACgxpLAeTyMFb+VE+6p9oxyrDe+yvEvBaFWHrANOMN1/Qf9fYV9Ma3wNvt+5a
         irVZDxFWW1lVnNQh57TZELiCImuin5LyGoPAaFb6g/Huhi3zSfqOXRx3TlIuGXjaKc1a
         cRuw==
X-Gm-Message-State: AOAM531qFamhAOOoJzJfZg1vvlQoHgpYVarss6PgPmssYVg+xo5CnCJL
        xJOlngHTP5MbzSqUhCam3RKuLHjt+FNTpEcpG7Q=
X-Google-Smtp-Source: ABdhPJxmokWZ7cOjdXf8MMvSkqVkT9+cOn3iwrgdZIp/zudiC3PYT1R5zoBB1G9q36YMf5cM2WDiyrYbOxVxH/+JvQY=
X-Received: by 2002:a92:8b08:: with SMTP id i8mr879113ild.35.1602451352982;
 Sun, 11 Oct 2020 14:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201011211428.154793-1-peron.clem@gmail.com>
In-Reply-To: <20201011211428.154793-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 11 Oct 2020 23:22:21 +0200
Message-ID: <CAJiuCcdGX1i6VV_-RdQRiSW_64i_AYaC02jdnfC4OzEnCB-jHw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: beelink-gs1: Update LED power node
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 11 Oct 2020 at 23:14, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Beelink GS1 LED trigger a warning when running dtbs_check.
>
> Update the node with a valid pattern property.
>
> Also add the function and the color of the LED and drop the
> label which is deprecated.
>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> index 3f7ceeb1a767..f506d6fa8017 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -7,6 +7,7 @@
>  #include "sun50i-h6-cpu-opp.dtsi"
>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>
>  / {
>         model =3D "Beelink GS1";
> @@ -43,8 +44,9 @@ ext_osc32k: ext_osc32k_clk {
>         leds {
>                 compatible =3D "gpio-leds";
>
> -               power {
> -                       label =3D "beelink:white:power";
> +               led-0 {
> +                       function =3D LED_FUNCTION_POWER;
> +                       color =3D LED_COLOR_ID_WHITE;
color =3D <LED_COLOR_ID_WHITE>;

Sorry, I will send a v2.

Clement

>                         gpios =3D <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 *=
/
>                         default-state =3D "on";
>                 };
> --
> 2.25.1
>
