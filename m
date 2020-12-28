Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637A12E68A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633782AbgL1QjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 11:39:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbgL1Qi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:38:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87E822245C;
        Mon, 28 Dec 2020 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609173498;
        bh=YV/sRyX1UmvG3GgdJ2m2ftk6FRFQv84QER2+PC7WNP0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UK5kKQ8TFRZmctDcMCpNwJwPKX+GfRJDqejqbHjLqlfEGLwBX3n8bZVw06xsMmJwR
         JjKvIRcN6I2rcNK9gh7+SV29hg+EgYWBPEJavUuG0h6Ra0F37O29wffn2NdMjKzj/s
         rh1frW8ZlXyOSbvX9wbPxFjkpT/f6IlwfQrNVs/KNGhUPwS99KMnLHk+0AWVBPx43i
         pt0Y7fdU1Q25Fn4Un7lOvEIwUHgNTQkdFEjgigz5z9SQ2xtTP3Xlss94yRHSBm4VEm
         7tAvCyq6ElkWLMiXTcmGas+bUNAxqzmhn6OPA0tKNyqGvqDeg8ZanAQsu+WtK+gAyv
         i7agiC8kfw8cw==
Received: by mail-wr1-f51.google.com with SMTP id 91so11780957wrj.7;
        Mon, 28 Dec 2020 08:38:18 -0800 (PST)
X-Gm-Message-State: AOAM533koXx012QVX392Fg1pd/efWqvttBqLVkZQ3NNP3q7XS8YXihFV
        kmkAMuF8V3Q1a0AIyaV6gtEVC+RzdMRR11gYrQ==
X-Google-Smtp-Source: ABdhPJyH9luqvq7mDBrXfC//wmYqhVyPNCFSGbrh2c9nlDMvIXGLGHRAotR70G+rGeb+bseslPiYL4Rabit/Z+t8IxA=
X-Received: by 2002:adf:e84c:: with SMTP id d12mr53775611wrn.382.1609173497206;
 Mon, 28 Dec 2020 08:38:17 -0800 (PST)
MIME-Version: 1.0
References: <1609144630-14721-1-git-send-email-yongqiang.niu@mediatek.com> <1609144630-14721-8-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1609144630-14721-8-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 29 Dec 2020 00:38:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9ObwPwKt6nRc_qSu9JE3WbqeRDEpKObnxsfhENbkT+iw@mail.gmail.com>
Message-ID: <CAAOTY_9ObwPwKt6nRc_qSu9JE3WbqeRDEpKObnxsfhENbkT+iw@mail.gmail.com>
Subject: Re: [PATCH v3, 7/8] soc: mediatek: mmsys: Use function call for
 setting mmsys ovl mout register
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=9C=
=8828=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:38=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Use function call for setting mmsys ovl mout register
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/soc/mediatek/mmsys/mtk-mmsys.c | 20 ++++++++++++++++++++
>  include/linux/soc/mediatek/mtk-mmsys.h |  3 +++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mmsys/mtk-mmsys.c b/drivers/soc/mediate=
k/mmsys/mtk-mmsys.c
> index dae665b..ea36a11 100644
> --- a/drivers/soc/mediatek/mmsys/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mmsys/mtk-mmsys.c
> @@ -74,6 +74,17 @@ void mtk_mmsys_ddp_connect(struct device *dev,
>                 reg =3D readl_relaxed(mmsys->regs + addr) | value;
>                 writel_relaxed(reg, mmsys->regs + addr);
>         }
> +
> +       if (!funcs->ovl_mout_en)
> +               return;
> +
> +       if (funcs->ovl_mout_en) {
> +               value =3D funcs->ovl_mout_en(cur, next, &addr);
> +               if (value) {
> +                       reg =3D readl_relaxed(mmsys->regs + addr) | value=
;
> +                       writel_relaxed(reg, mmsys->regs + addr);
> +               }
> +       }

mtk_mmsys_ddp_mout_en() could write register inside it rather than
return value and write register in mtk_mmsys_ddp_connect(). So you
could do ovl_mout_en() in mtk_mmsys_ddp_mout_en().

Regards,
Chun-Kuang.

>  }
>  EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
>
> @@ -99,6 +110,15 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
>                 reg =3D readl_relaxed(mmsys->regs + addr) & ~value;
>                 writel_relaxed(reg, mmsys->regs + addr);
>         }
> +
> +       if (!funcs->ovl_mout_en)
> +               return;
> +
> +       value =3D funcs->ovl_mout_en(cur, next, &addr);
> +       if (value) {
> +               reg =3D readl_relaxed(mmsys->regs + addr) & ~value;
> +               writel_relaxed(reg, mmsys->regs + addr);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
>
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index aa4f60e..220203d 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -49,6 +49,9 @@ struct mtk_mmsys_conn_funcs {
>         u32 (*mout_en)(enum mtk_ddp_comp_id cur,
>                        enum mtk_ddp_comp_id next,
>                        unsigned int *addr);
> +       u32 (*ovl_mout_en)(enum mtk_ddp_comp_id cur,
> +                          enum mtk_ddp_comp_id next,
> +                          unsigned int *addr);
>         u32 (*sel_in)(enum mtk_ddp_comp_id cur,
>                       enum mtk_ddp_comp_id next,
>                       unsigned int *addr);
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
