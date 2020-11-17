Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7214B2B5ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgKQMCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgKQMCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:02:07 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905DEC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 04:02:06 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h21so2988320wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 04:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRX4TaDlmzy/dYzUJb8MjTcRK0N9HFquY94CX4KxEUc=;
        b=MSjZoVGzHCfEDpuGhWrG+5Pxg1zjCNS57F+J0/pvtJufCQz7fhLFeYGXwOPDfjOLps
         p4CpKTQdmhy+6XuiAqm1+kedTbEaq5o6oBhCq/MJsK2pkljo58Q8XI6m7v8lt0L4eSsV
         NL/cYmtQCsJwhLCdSpb3WuxjU6YsYlaynxCu4fJjwdKR+mw00jgHQmdHRK9+E7DSAUjd
         ZX1YHILtzYhjZ6op4j58C5vtw9TY790hg3PwrG9/Z+dX5+EusLhfIRWA+88YsCggexBV
         mjS4oXM4rvhrD2orXU6DNyn0p8rBsusiBqoj0xOKs2EijHGKdWkMQx+iBLxLHeZ9kGA0
         n+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRX4TaDlmzy/dYzUJb8MjTcRK0N9HFquY94CX4KxEUc=;
        b=jNt3hykC+LdiHLYqI0Mtwaquaii/SprHw9blgYF9T3IR/j0/801Af/nBpsPDFID/Yc
         fzWxf0KC4VrdAmEac8i77gCeRuN8W0UiPvwrm1lr9rQVsWvry2Lginxq7WrahcUrGpA8
         8ERZMgEY6HCJFk8bCQ3jN3+WS+giIqYaqOOPlak6+ZCZBc5m/Q+caPIwjMUnAN3cOvS2
         /AMAHC5fz0EZrEYhM0WfsGGYzQmtwHcAL5D11WBwuovGVkio2IRhalaDiQxbRwE63J9e
         VF/KHs8xGt0rt3AD31aPB+pn8Qof34uQ1qL/kvz6XG+lvM1wXDThPj65BASd+BNcSoOA
         AZNA==
X-Gm-Message-State: AOAM530vy+au3jfNg/3NKwxYEYNLVgdfoJYMW8MoKa95Pre7bUs6BM7h
        Rc2FHDYJzYPIB0Tknys8sNA=
X-Google-Smtp-Source: ABdhPJw11bdW3TgvO6Qh9Hp1LKHklpGieGPVaHwjyvo5ewr+wdOD9dOf4mBxQqh27eJ21YK3SbjWwA==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr4064264wme.85.1605614525226;
        Tue, 17 Nov 2020 04:02:05 -0800 (PST)
Received: from a-VirtualBox ([103.120.71.253])
        by smtp.gmail.com with ESMTPSA id y4sm3215086wmj.2.2020.11.17.04.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 04:02:04 -0800 (PST)
Date:   Tue, 17 Nov 2020 17:01:58 +0500
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
Message-ID: <20201117170158.7d2c721c@a-VirtualBox>
In-Reply-To: <20201117165848.54eb2d87@a-VirtualBox>
References: <20201115001403.7833-1-chunkuang.hu@kernel.org>
        <CAAOTY_-16s=NXg2kOJijhO+82nNsT9HkKj4PVh1qN8dKchBOBA@mail.gmail.com>
        <20201116002522.1a5c3736@a-VirtualBox>
        <CAAOTY_-_N9pcmao0FFtGs-qVLrvA-QBz5FJrSaYynuMZMe1Qhg@mail.gmail.com>
        <20201116165311.15a36e82@a-VirtualBox>
        <CAAOTY_8LOLg8BeVY39EciSPqtBzeafPpenm0721+2rfhkKH0Cw@mail.gmail.com>
        <20201117165848.54eb2d87@a-VirtualBox>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 16:58:48 +0500
Bilal Wasim <bilalwasim676@gmail.com> wrote:

> Hi CK,
>=20
> On Tue, 17 Nov 2020 00:43:44 +0800
> Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:
>=20
> > Hi, Bilal:
> >=20
> > Bilal Wasim <bilalwasim676@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=
=8816=E6=97=A5 =E9=80=B1=E4=B8=80
> > =E4=B8=8B=E5=8D=887:53=E5=AF=AB=E9=81=93=EF=BC=9A =20
> > >
> > > Hi CK,
> > >
> > > On Mon, 16 Nov 2020 07:12:55 +0800
> > > Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:
> > >   =20
> > > > Hi, Bilal:
> > > >
> > > > Bilal Wasim <bilalwasim676@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=
=9C=8816=E6=97=A5 =E9=80=B1=E4=B8=80
> > > > =E4=B8=8A=E5=8D=883:25=E5=AF=AB=E9=81=93=EF=BC=9A   =20
> > > > >
> > > > > Hi CK,
> > > > >
> > > > > On Sun, 15 Nov 2020 08:53:24 +0800
> > > > > Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:
> > > > >   =20
> > > > > > Hi, Bilal:
> > > > > >
> > > > > > Please help to test this patch on your Chromebook elm,
> > > > > > thanks.
> > > > > >
> > > > > > Regards,
> > > > > > Chun-Kuang Hu   =20
> > > > >
> > > > > Just tried this patch on the Chromebook Elm, and it doesn't
> > > > > work. The HDMI screen remains black, though the rest of the
> > > > > system keeps on operating normally.   =20
> > > >
> > > > Could you print this information, so I could find out the
> > > > solution for both small hbp and elm.
> > > >
> > > > vm->hfront_porch, vm->hback_porch, dsi_tmp_buf_bpp,
> > > > data_phy_cycles_byte, and the final horizontal_frontporch_byte,
> > > > horizontal_backporch_byte.   =20
> > >
> > > Here are the values I got,
> > >
> > > [    2.506400] [drm] vm->hfront_porch: 48
> > > [    2.506402] [drm] vm->hback_porch: 200
> > > [    2.506404] [drm] dsi_tmp_buf_bpp: 3
> > > [    2.506406] [drm] data_phy_cycles_byte: 180
> > > [    2.506408] [drm] horizontal_frontporch_byte: 110
> > > [    2.506409] [drm] horizontal_backporch_byte: 455
> > >
> > > Please let me know if I can help debug this in any other way.
> > >   =20
> >=20
> > How about this patch [1] ?
> >=20
> > [1]
> > https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/2536217/2
> > =20
>=20
> This patch works, though it doesn't apply cleanly on 5.9-rc3 (had to
> manually patch the mtk_dsi.c file).=20
>=20

Just to clarify: I tested with 5.10-rc3, not 5.9-rc3. Apologies for the
typo.

Thanks,=20
Bilal

> Here are the various variable values, if you're interested.=20
>=20
> [    2.453292] [drm] vm->hfront_porch: 48
> [    2.453293] [drm] vm->hback_porch: 200
> [    2.453295] [drm] dsi_tmp_buf_bpp: 3
> [    2.453296] [drm] data_phy_cycles_byte: 192
> [    2.453298] [drm] horizontal_frontporch_byte: 107
> [    2.453299] [drm] horizontal_backporch_byte: 436
>=20
> Thanks,=20
> Bilal
>=20
> >  =20
> > > Thanks,
> > > Bilal
> > >   =20
> > > >
> > > > Regards,
> > > > Chun-Kuang.
> > > >   =20
> > > > >   =20
> > > > > >
> > > > > > Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B4=
11=E6=9C=8815=E6=97=A5
> > > > > > =E9=80=B1=E6=97=A5=E4=B8=8A=E5=8D=888:14=E5=AF=AB=E9=81=93=EF=
=BC=9A   =20
> > > > > > >
> > > > > > > From: CK Hu <ck.hu@mediatek.com>
> > > > > > >
> > > > > > > Using vm->hfront_porch + vm->hback_porch to calculate
> > > > > > > horizontal_backporch_byte would make it negtive, so
> > > > > > > use horizontal_backporch_byte itself to make it positive.
> > > > > > >
> > > > > > > Fixes: 35bf948f1edb ("drm/mediatek: dsi: Fix scrolling of
> > > > > > > panel with small hfp or hbp")
> > > > > > >
> > > > > > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > > > > > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 53
> > > > > > > ++++++++++-------------------- 1 file changed, 18
> > > > > > > insertions(+), 35 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > > > > b/drivers/gpu/drm/mediatek/mtk_dsi.c index
> > > > > > > 4a188a942c38..2a64fdaed9a7 100644 ---
> > > > > > > a/drivers/gpu/drm/mediatek/mtk_dsi.c +++
> > > > > > > b/drivers/gpu/drm/mediatek/mtk_dsi.c @@ -444,7 +444,10 @@
> > > > > > > static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
> > > > > > > u32 horizontal_sync_active_byte; u32
> > > > > > > horizontal_backporch_byte; u32 horizontal_frontporch_byte;
> > > > > > > +       u32 horizontal_front_back_byte;
> > > > > > > +       u32 data_phy_cycles_byte;
> > > > > > >         u32 dsi_tmp_buf_bpp, data_phy_cycles;
> > > > > > > +       u32 delta;
> > > > > > >         struct mtk_phy_timing *timing =3D &dsi->phy_timing;
> > > > > > >
> > > > > > >         struct videomode *vm =3D &dsi->vm;
> > > > > > > @@ -474,42 +477,22 @@ static void
> > > > > > > mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
> > > > > > > data_phy_cycles =3D timing->lpx + timing->da_hs_prepare
> > > > > > > + timing->da_hs_zero + timing->da_hs_exit;
> > > > > > >
> > > > > > > -       if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> > > > > > > -               if ((vm->hfront_porch + vm->hback_porch) *
> > > > > > > dsi_tmp_buf_bpp >
> > > > > > > -                   data_phy_cycles * dsi->lanes + 18) {
> > > > > > > -                       horizontal_frontporch_byte =3D
> > > > > > > -                               vm->hfront_porch *
> > > > > > > dsi_tmp_buf_bpp -
> > > > > > > -                               (data_phy_cycles *
> > > > > > > dsi->lanes + 18) *
> > > > > > > -                               vm->hfront_porch /
> > > > > > > -                               (vm->hfront_porch +
> > > > > > > vm->hback_porch); -
> > > > > > > -                       horizontal_backporch_byte =3D
> > > > > > > -                               horizontal_backporch_byte
> > > > > > > -
> > > > > > > -                               (data_phy_cycles *
> > > > > > > dsi->lanes + 18) *
> > > > > > > -                               vm->hback_porch /
> > > > > > > -                               (vm->hfront_porch +
> > > > > > > vm->hback_porch);
> > > > > > > -               } else {
> > > > > > > -                       DRM_WARN("HFP less than d-phy, FPS
> > > > > > > will under 60Hz\n");
> > > > > > > -                       horizontal_frontporch_byte =3D
> > > > > > > vm->hfront_porch *
> > > > > > > -
> > > > > > > dsi_tmp_buf_bpp;
> > > > > > > -               }
> > > > > > > +       delta =3D dsi->mode_flags &
> > > > > > > MIPI_DSI_MODE_VIDEO_BURST ? 18 : 12; +
> > > > > > > +       horizontal_frontporch_byte =3D vm->hfront_porch *
> > > > > > > dsi_tmp_buf_bpp;
> > > > > > > +       horizontal_front_back_byte =3D
> > > > > > > horizontal_frontporch_byte
> > > > > > > + horizontal_backporch_byte;
> > > > > > > +       data_phy_cycles_byte =3D data_phy_cycles *
> > > > > > > dsi->lanes
> > > > > > > + delta; +
> > > > > > > +       if (horizontal_front_back_byte >
> > > > > > > data_phy_cycles_byte) {
> > > > > > > +               horizontal_frontporch_byte -=3D
> > > > > > > data_phy_cycles_byte * +
> > > > > > > horizontal_frontporch_byte /
> > > > > > > +
> > > > > > > horizontal_front_back_byte; +
> > > > > > > +               horizontal_backporch_byte -=3D
> > > > > > > data_phy_cycles_byte * +
> > > > > > > horizontal_backporch_byte /
> > > > > > > +
> > > > > > > horizontal_front_back_byte; } else {
> > > > > > > -               if ((vm->hfront_porch + vm->hback_porch) *
> > > > > > > dsi_tmp_buf_bpp >
> > > > > > > -                   data_phy_cycles * dsi->lanes + 12) {
> > > > > > > -                       horizontal_frontporch_byte =3D
> > > > > > > -                               vm->hfront_porch *
> > > > > > > dsi_tmp_buf_bpp -
> > > > > > > -                               (data_phy_cycles *
> > > > > > > dsi->lanes + 12) *
> > > > > > > -                               vm->hfront_porch /
> > > > > > > -                               (vm->hfront_porch +
> > > > > > > vm->hback_porch);
> > > > > > > -                       horizontal_backporch_byte =3D
> > > > > > > horizontal_backporch_byte -
> > > > > > > -                               (data_phy_cycles *
> > > > > > > dsi->lanes + 12) *
> > > > > > > -                               vm->hback_porch /
> > > > > > > -                               (vm->hfront_porch +
> > > > > > > vm->hback_porch);
> > > > > > > -               } else {
> > > > > > > -                       DRM_WARN("HFP less than d-phy, FPS
> > > > > > > will under 60Hz\n");
> > > > > > > -                       horizontal_frontporch_byte =3D
> > > > > > > vm->hfront_porch *
> > > > > > > -
> > > > > > > dsi_tmp_buf_bpp;
> > > > > > > -               }
> > > > > > > +               DRM_WARN("HFP + HBP less than d-phy, FPS
> > > > > > > will under 60Hz\n"); }
> > > > > > >
> > > > > > >         writel(horizontal_sync_active_byte, dsi->regs +
> > > > > > > DSI_HSA_WC); --
> > > > > > > 2.17.1
> > > > > > >   =20
> > > > >
> > > > > Thanks,
> > > > > Bilal   =20
> > >   =20
>=20

