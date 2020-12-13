Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6992D8E7D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 17:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395530AbgLMQDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 11:03:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395125AbgLMQD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 11:03:29 -0500
X-Gm-Message-State: AOAM532ud9oQkk/RMR0ehkkfNRemRQmqQTl1Ko7i4ft0DquQhj0azZWn
        g93+DSovd9g+akd4NLCmkLAYupP4BZMtk9j8WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607875367;
        bh=ukf/aBNi4L2oBoukiy7AOl9FVhu9uGDgT5aSBa8w9Z8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AUBdMfUEsNEQpePC6+fWAyO3yOhC2WrVKQ5FnASYG0dhZEpSKaRLztEN1eR+iDC+q
         B+0tYcaGAW5b7amJ+D/c4BjLfjsolAbIr1pbj0Hm/6Lqu/nOmiF7egKPHlLgNa59G3
         m2TVJV4ibG8KkDT4re/GZA0cp7eUscQQqsrThZgBclYVT3uqpD1gWdXQJBfc/tj3qr
         Z/poHo8ZoUS80+LrN9Rv7ypnsa3JmEC7XFubO20i9h9wonhB+jrbKItsK+F5Wshvsv
         aJ7g1acESPeR1ihxw1p5rpXIGlEw/PBA5IjFKS/lfxDKOomoQ0KMAicfCZBlOs9Bof
         u+ePZfNa9C2NA==
X-Google-Smtp-Source: ABdhPJyvtR8vkMXI6k90bZ32VwTzFSlj7MAJwPMN2aNSdllIn6Ndy3QBDjhbIBD902YhIvQ4AFrHXTJXys+fy5BHnmQ=
X-Received: by 2002:a17:907:9627:: with SMTP id gb39mr19349115ejc.267.1607875365732;
 Sun, 13 Dec 2020 08:02:45 -0800 (PST)
MIME-Version: 1.0
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com> <1607746317-4696-16-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607746317-4696-16-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 14 Dec 2020 00:02:33 +0800
X-Gmail-Original-Message-ID: <CAAOTY_85qGGc3FhSBDYgNG79sNyJg+Nm1WUrCCuhraRQO_e96Q@mail.gmail.com>
Message-ID: <CAAOTY_85qGGc3FhSBDYgNG79sNyJg+Nm1WUrCCuhraRQO_e96Q@mail.gmail.com>
Subject: Re: [PATCH v2, 15/17] soc: mediatek: mmsys: add mt8192 mmsys support
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
=8812=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8812:22=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add mt8192 mmsys support
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/soc/mediatek/mmsys/Makefile       |   1 +
>  drivers/soc/mediatek/mmsys/mt8192-mmsys.c | 119 ++++++++++++++++++++++++=
++++++
>  include/linux/soc/mediatek/mtk-mmsys.h    |   1 +
>  3 files changed, 121 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mmsys/mt8192-mmsys.c
>
> diff --git a/drivers/soc/mediatek/mmsys/Makefile b/drivers/soc/mediatek/m=
msys/Makefile
> index 25eeb9e5..7508cd3 100644
> --- a/drivers/soc/mediatek/mmsys/Makefile
> +++ b/drivers/soc/mediatek/mmsys/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_MTK_MMSYS) +=3D mt2701-mmsys.o
>  obj-$(CONFIG_MTK_MMSYS) +=3D mt8183-mmsys.o
> +obj-$(CONFIG_MTK_MMSYS) +=3D mt8192-mmsys.o
>  obj-$(CONFIG_MTK_MMSYS) +=3D mtk-mmsys.o
> diff --git a/drivers/soc/mediatek/mmsys/mt8192-mmsys.c b/drivers/soc/medi=
atek/mmsys/mt8192-mmsys.c
> new file mode 100644
> index 0000000..79cb33f
> --- /dev/null
> +++ b/drivers/soc/mediatek/mmsys/mt8192-mmsys.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2020 MediaTek Inc.
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/mediatek/mtk-mmsys.h>
> +
> +#define MMSYS_OVL_MOUT_EN              0xf04
> +#define DISP_OVL0_GO_BLEND                     BIT(0)
> +#define DISP_OVL0_GO_BG                                BIT(1)
> +#define DISP_OVL0_2L_GO_BLEND                  BIT(2)
> +#define DISP_OVL0_2L_GO_BG                     BIT(3)
> +#define DISP_OVL1_2L_MOUT_EN           0xf08
> +#define OVL1_2L_MOUT_EN_RDMA1                  BIT(4)
> +#define DISP_OVL0_2L_MOUT_EN           0xf18
> +#define DISP_OVL0_MOUT_EN              0xf1c
> +#define OVL0_MOUT_EN_DISP_RDMA0                        BIT(0)
> +#define OVL0_MOUT_EN_OVL0_2L                   BIT(4)
> +#define DISP_RDMA0_SEL_IN              0xf2c
> +#define RDMA0_SEL_IN_OVL0_2L                   0x3
> +#define DISP_RDMA0_SOUT_SEL            0xf30
> +#define RDMA0_SOUT_COLOR0                      0x1
> +#define DISP_CCORR0_SOUT_SEL           0xf34
> +#define CCORR0_SOUT_AAL0                       0x1
> +#define DISP_AAL0_SEL_IN               0xf38
> +#define AAL0_SEL_IN_CCORR0                     0x1
> +#define DISP_DITHER0_MOUT_EN           0xf3c
> +#define DITHER0_MOUT_DSI0                      BIT(0)
> +#define DISP_DSI0_SEL_IN               0xf40
> +#define DSI0_SEL_IN_DITHER0                    0x1
> +#define DISP_OVL2_2L_MOUT_EN           0xf4c
> +#define OVL2_2L_MOUT_RDMA4                     BIT(0)
> +
> +static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
> +                                         enum mtk_ddp_comp_id next,
> +                                         unsigned int *addr)
> +{
> +       unsigned int value;
> +
> +       if (cur =3D=3D DDP_COMPONENT_OVL_2L0 && next =3D=3D DDP_COMPONENT=
_RDMA0) {
> +               *addr =3D DISP_OVL0_2L_MOUT_EN;
> +               value =3D OVL0_MOUT_EN_DISP_RDMA0;
> +       } else if (cur =3D=3D DDP_COMPONENT_OVL_2L2 && next =3D=3D DDP_CO=
MPONENT_RDMA4) {
> +               *addr =3D DISP_OVL2_2L_MOUT_EN;
> +               value =3D OVL2_2L_MOUT_RDMA4;
> +       } else if (cur =3D=3D DDP_COMPONENT_DITHER && next =3D=3D DDP_COM=
PONENT_DSI0) {
> +               *addr =3D DISP_DITHER0_MOUT_EN;
> +               value =3D DITHER0_MOUT_DSI0;
> +       } else {
> +               value =3D 0;
> +       }
> +
> +       return value;
> +}
> +
> +static unsigned int mtk_mmsys_ddp_sel_in(enum mtk_ddp_comp_id cur,
> +                                        enum mtk_ddp_comp_id next,
> +                                        unsigned int *addr)
> +{
> +       unsigned int value;
> +
> +       if (cur =3D=3D DDP_COMPONENT_OVL_2L0 && next =3D=3D DDP_COMPONENT=
_RDMA0) {
> +               *addr =3D DISP_RDMA0_SEL_IN;
> +               value =3D RDMA0_SEL_IN_OVL0_2L;
> +       } else if (cur =3D=3D DDP_COMPONENT_CCORR && next =3D=3D DDP_COMP=
ONENT_AAL0) {
> +               *addr =3D DISP_AAL0_SEL_IN;
> +               value =3D AAL0_SEL_IN_CCORR0;
> +       } else if (cur =3D=3D DDP_COMPONENT_DITHER && next =3D=3D DDP_COM=
PONENT_DSI0) {
> +               *addr =3D DISP_DSI0_SEL_IN;
> +               value =3D DSI0_SEL_IN_DITHER0;
> +       } else {
> +               value =3D 0;
> +       }
> +
> +       return value;
> +}
> +
> +static void mtk_mmsys_ddp_sout_sel(void __iomem *config_regs,
> +                                  enum mtk_ddp_comp_id cur,
> +                                  enum mtk_ddp_comp_id next)
> +{
> +       if (cur =3D=3D DDP_COMPONENT_RDMA0 && next =3D=3D DDP_COMPONENT_C=
OLOR0) {
> +               writel_relaxed(RDMA0_SOUT_COLOR0, config_regs + DISP_RDMA=
0_SOUT_SEL);
> +       } else if (cur =3D=3D DDP_COMPONENT_CCORR && next =3D=3D DDP_COMP=
ONENT_AAL0) {
> +               writel_relaxed(CCORR0_SOUT_AAL0, config_regs + DISP_CCORR=
0_SOUT_SEL);
> +       }
> +}
> +
> +static unsigned int mtk_mmsys_ovl_mout_en(enum mtk_ddp_comp_id cur,
> +                                         enum mtk_ddp_comp_id next,
> +                                         unsigned int *addr)
> +{
> +       int value =3D -1;
> +
> +       *addr =3D MMSYS_OVL_MOUT_EN;
> +
> +       if (cur =3D=3D DDP_COMPONENT_OVL0 && next =3D=3D DDP_COMPONENT_OV=
L_2L0)
> +               value =3D DISP_OVL0_GO_BG;
> +       else if (cur =3D=3D DDP_COMPONENT_OVL_2L0 && next =3D=3D DDP_COMP=
ONENT_OVL0)
> +               value =3D DISP_OVL0_2L_GO_BG;
> +       else if (cur =3D=3D DDP_COMPONENT_OVL0)
> +               value =3D DISP_OVL0_GO_BLEND;
> +       else if (cur =3D=3D DDP_COMPONENT_OVL_2L0)
> +               value =3D DISP_OVL0_2L_GO_BLEND;
> +       else
> +               value =3D -1;
> +
> +       return value;
> +}

I think you should squash mtk_mmsys_ovl_mout_en() with mtk_mmsys_ddp_mout_e=
n().

Regards,
Chun-Kuang.

> +
> +struct mtk_mmsys_conn_funcs mt8192_mmsys_funcs =3D {
> +       .mout_en =3D mtk_mmsys_ddp_mout_en,
> +       .ovl_mout_en =3D mtk_mmsys_ovl_mout_en,
> +       .sel_in =3D mtk_mmsys_ddp_sel_in,
> +       .sout_sel =3D mtk_mmsys_ddp_sout_sel,
> +};
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index 220203d..efa07b9 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -62,6 +62,7 @@ struct mtk_mmsys_conn_funcs {
>
>  extern struct mtk_mmsys_conn_funcs mt2701_mmsys_funcs;
>  extern struct mtk_mmsys_conn_funcs mt8183_mmsys_funcs;
> +extern struct mtk_mmsys_conn_funcs mt8192_mmsys_funcs;
>
>  void mtk_mmsys_ddp_connect(struct device *dev,
>                            enum mtk_ddp_comp_id cur,
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
