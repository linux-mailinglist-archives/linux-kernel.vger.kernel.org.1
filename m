Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F792B31AF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 01:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgKOAxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 19:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgKOAxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 19:53:37 -0500
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D85AA24178
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 00:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605401617;
        bh=2xRinuFWqV9wNbtdYn55Adl9enTowu3JLHrktB7k1r8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I/JPZvzlqno3hdNkxz2d9/Q6nqCdGlmILxEFb8oiPomoOTBUzpW337OlrsZQQ3PCx
         7axUizSij8Yger2piJ5WXvJ29AViJfdCscI7ZS+OXMe2GwNcTcmtmtoOYBm5Sv78g2
         mVWVmJRysOTVvxTiaO+9eid4wqhiCgD0qMf4c3YE=
Received: by mail-ed1-f46.google.com with SMTP id d18so2141770edt.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 16:53:36 -0800 (PST)
X-Gm-Message-State: AOAM532LRBUl9Iwv5NK3BHVxQNPO19XisfeNQ+toE6JnUvHhSRqbxYQM
        vRoJX85pIy7PAlCWyLtixCegQ8Wi9srY+tSoJg==
X-Google-Smtp-Source: ABdhPJwW4TOZ4awkXt4BWs5LinUavfZHC1Yo8OVPShdZC9gORcWby3eWUHFQvp97/lNMofLDe1x8TOTpuL10pQBj7Tg=
X-Received: by 2002:a50:f742:: with SMTP id j2mr1351097edn.72.1605401615457;
 Sat, 14 Nov 2020 16:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20201115001403.7833-1-chunkuang.hu@kernel.org>
In-Reply-To: <20201115001403.7833-1-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 15 Nov 2020 08:53:24 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-16s=NXg2kOJijhO+82nNsT9HkKj4PVh1qN8dKchBOBA@mail.gmail.com>
Message-ID: <CAAOTY_-16s=NXg2kOJijhO+82nNsT9HkKj4PVh1qN8dKchBOBA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: dsi: Calculate horizontal_backporch_byte by itself
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jitao Shi <jitao.shi@mediatek.com>,
        Bilal Wasim <bilalwasim676@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bilal:

Please help to test this patch on your Chromebook elm, thanks.

Regards,
Chun-Kuang Hu

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=881=
5=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=888:14=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> From: CK Hu <ck.hu@mediatek.com>
>
> Using vm->hfront_porch + vm->hback_porch to calculate
> horizontal_backporch_byte would make it negtive, so
> use horizontal_backporch_byte itself to make it positive.
>
> Fixes: 35bf948f1edb ("drm/mediatek: dsi: Fix scrolling of panel with smal=
l hfp or hbp")
>
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 53 ++++++++++--------------------
>  1 file changed, 18 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 4a188a942c38..2a64fdaed9a7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -444,7 +444,10 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi=
 *dsi)
>         u32 horizontal_sync_active_byte;
>         u32 horizontal_backporch_byte;
>         u32 horizontal_frontporch_byte;
> +       u32 horizontal_front_back_byte;
> +       u32 data_phy_cycles_byte;
>         u32 dsi_tmp_buf_bpp, data_phy_cycles;
> +       u32 delta;
>         struct mtk_phy_timing *timing =3D &dsi->phy_timing;
>
>         struct videomode *vm =3D &dsi->vm;
> @@ -474,42 +477,22 @@ static void mtk_dsi_config_vdo_timing(struct mtk_ds=
i *dsi)
>         data_phy_cycles =3D timing->lpx + timing->da_hs_prepare +
>                           timing->da_hs_zero + timing->da_hs_exit;
>
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
> +       delta =3D dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ? 18 : 12;
> +
> +       horizontal_frontporch_byte =3D vm->hfront_porch * dsi_tmp_buf_bpp=
;
> +       horizontal_front_back_byte =3D horizontal_frontporch_byte + horiz=
ontal_backporch_byte;
> +       data_phy_cycles_byte =3D data_phy_cycles * dsi->lanes + delta;
> +
> +       if (horizontal_front_back_byte > data_phy_cycles_byte) {
> +               horizontal_frontporch_byte -=3D data_phy_cycles_byte *
> +                                             horizontal_frontporch_byte =
/
> +                                             horizontal_front_back_byte;
> +
> +               horizontal_backporch_byte -=3D data_phy_cycles_byte *
> +                                            horizontal_backporch_byte /
> +                                            horizontal_front_back_byte;
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
>         }
>
>         writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
> --
> 2.17.1
>
