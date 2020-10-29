Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1C29ECC1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgJ2NWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgJ2NWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:22:37 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A5920782;
        Thu, 29 Oct 2020 13:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603977755;
        bh=SSqEczktkXqJPCkYJd5JJVd8x3QTRgXyJPz9DieXvI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n0vFVgEuizL/dTUyl+wJFfcFZMUwk+0j4zhPJs5vSe4XjhlYhsY0EfpbaEQTylhWt
         Cubd0FfxN5Ee2oJDXYXEOxUZlwmqAWAKdT/7JjFbdX+nfd/dDeF2qeDk5f6rU5tvO4
         3Skh01R/yatRbFl/JN9wAt8ukwMHssGIzImAfJzg=
Received: by mail-ed1-f42.google.com with SMTP id v19so2983889edx.9;
        Thu, 29 Oct 2020 06:22:35 -0700 (PDT)
X-Gm-Message-State: AOAM531sjCpDSIh+ihtyr0Kk87TVoOrjE1xFgJi3hM1aShnVfos5xp0p
        XqBUNw1nEdQg438Uzj1pmbP2UJhVzg+Ozd4YDw==
X-Google-Smtp-Source: ABdhPJwDHdKRH0zxp2zdI0rhG8MdiqpEtBhgAHcNHzUa5A/NrM0N2+qgtroMDJUvOVjURs3Jt16EVSasoziDTaYiQJ8=
X-Received: by 2002:aa7:cb1a:: with SMTP id s26mr3896896edt.219.1603977753903;
 Thu, 29 Oct 2020 06:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201013100625.13056-1-jitao.shi@mediatek.com> <20201013100625.13056-2-jitao.shi@mediatek.com>
In-Reply-To: <20201013100625.13056-2-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 29 Oct 2020 21:22:19 +0800
X-Gmail-Original-Message-ID: <CAAOTY_800OtqtJCtCAYS2Kcw7QLp-ojv63mNu8TS1aunTOsHGQ@mail.gmail.com>
Message-ID: <CAAOTY_800OtqtJCtCAYS2Kcw7QLp-ojv63mNu8TS1aunTOsHGQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] drm/mediatek: dsi: fix scrolling of panel with
 small hfp or hbp
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8813=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:06=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Replace horizontal_backporch_byte with vm->hback_porch * bpp to aovid
> flowing judgement negative number.
>
> if ((vm->hfront_porch * dsi_tmp_buf_bpp + horizontal_backporch_byte) >
>         data_phy_cycles * dsi->lanes + delta)
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 65 +++++++++++++++-----------------=
------
>  1 file changed, 25 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 80b7a082e874..ddddf69ebeaf 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -445,6 +445,7 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi =
*dsi)
>         u32 horizontal_backporch_byte;
>         u32 horizontal_frontporch_byte;
>         u32 dsi_tmp_buf_bpp, data_phy_cycles;
> +       u32 delta;
>         struct mtk_phy_timing *timing =3D &dsi->phy_timing;
>
>         struct videomode *vm =3D &dsi->vm;
> @@ -466,50 +467,34 @@ static void mtk_dsi_config_vdo_timing(struct mtk_ds=
i *dsi)
>         horizontal_sync_active_byte =3D (vm->hsync_len * dsi_tmp_buf_bpp =
- 10);
>
>         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> -               horizontal_backporch_byte =3D vm->hback_porch * dsi_tmp_b=
uf_bpp;
> +               horizontal_backporch_byte =3D
> +                       (vm->hback_porch * dsi_tmp_buf_bpp - 10);
>         else
> -               horizontal_backporch_byte =3D (vm->hback_porch + vm->hsyn=
c_len) *
> -                                           dsi_tmp_buf_bpp;
> +               horizontal_backporch_byte =3D ((vm->hback_porch + vm->hsy=
nc_len) *
> +                       dsi_tmp_buf_bpp - 10);
>
>         data_phy_cycles =3D timing->lpx + timing->da_hs_prepare +
> -                         timing->da_hs_zero + timing->da_hs_exit;
> -
> -       if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> -               if ((vm->hfront_porch + vm->hback_porch) * dsi_tmp_buf_bp=
p >
> -                   data_phy_cycles * dsi->lanes + 18) {
> -                       horizontal_frontporch_byte =3D
> -                               vm->hfront_porch * dsi_tmp_buf_bpp -
> -                               (data_phy_cycles * dsi->lanes + 18) *
> -                               vm->hfront_porch /
> -                               (vm->hfront_porch + vm->hback_porch);
> -
> -                       horizontal_backporch_byte =3D
> -                               horizontal_backporch_byte -
> -                               (data_phy_cycles * dsi->lanes + 18) *
> -                               vm->hback_porch /
> -                               (vm->hfront_porch + vm->hback_porch);
> -               } else {
> -                       DRM_WARN("HFP less than d-phy, FPS will under 60H=
z\n");
> -                       horizontal_frontporch_byte =3D vm->hfront_porch *
> -                                                    dsi_tmp_buf_bpp;
> -               }
> +                         timing->da_hs_zero + timing->da_hs_exit + 3;
> +
> +       delta =3D (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) ? 18 : 12=
;
> +
> +       if ((vm->hfront_porch * dsi_tmp_buf_bpp + horizontal_backporch_by=
te) >
> +           data_phy_cycles * dsi->lanes + delta) {
> +               horizontal_frontporch_byte =3D
> +                       vm->hfront_porch * dsi_tmp_buf_bpp -
> +                       (data_phy_cycles * dsi->lanes + delta) *
> +                       vm->hfront_porch /
> +                       (vm->hfront_porch + vm->hback_porch);
> +
> +               horizontal_backporch_byte =3D
> +                       horizontal_backporch_byte -
> +                       (data_phy_cycles * dsi->lanes + delta) *
> +                       vm->hback_porch /
> +                       (vm->hfront_porch + vm->hback_porch);
>         } else {
> -               if ((vm->hfront_porch + vm->hback_porch) * dsi_tmp_buf_bp=
p >
> -                   data_phy_cycles * dsi->lanes + 12) {
> -                       horizontal_frontporch_byte =3D
> -                               vm->hfront_porch * dsi_tmp_buf_bpp -
> -                               (data_phy_cycles * dsi->lanes + 12) *
> -                               vm->hfront_porch /
> -                               (vm->hfront_porch + vm->hback_porch);
> -                       horizontal_backporch_byte =3D horizontal_backporc=
h_byte -
> -                               (data_phy_cycles * dsi->lanes + 12) *
> -                               vm->hback_porch /
> -                               (vm->hfront_porch + vm->hback_porch);
> -               } else {
> -                       DRM_WARN("HFP less than d-phy, FPS will under 60H=
z\n");
> -                       horizontal_frontporch_byte =3D vm->hfront_porch *
> -                                                    dsi_tmp_buf_bpp;
> -               }
> +               DRM_WARN("HFP + HBP less than d-phy, FPS will under 60Hz\=
n");
> +               horizontal_frontporch_byte =3D vm->hfront_porch *
> +                                            dsi_tmp_buf_bpp;

I've applied this patch, but small hbp has problem because
horizontal_backporch_byte < 0.
I try to modify this patch according to two assumption:

1. horizontal_backporch_byte should be smaller than (vm->hback_porch +
vm->hsync_len) * dsi_tmp_buf_bpp at least 10.
2. horizontal_backporch_byte should >=3D 0.

According to these two assumption, I've a patch [1]. My key point is
that I use horizontal_backporch_byte to calculate the ratio to
subtract it. Is my assumption correct?
If not, please explain why do you calculate in this way, so we could
find out how to solve this problem.

[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/2506992

Regards,
Chun-Kuang.

>         }
>
>         writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
> --
> 2.12.5
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
