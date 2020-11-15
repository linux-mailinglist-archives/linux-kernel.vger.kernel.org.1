Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812172B389A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 20:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgKOTZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 14:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgKOTZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 14:25:33 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4040CC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 11:25:33 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id s25so21387208ejy.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 11:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xB3qnHJkLixs9eUsHbiHUvqVDk7eh+uvldQKjizPJpk=;
        b=gyIikv2QoBHSmo3GXfTZCoJpENLKByqzYlL4BJQAkUjm8QbHavAdx6z8LCFuDODvAw
         PnJoLxPyaQnOMUw/LZgsD+7GDn3nh+9LJoZhP4xDFlZO1bB+/a1hcUr6TOm/flRwUoHQ
         TAMfyxta6QoKfhYNUg2oXnWIwI5gTtm6hBQnnukj17HgzF1KELxcpvn0W5LE9MGZ8zfT
         YN5u0I12pR0dsx8TRsVkH/ZNMpR5nVxoE8odCsBmidofp5Zby7JZV+lEVnj9Q0e55i26
         N3KZxGIwoKYHbCWTPAd+WkJRRPfBuGwRq95IfdeBk4DziMAkAepsezC9x95P2IumUZQe
         G3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xB3qnHJkLixs9eUsHbiHUvqVDk7eh+uvldQKjizPJpk=;
        b=Y0MEoiG/anu1zqd+trKT8icrEUCbVKgzWiXx+9fQX0erB/nVSAhEtUSbCAbQm9jd95
         OxeqHuTKlC0nnGDdi0cRdNRLdr69Ehm5kbPL6zYlcqILWIAiHVMRY2Ti6oIoouAIishW
         eL00u0NhCWllvyp3DN/SEJbkTbyBQuIYXqFyoEbfAuQQfCdUzGiQ4e9H2M3GttRPyzIb
         4maHPQggL2F4LaJv9+rD59yksAaPrqh0YF+OWKqOysGW1bGiBRhVKm7B3inRr8o0H0Up
         ylrwap+GGLAVrYJl0k5omOk0RZ3F8uxdISpq0Bkm31MK2+/v+hwQrqg+0XCdsRsAxKB9
         AcVg==
X-Gm-Message-State: AOAM532+Lbste3xlmQuqsD11Dksh319X3TXIfeySKrApjK9NVnxZf8mX
        U7ZGNqcm2njmgKDJTHgsooU=
X-Google-Smtp-Source: ABdhPJwojTgCrs7WkkvNVHL8ZGygT/viZY4rQYGKpf65SaKcUgVB/s3s2/PwE3EfvSJVKjs1imrfoQ==
X-Received: by 2002:a17:906:3ada:: with SMTP id z26mr11511937ejd.151.1605468331907;
        Sun, 15 Nov 2020 11:25:31 -0800 (PST)
Received: from a-VirtualBox ([103.120.71.253])
        by smtp.gmail.com with ESMTPSA id e19sm9306082ejz.35.2020.11.15.11.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:25:31 -0800 (PST)
Date:   Mon, 16 Nov 2020 00:25:22 +0500
From:   Bilal Wasim <bilalwasim676@gmail.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jitao Shi <jitao.shi@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>
Subject: Re: [PATCH] drm/mediatek: dsi: Calculate horizontal_backporch_byte
 by itself
Message-ID: <20201116002522.1a5c3736@a-VirtualBox>
In-Reply-To: <CAAOTY_-16s=NXg2kOJijhO+82nNsT9HkKj4PVh1qN8dKchBOBA@mail.gmail.com>
References: <20201115001403.7833-1-chunkuang.hu@kernel.org>
        <CAAOTY_-16s=NXg2kOJijhO+82nNsT9HkKj4PVh1qN8dKchBOBA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK,=20

On Sun, 15 Nov 2020 08:53:24 +0800
Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:

> Hi, Bilal:
>=20
> Please help to test this patch on your Chromebook elm, thanks.
>=20
> Regards,
> Chun-Kuang Hu

Just tried this patch on the Chromebook Elm, and it doesn't work. The
HDMI screen remains black, though the rest of the system keeps on
operating normally.

>=20
> Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=
=8815=E6=97=A5 =E9=80=B1=E6=97=A5
> =E4=B8=8A=E5=8D=888:14=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > From: CK Hu <ck.hu@mediatek.com>
> >
> > Using vm->hfront_porch + vm->hback_porch to calculate
> > horizontal_backporch_byte would make it negtive, so
> > use horizontal_backporch_byte itself to make it positive.
> >
> > Fixes: 35bf948f1edb ("drm/mediatek: dsi: Fix scrolling of panel
> > with small hfp or hbp")
> >
> > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 53
> > ++++++++++-------------------- 1 file changed, 18 insertions(+), 35
> > deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > b/drivers/gpu/drm/mediatek/mtk_dsi.c index
> > 4a188a942c38..2a64fdaed9a7 100644 ---
> > a/drivers/gpu/drm/mediatek/mtk_dsi.c +++
> > b/drivers/gpu/drm/mediatek/mtk_dsi.c @@ -444,7 +444,10 @@ static
> > void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi) u32
> > horizontal_sync_active_byte; u32 horizontal_backporch_byte;
> >         u32 horizontal_frontporch_byte;
> > +       u32 horizontal_front_back_byte;
> > +       u32 data_phy_cycles_byte;
> >         u32 dsi_tmp_buf_bpp, data_phy_cycles;
> > +       u32 delta;
> >         struct mtk_phy_timing *timing =3D &dsi->phy_timing;
> >
> >         struct videomode *vm =3D &dsi->vm;
> > @@ -474,42 +477,22 @@ static void mtk_dsi_config_vdo_timing(struct
> > mtk_dsi *dsi) data_phy_cycles =3D timing->lpx + timing->da_hs_prepare
> > + timing->da_hs_zero + timing->da_hs_exit;
> >
> > -       if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> > -               if ((vm->hfront_porch + vm->hback_porch) *
> > dsi_tmp_buf_bpp >
> > -                   data_phy_cycles * dsi->lanes + 18) {
> > -                       horizontal_frontporch_byte =3D
> > -                               vm->hfront_porch * dsi_tmp_buf_bpp -
> > -                               (data_phy_cycles * dsi->lanes + 18)
> > *
> > -                               vm->hfront_porch /
> > -                               (vm->hfront_porch +
> > vm->hback_porch); -
> > -                       horizontal_backporch_byte =3D
> > -                               horizontal_backporch_byte -
> > -                               (data_phy_cycles * dsi->lanes + 18)
> > *
> > -                               vm->hback_porch /
> > -                               (vm->hfront_porch +
> > vm->hback_porch);
> > -               } else {
> > -                       DRM_WARN("HFP less than d-phy, FPS will
> > under 60Hz\n");
> > -                       horizontal_frontporch_byte =3D
> > vm->hfront_porch *
> > -
> > dsi_tmp_buf_bpp;
> > -               }
> > +       delta =3D dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ? 18 :
> > 12; +
> > +       horizontal_frontporch_byte =3D vm->hfront_porch *
> > dsi_tmp_buf_bpp;
> > +       horizontal_front_back_byte =3D horizontal_frontporch_byte +
> > horizontal_backporch_byte;
> > +       data_phy_cycles_byte =3D data_phy_cycles * dsi->lanes + delta;
> > +
> > +       if (horizontal_front_back_byte > data_phy_cycles_byte) {
> > +               horizontal_frontporch_byte -=3D data_phy_cycles_byte *
> > +
> > horizontal_frontporch_byte /
> > +
> > horizontal_front_back_byte; +
> > +               horizontal_backporch_byte -=3D data_phy_cycles_byte *
> > +
> > horizontal_backporch_byte /
> > +
> > horizontal_front_back_byte; } else {
> > -               if ((vm->hfront_porch + vm->hback_porch) *
> > dsi_tmp_buf_bpp >
> > -                   data_phy_cycles * dsi->lanes + 12) {
> > -                       horizontal_frontporch_byte =3D
> > -                               vm->hfront_porch * dsi_tmp_buf_bpp -
> > -                               (data_phy_cycles * dsi->lanes + 12)
> > *
> > -                               vm->hfront_porch /
> > -                               (vm->hfront_porch +
> > vm->hback_porch);
> > -                       horizontal_backporch_byte =3D
> > horizontal_backporch_byte -
> > -                               (data_phy_cycles * dsi->lanes + 12)
> > *
> > -                               vm->hback_porch /
> > -                               (vm->hfront_porch +
> > vm->hback_porch);
> > -               } else {
> > -                       DRM_WARN("HFP less than d-phy, FPS will
> > under 60Hz\n");
> > -                       horizontal_frontporch_byte =3D
> > vm->hfront_porch *
> > -
> > dsi_tmp_buf_bpp;
> > -               }
> > +               DRM_WARN("HFP + HBP less than d-phy, FPS will under
> > 60Hz\n"); }
> >
> >         writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
> > --
> > 2.17.1
> > =20

Thanks,
Bilal
