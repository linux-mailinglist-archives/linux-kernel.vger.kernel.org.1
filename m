Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324852ECF5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbhAGMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:09:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbhAGMJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:09:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D357123371;
        Thu,  7 Jan 2021 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610021350;
        bh=Bax/TD9n3UeF4RLUUYlRxx9HMo70f3ud0l2YLRw3aJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tpCL7OQlHjsN4r7T3Mo2j2HPzP4X0bQVq2Wi4iYFY4q9KzPdReZfolrMuln/P4bIg
         dDlctOUFIa3l4ncVGx2P+H0K6JIykMplib0B+uwY1a88eP3KtsuDj3jVrTJYpIy/up
         1w0KoP81u3P/iU5j2dEufUwbyyqbBz9xuQfonz7+tz4lqV0XtIvL87J+4hDn4/t7zh
         QQ4jmsf6olG2RZ4e6PmNDPnkxdcQBnepXnry/cXkwhotYBDtcaMyWXa0FAIjPyHEo7
         FK8ZURfkgYnOs5+IVVj/byCkveyw3Owey8kctMopuWkMtM5AXQQQWeLjEgBGFkWkcN
         B8JJSO5h5WrNg==
Received: by mail-ej1-f45.google.com with SMTP id lt17so9405016ejb.3;
        Thu, 07 Jan 2021 04:09:09 -0800 (PST)
X-Gm-Message-State: AOAM5339bPziR+uEzwxn9Fkx9LZYdK78Hyaug6FyysaEIxeDXVLI8FoJ
        JAuyoePhvo+jkBwu7Z1F8WHrUFEtpxa02xBvYQ==
X-Google-Smtp-Source: ABdhPJwLWYyQXSkeJmJYkDh2Wp/HMnw+iryfBXBAZeGMzi476416Ju5zo44dK3b7l2wd0kclwctstGJHZkRWEc8NWXM=
X-Received: by 2002:a17:907:414c:: with SMTP id od20mr6066221ejb.75.1610021348232;
 Thu, 07 Jan 2021 04:09:08 -0800 (PST)
MIME-Version: 1.0
References: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com> <1609989081-29353-11-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1609989081-29353-11-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 7 Jan 2021 20:08:56 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-xZyFXTROVStte_-X0aNGLa0qZDe5AtC7M2RigOB1c3Q@mail.gmail.com>
Message-ID: <CAAOTY_-xZyFXTROVStte_-X0aNGLa0qZDe5AtC7M2RigOB1c3Q@mail.gmail.com>
Subject: Re: [PATCH v9, 10/11] drm/mediatek: add DDP support for MT8183
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
> Add DDP support for MT8167 SoC.
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 48 ++++++++++++++++++++++++++++=
++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/med=
iatek/mtk_drm_ddp.c
> index 1f99db6..1308046 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -15,6 +15,8 @@
>
>  #define MT2701_DISP_MUTEX0_MOD0                        0x2c
>  #define MT2701_DISP_MUTEX0_SOF0                        0x30
> +#define MT8183_DISP_MUTEX0_MOD0                        0x30
> +#define MT8183_DISP_MUTEX0_SOF0                        0x2c
>
>  #define DISP_REG_MUTEX_EN(n)                   (0x20 + 0x20 * (n))
>  #define DISP_REG_MUTEX(n)                      (0x24 + 0x20 * (n))
> @@ -38,6 +40,18 @@
>  #define MT8167_MUTEX_MOD_DISP_DITHER           15
>  #define MT8167_MUTEX_MOD_DISP_UFOE             16
>
> +#define MT8183_MUTEX_MOD_DISP_RDMA0            0
> +#define MT8183_MUTEX_MOD_DISP_RDMA1            1
> +#define MT8183_MUTEX_MOD_DISP_OVL0             9
> +#define MT8183_MUTEX_MOD_DISP_OVL0_2L          10
> +#define MT8183_MUTEX_MOD_DISP_OVL1_2L          11
> +#define MT8183_MUTEX_MOD_DISP_WDMA0            12
> +#define MT8183_MUTEX_MOD_DISP_COLOR0           13
> +#define MT8183_MUTEX_MOD_DISP_CCORR0           14
> +#define MT8183_MUTEX_MOD_DISP_AAL0             15
> +#define MT8183_MUTEX_MOD_DISP_GAMMA0           16
> +#define MT8183_MUTEX_MOD_DISP_DITHER0          17
> +
>  #define MT8173_MUTEX_MOD_DISP_OVL0             11
>  #define MT8173_MUTEX_MOD_DISP_OVL1             12
>  #define MT8173_MUTEX_MOD_DISP_RDMA0            13
> @@ -89,6 +103,10 @@
>  #define MT8167_MUTEX_SOF_DPI0          2
>  #define MT8167_MUTEX_SOF_DPI1          3
>
> +#define MT8183_MUTEX_SOF_DPI0                  2
> +#define MT8183_MUTEX_EOF_DSI0                  (MUTEX_SOF_DSI0 << 6)
> +#define MT8183_MUTEX_EOF_DPI0                  (MT8183_MUTEX_SOF_DPI0 <<=
 6)
> +
>
>  struct mtk_disp_mutex {
>         int id;
> @@ -183,6 +201,20 @@ struct mtk_ddp {
>         [DDP_COMPONENT_WDMA1] =3D MT8173_MUTEX_MOD_DISP_WDMA1,
>  };
>
> +static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] =3D {
> +       [DDP_COMPONENT_AAL0] =3D MT8183_MUTEX_MOD_DISP_AAL0,
> +       [DDP_COMPONENT_CCORR] =3D MT8183_MUTEX_MOD_DISP_CCORR0,
> +       [DDP_COMPONENT_COLOR0] =3D MT8183_MUTEX_MOD_DISP_COLOR0,
> +       [DDP_COMPONENT_DITHER] =3D MT8183_MUTEX_MOD_DISP_DITHER0,
> +       [DDP_COMPONENT_GAMMA] =3D MT8183_MUTEX_MOD_DISP_GAMMA0,
> +       [DDP_COMPONENT_OVL0] =3D MT8183_MUTEX_MOD_DISP_OVL0,
> +       [DDP_COMPONENT_OVL_2L0] =3D MT8183_MUTEX_MOD_DISP_OVL0_2L,
> +       [DDP_COMPONENT_OVL_2L1] =3D MT8183_MUTEX_MOD_DISP_OVL1_2L,
> +       [DDP_COMPONENT_RDMA0] =3D MT8183_MUTEX_MOD_DISP_RDMA0,
> +       [DDP_COMPONENT_RDMA1] =3D MT8183_MUTEX_MOD_DISP_RDMA1,
> +       [DDP_COMPONENT_WDMA0] =3D MT8183_MUTEX_MOD_DISP_WDMA0,
> +};
> +
>  static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] =3D {
>         [DDP_MUTEX_SOF_SINGLE_MODE] =3D MUTEX_SOF_SINGLE_MODE,
>         [DDP_MUTEX_SOF_DSI0] =3D MUTEX_SOF_DSI0,
> @@ -200,6 +232,12 @@ struct mtk_ddp {
>         [DDP_MUTEX_SOF_DPI1] =3D MT8167_MUTEX_SOF_DPI1,
>  };
>
> +static const unsigned int mt8183_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] =3D {
> +       [DDP_MUTEX_SOF_SINGLE_MODE] =3D MUTEX_SOF_SINGLE_MODE,
> +       [DDP_MUTEX_SOF_DSI0] =3D MUTEX_SOF_DSI0 | MT8183_MUTEX_EOF_DSI0,
> +       [DDP_MUTEX_SOF_DPI0] =3D MT8183_MUTEX_SOF_DPI0 | MT8183_MUTEX_EOF=
_DPI0,

According to discussion in [1], add comment for the odd EOF setting.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/1595469798-38=
24-8-git-send-email-yongqiang.niu@mediatek.com/

Regards,
Chun-Kuang.

> +};
> +
>  static const struct mtk_ddp_data mt2701_ddp_driver_data =3D {
>         .mutex_mod =3D mt2701_mutex_mod,
>         .mutex_sof =3D mt2712_mutex_sof,
> @@ -229,6 +267,14 @@ struct mtk_ddp {
>         .mutex_sof_reg =3D MT2701_DISP_MUTEX0_SOF0,
>  };
>
> +static const struct mtk_ddp_data mt8183_ddp_driver_data =3D {
> +       .mutex_mod =3D mt8183_mutex_mod,
> +       .mutex_sof =3D mt8183_mutex_sof,
> +       .mutex_mod_reg =3D MT8183_DISP_MUTEX0_MOD0,
> +       .mutex_sof_reg =3D MT8183_DISP_MUTEX0_SOF0,
> +       .no_clk =3D true,
> +};
> +
>  struct mtk_disp_mutex *mtk_disp_mutex_get(struct device *dev, unsigned i=
nt id)
>  {
>         struct mtk_ddp *ddp =3D dev_get_drvdata(dev);
> @@ -449,6 +495,8 @@ static int mtk_ddp_remove(struct platform_device *pde=
v)
>           .data =3D &mt8167_ddp_driver_data},
>         { .compatible =3D "mediatek,mt8173-disp-mutex",
>           .data =3D &mt8173_ddp_driver_data},
> +       { .compatible =3D "mediatek,mt8183-disp-mutex",
> +         .data =3D &mt8183_ddp_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
