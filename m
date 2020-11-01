Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48E52A224E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 00:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgKAXIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 18:08:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbgKAXIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 18:08:44 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E6BC22365
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 23:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604272123;
        bh=Daf3cedAfsWFZ8LaPoAP0BurQA0TaRmQuvz1zCMuTcM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SlAfecU94oWlViEtb8HXVqRLPwAaM7y0hULWhzBRZvJ6woHCrsnwrudqiEMagtxyl
         MgXJamUlYW1EhaG7GZDCLvQVkqfuXOkq7wB6qp6vaL1b0ws3YciVJb7FmqIv45s8Kh
         216iAfzBMushIicISpvJEAQ+OvgQ3vgsC6dU8kNI=
Received: by mail-ej1-f41.google.com with SMTP id p5so16451037ejj.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 15:08:43 -0800 (PST)
X-Gm-Message-State: AOAM530HlSL37Xx1dUp61g2L/TMzmIR9Hpb3i2nAVjKEm9F0XzeaVRwo
        9aLt/jwQ/weZvaKXwCdp9PcVAHAtyYdzbU0Cpw==
X-Google-Smtp-Source: ABdhPJwwVYRVtfleTE1rDFQyKE26UbeEsl9z6niI/v8LCfBDJtkI4L3ysCoHGFUcrnxlM1TnjgHman6q8lDmpg7qjts=
X-Received: by 2002:a17:906:5a96:: with SMTP id l22mr12666847ejq.303.1604272121876;
 Sun, 01 Nov 2020 15:08:41 -0800 (PST)
MIME-Version: 1.0
References: <20201029152702.533-1-chunkuang.hu@kernel.org> <20201029152702.533-3-chunkuang.hu@kernel.org>
 <1604039049.31607.13.camel@mhfsdcap03>
In-Reply-To: <1604039049.31607.13.camel@mhfsdcap03>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 2 Nov 2020 07:08:30 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8Nf=Lh_JDojKY3oHdTigO=i+BHuvVA+9hYXCzgu-2Cfg@mail.gmail.com>
Message-ID: <CAAOTY_8Nf=Lh_JDojKY3oHdTigO=i+BHuvVA+9hYXCzgu-2Cfg@mail.gmail.com>
Subject: Re: [PATCH 2/3] phy: mediatek: Move mtk_mipi_dsi_phy driver into
 drivers/phy/mediatek folder
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Vinod:

Hi, Chunfeng:

Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=88=
30=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:24=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Thu, 2020-10-29 at 23:27 +0800, Chun-Kuang Hu wrote:
> > mtk_mipi_dsi_phy is currently placed inside mediatek drm driver, but it=
's
> > more suitable to place a phy driver into phy driver folder, so move
> > mtk_mipi_dsi_phy driver into phy driver folder.
> >
> > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
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
>
> Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

I would like to apply the whole series into my tree, would you please
give an acked-by tag on this patch, so I could apply this patch into
my tree.

Regards,
Chun-Kuang.

>
> Please add phy maintaniner "Vinod Koul <vkoul@kernel.org>"
>
> Thanks
>
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
