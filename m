Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31E12ECD77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbhAGKGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:06:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbhAGKGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:06:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 134EE2311E;
        Thu,  7 Jan 2021 10:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610013926;
        bh=XWCiwpuOus+rdx5NyKPd3hsIfab/jop8IOEOi6Fl1DA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZQlxjdoPZBXInGVwW3bTDZ4hvXBCLB1JkW5GjZ7QKa8miUN/QoTEvHKaXGjhCWP2k
         OWMmcVm8Rg3sSrDhqtbGEpVn0q3L5vlm4t4JeTMxmErtvysj6IfrxbAxKpUhVXrYw1
         4fmh8vS3lE6eaDGvD0fsUQ6uJnqlaki1338DY8/effyd3TcAx2KLycvuc3imj5+mLA
         NhtjcHxr8yATbbnFhHOwRI/uYoKSgb63DEawnvZArG6jb+uk7q9k8oRAqpl4MiFCCt
         9zOrqcpFKUppfsDVIXTTsjdi6+oBbYz7ONtFPM0OAXimIfeDJ/gzizKve1KoHORJcK
         uNzbWlYafWYmg==
Received: by mail-ed1-f44.google.com with SMTP id cw27so7207236edb.5;
        Thu, 07 Jan 2021 02:05:25 -0800 (PST)
X-Gm-Message-State: AOAM531f6GCF/uo0V8vg7CDDyeAMey16D/GV02hktxw+uEuFPh/Bq5VI
        FUZrB5TA8qCpV15YkGCtnKLYKmrHYPiPws8IGw==
X-Google-Smtp-Source: ABdhPJy6aKdf+ALvz/JPUW+3K8X25ja4+q1SbtTR9U4Ty1Mcr7xuSbOEslRjkoLF1UiANP8PhaulwzMLGh/Te/js2dU=
X-Received: by 2002:a50:c3c5:: with SMTP id i5mr1123540edf.166.1610013924641;
 Thu, 07 Jan 2021 02:05:24 -0800 (PST)
MIME-Version: 1.0
References: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com> <1609989081-29353-6-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1609989081-29353-6-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 7 Jan 2021 18:05:13 +0800
X-Gmail-Original-Message-ID: <CAAOTY__Ox7jxLxQvm_mvAqEedj48=grH0Mao7xZ5bLuABZNeMQ@mail.gmail.com>
Message-ID: <CAAOTY__Ox7jxLxQvm_mvAqEedj48=grH0Mao7xZ5bLuABZNeMQ@mail.gmail.com>
Subject: Re: [PATCH v9, 05/11] drm/mediatek: add fifo_size into rdma private data
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
> Get the fifo size from device tree
> because each rdma in the same SoC may have different fifo size

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_rdma.c
> index d46b8ae..8c64d5c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -64,6 +64,7 @@ struct mtk_disp_rdma {
>         struct mtk_ddp_comp             ddp_comp;
>         struct drm_crtc                 *crtc;
>         const struct mtk_disp_rdma_data *data;
> +       u32                             fifo_size;
>  };
>
>  static inline struct mtk_disp_rdma *comp_to_rdma(struct mtk_ddp_comp *co=
mp)
> @@ -132,12 +133,18 @@ static void mtk_rdma_config(struct mtk_ddp_comp *co=
mp, unsigned int width,
>         unsigned int threshold;
>         unsigned int reg;
>         struct mtk_disp_rdma *rdma =3D comp_to_rdma(comp);
> +       u32 rdma_fifo_size;
>
>         mtk_ddp_write_mask(cmdq_pkt, width, comp,
>                            DISP_REG_RDMA_SIZE_CON_0, 0xfff);
>         mtk_ddp_write_mask(cmdq_pkt, height, comp,
>                            DISP_REG_RDMA_SIZE_CON_1, 0xfffff);
>
> +       if (rdma->fifo_size)
> +               rdma_fifo_size =3D rdma->fifo_size;
> +       else
> +               rdma_fifo_size =3D RDMA_FIFO_SIZE(rdma);
> +
>         /*
>          * Enable FIFO underflow since DSI and DPI can't be blocked.
>          * Keep the FIFO pseudo size reset default of 8 KiB. Set the
> @@ -146,7 +153,7 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp=
, unsigned int width,
>          */
>         threshold =3D width * height * vrefresh * 4 * 7 / 1000000;
>         reg =3D RDMA_FIFO_UNDERFLOW_EN |
> -             RDMA_FIFO_PSEUDO_SIZE(RDMA_FIFO_SIZE(rdma)) |
> +             RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) |
>               RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
>         mtk_ddp_write(cmdq_pkt, reg, comp, DISP_REG_RDMA_FIFO_CON);
>  }
> @@ -292,6 +299,16 @@ static int mtk_disp_rdma_probe(struct platform_devic=
e *pdev)
>                 return comp_id;
>         }
>
> +       if (of_find_property(dev->of_node, "mediatek,rdma-fifo-size", &re=
t)) {
> +               ret =3D of_property_read_u32(dev->of_node,
> +                                          "mediatek,rdma-fifo-size",
> +                                          &priv->fifo_size);
> +               if (ret) {
> +                       dev_err(dev, "Failed to get rdma fifo size\n");
> +                       return ret;
> +               }
> +       }
> +
>         ret =3D mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, com=
p_id,
>                                 &mtk_disp_rdma_funcs);
>         if (ret) {
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
