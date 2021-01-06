Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC702EC14D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbhAFQhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbhAFQhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:37:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 578AE23134;
        Wed,  6 Jan 2021 16:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609951010;
        bh=ai320C/i8fqJR2sej6eOOTuLgqLIteCxyyp08G8iKLk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jbUqG0STBL4wVLlsfQTALXYXJLuhmER2HsgqTBkeQacSjcnS360EdBqsbig9QmMOr
         j2ezkVc7ya1kR+yeEJee3xDR3zTy7ilsNNAaWk3g0/lnFPuiR4n5kkPyYE/ixQTuwC
         HYEXyujAIu7XSd2xyITShU3yCPq3GT+eLDbyhp83asf9TctQgEtZqfVRRqfD6nJXKZ
         Sdawbs0ALAJKBZBcv0MVKRrjocW89DCVeADYZv7EzXLX+enktbjflxPLpeaUitPY1w
         41sq5Nzs3oQKN3Zk6dxZzgsxR8cb//x9kNVQA0TWjeycKGPJlEGJWVDHKjaGkXRksj
         k3m8aCmd54EqQ==
Received: by mail-ed1-f50.google.com with SMTP id cw27so4959956edb.5;
        Wed, 06 Jan 2021 08:36:50 -0800 (PST)
X-Gm-Message-State: AOAM531IU3+XAYrjeWVt3SUvtp91TC2JnJKFV+rrWG74KQFeGhJsSiUd
        G2MWKIDDC7WXoi1lP9b539xQ3SJ3GzwsagoGfg==
X-Google-Smtp-Source: ABdhPJzpUH6QdUBnvH2TcKustKPrfyYDr3r4JSutkE3V/dcxPu5UI4vmqh7oVVbk6+uNnml1r9fC6o6DyHP5x8UDeYk=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr4471752edw.303.1609951008829;
 Wed, 06 Jan 2021 08:36:48 -0800 (PST)
MIME-Version: 1.0
References: <1609815993-22744-1-git-send-email-yongqiang.niu@mediatek.com> <1609815993-22744-11-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1609815993-22744-11-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 7 Jan 2021 00:36:33 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9=wj=u6u+yMCxMgxQ+_g0E3NGeghsRMPavcE2kcEympQ@mail.gmail.com>
Message-ID: <CAAOTY_9=wj=u6u+yMCxMgxQ+_g0E3NGeghsRMPavcE2kcEympQ@mail.gmail.com>
Subject: Re: [PATCH v4, 10/10] soc: mediatek: mmsys: add mt8192 mmsys support
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

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=885=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8811:17=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add mt8192 mmsys support
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/soc/mediatek/mmsys/Makefile       |   1 +
>  drivers/soc/mediatek/mmsys/mt8192-mmsys.c | 149 ++++++++++++++++++++++++=
++++++
>  drivers/soc/mediatek/mmsys/mtk-mmsys.c    |   9 ++
>  include/linux/soc/mediatek/mtk-mmsys.h    |   1 +
>  4 files changed, 160 insertions(+)
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
> index 0000000..2e350d1
> --- /dev/null
> +++ b/drivers/soc/mediatek/mmsys/mt8192-mmsys.c
> @@ -0,0 +1,149 @@
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
> +static void mtk_mmsys_ddp_mout_en(void __iomem *config_regs,
> +                                 enum mtk_ddp_comp_id cur,
> +                                 enum mtk_ddp_comp_id next,
> +                                 bool enable)
> +{
> +       unsigned int addr, value, reg;
> +
> +       if (cur =3D=3D DDP_COMPONENT_OVL_2L0 && next =3D=3D DDP_COMPONENT=
_RDMA0) {
> +               addr =3D DISP_OVL0_2L_MOUT_EN;
> +               value =3D OVL0_MOUT_EN_DISP_RDMA0;
> +       } else if (cur =3D=3D DDP_COMPONENT_OVL_2L2 && next =3D=3D DDP_CO=
MPONENT_RDMA4) {
> +               addr =3D DISP_OVL2_2L_MOUT_EN;
> +               value =3D OVL2_2L_MOUT_RDMA4;
> +       } else if (cur =3D=3D DDP_COMPONENT_DITHER && next =3D=3D DDP_COM=
PONENT_DSI0) {
> +               addr =3D DISP_DITHER0_MOUT_EN;
> +               value =3D DITHER0_MOUT_DSI0;
> +       } else {
> +               value =3D 0;
> +       }
> +
> +       if (value) {
> +               reg =3D readl_relaxed(config_regs + addr);
> +
> +               if (enable)
> +                       reg |=3D value;
> +               else
> +                       reg &=3D ~value;
> +
> +               writel_relaxed(reg, config_regs + addr);
> +       }
> +}
> +
> +static void mtk_mmsys_ddp_sel_in(void __iomem *config_regs,
> +                                enum mtk_ddp_comp_id cur,
> +                                enum mtk_ddp_comp_id next,
> +                                bool enable)
> +{
> +       unsigned int addr, value, reg;
> +
> +       if (cur =3D=3D DDP_COMPONENT_OVL_2L0 && next =3D=3D DDP_COMPONENT=
_RDMA0) {
> +               addr =3D DISP_RDMA0_SEL_IN;
> +               value =3D RDMA0_SEL_IN_OVL0_2L;
> +       } else if (cur =3D=3D DDP_COMPONENT_CCORR && next =3D=3D DDP_COMP=
ONENT_AAL0) {
> +               addr =3D DISP_AAL0_SEL_IN;
> +               value =3D AAL0_SEL_IN_CCORR0;
> +       } else if (cur =3D=3D DDP_COMPONENT_DITHER && next =3D=3D DDP_COM=
PONENT_DSI0) {
> +               addr =3D DISP_DSI0_SEL_IN;
> +               value =3D DSI0_SEL_IN_DITHER0;
> +       } else {
> +               value =3D 0;
> +       }
> +
> +       if (value) {
> +               reg =3D readl_relaxed(config_regs + addr);
> +
> +               if (enable)
> +                       reg |=3D value;
> +               else
> +                       reg &=3D ~value;
> +
> +               writel_relaxed(reg, config_regs + addr);
> +       }
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
> +static void mtk_mmsys_ovl_mout_en(void __iomem *config_regs,
> +                                 enum mtk_ddp_comp_id cur,
> +                                 enum mtk_ddp_comp_id next,
> +                                 bool enable)
> +{
> +       unsigned int addr, value, reg;
> +
> +       addr =3D MMSYS_OVL_MOUT_EN;
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
> +               value =3D 0;
> +
> +       if (value) {
> +               reg =3D readl_relaxed(config_regs + addr);
> +
> +               if (enable)
> +                       reg |=3D value;
> +               else
> +                       reg &=3D ~value;
> +
> +               writel_relaxed(reg, config_regs + addr);
> +       }

I think you could squash mtk_mmsys_ovl_mout_en() into
mtk_mmsys_ddp_mout_en() and directly read/write register in if-else
statement.

Regards,
Chun-Kuang.

> +}
> +
> +struct mtk_mmsys_conn_funcs mt8192_mmsys_funcs =3D {
> +       .mout_en =3D mtk_mmsys_ddp_mout_en,
> +       .ovl_mout_en =3D mtk_mmsys_ovl_mout_en,
> +       .sel_in =3D mtk_mmsys_ddp_sel_in,
> +       .sout_sel =3D mtk_mmsys_ddp_sout_sel,
> +};
> diff --git a/drivers/soc/mediatek/mmsys/mtk-mmsys.c b/drivers/soc/mediate=
k/mmsys/mtk-mmsys.c
> index 34728ed..2c72607 100644
> --- a/drivers/soc/mediatek/mmsys/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mmsys/mtk-mmsys.c
> @@ -50,6 +50,11 @@ struct mtk_mmsys {
>         .funcs =3D &mt8183_mmsys_funcs,
>  };
>
> +static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data =3D {
> +       .clk_driver =3D "clk-mt8192-mm",
> +       .funcs =3D &mt8192_mmsys_funcs,
> +};
> +
>  void mtk_mmsys_ddp_connect(struct device *dev,
>                            enum mtk_ddp_comp_id cur,
>                            enum mtk_ddp_comp_id next)
> @@ -157,6 +162,10 @@ static int mtk_mmsys_probe(struct platform_device *p=
dev)
>                 .compatible =3D "mediatek,mt8183-mmsys",
>                 .data =3D &mt8183_mmsys_driver_data,
>         },
> +       {
> +               .compatible =3D "mediatek,mt8192-mmsys",
> +               .data =3D &mt8192_mmsys_driver_data,
> +       },
>         { }
>  };
>
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index 19318d2..eeec96a 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -65,6 +65,7 @@ struct mtk_mmsys_conn_funcs {
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
