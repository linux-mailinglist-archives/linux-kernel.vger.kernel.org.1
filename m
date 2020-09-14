Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6722699D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgINXkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgINXkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:40:41 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBF6E21D7A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600126840;
        bh=7YxhV2xZvx6nrVGCgI8yLCt9xE01+z6rpckv6HeDiOE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F5kaa6bDRZsnqgJGDMMmyNFrKwzGHueqBd6WRKMgYu9urtYGZwverk0IH0Rhg7VEB
         rH8RmZ+WayMCTXd+FI77zXckVabDIWc6xRMn4rIKVV+WOc6d1tKVajNp1PuCl+KMAU
         CQf0DVw7gP2BTeslaKe2/Fqfk4CW/GcaYQqM9fdY=
Received: by mail-ed1-f48.google.com with SMTP id k14so1287060edo.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:40:39 -0700 (PDT)
X-Gm-Message-State: AOAM530hOdPEdnnkG5AQS/qKUelrSmFRu7Hjss1bKYQUr9sWHPM2QH6g
        0LfFg01XXa2xBhensBum0OM+Lo6C4BpGgHEUHA==
X-Google-Smtp-Source: ABdhPJy5v5jvk9nSph1QBw9pjsPnW7VLL4rfeN5p0mGA8rEDQJvTN+DhAO3VLkzSupQ7VClzUOPWvQWNgPXdD9WbwZ0=
X-Received: by 2002:a50:cbc7:: with SMTP id l7mr19619839edi.148.1600126838289;
 Mon, 14 Sep 2020 16:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200911112119.3218073-1-yukuai3@huawei.com>
In-Reply-To: <20200911112119.3218073-1-yukuai3@huawei.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 15 Sep 2020 07:40:28 +0800
X-Gmail-Original-Message-ID: <CAAOTY__776k8oZRH-DEEO1JZx6Sf0vDMjPVDDXkFH=51nQvJBg@mail.gmail.com>
Message-ID: <CAAOTY__776k8oZRH-DEEO1JZx6Sf0vDMjPVDDXkFH=51nQvJBg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: add missing put_device() call in mtk_drm_kms_init()
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        djkurtz@chromium.org, yt.shen@mediatek.com,
        CK Hu <ck.hu@mediatek.com>, littlecvr@chromium.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yu Kuai:

Yu Kuai <yukuai3@huawei.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8811=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:22=E5=AF=AB=E9=81=93=EF=BC=9A
>
> if of_find_device_by_node() succeed, mtk_drm_kms_init() doesn't have
> a corresponding put_device(). Thus add jump target to fix the exception
> handling for this function implementation.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT817=
3.")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 040a8f393fe2..7aceace94ebf 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -165,7 +165,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>
>         ret =3D drmm_mode_config_init(drm);
>         if (ret)
> -               return ret;
> +               goto put_mutex_dev;
>
>         drm->mode_config.min_width =3D 64;
>         drm->mode_config.min_height =3D 64;
> @@ -182,7 +182,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>
>         ret =3D component_bind_all(drm->dev, drm);
>         if (ret)
> -               return ret;
> +               goto put_mutex_dev;
>
>         /*
>          * We currently support two fixed data streams, each optional,
> @@ -229,7 +229,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>         }
>         if (!dma_dev->dma_parms) {
>                 ret =3D -ENOMEM;
> -               goto err_component_unbind;
> +               goto put_dma_dev;
>         }
>
>         ret =3D dma_set_max_seg_size(dma_dev, (unsigned int)DMA_BIT_MASK(=
32));
> @@ -256,9 +256,12 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  err_unset_dma_parms:
>         if (private->dma_parms_allocated)
>                 dma_dev->dma_parms =3D NULL;
> +put_dma_dev:
> +       put_device(private->dma_dev);
>  err_component_unbind:
>         component_unbind_all(drm->dev, drm);
> -
> +put_mutex_dev:
> +       put_device(private->mutex_dev);
>         return ret;
>  }
>
> --
> 2.25.4
>
