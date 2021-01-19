Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2532FC4FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 00:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbhASXnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 18:43:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:32862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730678AbhASXnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 18:43:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 630D723109
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611099764;
        bh=vfWq8ORmisMymcb7jEgSy/+PLX1UbYJNGh+DIqiVZ3c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cYz2SiA7iMr/9YcqooJQXawqQMzYzYTU3o97XUGd//h1JT+reDI5GVwdi8mDqCnB9
         871S2NE8UrbERiInElunFQYPil6LVsNZEatFEYXrLZWRH6OtHMVUpq9r86iX3PIIoG
         Q0Fq7sExupofbMKTPeBCpLwHGhalDrNDVv2iiWMP/IcIgCqalcet3yh5YmX/X1b2Qy
         IeIKEADLH+L5ezQuqMyVlJ/BxVXNTVLTb7XmbVnSxX39Y1xYfN41ThRbZbYUbRnMb6
         9vdfg4G9kPSGeJbLpfycTgh8ox85Tc2msxKaVD4OLuNxQL+t8rsquKQc309aYB183N
         /6V8hKOsw50qQ==
Received: by mail-ej1-f47.google.com with SMTP id by1so24582263ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 15:42:44 -0800 (PST)
X-Gm-Message-State: AOAM532iIjBE+NXxd3AFjZmmYG8Z0QyDa6VZIljFfVx3Ibk28JdxjFXp
        Hyd1dm9Na2UskgetttstDAz7Y8jXmRhsoMnXew==
X-Google-Smtp-Source: ABdhPJy5pH3VJgW9xcAFQp76ROjf3pDBkBxpmVLZMF92SXietZmMe2rKOGmeI13Kif0jfu6KtXkSobYRfIp0pn/TCb8=
X-Received: by 2002:a17:907:d8b:: with SMTP id go11mr4451807ejc.303.1611099762927;
 Tue, 19 Jan 2021 15:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20210106231729.17173-1-chunkuang.hu@kernel.org>
In-Reply-To: <20210106231729.17173-1-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 20 Jan 2021 07:42:31 +0800
X-Gmail-Original-Message-ID: <CAAOTY__OmMnXL5gvso4meUfQS-xnKA6EErhM3bL3HE4zh6JMcQ@mail.gmail.com>
Message-ID: <CAAOTY__OmMnXL5gvso4meUfQS-xnKA6EErhM3bL3HE4zh6JMcQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Share mtk mutex driver for both DRM and MDP
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=887=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=887:17=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> mtk mutex is a driver used by DRM and MDP [1], so this series move
> mtk mutex driver from DRM folder to soc folder, so it could be used
> by DRM and MDP.

Applied [1/5] ~ [4/5] to mediatek-drm-next [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Changes in v2:
> 1. Rebase onto mediatek-drm-next [2].
> 2. Export symbol for mtk-mutex API.
>
> [1] https://patchwork.kernel.org/patch/11140751/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.gi=
t/log/?h=3Dmediatek-drm-next
>
> CK Hu (5):
>   drm/mediatek: Remove redundant file including
>   drm/mediatek: Rename file mtk_drm_ddp to mtk_mutex
>   drm/mediatek: Change disp/ddp term to mutex in mtk mutex driver
>   drm/mediatek: Automatically search unclaimed mtk mutex in
>     mtk_mutex_get()
>   soc / drm: mediatek: Move mtk mutex driver to soc folder
>
>  drivers/gpu/drm/mediatek/Makefile             |   1 -
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  32 +-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.h        |  28 --
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   3 -
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   1 -
>  drivers/soc/mediatek/Makefile                 |   1 +
>  .../mediatek/mtk-mutex.c}                     | 328 +++++++++---------
>  include/linux/soc/mediatek/mtk-mutex.h        |  26 ++
>  8 files changed, 212 insertions(+), 208 deletions(-)
>  delete mode 100644 drivers/gpu/drm/mediatek/mtk_drm_ddp.h
>  rename drivers/{gpu/drm/mediatek/mtk_drm_ddp.c =3D> soc/mediatek/mtk-mut=
ex.c} (53%)
>  create mode 100644 include/linux/soc/mediatek/mtk-mutex.h
>
> --
> 2.17.1
>
