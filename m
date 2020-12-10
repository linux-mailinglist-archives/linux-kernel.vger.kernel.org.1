Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980202D6075
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391281AbgLJPvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:51:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403801AbgLJPvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:51:09 -0500
X-Gm-Message-State: AOAM531p2FN++cP3ZtHJfsfdjZh2WEML91I7W6Jj+pojvoyWTSPxMgls
        wEWPKysRcyfo1GnxY+XpFpgwe0BF8xZhMk/NTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607615429;
        bh=JswAsdHWyxMnvC+dTai6TVtWwh9Dj+cpwNchJF8bnPo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u4vlNxk5gZO0CNj3V9ovmXkU8Ld269fUM1zfcIXmVogxFNzaTn9yG8x2ztsLM4Ur/
         nX/gR+bkNweRpLwlcut21M19lVWWwrfkh1vGwtO2bKy/3JiUpCjly809+gbZObR/i6
         bdvDXyP0hgjzNMFuoM00bgq01lVMolh2pfLtrFRer6SHq7pe+7GGnXwp5n+UgjfHT7
         RNgu4aVuPlOt+dY4LDm9YpFmOO00MANM3AtkfXeX8FuQXiTBsWsjjBp0JylYmQ5Xz/
         iZ79sr3Lm6Cjo2aNOk9vPt9jtNfUgpFyqotyViLCrK+WWr2x+sLy4vwOdWido36iUy
         sQPjnfa0mc9jQ==
X-Google-Smtp-Source: ABdhPJwtcxVDc6Q2bu5uvq6r1O0IW7GMG0SyjPcCWYbsaNRsfJcxcmQwSG/LXBiPJ0zdfQUzcOkO6cQLrj6rQ7eo7AI=
X-Received: by 2002:a05:6402:845:: with SMTP id b5mr7518636edz.38.1607615427120;
 Thu, 10 Dec 2020 07:50:27 -0800 (PST)
MIME-Version: 1.0
References: <1607591262-21736-1-git-send-email-yongqiang.niu@mediatek.com> <1607591262-21736-6-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607591262-21736-6-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 10 Dec 2020 23:50:16 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-aYFz1Xg6r2ur+BF_k_35F3qNLLb16_2c0MaMsYre-+w@mail.gmail.com>
Message-ID: <CAAOTY_-aYFz1Xg6r2ur+BF_k_35F3qNLLb16_2c0MaMsYre-+w@mail.gmail.com>
Subject: Re: [PATCH v8, 5/6] drm/mediatek: add RDMA fifo size error handle
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
=8810=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:08=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This patch add RDMA fifo size error handle
> rdma fifo size will not always bigger than the calculated threshold
> if that case happened, we need set fifo size as the threshold
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_rdma.c
> index 794acc5..0508392 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -151,6 +151,10 @@ static void mtk_rdma_config(struct mtk_ddp_comp *com=
p, unsigned int width,
>          * account for blanking, and with a pixel depth of 4 bytes:
>          */
>         threshold =3D width * height * vrefresh * 4 * 7 / 1000000;
> +
> +       if (threshold > rdma_fifo_size)
> +               threshold =3D rdma_fifo_size;

If the formula is not correct, you should fix the formula not work around.

Regards,
Chun-Kuang.

> +
>         reg =3D RDMA_FIFO_UNDERFLOW_EN |
>               RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) |
>               RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
