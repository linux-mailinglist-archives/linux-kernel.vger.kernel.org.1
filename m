Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD82F6EED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 00:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbhANX2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 18:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbhANX2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 18:28:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 710EF23AC6;
        Thu, 14 Jan 2021 23:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610666840;
        bh=4Zj3Wl9MmezHCv26E0/LT5ibGDbwFsMqnirwMOVtjqE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aBLoFuP9S4Nc3XrlPFcxpWS2vWovEqXQd9fxBf6JZfHE2hegibJmRABAh+PPF7RLr
         73MX39xJBmv973lJK2GoCa78CI7e7G04MIaff7ut6UhF0nf7DXAlQp6HjQtzcLRfPf
         qcKkvU09liZCmxbEsjeFf/3FIG+og4y4FNILMH6O3Azz0G2n6fx34/CS4Ifp+IRf8P
         GlSwRBKhSCKwj6xECjsMMrWT7dC3mTU2EJcd+cX61/zSv/Bf6Jedjx7HfcjCJeaHMw
         qHg4v4Gty8N54mrBohg1Eb9qnSlVTgZ9PnbsE1nflAsGuiMaKbYb5ZnqU4rge2ElDP
         RpGeHwhRWfojA==
Received: by mail-ej1-f42.google.com with SMTP id q22so10748124eja.2;
        Thu, 14 Jan 2021 15:27:20 -0800 (PST)
X-Gm-Message-State: AOAM532ZGnwEX26aYNhEPvp9CAmQwxXDlEGutRBSdAv15Sxi9Aa+5E9n
        73a58zWuZM3GRxlpwYF6MWiMMZNIsPYW+hmkpg==
X-Google-Smtp-Source: ABdhPJwT7znQYQKLZ+6Sn6y2n9e+stArAY5GAuMtoUClRK/SPi6pP38lZV6DIyg4QRGopg8Iq3NUruuIGHT/VFxhO+Y=
X-Received: by 2002:a17:906:fb1a:: with SMTP id lz26mr6911340ejb.194.1610666838951;
 Thu, 14 Jan 2021 15:27:18 -0800 (PST)
MIME-Version: 1.0
References: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com>
 <1609989081-29353-6-git-send-email-yongqiang.niu@mediatek.com> <CAAOTY__Ox7jxLxQvm_mvAqEedj48=grH0Mao7xZ5bLuABZNeMQ@mail.gmail.com>
In-Reply-To: <CAAOTY__Ox7jxLxQvm_mvAqEedj48=grH0Mao7xZ5bLuABZNeMQ@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 15 Jan 2021 07:27:07 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8psXwmWqKidGKZN05jcNqhq4igNmbbXX2xePYDgwHDDg@mail.gmail.com>
Message-ID: <CAAOTY_8psXwmWqKidGKZN05jcNqhq4igNmbbXX2xePYDgwHDDg@mail.gmail.com>
Subject: Re: [PATCH v9, 05/11] drm/mediatek: add fifo_size into rdma private data
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=887=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:05=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi, Yongqiang:
>
> Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=887=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:12=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Get the fifo size from device tree
> > because each rdma in the same SoC may have different fifo size
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> >
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm=
/mediatek/mtk_disp_rdma.c
> > index d46b8ae..8c64d5c 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > @@ -64,6 +64,7 @@ struct mtk_disp_rdma {
> >         struct mtk_ddp_comp             ddp_comp;
> >         struct drm_crtc                 *crtc;
> >         const struct mtk_disp_rdma_data *data;
> > +       u32                             fifo_size;
> >  };
> >
> >  static inline struct mtk_disp_rdma *comp_to_rdma(struct mtk_ddp_comp *=
comp)
> > @@ -132,12 +133,18 @@ static void mtk_rdma_config(struct mtk_ddp_comp *=
comp, unsigned int width,
> >         unsigned int threshold;
> >         unsigned int reg;
> >         struct mtk_disp_rdma *rdma =3D comp_to_rdma(comp);
> > +       u32 rdma_fifo_size;
> >
> >         mtk_ddp_write_mask(cmdq_pkt, width, comp,
> >                            DISP_REG_RDMA_SIZE_CON_0, 0xfff);
> >         mtk_ddp_write_mask(cmdq_pkt, height, comp,
> >                            DISP_REG_RDMA_SIZE_CON_1, 0xfffff);
> >
> > +       if (rdma->fifo_size)
> > +               rdma_fifo_size =3D rdma->fifo_size;
> > +       else
> > +               rdma_fifo_size =3D RDMA_FIFO_SIZE(rdma);
> > +
> >         /*
> >          * Enable FIFO underflow since DSI and DPI can't be blocked.
> >          * Keep the FIFO pseudo size reset default of 8 KiB. Set the
> > @@ -146,7 +153,7 @@ static void mtk_rdma_config(struct mtk_ddp_comp *co=
mp, unsigned int width,
> >          */
> >         threshold =3D width * height * vrefresh * 4 * 7 / 1000000;
> >         reg =3D RDMA_FIFO_UNDERFLOW_EN |
> > -             RDMA_FIFO_PSEUDO_SIZE(RDMA_FIFO_SIZE(rdma)) |
> > +             RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) |
> >               RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
> >         mtk_ddp_write(cmdq_pkt, reg, comp, DISP_REG_RDMA_FIFO_CON);
> >  }
> > @@ -292,6 +299,16 @@ static int mtk_disp_rdma_probe(struct platform_dev=
ice *pdev)
> >                 return comp_id;
> >         }
> >
> > +       if (of_find_property(dev->of_node, "mediatek,rdma-fifo-size", &=
ret)) {
> > +               ret =3D of_property_read_u32(dev->of_node,
> > +                                          "mediatek,rdma-fifo-size",
> > +                                          &priv->fifo_size);
> > +               if (ret) {
> > +                       dev_err(dev, "Failed to get rdma fifo size\n");
> > +                       return ret;
> > +               }
> > +       }
> > +
> >         ret =3D mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, c=
omp_id,
> >                                 &mtk_disp_rdma_funcs);
> >         if (ret) {
> > --
> > 1.8.1.1.dirty
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
