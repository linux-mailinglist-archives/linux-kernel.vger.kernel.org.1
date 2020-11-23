Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299562C0DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbgKWOcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729794AbgKWOcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:32:11 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E43820782
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606141930;
        bh=ftNKqa+bYDhqF4CMFphNHzMCzHAOisKpwk67ZYS6ZgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z33v22hdW4YxiwW6UEgw0GvvELco7HO5D74BE8TiqvAF2YrPjUDKYmmLTSTjzEXzQ
         v6Qi2fTyU9w/KjIUEQPP7wzuYXaF7LpZ++7dBhNBNaz6XK+BswUidtVXm9Oslh+sSJ
         xFTJAgH+Rq7jFYAWobff4/qdOjMk7bGHLg9i3vfg=
Received: by mail-ed1-f54.google.com with SMTP id cf17so13739315edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:32:10 -0800 (PST)
X-Gm-Message-State: AOAM532/bKULqpFjIVmqnp4sZIZj0kd6lpXN3fLfCt3HyW59Ab0xJVZo
        mhJu4YWj75htYHXMDaJwZEypbjpIK3Srr15kKg==
X-Google-Smtp-Source: ABdhPJyS2K7No/Iy7mVbNPsYoEYSje2gRGMO/P9wTkTu5AgIlPqa/VzyGgZFr00oj+Lye5y2SIpkBeoCVwE63Mb7TOk=
X-Received: by 2002:a50:f742:: with SMTP id j2mr39321499edn.72.1606141928430;
 Mon, 23 Nov 2020 06:32:08 -0800 (PST)
MIME-Version: 1.0
References: <20201112190039.2785914-1-lee.jones@linaro.org> <20201112190039.2785914-29-lee.jones@linaro.org>
In-Reply-To: <20201112190039.2785914-29-lee.jones@linaro.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 23 Nov 2020 22:31:56 +0800
X-Gmail-Original-Message-ID: <CAAOTY__Q39YMUGLtrBi0p+kedU5xSHv0dUKz2NA3ajR17Fe-4A@mail.gmail.com>
Message-ID: <CAAOTY__Q39YMUGLtrBi0p+kedU5xSHv0dUKz2NA3ajR17Fe-4A@mail.gmail.com>
Subject: Re: [PATCH 28/30] drm/mediatek/mtk_disp_color: Fix formatting and
 provide missing member description
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=883:01=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/mediatek/mtk_disp_color.c:40: warning: Function paramete=
r or member 'ddp_comp' not described in 'mtk_disp_color'
>  drivers/gpu/drm/mediatek/mtk_disp_color.c:40: warning: Function paramete=
r or member 'crtc' not described in 'mtk_disp_color'
>  drivers/gpu/drm/mediatek/mtk_disp_color.c:40: warning: Function paramete=
r or member 'data' not described in 'mtk_disp_color'
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_color.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/=
mediatek/mtk_disp_color.c
> index 3ae9c810845bb..a788ff95ed6e4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
> @@ -30,8 +30,9 @@ struct mtk_disp_color_data {
>
>  /**
>   * struct mtk_disp_color - DISP_COLOR driver structure
> - * @ddp_comp - structure containing type enum and hardware resources
> - * @crtc - associated crtc to report irq events to
> + * @ddp_comp: structure containing type enum and hardware resources
> + * @crtc: associated crtc to report irq events to
> + * @data: platform colour driver data
>   */
>  struct mtk_disp_color {
>         struct mtk_ddp_comp                     ddp_comp;
> --
> 2.25.1
>
