Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FA02699CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgINXjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgINXjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:39:04 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ACFC21D43
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600126743;
        bh=SqboHRni2bD1vhdXq+F163RDYtXSS69vUAB3qmgkNBY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yZrILwRiKWB3Exo04Zl6br1gc+l/7hc0rbEEUZD7eGpkF/vnTrrTegyPWxzZlH87e
         tb/Nrq3h6DTC2VNTI/4r9e/2B8tbTGokLt/nAf07oTEem9NBKbIYnPTedsGXImc/ry
         4FBNmwk9IUb+vT8xq31IVkhGuXPDsglLsK9TiP8k=
Received: by mail-ed1-f46.google.com with SMTP id a12so1192956eds.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:39:03 -0700 (PDT)
X-Gm-Message-State: AOAM531tNFBa3B/DYWKqq6B0IFPrQU9ZgxyaQ279nGxRTTux76lb1Szl
        Lc1s/JtOvXCuIV21QGUBewo+TJmBIbwr6mQ1ig==
X-Google-Smtp-Source: ABdhPJw6RlAfURdpFIW30aW+5Mnee4BOMoBlhb5m43SWlzBpt3unMBFHnJE1V6y4/LgtpshCnDhXAjKJywhgMoXw5nw=
X-Received: by 2002:aa7:dcd2:: with SMTP id w18mr20041867edu.288.1600126742006;
 Mon, 14 Sep 2020 16:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200909084942.2122349-1-yukuai3@huawei.com>
In-Reply-To: <20200909084942.2122349-1-yukuai3@huawei.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 15 Sep 2020 07:38:51 +0800
X-Gmail-Original-Message-ID: <CAAOTY__OPKHd+=WD_nfPJVbXh8As8CDi=tGzbMAtxBQXbzjQYg@mail.gmail.com>
Message-ID: <CAAOTY__OPKHd+=WD_nfPJVbXh8As8CDi=tGzbMAtxBQXbzjQYg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: add exception handing in mtk_drm_probe() if
 component init fail
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>, yt.shen@mediatek.com,
        djkurtz@chromium.org, littlecvr@chromium.org,
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

Yu Kuai <yukuai3@huawei.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=889=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> mtk_ddp_comp_init() is called in a loop in mtk_drm_probe(), if it
> fail, previous successive init component is not proccessed.
>
> Thus uninitialize valid component and put their device if component
> init failed.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT817=
3.")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 040a8f393fe2..75a6cf231fd7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -544,8 +544,13 @@ static int mtk_drm_probe(struct platform_device *pde=
v)
>         pm_runtime_disable(dev);
>  err_node:
>         of_node_put(private->mutex_node);
> -       for (i =3D 0; i < DDP_COMPONENT_ID_MAX; i++)
> +       for (i =3D 0; i < DDP_COMPONENT_ID_MAX; i++) {
>                 of_node_put(private->comp_node[i]);
> +               if (private->ddp_comp[i]) {
> +                       put_device(private->ddp_comp[i]->larb_dev);
> +                       private->ddp_comp[i] =3D NULL;
> +               }
> +       }
>         return ret;
>  }
>
> --
> 2.25.4
>
