Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9D02B3A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 00:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgKOXNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 18:13:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgKOXNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 18:13:08 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED6D22453
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 23:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605481987;
        bh=lk702/tUQXibGYdggCfUZgCdOzqj1Eu9ni298A0WYIY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2Fa/9ZiHQnc5BbU0XZDC3uAMemNwIsstR9qKiGMuNCt9Qj4Vz3Qb03lkXZ5P4m3LP
         94hqfd32fXJf0Y/9wy6nkz6popX+S300JgMACJh+ICLNvuIT77/glxBmqfn4UJmqkw
         BJfiiLWQTLleOY/WvL2Z0rbAfFBNQb4uQMsUlmbQ=
Received: by mail-ej1-f42.google.com with SMTP id dk16so21837194ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 15:13:07 -0800 (PST)
X-Gm-Message-State: AOAM533bAkqpzaHycTnYzsFNOuOpuEaceGZmZjxE2NjpqsErTL1s190D
        AuP2WjtShzW2vqgphtLnFyejT/il6u79q9VwWA==
X-Google-Smtp-Source: ABdhPJyhR7yVa8OMs9CVMO4MXD46m7RyAQokGoT/HE9LB+f69Ko6msdZkOuu0dL0VOctbP5UKTEaLDUtX2zyBsS3qnw=
X-Received: by 2002:a17:906:a106:: with SMTP id t6mr11718404ejy.63.1605481985911;
 Sun, 15 Nov 2020 15:13:05 -0800 (PST)
MIME-Version: 1.0
References: <20201115001403.7833-1-chunkuang.hu@kernel.org>
 <CAAOTY_-16s=NXg2kOJijhO+82nNsT9HkKj4PVh1qN8dKchBOBA@mail.gmail.com> <20201116002522.1a5c3736@a-VirtualBox>
In-Reply-To: <20201116002522.1a5c3736@a-VirtualBox>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 16 Nov 2020 07:12:55 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-_N9pcmao0FFtGs-qVLrvA-QBz5FJrSaYynuMZMe1Qhg@mail.gmail.com>
Message-ID: <CAAOTY_-_N9pcmao0FFtGs-qVLrvA-QBz5FJrSaYynuMZMe1Qhg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: dsi: Calculate horizontal_backporch_byte by itself
To:     Bilal Wasim <bilalwasim676@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
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

Bilal Wasim <bilalwasim676@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=883:25=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi CK,
>
> On Sun, 15 Nov 2020 08:53:24 +0800
> Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:
>
> > Hi, Bilal:
> >
> > Please help to test this patch on your Chromebook elm, thanks.
> >
> > Regards,
> > Chun-Kuang Hu
>
> Just tried this patch on the Chromebook Elm, and it doesn't work. The
> HDMI screen remains black, though the rest of the system keeps on
> operating normally.

Could you print this information, so I could find out the solution for
both small hbp and elm.

vm->hfront_porch, vm->hback_porch, dsi_tmp_buf_bpp,
data_phy_cycles_byte, and the final horizontal_frontporch_byte,
horizontal_backporch_byte.

Regards,
Chun-Kuang.

>
> >
> > Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=
=8815=E6=97=A5 =E9=80=B1=E6=97=A5
> > =E4=B8=8A=E5=8D=888:14=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > From: CK Hu <ck.hu@mediatek.com>
> > >
> > > Using vm->hfront_porch + vm->hback_porch to calculate
> > > horizontal_backporch_byte would make it negtive, so
> > > use horizontal_backporch_byte itself to make it positive.
> > >
> > > Fixes: 35bf948f1edb ("drm/mediatek: dsi: Fix scrolling of panel
> > > with small hfp or hbp")
> > >
> > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 53
> > > ++++++++++-------------------- 1 file changed, 18 insertions(+), 35
> > > deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > b/drivers/gpu/drm/mediatek/mtk_dsi.c index
> > > 4a188a942c38..2a64fdaed9a7 100644 ---
> > > a/drivers/gpu/drm/mediatek/mtk_dsi.c +++
> > > b/drivers/gpu/drm/mediatek/mtk_dsi.c @@ -444,7 +444,10 @@ static
> > > void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi) u32
> > > horizontal_sync_active_byte; u32 horizontal_backporch_byte;
> > >         u32 horizontal_frontporch_byte;
> > > +       u32 horizontal_front_back_byte;
> > > +       u32 data_phy_cycles_byte;
> > >         u32 dsi_tmp_buf_bpp, data_phy_cycles;
> > > +       u32 delta;
> > >         struct mtk_phy_timing *timing =3D &dsi->phy_timing;
> > >
> > >         struct videomode *vm =3D &dsi->vm;
> > > @@ -474,42 +477,22 @@ static void mtk_dsi_config_vdo_timing(struct
> > > mtk_dsi *dsi) data_phy_cycles =3D timing->lpx + timing->da_hs_prepare
> > > + timing->da_hs_zero + timing->da_hs_exit;
> > >
> > > -       if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> > > -               if ((vm->hfront_porch + vm->hback_porch) *
> > > dsi_tmp_buf_bpp >
> > > -                   data_phy_cycles * dsi->lanes + 18) {
> > > -                       horizontal_frontporch_byte =3D
> > > -                               vm->hfront_porch * dsi_tmp_buf_bpp -
> > > -                               (data_phy_cycles * dsi->lanes + 18)
> > > *
> > > -                               vm->hfront_porch /
> > > -                               (vm->hfront_porch +
> > > vm->hback_porch); -
> > > -                       horizontal_backporch_byte =3D
> > > -                               horizontal_backporch_byte -
> > > -                               (data_phy_cycles * dsi->lanes + 18)
> > > *
> > > -                               vm->hback_porch /
> > > -                               (vm->hfront_porch +
> > > vm->hback_porch);
> > > -               } else {
> > > -                       DRM_WARN("HFP less than d-phy, FPS will
> > > under 60Hz\n");
> > > -                       horizontal_frontporch_byte =3D
> > > vm->hfront_porch *
> > > -
> > > dsi_tmp_buf_bpp;
> > > -               }
> > > +       delta =3D dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ? 18 :
> > > 12; +
> > > +       horizontal_frontporch_byte =3D vm->hfront_porch *
> > > dsi_tmp_buf_bpp;
> > > +       horizontal_front_back_byte =3D horizontal_frontporch_byte +
> > > horizontal_backporch_byte;
> > > +       data_phy_cycles_byte =3D data_phy_cycles * dsi->lanes + delta=
;
> > > +
> > > +       if (horizontal_front_back_byte > data_phy_cycles_byte) {
> > > +               horizontal_frontporch_byte -=3D data_phy_cycles_byte =
*
> > > +
> > > horizontal_frontporch_byte /
> > > +
> > > horizontal_front_back_byte; +
> > > +               horizontal_backporch_byte -=3D data_phy_cycles_byte *
> > > +
> > > horizontal_backporch_byte /
> > > +
> > > horizontal_front_back_byte; } else {
> > > -               if ((vm->hfront_porch + vm->hback_porch) *
> > > dsi_tmp_buf_bpp >
> > > -                   data_phy_cycles * dsi->lanes + 12) {
> > > -                       horizontal_frontporch_byte =3D
> > > -                               vm->hfront_porch * dsi_tmp_buf_bpp -
> > > -                               (data_phy_cycles * dsi->lanes + 12)
> > > *
> > > -                               vm->hfront_porch /
> > > -                               (vm->hfront_porch +
> > > vm->hback_porch);
> > > -                       horizontal_backporch_byte =3D
> > > horizontal_backporch_byte -
> > > -                               (data_phy_cycles * dsi->lanes + 12)
> > > *
> > > -                               vm->hback_porch /
> > > -                               (vm->hfront_porch +
> > > vm->hback_porch);
> > > -               } else {
> > > -                       DRM_WARN("HFP less than d-phy, FPS will
> > > under 60Hz\n");
> > > -                       horizontal_frontporch_byte =3D
> > > vm->hfront_porch *
> > > -
> > > dsi_tmp_buf_bpp;
> > > -               }
> > > +               DRM_WARN("HFP + HBP less than d-phy, FPS will under
> > > 60Hz\n"); }
> > >
> > >         writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
> > > --
> > > 2.17.1
> > >
>
> Thanks,
> Bilal
