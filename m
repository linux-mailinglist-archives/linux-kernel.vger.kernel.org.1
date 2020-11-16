Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C122B4A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbgKPQRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:17:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731378AbgKPQRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:17:14 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF3262227F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 16:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605543434;
        bh=q1HNWQlgqyDV4J+94bAX1fiF1L9E46ZR4cKIv+z263Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dj5aAyQ1f5t4ajIRx09p+pzqAm9V9n/zJv9vYOtdh3E4cupE5WneWybBM8nlkxjrc
         c08AIbC+ARdj5MO4GlOZ+dL7VvRZbBHsVZEU8oGdhSqVvdDXripbzytHPt9RM9OZXI
         BaaD21da+IYcNePJxoOZRNpEG3pf/cX8onFrGfo8=
Received: by mail-ed1-f52.google.com with SMTP id a15so19326875edy.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:17:13 -0800 (PST)
X-Gm-Message-State: AOAM532WrtxSSmMXnMhmhU0Ermpa3jVW8xxoDB/+NhwWZoWfDGwRiJ0q
        eieUestc4Vf8S2L/W2IMweTCMVWVW8T9M+3BdQ==
X-Google-Smtp-Source: ABdhPJyPsbGQNAIpJqwexuf+/mGJEj4xArjOBxDL5Q/Sy+XEJHFSX6d1dq3TrtTA8UHG1sae7pvgH7U8o4j6Ylx5HZ4=
X-Received: by 2002:aa7:d408:: with SMTP id z8mr16316296edq.166.1605543432331;
 Mon, 16 Nov 2020 08:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20201029152702.533-1-chunkuang.hu@kernel.org> <20201029152702.533-3-chunkuang.hu@kernel.org>
 <1604039049.31607.13.camel@mhfsdcap03> <CAAOTY_8Nf=Lh_JDojKY3oHdTigO=i+BHuvVA+9hYXCzgu-2Cfg@mail.gmail.com>
 <20201116072554.GH7499@vkoul-mobl>
In-Reply-To: <20201116072554.GH7499@vkoul-mobl>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 17 Nov 2020 00:17:00 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8SyT87bSAmdrhwnEzRO_Yt0BQtDWnPrPahg4qTrUq1zQ@mail.gmail.com>
Message-ID: <CAAOTY_8SyT87bSAmdrhwnEzRO_Yt0BQtDWnPrPahg4qTrUq1zQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] phy: mediatek: Move mtk_mipi_dsi_phy driver into
 drivers/phy/mediatek folder
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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

Vinod Koul <vkoul@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=8816=E6=97=A5=
 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:25=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 02-11-20, 07:08, Chun-Kuang Hu wrote:
> > + Vinod:
> >
> > Hi, Chunfeng:
> >
> > Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2020=E5=B9=B410=E6=
=9C=8830=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:24=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > On Thu, 2020-10-29 at 23:27 +0800, Chun-Kuang Hu wrote:
> > > > mtk_mipi_dsi_phy is currently placed inside mediatek drm driver, bu=
t it's
> > > > more suitable to place a phy driver into phy driver folder, so move
> > > > mtk_mipi_dsi_phy driver into phy driver folder.
> > > >
> > > > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > > ---
> > > >  drivers/gpu/drm/mediatek/Kconfig                           | 7 ---=
----
> > > >  drivers/gpu/drm/mediatek/Makefile                          | 6 ---=
---
> > > >  drivers/phy/mediatek/Kconfig                               | 7 +++=
++++
> > > >  drivers/phy/mediatek/Makefile                              | 5 +++=
++
> > > >  .../mediatek/phy-mtk-mipi-dsi-mt8173.c}                    | 2 +-
> > > >  .../mediatek/phy-mtk-mipi-dsi-mt8183.c}                    | 2 +-
> > > >  .../mtk_mipi_tx.c =3D> phy/mediatek/phy-mtk-mipi-dsi.c}      | 2 +=
-
> > > >  .../mtk_mipi_tx.h =3D> phy/mediatek/phy-mtk-mipi-dsi.h}      | 0
> > > >  8 files changed, 15 insertions(+), 16 deletions(-)
> > > >  rename drivers/{gpu/drm/mediatek/mtk_mt8173_mipi_tx.c =3D> phy/med=
iatek/phy-mtk-mipi-dsi-mt8173.c} (99%)
> > > >  rename drivers/{gpu/drm/mediatek/mtk_mt8183_mipi_tx.c =3D> phy/med=
iatek/phy-mtk-mipi-dsi-mt8183.c} (99%)
> > > >  rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.c =3D> phy/mediatek/p=
hy-mtk-mipi-dsi.c} (99%)
> > > >  rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.h =3D> phy/mediatek/p=
hy-mtk-mipi-dsi.h} (100%)
> > >
> > > Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> >
> > I would like to apply the whole series into my tree, would you please
> > give an acked-by tag on this patch, so I could apply this patch into
> > my tree.
>
> I would prefer this to go thru phy tree, unless there are dependencies,
> which I am not clear looking at above
>

Please apply this series to phy tree, and I would drop this series
from my tree, thanks.

Regards,
Chun-Kuang.

> --
> ~Vinod
