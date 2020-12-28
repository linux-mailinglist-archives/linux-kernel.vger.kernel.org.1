Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05F82E6C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgL1Xcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 18:32:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbgL1Xcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 18:32:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 457C2224D2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 23:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609198333;
        bh=4zuOP87T+tBs/U4EXSadvydWrwt6Bdq/pnBuDyNsp3I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MHDXi03f6vV1G6r6J8eFCqOIkk4cqccxHFFVwin1a+8+kZzWn+BEsSAcrFk3u2n/d
         IV61cDtg8SfC13nFvgcrDj5TQvSvEgBeiooxTnLLWzv6J0IRxUrMOd3djHju93YkuF
         yGwuP3iSRjDdcgwB9OpA9MwRPi6zp4gssF+xUXElj13YzfV2fxqYYKaG5Ut3Pqw+PM
         iIw0zohsbxUniZC76Go+v0RypNxVa5uyZobQ9pvQuKNpqbzA3Tlw1or6YfrL1EdW2D
         H1OgXrkfbC3NLj4nOfZ8qSDCfBDqlzhwkzgI/tq6luEysWVdltiITD4FafGRmMLgud
         uMi1kAUMFexQw==
Received: by mail-ej1-f48.google.com with SMTP id g20so16170380ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 15:32:13 -0800 (PST)
X-Gm-Message-State: AOAM533+Q0MKad6l7elxxeQvUYJ267YP4ns5dOYcpflp8sNqC4rkM4CT
        sor0JsTuiwckuRLgemvgxdeRUDKQPWF5ayeZWw==
X-Google-Smtp-Source: ABdhPJyi7sWe+M1pwp7M/taBxI8fPAUdgCkIwfXdysJx91vWg0TwrvQd0TZnEL+XEJtjyTVXSlFp6eaIJBvkueKMUQw=
X-Received: by 2002:a17:906:fb1a:: with SMTP id lz26mr43221179ejb.194.1609198331821;
 Mon, 28 Dec 2020 15:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20201210161050.8460-1-chunkuang.hu@kernel.org>
In-Reply-To: <20201210161050.8460-1-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 29 Dec 2020 07:32:00 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8vxmAR-RBVhPZdpMRZzUZZ8KBAV2R1rR0FvxhMv22UvQ@mail.gmail.com>
Message-ID: <CAAOTY_8vxmAR-RBVhPZdpMRZzUZZ8KBAV2R1rR0FvxhMv22UvQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Decouple Mediatek DRM sub driver
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

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=881=
1=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:10=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> mtk ccorr is controlled by DRM and MDP [1]. In order to share
> mtk_ccorr driver for DRM and MDP, decouple Mediatek DRM sub driver
> which include mtk_ccorr, so MDP could use this decoupled mtk_ccorr.

For this series, applied to mediatek-drm-next [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Changes in v2:
> 1. Fix iommu larb problem.
> 2. Based on mediatek-drm-next-5.11-2 [2].
>
> [1] https://patchwork.kernel.org/patch/11140751/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.gi=
t/log/?h=3Dmediatek-drm-next-5.11-2
>
> CK Hu (10):
>   drm/mediatek: Separate getting larb device to a function
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
>  drivers/gpu/drm/mediatek/mtk_disp_color.c   |  89 ++--
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  69 ++++
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     | 217 +++++-----
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 169 ++++----
>  drivers/gpu/drm/mediatek/mtk_dpi.c          |  44 +-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |  75 ++--
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |   1 -
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 429 ++++++++++++--------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 100 +++--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  30 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   2 +-
>  drivers/gpu/drm/mediatek/mtk_dsi.c          |  47 +--
>  12 files changed, 676 insertions(+), 596 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_drv.h
>
> --
> 2.17.1
>
