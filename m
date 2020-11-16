Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A043F2B4B84
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbgKPQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:44:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732246AbgKPQn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:43:59 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1121E222B9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605545038;
        bh=pqIrQ/SF+HVKglFaHrChSupMsQVf0dgMPQhvtB75MSQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HzdwI6wya0cMc2shLcxZP+wZtNJ90bLSCkW6l4Gr5/Ay8497iJX1nAjZwtvgPr+9n
         XTV64mOfNqPtjA8v6ta+V2Bhit9y4DVaGDdITs90srsz6JaEoq+G/+uNCORs5ee8je
         0cwfis/jW7ZF67sT1tDNWE7wUOPDQHnBWB60aNSY=
Received: by mail-ed1-f44.google.com with SMTP id ay21so19439720edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:43:57 -0800 (PST)
X-Gm-Message-State: AOAM5321u8A8UUFPhPbDOvhjwO14rN126JGmLVa7qIY8421VSc7QAfGE
        SNcsi9nkBisSbfyZPfBvwR81JnjRIBEo+xRDnQ==
X-Google-Smtp-Source: ABdhPJxdBHAa+XaIFVl0U/yTbqojIu846lIvctt5IPHV0DZDoxLgbEbGMB6qEzbQ1e5fnqHDspF9dVzKRfTaUFQw02M=
X-Received: by 2002:aa7:d408:: with SMTP id z8mr16437263edq.166.1605545036476;
 Mon, 16 Nov 2020 08:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20201115001403.7833-1-chunkuang.hu@kernel.org>
 <CAAOTY_-16s=NXg2kOJijhO+82nNsT9HkKj4PVh1qN8dKchBOBA@mail.gmail.com>
 <20201116002522.1a5c3736@a-VirtualBox> <CAAOTY_-_N9pcmao0FFtGs-qVLrvA-QBz5FJrSaYynuMZMe1Qhg@mail.gmail.com>
 <20201116165311.15a36e82@a-VirtualBox>
In-Reply-To: <20201116165311.15a36e82@a-VirtualBox>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 17 Nov 2020 00:43:44 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8LOLg8BeVY39EciSPqtBzeafPpenm0721+2rfhkKH0Cw@mail.gmail.com>
Message-ID: <CAAOTY_8LOLg8BeVY39EciSPqtBzeafPpenm0721+2rfhkKH0Cw@mail.gmail.com>
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
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:53=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi CK,
>
> On Mon, 16 Nov 2020 07:12:55 +0800
> Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:
>
> > Hi, Bilal:
> >
> > Bilal Wasim <bilalwasim676@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=
=8816=E6=97=A5 =E9=80=B1=E4=B8=80
> > =E4=B8=8A=E5=8D=883:25=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > Hi CK,
> > >
> > > On Sun, 15 Nov 2020 08:53:24 +0800
> > > Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:
> > >
> > > > Hi, Bilal:
> > > >
> > > > Please help to test this patch on your Chromebook elm, thanks.
> > > >
> > > > Regards,
> > > > Chun-Kuang Hu
> > >
> > > Just tried this patch on the Chromebook Elm, and it doesn't work.
> > > The HDMI screen remains black, though the rest of the system keeps
> > > on operating normally.
> >
> > Could you print this information, so I could find out the solution for
> > both small hbp and elm.
> >
> > vm->hfront_porch, vm->hback_porch, dsi_tmp_buf_bpp,
> > data_phy_cycles_byte, and the final horizontal_frontporch_byte,
> > horizontal_backporch_byte.
>
> Here are the values I got,
>
> [    2.506400] [drm] vm->hfront_porch: 48
> [    2.506402] [drm] vm->hback_porch: 200
> [    2.506404] [drm] dsi_tmp_buf_bpp: 3
> [    2.506406] [drm] data_phy_cycles_byte: 180
> [    2.506408] [drm] horizontal_frontporch_byte: 110
> [    2.506409] [drm] horizontal_backporch_byte: 455
>
> Please let me know if I can help debug this in any other way.
>

How about this patch [1] ?

[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/2536217/2

> Thanks,
> Bilal
>
> >
> > Regards,
> > Chun-Kuang.
> >
> > >
> > > >
> > > > Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B411=
=E6=9C=8815=E6=97=A5 =E9=80=B1=E6=97=A5
> > > > =E4=B8=8A=E5=8D=888:14=E5=AF=AB=E9=81=93=EF=BC=9A
> > > > >
> > > > > From: CK Hu <ck.hu@mediatek.com>
> > > > >
> > > > > Using vm->hfront_porch + vm->hback_porch to calculate
> > > > > horizontal_backporch_byte would make it negtive, so
> > > > > use horizontal_backporch_byte itself to make it positive.
> > > > >
> > > > > Fixes: 35bf948f1edb ("drm/mediatek: dsi: Fix scrolling of panel
> > > > > with small hfp or hbp")
> > > > >
> > > > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > > > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > > > ---
> > > > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 53
> > > > > ++++++++++-------------------- 1 file changed, 18
> > > > > insertions(+), 35 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > > b/drivers/gpu/drm/mediatek/mtk_dsi.c index
> > > > > 4a188a942c38..2a64fdaed9a7 100644 ---
> > > > > a/drivers/gpu/drm/mediatek/mtk_dsi.c +++
> > > > > b/drivers/gpu/drm/mediatek/mtk_dsi.c @@ -444,7 +444,10 @@ static
> > > > > void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi) u32
> > > > > horizontal_sync_active_byte; u32 horizontal_backporch_byte;
> > > > >         u32 horizontal_frontporch_byte;
> > > > > +       u32 horizontal_front_back_byte;
> > > > > +       u32 data_phy_cycles_byte;
> > > > >         u32 dsi_tmp_buf_bpp, data_phy_cycles;
> > > > > +       u32 delta;
> > > > >         struct mtk_phy_timing *timing =3D &dsi->phy_timing;
> > > > >
> > > > >         struct videomode *vm =3D &dsi->vm;
> > > > > @@ -474,42 +477,22 @@ static void
> > > > > mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi) data_phy_cycles
> > > > > =3D timing->lpx + timing->da_hs_prepare
> > > > > + timing->da_hs_zero + timing->da_hs_exit;
> > > > >
> > > > > -       if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> > > > > -               if ((vm->hfront_porch + vm->hback_porch) *
> > > > > dsi_tmp_buf_bpp >
> > > > > -                   data_phy_cycles * dsi->lanes + 18) {
> > > > > -                       horizontal_frontporch_byte =3D
> > > > > -                               vm->hfront_porch *
> > > > > dsi_tmp_buf_bpp -
> > > > > -                               (data_phy_cycles * dsi->lanes +
> > > > > 18) *
> > > > > -                               vm->hfront_porch /
> > > > > -                               (vm->hfront_porch +
> > > > > vm->hback_porch); -
> > > > > -                       horizontal_backporch_byte =3D
> > > > > -                               horizontal_backporch_byte -
> > > > > -                               (data_phy_cycles * dsi->lanes +
> > > > > 18) *
> > > > > -                               vm->hback_porch /
> > > > > -                               (vm->hfront_porch +
> > > > > vm->hback_porch);
> > > > > -               } else {
> > > > > -                       DRM_WARN("HFP less than d-phy, FPS will
> > > > > under 60Hz\n");
> > > > > -                       horizontal_frontporch_byte =3D
> > > > > vm->hfront_porch *
> > > > > -
> > > > > dsi_tmp_buf_bpp;
> > > > > -               }
> > > > > +       delta =3D dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ?
> > > > > 18 : 12; +
> > > > > +       horizontal_frontporch_byte =3D vm->hfront_porch *
> > > > > dsi_tmp_buf_bpp;
> > > > > +       horizontal_front_back_byte =3D horizontal_frontporch_byte
> > > > > + horizontal_backporch_byte;
> > > > > +       data_phy_cycles_byte =3D data_phy_cycles * dsi->lanes +
> > > > > delta; +
> > > > > +       if (horizontal_front_back_byte > data_phy_cycles_byte) {
> > > > > +               horizontal_frontporch_byte -=3D
> > > > > data_phy_cycles_byte * +
> > > > > horizontal_frontporch_byte /
> > > > > +
> > > > > horizontal_front_back_byte; +
> > > > > +               horizontal_backporch_byte -=3D
> > > > > data_phy_cycles_byte * +
> > > > > horizontal_backporch_byte /
> > > > > +
> > > > > horizontal_front_back_byte; } else {
> > > > > -               if ((vm->hfront_porch + vm->hback_porch) *
> > > > > dsi_tmp_buf_bpp >
> > > > > -                   data_phy_cycles * dsi->lanes + 12) {
> > > > > -                       horizontal_frontporch_byte =3D
> > > > > -                               vm->hfront_porch *
> > > > > dsi_tmp_buf_bpp -
> > > > > -                               (data_phy_cycles * dsi->lanes +
> > > > > 12) *
> > > > > -                               vm->hfront_porch /
> > > > > -                               (vm->hfront_porch +
> > > > > vm->hback_porch);
> > > > > -                       horizontal_backporch_byte =3D
> > > > > horizontal_backporch_byte -
> > > > > -                               (data_phy_cycles * dsi->lanes +
> > > > > 12) *
> > > > > -                               vm->hback_porch /
> > > > > -                               (vm->hfront_porch +
> > > > > vm->hback_porch);
> > > > > -               } else {
> > > > > -                       DRM_WARN("HFP less than d-phy, FPS will
> > > > > under 60Hz\n");
> > > > > -                       horizontal_frontporch_byte =3D
> > > > > vm->hfront_porch *
> > > > > -
> > > > > dsi_tmp_buf_bpp;
> > > > > -               }
> > > > > +               DRM_WARN("HFP + HBP less than d-phy, FPS will
> > > > > under 60Hz\n"); }
> > > > >
> > > > >         writel(horizontal_sync_active_byte, dsi->regs +
> > > > > DSI_HSA_WC); --
> > > > > 2.17.1
> > > > >
> > >
> > > Thanks,
> > > Bilal
>
