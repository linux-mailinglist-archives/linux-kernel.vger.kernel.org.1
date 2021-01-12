Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C462F24D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405303AbhALAZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404267AbhALAU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:20:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40BD922D58;
        Tue, 12 Jan 2021 00:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610410815;
        bh=xT8MvbQsR9UkUaNVPWZFZYrUWOAO1atkSNUZ7hy/oTU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k1mKag3BxKHQJoteEtTEmVGkvD8AhrOyiTgPgLjTrz57CUyTRdPGTFR2jGUHQX0K6
         WsTW+D7pYGJtqOr2P4n/A8inTPTMAWhCqJ7+ZLw4W0YZB+UOy5FaQ9pjVmCjR04qnh
         xC6y77yqF6rJSkmtlwDVsXDm4vtyfrtn7VsM+imLOR+DuxY79Uvuf0Ao+CeOtHdOBn
         gHhxB9//foZE6SGE3358Ful55ukzurLpQUHJE/I50bwp390OxuJY8b9UEYcjNdp3mk
         IadFFRXn89NR+zn0UrT8+kBhbYsXKzmPj4KrI1dmDTsZEtZ9Tmd7lgI72N5kT1KbQZ
         cgJ7wQYzBDw/g==
Received: by mail-ed1-f52.google.com with SMTP id cw27so385537edb.5;
        Mon, 11 Jan 2021 16:20:15 -0800 (PST)
X-Gm-Message-State: AOAM530qi7sHuAosL31+0E6wd/j+Hx4FDLhFj+mb9qxCAXDZuYpgojUO
        DnQcO9Gs2uMN6T9L/etCedTdBomkxgL1iadm+w==
X-Google-Smtp-Source: ABdhPJw95ZpXKnHgH0CIhq3w3Khy4bp6U8XIOVwTypB2JtA2ezUS774iekd3YAxIwUn1uaUwcoFQCOFiB0igSVjur0Y=
X-Received: by 2002:a50:c3c5:: with SMTP id i5mr1348359edf.166.1610410813706;
 Mon, 11 Jan 2021 16:20:13 -0800 (PST)
MIME-Version: 1.0
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com> <1610351031-21133-9-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1610351031-21133-9-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 12 Jan 2021 08:20:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY__+DzbaAi=YUsx0_Sbq9rYzddCgiBvDMQyHgKSOiRvpjA@mail.gmail.com>
Message-ID: <CAAOTY__+DzbaAi=YUsx0_Sbq9rYzddCgiBvDMQyHgKSOiRvpjA@mail.gmail.com>
Subject: Re: [PATCH v3, 08/15] drm/mediatek: check if fb is null
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:48=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> It's possible that state->base.fb is null. Add a check before access its
> format.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: b6b1bb980ec4 ( drm/mediatek: Turn off Alpha bit when plane format =
has no alpha)
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index 4934bee..8e7f494 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -279,7 +279,7 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp =
*comp, unsigned int idx,
>         }
>
>         con =3D ovl_fmt_convert(ovl, fmt);
> -       if (state->base.fb->format->has_alpha)
> +       if (state->base.fb && state->base.fb->format->has_alpha)
>                 con |=3D OVL_CON_AEN | OVL_CON_ALPHA;
>
>         if (pending->rotation & DRM_MODE_REFLECT_Y) {
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
