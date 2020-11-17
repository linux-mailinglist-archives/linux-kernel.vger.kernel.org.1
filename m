Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E52B668B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbgKQOEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:04:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729468AbgKQOEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:04:35 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E73221734
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605621874;
        bh=l8BPO8tEueP5+Y6qI4QrJs7Dyfaap1EycZY0EXu45O4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jibHgn+AlaByHleB2bokCMBk7yWP0k2MgJgwIKOfHoRPBMBV5y0aCblxVajk2jXLU
         IyHtDiK0c93rz36PQmzAEecRBaFJ051NpwJXhXmOyEe85TyQpzgP2e3ruOLiYfsGvR
         26Oy3Te4E+uGIN54sw9h44CyCO/n7F86mefjEmmk=
Received: by mail-wr1-f51.google.com with SMTP id k2so23341891wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:04:34 -0800 (PST)
X-Gm-Message-State: AOAM532M6zC6koYPgVSdEr4m5nygavTAxcHJXdmlSJNHxxqzXGnS1zuf
        quwwZvKsQzOsvUZzlx2wb3C5WovILREtRIQhVw==
X-Google-Smtp-Source: ABdhPJzgVTD4fRuIawDxKibD1KTl+2JFFlHBn4RCmHXuBwWH2WBI1tkFRxUYykzj4pZRB7qrw19ZlGAuMrIiZsa/ECw=
X-Received: by 2002:adf:dccd:: with SMTP id x13mr26751772wrm.394.1605621872677;
 Tue, 17 Nov 2020 06:04:32 -0800 (PST)
MIME-Version: 1.0
References: <20201116231407.94-1-chunkuang.hu@kernel.org> <20201116231407.94-3-chunkuang.hu@kernel.org>
 <1605584151.31607.35.camel@mhfsdcap03>
In-Reply-To: <1605584151.31607.35.camel@mhfsdcap03>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 17 Nov 2020 22:04:19 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9EstG-8RaB1mft_Re1_zOf3Y_TVRGESW-s9nCzYKv+vg@mail.gmail.com>
Message-ID: <CAAOTY_9EstG-8RaB1mft_Re1_zOf3Y_TVRGESW-s9nCzYKv+vg@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/3] phy: mediatek: Move mtk_mipi_dsi_phy driver
 into drivers/phy/mediatek folder
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vinod:

Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=88=
17=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8811:36=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi CK,
> On Tue, 2020-11-17 at 07:14 +0800, Chun-Kuang Hu wrote:
> > mtk_mipi_dsi_phy is currently placed inside mediatek drm driver, but it=
's
> > more suitable to place a phy driver into phy driver folder, so move
> > mtk_mipi_dsi_phy driver into phy driver folder.
> >
> > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> You forgot to add acked-by me

If you apply this patch, please add acked-by tag of chunfeng [1], thanks.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/2020102915270=
2.533-3-chunkuang.hu@kernel.org/

Regards,
Chun-Kuang.

>
> > ---
> >  drivers/gpu/drm/mediatek/Kconfig                           | 7 -------
> >  drivers/gpu/drm/mediatek/Makefile                          | 6 ------
> >  drivers/phy/mediatek/Kconfig                               | 7 +++++++
> >  drivers/phy/mediatek/Makefile                              | 5 +++++
> >  .../mediatek/phy-mtk-mipi-dsi-mt8173.c}                    | 2 +-
> >  .../mediatek/phy-mtk-mipi-dsi-mt8183.c}                    | 2 +-
> >  .../mtk_mipi_tx.c =3D> phy/mediatek/phy-mtk-mipi-dsi.c}      | 2 +-
> >  .../mtk_mipi_tx.h =3D> phy/mediatek/phy-mtk-mipi-dsi.h}      | 0
> >  8 files changed, 15 insertions(+), 16 deletions(-)
> >  rename drivers/{gpu/drm/mediatek/mtk_mt8173_mipi_tx.c =3D> phy/mediate=
k/phy-mtk-mipi-dsi-mt8173.c} (99%)
> >  rename drivers/{gpu/drm/mediatek/mtk_mt8183_mipi_tx.c =3D> phy/mediate=
k/phy-mtk-mipi-dsi-mt8183.c} (99%)
> >  rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.c =3D> phy/mediatek/phy-m=
tk-mipi-dsi.c} (99%)
> >  rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.h =3D> phy/mediatek/phy-m=
tk-mipi-dsi.h} (100%)
> >
> > diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediate=
k/Kconfig
> > index 24c4890a6e65..2976d21e9a34 100644
> > --- a/drivers/gpu/drm/mediatek/Kconfig
> > +++ b/drivers/gpu/drm/mediatek/Kconfig
> > @@ -28,10 +28,3 @@ config DRM_MEDIATEK_HDMI
> >       select PHY_MTK_HDMI
> >       help
> >         DRM/KMS HDMI driver for Mediatek SoCs
> > -
> > -config PHY_MTK_MIPI_DSI
> > -     tristate "Mediatek MIPI-DSI-PHY Driver"
> > -     depends on ARCH_MEDIATEK && OF
> > -     select GENERIC_PHY
> > -     help
> > -       Support MIPI DSI PHY for Mediatek SoCs.
> > diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediat=
ek/Makefile
> > index baa188000543..a892edec5563 100644
> > --- a/drivers/gpu/drm/mediatek/Makefile
> > +++ b/drivers/gpu/drm/mediatek/Makefile
> > @@ -19,9 +19,3 @@ mediatek-drm-hdmi-objs :=3D mtk_cec.o \
> >                         mtk_hdmi_ddc.o
> >
> >  obj-$(CONFIG_DRM_MEDIATEK_HDMI) +=3D mediatek-drm-hdmi.o
> > -
> > -phy-mtk-mipi-dsi-drv-objs :=3D mtk_mipi_tx.o \
> > -                          mtk_mt8173_mipi_tx.o \
> > -                          mtk_mt8183_mipi_tx.o
> > -
> > -obj-$(CONFIG_PHY_MTK_MIPI_DSI) +=3D phy-mtk-mipi-dsi-drv.o
> > diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfi=
g
> > index 50c5e9306e19..574b8e6398d2 100644
> > --- a/drivers/phy/mediatek/Kconfig
> > +++ b/drivers/phy/mediatek/Kconfig
> > @@ -42,3 +42,10 @@ config PHY_MTK_HDMI
> >       select GENERIC_PHY
> >       help
> >         Support HDMI PHY for Mediatek SoCs.
> > +
> > +config PHY_MTK_MIPI_DSI
> > +     tristate "MediaTek MIPI-DSI Driver"
> > +     depends on ARCH_MEDIATEK && OF
> > +     select GENERIC_PHY
> > +     help
> > +       Support MIPI DSI for Mediatek SoCs.
> > diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makef=
ile
> > index 6325e38709ed..ace660fbed3a 100644
> > --- a/drivers/phy/mediatek/Makefile
> > +++ b/drivers/phy/mediatek/Makefile
> > @@ -11,3 +11,8 @@ phy-mtk-hdmi-drv-y                  :=3D phy-mtk-hdmi=
.o
> >  phy-mtk-hdmi-drv-y                   +=3D phy-mtk-hdmi-mt2701.o
> >  phy-mtk-hdmi-drv-y                   +=3D phy-mtk-hdmi-mt8173.o
> >  obj-$(CONFIG_PHY_MTK_HDMI)           +=3D phy-mtk-hdmi-drv.o
> > +
> > +phy-mtk-mipi-dsi-drv-y                       :=3D phy-mtk-mipi-dsi.o
> > +phy-mtk-mipi-dsi-drv-y                       +=3D phy-mtk-mipi-dsi-mt8=
173.o
> > +phy-mtk-mipi-dsi-drv-y                       +=3D phy-mtk-mipi-dsi-mt8=
183.o
> > +obj-$(CONFIG_PHY_MTK_MIPI_DSI)               +=3D phy-mtk-mipi-dsi-drv=
.o
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c b/drivers/ph=
y/mediatek/phy-mtk-mipi-dsi-mt8173.c
> > similarity index 99%
> > rename from drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
> > rename to drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
> > index f18db14d8b63..7a847954594f 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
> > +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
> > @@ -4,7 +4,7 @@
> >   * Author: jitao.shi <jitao.shi@mediatek.com>
> >   */
> >
> > -#include "mtk_mipi_tx.h"
> > +#include "phy-mtk-mipi-dsi.h"
> >
> >  #define MIPITX_DSI_CON               0x00
> >  #define RG_DSI_LDOCORE_EN            BIT(0)
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c b/drivers/ph=
y/mediatek/phy-mtk-mipi-dsi-mt8183.c
> > similarity index 99%
> > rename from drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> > rename to drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
> > index 9f3e55aeebb2..99108426d57c 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> > +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
> > @@ -4,7 +4,7 @@
> >   * Author: jitao.shi <jitao.shi@mediatek.com>
> >   */
> >
> > -#include "mtk_mipi_tx.h"
> > +#include "phy-mtk-mipi-dsi.h"
> >
> >  #define MIPITX_LANE_CON              0x000c
> >  #define RG_DSI_CPHY_T1DRV_EN         BIT(0)
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/phy/media=
tek/phy-mtk-mipi-dsi.c
> > similarity index 99%
> > rename from drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> > rename to drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> > index f2a892e16c27..18c481251f04 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> > +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> > @@ -3,7 +3,7 @@
> >   * Copyright (c) 2015 MediaTek Inc.
> >   */
> >
> > -#include "mtk_mipi_tx.h"
> > +#include "phy-mtk-mipi-dsi.h"
> >
> >  inline struct mtk_mipi_tx *mtk_mipi_tx_from_clk_hw(struct clk_hw *hw)
> >  {
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h b/drivers/phy/media=
tek/phy-mtk-mipi-dsi.h
> > similarity index 100%
> > rename from drivers/gpu/drm/mediatek/mtk_mipi_tx.h
> > rename to drivers/phy/mediatek/phy-mtk-mipi-dsi.h
>
