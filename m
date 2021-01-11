Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7B2F24C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405121AbhALAZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404218AbhALAAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:00:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECF3B22D49;
        Mon, 11 Jan 2021 23:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610409599;
        bh=S7y++HNlfNSNt0z4hKXdDcHN7UOBqQprNlJ3aTrtBYQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HiEvwXA9IroMbrlXh21jp1S6SSV5cJVAv5JBbdYAC0J/v9aYUHcpGAN4kNXLIkpbH
         VNycfN43tf06eRJc9uEXH005Degd9TEXsuYcw4BgAgx5jcd5kimfaSH8hJGC0pd2Rg
         bH9aUEuYO25srMpMsa+x1RYbgPfKAHoHjxhkFNLp0fvceYv2qqYEZul+ZrynvrGO5N
         iXYbeQL2ir8N6zlGoZO8A0eke6L1NsfJiXYELNcL8lGh/esLkO3imBgr/5Ro4Rrrbx
         NPVXKTy+8p/KLyv9Hn8Am30PzYImkTnzjPkIegI1cRXuwzCJh+Iun+1/mH/1AEmV8f
         4Qq0DxucXbkKA==
Received: by mail-ej1-f43.google.com with SMTP id jx16so882152ejb.10;
        Mon, 11 Jan 2021 15:59:58 -0800 (PST)
X-Gm-Message-State: AOAM530BRnikVA5Y79WEOxaVF4enzmD1vSL8BEgQ+Ogx1Em5UFOsEP2f
        TdMflRAc70sKbfyW5b9yOs85pojdum+KbI8dDA==
X-Google-Smtp-Source: ABdhPJxUeXqwm6w53tZVM99kGi6AORPcbUrwUwsYACUNteu6ZKUg3hrzvr3AzddjV19UEYCrp6RdUGZBIAssahFIByc=
X-Received: by 2002:a17:906:ae4e:: with SMTP id lf14mr1336071ejb.310.1610409597420;
 Mon, 11 Jan 2021 15:59:57 -0800 (PST)
MIME-Version: 1.0
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com> <1610351031-21133-8-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1610351031-21133-8-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 12 Jan 2021 07:59:46 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9_LN8nYSmg42gpR5dLqTe+ABt61WzM8S5cp2D6-rWKyw@mail.gmail.com>
Message-ID: <CAAOTY_9_LN8nYSmg42gpR5dLqTe+ABt61WzM8S5cp2D6-rWKyw@mail.gmail.com>
Subject: Re: [PATCH v3, 07/15] drm/mediatek: enable OVL_LAYER_SMI_ID_EN for
 multi-layer usecase
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
=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:44=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> enable OVL_LAYER_SMI_ID_EN for multi-layer usecase

Could you describe more information? Without this patch, what would happen?

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index b47c238..4934bee 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -23,6 +23,7 @@
>  #define DISP_REG_OVL_RST                       0x0014
>  #define DISP_REG_OVL_ROI_SIZE                  0x0020
>  #define DISP_REG_OVL_DATAPATH_CON              0x0024
> +#define OVL_LAYER_SMI_ID_EN                            BIT(0)
>  #define OVL_BGCLR_SEL_IN                               BIT(2)
>  #define DISP_REG_OVL_ROI_BGCLR                 0x0028
>  #define DISP_REG_OVL_SRC_CON                   0x002c
> @@ -61,6 +62,7 @@ struct mtk_disp_ovl_data {
>         unsigned int gmc_bits;
>         unsigned int layer_nr;
>         bool fmt_rgb565_is_0;
> +       bool smi_id_en;
>  };
>
>  /**
> @@ -116,7 +118,17 @@ static void mtk_ovl_disable_vblank(struct mtk_ddp_co=
mp *comp)
>
>  static void mtk_ovl_start(struct mtk_ddp_comp *comp)
>  {
> +       struct mtk_disp_ovl *ovl =3D comp_to_ovl(comp);
> +
>         writel_relaxed(0x1, comp->regs + DISP_REG_OVL_EN);
> +
> +       if(ovl->data->smi_id_en) {
> +               unsigned int reg;
> +
> +               reg =3D readl(comp->regs + DISP_REG_OVL_DATAPATH_CON);
> +               reg =3D reg | OVL_LAYER_SMI_ID_EN;
> +               writel_relaxed(reg, comp->regs + DISP_REG_OVL_DATAPATH_CO=
N);

I think this setting should before write 1 to DISP_REG_OVL_EN.

> +       }
>  }
>
>  static void mtk_ovl_stop(struct mtk_ddp_comp *comp)

Should clear DISP_REG_OVL_DATAPATH_CON when stop?

Regards,
Chun-Kuang.

> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
