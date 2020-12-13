Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5542D8ACA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 02:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439958AbgLMBQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 20:16:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgLMBP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 20:15:59 -0500
X-Gm-Message-State: AOAM533WfqHA8m6nRi+08Ou3NrAWn3EFzaRT62nhAIFmwXj1zeW4/6Xm
        mUQwuFemsa+Yc9dU/phNJHKmXw/5CISf6fn1NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607822118;
        bh=DuuvSYAgKQaNskB+hKM10xoonyLBpgBKY3lVUg/jzKM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mGfFiGHPZ+0K8oG5EitT1rP0Ln7RvsH4jvAjTD/RVWb71OgL+ZTr8BAXiI21Spjtg
         duuylj1rz9UqQjR3OJ+PXojw0hlVngPLz7cKAwS+YQGKYol99bj1NnYaWyF6bRdPqh
         oMJFtI1YvBDFzij0buLUhDhZQMQPcLu821pavPB//cyYkhoY25h0sYconPs7MadNiv
         TqySZQHNs2nxx3QOzCBpq/G9G2Lp2Dc5z8p2lgEYYge3m/bv6wyc6gkmKtZoa1wNtK
         FEuO4I+UZDyJr/vU9Xk539Ta9f7YLNrRYFVYZwiFCDvZzqFaNMuJa5mxIbETRGhxX3
         y9smBV9qObshA==
X-Google-Smtp-Source: ABdhPJxwatlJb+8VRQZCMPRl8VIOjuxvSaZJuqeloLzJDD7QgR6XPq6bmpgZNV+0chJV9VkJ7Cdgd5MYWpjqub7z4kY=
X-Received: by 2002:a17:907:414c:: with SMTP id od20mr16781511ejb.75.1607822116713;
 Sat, 12 Dec 2020 17:15:16 -0800 (PST)
MIME-Version: 1.0
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com> <1607746317-4696-5-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607746317-4696-5-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 13 Dec 2020 09:15:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8bsmRtt9Kpd1__iEuPJ3Ox7jbn_yXnUeUoj041AhjSkQ@mail.gmail.com>
Message-ID: <CAAOTY_8bsmRtt9Kpd1__iEuPJ3Ox7jbn_yXnUeUoj041AhjSkQ@mail.gmail.com>
Subject: Re: [PATCH v2, 04/17] drm/mediatek: add component OVL_2L2
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=9C=
=8812=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8812:12=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This patch add component OVL_2L2

Break drm part and soc part into different patches.

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
>  include/linux/soc/mediatek/mtk-mmsys.h      | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 8eba44b..8938554 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -403,6 +403,7 @@ struct mtk_ddp_comp_match {
>         [DDP_COMPONENT_OVL1]    =3D { MTK_DISP_OVL,       1, NULL },
>         [DDP_COMPONENT_OVL_2L0] =3D { MTK_DISP_OVL_2L,    0, NULL },
>         [DDP_COMPONENT_OVL_2L1] =3D { MTK_DISP_OVL_2L,    1, NULL },
> +       [DDP_COMPONENT_OVL_2L2] =3D { MTK_DISP_OVL_2L,    2, NULL },
>         [DDP_COMPONENT_PWM0]    =3D { MTK_DISP_PWM,       0, NULL },
>         [DDP_COMPONENT_PWM1]    =3D { MTK_DISP_PWM,       1, NULL },
>         [DDP_COMPONENT_PWM2]    =3D { MTK_DISP_PWM,       2, NULL },
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index 4b6c514..42476c2 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -29,6 +29,7 @@ enum mtk_ddp_comp_id {
>         DDP_COMPONENT_OVL0,
>         DDP_COMPONENT_OVL_2L0,
>         DDP_COMPONENT_OVL_2L1,
> +       DDP_COMPONENT_OVL_2L2,
>         DDP_COMPONENT_OVL1,
>         DDP_COMPONENT_PWM0,
>         DDP_COMPONENT_PWM1,
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
