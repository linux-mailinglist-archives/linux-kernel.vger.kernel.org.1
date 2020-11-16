Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19852B4AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbgKPQSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731618AbgKPQSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:18:35 -0500
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E26223C7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605543514;
        bh=FsCTuWY5dgbEYPYoLX82oXYdTcQy1FIVElAFfZct3k8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oe7/tt18Twv01APSGnqs8SWS1fDCBKIyWzn/U+44CK8947Civ2f4SrphT6VetEj5t
         kWjqEP48VMSNpsDrmPODrOa9csiO8j5dFT8YHh/rSsWAQZG/2hHORMS7O7uYD7I5X3
         gKq7a/V3Gs/4tndGlHB2qoY3O+C7aBH6vPHH2h1c=
Received: by mail-ed1-f49.google.com with SMTP id k4so2601267edl.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:18:34 -0800 (PST)
X-Gm-Message-State: AOAM530C6/24FPzHeRAGqvzLwpM7Hm9E6EJvVf9c3scwYmF23oY3MiaW
        uDaq1JaaS7Zsgl+gdoB5VWHZqfryufn69RzqQw==
X-Google-Smtp-Source: ABdhPJy5UEMa514VORYkzr40o5c6+5CuGbj0ZX3gVbzHQCZd656Uw9TY6XR+KuAhCyCycCnwR0Dvv0cwt3EvXFa5jUM=
X-Received: by 2002:aa7:dbca:: with SMTP id v10mr16591877edt.219.1605543513111;
 Mon, 16 Nov 2020 08:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20201103003422.17838-1-chunkuang.hu@kernel.org> <CAAOTY_9px2KEoEF4YrYapP0kDPct+9SwpUEF591zRRU10+BSHg@mail.gmail.com>
In-Reply-To: <CAAOTY_9px2KEoEF4YrYapP0kDPct+9SwpUEF591zRRU10+BSHg@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 17 Nov 2020 00:18:21 +0800
X-Gmail-Original-Message-ID: <CAAOTY__XjQZYnaO4_xioZnQZmUWrt5SDxJPkiLdXW1Q6DjBJnw@mail.gmail.com>
Message-ID: <CAAOTY__XjQZYnaO4_xioZnQZmUWrt5SDxJPkiLdXW1Q6DjBJnw@mail.gmail.com>
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

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=881=
6=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=887:33=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=
=883=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=888:34=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > mtk ccorr is controlled by DRM and MDP [1]. In order to share
> > mtk_ccorr driver for DRM and MDP, decouple Mediatek DRM sub driver
> > which include mtk_ccorr, so MDP could use this decoupled mtk_ccorr.
>
> Applied the whole series into mediatek-drm-next [1].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.gi=
t/log/?h=3Dmediatek-drm-next
>

Sorry, because of iommu larb problem, I drop this series from mediatek-drm-=
next.

Regards,
Chun-Kuang.

> Regards,
> Chun-Kuang.
>
> >
> > [1] https://patchwork.kernel.org/patch/11140751/
> >
> > CK Hu (9):
> >   drm/mediatek: Move clk info from struct mtk_ddp_comp to sub driver
> >     private data
> >   drm/mediatek: Move regs info from struct mtk_ddp_comp to sub driver
> >     private data
> >   drm/mediatek: Remove irq in struct mtk_ddp_comp
> >   drm/mediatek: Use struct cmdq_client_reg to gather cmdq variable
> >   drm/mediatek: Move cmdq_reg info from struct mtk_ddp_comp to sub
> >     driver private data
> >   drm/mediatek: Change sub driver interface from mtk_ddp_comp to device
> >   drm/mediatek: Register vblank callback function
> >   drm/mediatek: DRM driver directly refer to sub driver's function
> >   drm/mediatek: Move mtk_ddp_comp_init() from sub driver to DRM driver
> >
> > Chun-Kuang Hu (2):
> >   drm/mediatek: Get CMDQ client register for all ddp component
> >   drm/mediatek: Use correct device pointer to get CMDQ client register
> >
> >  drivers/gpu/drm/mediatek/mtk_disp_color.c   |  86 ++---
> >  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  69 ++++
> >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     | 215 ++++++-----
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 169 +++++----
> >  drivers/gpu/drm/mediatek/mtk_dpi.c          |  44 +--
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |  75 ++--
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |   1 -
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 389 ++++++++++++--------
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 100 ++---
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  30 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   2 +-
> >  drivers/gpu/drm/mediatek/mtk_dsi.c          |  47 +--
> >  12 files changed, 658 insertions(+), 569 deletions(-)
> >  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_drv.h
> >
> > --
> > 2.17.1
> >
