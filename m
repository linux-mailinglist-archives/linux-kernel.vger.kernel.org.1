Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495A32AC960
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgKIXcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:32:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgKIXcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:32:09 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1F2420867
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 23:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604964728;
        bh=qEITAPMHJ7RcpcZ6fFQRVmfMg/2dltGWGmZBxVMFc4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mdr2RIaVsFL5h20iTYlVWUcsRG2pEZ7we8XV+SZcKUJBfEXE/Blkf5uWZeB0Dq7fz
         1ssHFSzReWAaVh2tZTb5Cmk03lRCF+P+/tbGsgJCyE1foECPljXAuBYZhOeC0Ra6PL
         pb5U976e3nFnR1mysNV1QwYZoXoAS20zv+M84Bo8=
Received: by mail-ej1-f43.google.com with SMTP id o9so14838091ejg.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 15:32:07 -0800 (PST)
X-Gm-Message-State: AOAM531rJCFcZLqOD+ScR6vwE5Z6Q6E1IHiNS6vDRpe9x4sHu0MSu0Nj
        wQAo2JeGoJwTu/Qe4fua8MC1lypGFCszBRmwtA==
X-Google-Smtp-Source: ABdhPJziewFX90NL28wieZNoMnJARdYMTBTgOKpCDGql+LFfX3AEL+OAko+xKqH/oxUVC1M88npS/jxmi6rc6MXUhDE=
X-Received: by 2002:a17:906:5a96:: with SMTP id l22mr17259608ejq.303.1604964726295;
 Mon, 09 Nov 2020 15:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20201029152702.533-1-chunkuang.hu@kernel.org>
In-Reply-To: <20201029152702.533-1-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 10 Nov 2020 07:31:55 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-8hs2oMNZStNyyD0VmCfOnHTdeZ75L8+BTx6gMwQZOWQ@mail.gmail.com>
Message-ID: <CAAOTY_-8hs2oMNZStNyyD0VmCfOnHTdeZ75L8+BTx6gMwQZOWQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Move Mediatek MIPI DSI PHY driver from DRM folder to
 PHY folder
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
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

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=882=
9=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:27=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> mtk_mipi_dsi_phy is currently placed inside mediatek drm driver, but it's
> more suitable to place a phy driver into phy driver folder, so move
> mtk_mipi_dsi_phy driver into phy driver folder.

Applied the whole series into mediatek-drm-next [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Chun-Kuang Hu (3):
>   drm/mediatek: Separate mtk_mipi_tx to an independent module
>   phy: mediatek: Move mtk_mipi_dsi_phy driver into drivers/phy/mediatek
>     folder
>   MAINTAINERS: add files for Mediatek DRM drivers
>
>  MAINTAINERS                                                | 1 +
>  drivers/gpu/drm/mediatek/Kconfig                           | 1 +
>  drivers/gpu/drm/mediatek/Makefile                          | 3 ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c                     | 1 -
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h                     | 1 -
>  drivers/phy/mediatek/Kconfig                               | 7 +++++++
>  drivers/phy/mediatek/Makefile                              | 5 +++++
>  .../mediatek/phy-mtk-mipi-dsi-mt8173.c}                    | 2 +-
>  .../mediatek/phy-mtk-mipi-dsi-mt8183.c}                    | 2 +-
>  .../mtk_mipi_tx.c =3D> phy/mediatek/phy-mtk-mipi-dsi.c}      | 5 ++++-
>  .../mtk_mipi_tx.h =3D> phy/mediatek/phy-mtk-mipi-dsi.h}      | 0
>  11 files changed, 20 insertions(+), 8 deletions(-)
>  rename drivers/{gpu/drm/mediatek/mtk_mt8173_mipi_tx.c =3D> phy/mediatek/=
phy-mtk-mipi-dsi-mt8173.c} (99%)
>  rename drivers/{gpu/drm/mediatek/mtk_mt8183_mipi_tx.c =3D> phy/mediatek/=
phy-mtk-mipi-dsi-mt8183.c} (99%)
>  rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.c =3D> phy/mediatek/phy-mtk=
-mipi-dsi.c} (97%)
>  rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.h =3D> phy/mediatek/phy-mtk=
-mipi-dsi.h} (100%)
>
> --
> 2.17.1
>
