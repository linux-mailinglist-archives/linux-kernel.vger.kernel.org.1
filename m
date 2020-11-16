Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804542B432D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgKPLxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKPLxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:53:21 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A840C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:53:20 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 19so23457288wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p9KGoxxYC+hgGvQRjQrRbEbTQUxe8E5TFAhLeXHI0Yc=;
        b=Az8/cOOPa7z8Y9SOXXHFJUN6I8AP9LU/yTgs5OycpyfRfAMB+J4ObKu4RzXyV1P2HE
         MCv4J7L35OGeXQ2xYHOXGoRpS8bvLz3Y7rgzXy8U3dDdl3XRSvO06r+YxjPwfAGKT2XS
         7Nsk3CnU+TxGNGjuNAQe5XHeCEJ5wR8m3/zxOMr5Ctp22H+r8k509jZKpSLmbdFgpp5j
         dADSEV19QOVfiXD9sJJLzzUkpYnJeWc9xvyGSIu9z+W7d9It06xrw29glDh3chlmr8uU
         TfgWVRsQXNjAZ4Lt4zWn/IsTjrQbqQXlVTvp9kznYPUSZOak332/tsU1vcUtf4v2ZzUW
         n5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9KGoxxYC+hgGvQRjQrRbEbTQUxe8E5TFAhLeXHI0Yc=;
        b=RFsj0d9RE52rcWxCGAiPw9HgVdsuHReChygj4xuvZMCiqF4B++NVrfYw3wQ8iJgb1O
         GO6kQZu8KerWrZZv08TDNP3tg1AFhoTM0Dxx+L2UNFQLqeRGb0MrFHuRs2a5ZDKBK07A
         czgIRRi/3Q2rJQs88yAZhxzlkaDty7n5zmMhPYfQqS9HZCFID85r+i2kosVmeBceBihU
         9uhmIVgAIcH5CG2F8iM+HYOv6FCSGNlH+DCoQgLHRDPcqjl0H45fUnOuRAz4v3FcMqWa
         qcEeYISp9s4IeNaYZacUOGZ59oip1i8eZ3WQE79ank3rJ/n5wTn7veHLAarOvWoDJzx0
         8F7A==
X-Gm-Message-State: AOAM531aH0HDtdhF1GzQtAjfFXR7Mn03Wqi5rqcIhoVEu3pUumXw6jPu
        iRHTcyVdnGL3piqLXu8tSzY=
X-Google-Smtp-Source: ABdhPJyYM5nTj19mPq3Lr3emSdpUM11H8uM1xqtl64jGJLVdb9lVIPJYxAePSU4X7DKb+9yGVHwJjg==
X-Received: by 2002:a1c:e345:: with SMTP id a66mr14986818wmh.188.1605527599204;
        Mon, 16 Nov 2020 03:53:19 -0800 (PST)
Received: from a-VirtualBox ([103.120.71.253])
        by smtp.gmail.com with ESMTPSA id d134sm19325713wmd.8.2020.11.16.03.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 03:53:19 -0800 (PST)
Date:   Mon, 16 Nov 2020 16:53:11 +0500
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
Message-ID: <20201116165311.15a36e82@a-VirtualBox>
In-Reply-To: <CAAOTY_-_N9pcmao0FFtGs-qVLrvA-QBz5FJrSaYynuMZMe1Qhg@mail.gmail.com>
References: <20201115001403.7833-1-chunkuang.hu@kernel.org>
        <CAAOTY_-16s=NXg2kOJijhO+82nNsT9HkKj4PVh1qN8dKchBOBA@mail.gmail.com>
        <20201116002522.1a5c3736@a-VirtualBox>
        <CAAOTY_-_N9pcmao0FFtGs-qVLrvA-QBz5FJrSaYynuMZMe1Qhg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK,=20

On Mon, 16 Nov 2020 07:12:55 +0800
Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:

> Hi, Bilal:
>=20
> Bilal Wasim <bilalwasim676@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=881=
6=E6=97=A5 =E9=80=B1=E4=B8=80
> =E4=B8=8A=E5=8D=883:25=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Hi CK,
> >
> > On Sun, 15 Nov 2020 08:53:24 +0800
> > Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:
> > =20
> > > Hi, Bilal:
> > >
> > > Please help to test this patch on your Chromebook elm, thanks.
> > >
> > > Regards,
> > > Chun-Kuang Hu =20
> >
> > Just tried this patch on the Chromebook Elm, and it doesn't work.
> > The HDMI screen remains black, though the rest of the system keeps
> > on operating normally. =20
>=20
> Could you print this information, so I could find out the solution for
> both small hbp and elm.
>=20
> vm->hfront_porch, vm->hback_porch, dsi_tmp_buf_bpp,
> data_phy_cycles_byte, and the final horizontal_frontporch_byte,
> horizontal_backporch_byte.

Here are the values I got,=20

[    2.506400] [drm] vm->hfront_porch: 48
[    2.506402] [drm] vm->hback_porch: 200
[    2.506404] [drm] dsi_tmp_buf_bpp: 3
[    2.506406] [drm] data_phy_cycles_byte: 180
[    2.506408] [drm] horizontal_frontporch_byte: 110
[    2.506409] [drm] horizontal_backporch_byte: 455

Please let me know if I can help debug this in any other way.

Thanks,=20
Bilal

>=20
> Regards,
> Chun-Kuang.
>=20
> > =20
> > >
> > > Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=
=9C=8815=E6=97=A5 =E9=80=B1=E6=97=A5
> > > =E4=B8=8A=E5=8D=888:14=E5=AF=AB=E9=81=93=EF=BC=9A =20
> > > >
> > > > From: CK Hu <ck.hu@mediatek.com>
> > > >
> > > > Using vm->hfront_porch + vm->hback_porch to calculate
> > > > horizontal_backporch_byte would make it negtive, so
> > > > use horizontal_backporch_byte itself to make it positive.
> > > >
> > > > Fixes: 35bf948f1edb ("drm/mediatek: dsi: Fix scrolling of panel
> > > > with small hfp or hbp")
> > > >
> > > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > > ---
> > > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 53
> > > > ++++++++++-------------------- 1 file changed, 18
> > > > insertions(+), 35 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > b/drivers/gpu/drm/mediatek/mtk_dsi.c index
> > > > 4a188a942c38..2a64fdaed9a7 100644 ---
> > > > a/drivers/gpu/drm/mediatek/mtk_dsi.c +++
> > > > b/drivers/gpu/drm/mediatek/mtk_dsi.c @@ -444,7 +444,10 @@ static
> > > > void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi) u32
> > > > horizontal_sync_active_byte; u32 horizontal_backporch_byte;
> > > >         u32 horizontal_frontporch_byte;
> > > > +       u32 horizontal_front_back_byte;
> > > > +       u32 data_phy_cycles_byte;
> > > >         u32 dsi_tmp_buf_bpp, data_phy_cycles;
> > > > +       u32 delta;
> > > >         struct mtk_phy_timing *timing =3D &dsi->phy_timing;
> > > >
> > > >         struct videomode *vm =3D &dsi->vm;
> > > > @@ -474,42 +477,22 @@ static void
> > > > mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi) data_phy_cycles
> > > > =3D timing->lpx + timing->da_hs_prepare
> > > > + timing->da_hs_zero + timing->da_hs_exit;
> > > >
> > > > -       if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> > > > -               if ((vm->hfront_porch + vm->hback_porch) *
> > > > dsi_tmp_buf_bpp >
> > > > -                   data_phy_cycles * dsi->lanes + 18) {
> > > > -                       horizontal_frontporch_byte =3D
> > > > -                               vm->hfront_porch *
> > > > dsi_tmp_buf_bpp -
> > > > -                               (data_phy_cycles * dsi->lanes +
> > > > 18) *
> > > > -                               vm->hfront_porch /
> > > > -                               (vm->hfront_porch +
> > > > vm->hback_porch); -
> > > > -                       horizontal_backporch_byte =3D
> > > > -                               horizontal_backporch_byte -
> > > > -                               (data_phy_cycles * dsi->lanes +
> > > > 18) *
> > > > -                               vm->hback_porch /
> > > > -                               (vm->hfront_porch +
> > > > vm->hback_porch);
> > > > -               } else {
> > > > -                       DRM_WARN("HFP less than d-phy, FPS will
> > > > under 60Hz\n");
> > > > -                       horizontal_frontporch_byte =3D
> > > > vm->hfront_porch *
> > > > -
> > > > dsi_tmp_buf_bpp;
> > > > -               }
> > > > +       delta =3D dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ?
> > > > 18 : 12; +
> > > > +       horizontal_frontporch_byte =3D vm->hfront_porch *
> > > > dsi_tmp_buf_bpp;
> > > > +       horizontal_front_back_byte =3D horizontal_frontporch_byte
> > > > + horizontal_backporch_byte;
> > > > +       data_phy_cycles_byte =3D data_phy_cycles * dsi->lanes +
> > > > delta; +
> > > > +       if (horizontal_front_back_byte > data_phy_cycles_byte) {
> > > > +               horizontal_frontporch_byte -=3D
> > > > data_phy_cycles_byte * +
> > > > horizontal_frontporch_byte /
> > > > +
> > > > horizontal_front_back_byte; +
> > > > +               horizontal_backporch_byte -=3D
> > > > data_phy_cycles_byte * +
> > > > horizontal_backporch_byte /
> > > > +
> > > > horizontal_front_back_byte; } else {
> > > > -               if ((vm->hfront_porch + vm->hback_porch) *
> > > > dsi_tmp_buf_bpp >
> > > > -                   data_phy_cycles * dsi->lanes + 12) {
> > > > -                       horizontal_frontporch_byte =3D
> > > > -                               vm->hfront_porch *
> > > > dsi_tmp_buf_bpp -
> > > > -                               (data_phy_cycles * dsi->lanes +
> > > > 12) *
> > > > -                               vm->hfront_porch /
> > > > -                               (vm->hfront_porch +
> > > > vm->hback_porch);
> > > > -                       horizontal_backporch_byte =3D
> > > > horizontal_backporch_byte -
> > > > -                               (data_phy_cycles * dsi->lanes +
> > > > 12) *
> > > > -                               vm->hback_porch /
> > > > -                               (vm->hfront_porch +
> > > > vm->hback_porch);
> > > > -               } else {
> > > > -                       DRM_WARN("HFP less than d-phy, FPS will
> > > > under 60Hz\n");
> > > > -                       horizontal_frontporch_byte =3D
> > > > vm->hfront_porch *
> > > > -
> > > > dsi_tmp_buf_bpp;
> > > > -               }
> > > > +               DRM_WARN("HFP + HBP less than d-phy, FPS will
> > > > under 60Hz\n"); }
> > > >
> > > >         writel(horizontal_sync_active_byte, dsi->regs +
> > > > DSI_HSA_WC); --
> > > > 2.17.1
> > > > =20
> >
> > Thanks,
> > Bilal =20

