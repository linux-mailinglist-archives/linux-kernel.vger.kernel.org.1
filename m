Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588182C0DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgKWOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:37:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgKWOhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:37:09 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7D9920773
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606142228;
        bh=OUEWYsBkqLktfnlUWZU93Abg+Nz/7mAOEsw44o/z+AY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LWeEmYqRvIgVibJPvSUA2bNMZQKSwK4bFEbNihh1IZICbn9g73foiQyD2lJ+Kj9cW
         aHXTvbMmNhyKgCdAiOyMUqq9ko2uFsk4zH5WkqDSAiwX//khUaYb3iSdJ3ZinOQsLL
         KFYTslYgHiC7hm8tX+CcEdkzT3d+WvIAEY97IJxc=
Received: by mail-ej1-f46.google.com with SMTP id gj5so23610982ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:37:07 -0800 (PST)
X-Gm-Message-State: AOAM532u+t93UB+UjO92raS7l7MRmTWzGTOQDWUDMaw7hWklMlmY2FEW
        bBslk4mad+6LnVL+PFBTdkByqYsIL+gY9QlhhA==
X-Google-Smtp-Source: ABdhPJwGasd9fgVLE5ED8mhWD3NZ+E+/6bwxsrrXYebqvxGYFpzg+IT9Mho0RkDbiY0q9WB2uZjp5mQd28XNDsFa8GI=
X-Received: by 2002:a17:906:d0cc:: with SMTP id bq12mr42714267ejb.127.1606142226345;
 Mon, 23 Nov 2020 06:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-19-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-19-lee.jones@linaro.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 23 Nov 2020 22:36:54 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9qciG6Cc4b8WqzCugdve99qjTO5ftsyK0PHJiOF+C19w@mail.gmail.com>
Message-ID: <CAAOTY_9qciG6Cc4b8WqzCugdve99qjTO5ftsyK0PHJiOF+C19w@mail.gmail.com>
Subject: Re: [PATCH 18/40] drm/mediatek/mtk_dpi: Remove unused struct
 definition 'mtk_dpi_encoder_funcs'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jie Qiu <jie.qiu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lee:

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/mediatek/mtk_dpi.c:530:39: warning: =E2=80=98mtk_dpi_enc=
oder_funcs=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>

Thanks for this patch, but I've applied another identical patch
"drm/mediatek: mtk_dpi: Fix unused variable 'mtk_dpi_encoder_funcs'"
[1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
commit/?h=3Dmediatek-drm-fixes&id=3D46b97aed5484a3f44584a10f9e0691bf89d2906=
4

Regards,
Chun-Kuang.

> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Jie Qiu <jie.qiu@mediatek.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index cf11c4850b405..52f11a63a3304 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -522,15 +522,6 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *=
dpi,
>         return 0;
>  }
>
> -static void mtk_dpi_encoder_destroy(struct drm_encoder *encoder)
> -{
> -       drm_encoder_cleanup(encoder);
> -}
> -
> -static const struct drm_encoder_funcs mtk_dpi_encoder_funcs =3D {
> -       .destroy =3D mtk_dpi_encoder_destroy,
> -};
> -
>  static int mtk_dpi_bridge_attach(struct drm_bridge *bridge,
>                                  enum drm_bridge_attach_flags flags)
>  {
> --
> 2.25.1
>
