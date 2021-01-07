Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452872ECDCE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbhAGKaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:30:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbhAGKaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:30:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD82923142;
        Thu,  7 Jan 2021 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610015370;
        bh=13M5zIZH8BYdSgLHcSiUssuxy7aGnL0zsfUTM4vT+Pc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PhzyKeH/omMWDkne6YDBSmYzC952k4TKrqQ+OcU3RWV226x+kfHocirL+sOZ1Ec1I
         L6FYpSbXcq2asi3sfqgBi0QnTs03QoC98IdxSzGWTO41n/JYWqaq0o4k86z7HrC8Ie
         ilPmplMJtIaIQ3XygqQIoEY2Hyr24EGZ914HsqxKeELf1D8HedliDW2sGcd4JtwV2f
         vhoiv7NnQ9Sr4DIB5ghdCSrOkw132MTxao0h77BnA1+creB8OzggJAtOWa+zzsJxlD
         YyErySULnK2ZXXY8Pl9n4joMIK9fxLbho21bcscMsaf3/9mZzdDdy0IOYt5tLzvHwp
         9lKjVFeYW7w2w==
Received: by mail-ej1-f48.google.com with SMTP id n26so8989389eju.6;
        Thu, 07 Jan 2021 02:29:29 -0800 (PST)
X-Gm-Message-State: AOAM533wEY4tge11YQP7IYg/wb8UlLuPZUAr3DQCPfLrq4kxRi0tP/7j
        +1sGTKdnnyWzDGdUy3LJny4mjxceW6NBGjAiQA==
X-Google-Smtp-Source: ABdhPJz05+dsxcv5R7wZF5woSln0ppvl0ASJjVM3ts6esC2GEruDIYNAngku7nUd4kbjmo3tFkzNSYPUlVOCGP5KdM4=
X-Received: by 2002:a17:907:9627:: with SMTP id gb39mr5843470ejc.267.1610015368212;
 Thu, 07 Jan 2021 02:29:28 -0800 (PST)
MIME-Version: 1.0
References: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com> <1609989081-29353-9-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1609989081-29353-9-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 7 Jan 2021 18:29:16 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8Gvk_tR-omr0ObbdB68kvjXR9rcri_ADSHvhGeFdOiHA@mail.gmail.com>
Message-ID: <CAAOTY_8Gvk_tR-omr0ObbdB68kvjXR9rcri_ADSHvhGeFdOiHA@mail.gmail.com>
Subject: Re: [PATCH v9, 08/11] drm/mediatek: add has_dither private data for gamma
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
=887=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:12=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> not all SoC has dither function in gamma module
> dd private data to control this function setting

'add' ?

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/=
mediatek/mtk_disp_gamma.c
> index 8501821..4eab82a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> @@ -24,7 +24,7 @@
>  #define LUT_10BIT_MASK                         0x03ff
>
>  struct mtk_disp_gamma_data {
> -       u32 reserved;
> +       bool has_dither;
>  };
>
>  /**
> @@ -72,7 +72,8 @@ static void mtk_gamma_config(struct mtk_ddp_comp *comp,=
 unsigned int w,
>
>         mtk_ddp_write(cmdq_pkt, h << 16 | w, comp, DISP_GAMMA_SIZE);
>
> -       mtk_dither_set(comp, bpc, DISP_GAMMA_CFG, cmdq_pkt);
> +       if (gamma->data && gamma->data->has_dither)
> +               mtk_dither_set(comp, bpc, DISP_GAMMA_CFG, cmdq_pkt);
>  }
>
>  static void mtk_gamma_start(struct mtk_ddp_comp *comp)
> @@ -168,8 +169,13 @@ static int mtk_disp_gamma_remove(struct platform_dev=
ice *pdev)
>         return 0;
>  }
>
> +static const struct mtk_disp_gamma_data mt8173_gamma_driver_data =3D {
> +       .has_dither =3D true,
> +};
> +
>  static const struct of_device_id mtk_disp_gamma_driver_dt_match[] =3D {
> -       { .compatible =3D "mediatek,mt8173-disp-gamma"},
> +       { .compatible =3D "mediatek,mt8173-disp-gamma",
> +         .data =3D &mt8173_gamma_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_gamma_driver_dt_match);
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
