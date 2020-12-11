Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B19B2D78E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437714AbgLKPOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:14:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406588AbgLKPO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:14:28 -0500
X-Gm-Message-State: AOAM530CqjNllkzk5YOXiN55aHrnHtjJUkWAkA0O2LQOSfQeWqJ0TC0n
        9CWHEceHNd1gwIZshrhMpsfGzAYHg5dDxOXq5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607697390;
        bh=/ZwrZKNlbkblr+ccvxgXpxqqSyaiIIGYtfKF+9mtR0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IiPap5ieh+Vlasayumi0ogQOJya3r1K9GHAyQh8oZnWDIcULjWIhFL7ZaU1upfVbe
         xTMb1UEmC/Ex1lufBhZfLbvXooQAugmRRyzWVTFl3fJkrTDsYNqB8axZd/AeWal8jh
         efrc0sEnkHX8V/be3blWm9M0LUSSnYKH/xCzqih8gWqMzDmc+xglCCJjWiAhl3Zsfh
         giS/lNG0dkujEm6L5MnY5ExHzfljb8XNVrh8+V8SYuMq4Bgo6MJk9uYxvxX1uQf8AM
         j+9On77QdRok6Z/uAyf1dtWYg2C0urcbtLGIkr4jy/IWDbwByS14qRB0PcsUJ+T10C
         4RK7/k13Fnusg==
X-Google-Smtp-Source: ABdhPJyKuTpTCwdxuO84i7E4GBzfPJMWgvofZFgGdvCP9mVCWpdVKYRH24qvd+VGeNPDuTw+bGIIUWWNJDkRiAOg6KA=
X-Received: by 2002:a5d:6443:: with SMTP id d3mr13991510wrw.422.1607697385198;
 Fri, 11 Dec 2020 06:36:25 -0800 (PST)
MIME-Version: 1.0
References: <1607591262-21736-1-git-send-email-yongqiang.niu@mediatek.com> <1607591262-21736-4-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607591262-21736-4-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 11 Dec 2020 22:36:14 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-XScjYX9xPvCQJLY2YKP19Ft2hxi5s6a2A0XCawiR6WQ@mail.gmail.com>
Message-ID: <CAAOTY_-XScjYX9xPvCQJLY2YKP19Ft2hxi5s6a2A0XCawiR6WQ@mail.gmail.com>
Subject: Re: [PATCH v8, 3/6] soc: mediatek: mmsys: add mt8183 function call
 for setting the routing registers
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
> add mt8183 function call for setting the routing registers

I think you should move this patch to the series "soc: mediatek:
Prepare MMSYS for DDP routing using function call" [1]. Without this
patch, that series has no strong reason to separate function call and
create mmsys folder. And this patch would go to soc tree same as that
series, so I think this patch should be moved to that series.

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D3988=
19

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/soc/mediatek/mmsys/Makefile       |  1 +
>  drivers/soc/mediatek/mmsys/mt8183-mmsys.c | 90 +++++++++++++++++++++++++=
++++++
>  drivers/soc/mediatek/mmsys/mtk-mmsys.c    |  1 +
>  include/linux/soc/mediatek/mtk-mmsys.h    |  1 +
>  4 files changed, 93 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mmsys/mt8183-mmsys.c
>
> diff --git a/drivers/soc/mediatek/mmsys/Makefile b/drivers/soc/mediatek/m=
msys/Makefile
> index ac03025..25eeb9e5 100644
> --- a/drivers/soc/mediatek/mmsys/Makefile
> +++ b/drivers/soc/mediatek/mmsys/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_MTK_MMSYS) +=3D mt2701-mmsys.o
> +obj-$(CONFIG_MTK_MMSYS) +=3D mt8183-mmsys.o
>  obj-$(CONFIG_MTK_MMSYS) +=3D mtk-mmsys.o
> diff --git a/drivers/soc/mediatek/mmsys/mt8183-mmsys.c b/drivers/soc/medi=
atek/mmsys/mt8183-mmsys.c
> new file mode 100644
> index 0000000..192b4ab
> --- /dev/null
> +++ b/drivers/soc/mediatek/mmsys/mt8183-mmsys.c
> @@ -0,0 +1,90 @@
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
> +#define DISP_OVL0_MOUT_EN              0xf00
> +#define DISP_OVL0_2L_MOUT_EN           0xf04
> +#define DISP_OVL1_2L_MOUT_EN           0xf08
> +#define DISP_DITHER0_MOUT_EN           0xf0c
> +#define DISP_PATH0_SEL_IN              0xf24
> +#define DISP_DSI0_SEL_IN               0xf2c
> +#define DISP_DPI0_SEL_IN               0xf30
> +#define DISP_RDMA0_SOUT_SEL_IN         0xf50
> +#define DISP_RDMA1_SOUT_SEL_IN         0xf54
> +
> +#define OVL0_MOUT_EN_OVL0_2L                   BIT(4)
> +#define OVL0_2L_MOUT_EN_DISP_PATH0             BIT(0)
> +#define OVL1_2L_MOUT_EN_RDMA1                  BIT(4)
> +#define DITHER0_MOUT_IN_DSI0                   BIT(0)
> +#define DISP_PATH0_SEL_IN_OVL0_2L              0x1
> +#define DSI0_SEL_IN_RDMA0                      0x1
> +#define DSI0_SEL_IN_RDMA1                      0x3
> +#define DPI0_SEL_IN_RDMA0                      0x1
> +#define DPI0_SEL_IN_RDMA1                      0x2
> +#define RDMA0_SOUT_COLOR0                      0x1
> +#define RDMA1_SOUT_DSI0                                0x1
> +
> +static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
> +                                         enum mtk_ddp_comp_id next,
> +                                         unsigned int *addr)
> +{
> +       unsigned int value;
> +
> +       if (cur =3D=3D DDP_COMPONENT_OVL0 && next =3D=3D DDP_COMPONENT_OV=
L_2L0) {
> +               *addr =3D DISP_OVL0_MOUT_EN;
> +               value =3D OVL0_MOUT_EN_OVL0_2L;
> +       } else if (cur =3D=3D DDP_COMPONENT_OVL_2L0 && next =3D=3D DDP_CO=
MPONENT_RDMA0) {
> +               *addr =3D DISP_OVL0_2L_MOUT_EN;
> +               value =3D OVL0_2L_MOUT_EN_DISP_PATH0;
> +       } else if (cur =3D=3D DDP_COMPONENT_OVL_2L1 && next =3D=3D DDP_CO=
MPONENT_RDMA1) {
> +               *addr =3D DISP_OVL1_2L_MOUT_EN;
> +               value =3D OVL1_2L_MOUT_EN_RDMA1;
> +       } else if (cur =3D=3D DDP_COMPONENT_DITHER && next =3D=3D DDP_COM=
PONENT_DSI0) {
> +               *addr =3D DISP_DITHER0_MOUT_EN;
> +               value =3D DITHER0_MOUT_IN_DSI0;
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
> +               *addr =3D DISP_PATH0_SEL_IN;
> +               value =3D DISP_PATH0_SEL_IN_OVL0_2L;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA1 && next =3D=3D DDP_COMP=
ONENT_DPI0) {
> +               *addr =3D DISP_DPI0_SEL_IN;
> +               value =3D DPI0_SEL_IN_RDMA1;
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
0_SOUT_SEL_IN);
> +       }
> +}
> +
> +struct mtk_mmsys_conn_funcs mt8183_mmsys_funcs =3D {
> +       .mout_en =3D mtk_mmsys_ddp_mout_en,
> +       .sel_in =3D mtk_mmsys_ddp_sel_in,
> +       .sout_sel =3D mtk_mmsys_ddp_sout_sel,
> +};
> diff --git a/drivers/soc/mediatek/mmsys/mtk-mmsys.c b/drivers/soc/mediate=
k/mmsys/mtk-mmsys.c
> index 9d6a3e9..63e1a63 100644
> --- a/drivers/soc/mediatek/mmsys/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mmsys/mtk-mmsys.c
> @@ -42,6 +42,7 @@ struct mtk_mmsys_driver_data {
>
>  static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data =3D {
>         .clk_driver =3D "clk-mt8183-mm",
> +       .funcs =3D &mt8183_mmsys_funcs,
>  };
>
>  struct mtk_mmsys {
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index 17e8b91..4b6c514 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -55,6 +55,7 @@ struct mtk_mmsys_conn_funcs {
>  };
>
>  extern struct mtk_mmsys_conn_funcs mt2701_mmsys_funcs;
> +extern struct mtk_mmsys_conn_funcs mt8183_mmsys_funcs;
>
>  void mtk_mmsys_ddp_connect(struct device *dev,
>                            enum mtk_ddp_comp_id cur,
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
