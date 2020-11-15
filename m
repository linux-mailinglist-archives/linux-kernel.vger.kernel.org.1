Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CBB2B3A97
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 00:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgKOXd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 18:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgKOXd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 18:33:26 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D73322453
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 23:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605483205;
        bh=AxjPWHiAXimR3BwkGu8Fq6s+JPSbGYc4j1v6w0slZqU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zNe+9BdsyFczGaIH+LDVLTlcFnYB7CoBtFB5N5EKdyKvAHRcGPsJtMLWZr5LoZHiO
         XyFg9n3dSQyNL2Ysote/LTsaY5HNlyE0fxKlA4g62mGy72Tm38E0/Pn569V51YVAk2
         74sqrbMgK1xvZsQHUmkwHR+D4jEMyKFi7ApbqoQE=
Received: by mail-ej1-f44.google.com with SMTP id f20so21930236ejz.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 15:33:25 -0800 (PST)
X-Gm-Message-State: AOAM530aenaKTVtoeThx4cr+0Dj1avDfAz7xDZiTh8FP0ekePXVtfCGP
        ZC/d7mEu1IoO4YVpvuytB1W6iBeJIe1hcyiNuw==
X-Google-Smtp-Source: ABdhPJwY5FAbz/l67tbdaapu7EKNmOwZT7Y3IG02ZWCruzVT3fqs01hVvXxojcLVUvNaQzjwOlzj809nVqGcTt86abM=
X-Received: by 2002:a17:906:5a96:: with SMTP id l22mr12127130ejq.303.1605483204156;
 Sun, 15 Nov 2020 15:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20201103003422.17838-1-chunkuang.hu@kernel.org>
In-Reply-To: <20201103003422.17838-1-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 16 Nov 2020 07:33:13 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9px2KEoEF4YrYapP0kDPct+9SwpUEF591zRRU10+BSHg@mail.gmail.com>
Message-ID: <CAAOTY_9px2KEoEF4YrYapP0kDPct+9SwpUEF591zRRU10+BSHg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Decouple Mediatek DRM sub driver
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=883=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=888:34=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> mtk ccorr is controlled by DRM and MDP [1]. In order to share
> mtk_ccorr driver for DRM and MDP, decouple Mediatek DRM sub driver
> which include mtk_ccorr, so MDP could use this decoupled mtk_ccorr.

Applied the whole series into mediatek-drm-next [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> [1] https://patchwork.kernel.org/patch/11140751/
>
> CK Hu (9):
>   drm/mediatek: Move clk info from struct mtk_ddp_comp to sub driver
>     private data
>   drm/mediatek: Move regs info from struct mtk_ddp_comp to sub driver
>     private data
>   drm/mediatek: Remove irq in struct mtk_ddp_comp
>   drm/mediatek: Use struct cmdq_client_reg to gather cmdq variable
>   drm/mediatek: Move cmdq_reg info from struct mtk_ddp_comp to sub
>     driver private data
>   drm/mediatek: Change sub driver interface from mtk_ddp_comp to device
>   drm/mediatek: Register vblank callback function
>   drm/mediatek: DRM driver directly refer to sub driver's function
>   drm/mediatek: Move mtk_ddp_comp_init() from sub driver to DRM driver
>
> Chun-Kuang Hu (2):
>   drm/mediatek: Get CMDQ client register for all ddp component
>   drm/mediatek: Use correct device pointer to get CMDQ client register
>
>  drivers/gpu/drm/mediatek/mtk_disp_color.c   |  86 ++---
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  69 ++++
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     | 215 ++++++-----
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 169 +++++----
>  drivers/gpu/drm/mediatek/mtk_dpi.c          |  44 +--
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |  75 ++--
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |   1 -
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 389 ++++++++++++--------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 100 ++---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  30 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   2 +-
>  drivers/gpu/drm/mediatek/mtk_dsi.c          |  47 +--
>  12 files changed, 658 insertions(+), 569 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_drv.h
>
> --
> 2.17.1
>
