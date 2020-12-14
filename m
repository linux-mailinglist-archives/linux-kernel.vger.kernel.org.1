Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59582DA448
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgLNXls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgLNXlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:41:12 -0500
X-Gm-Message-State: AOAM532T73sOa/tLtZ8RcHUU1nAmTJOXOXSW/6rg4c8auemmWIYLoaST
        iKKnlhSfG+ydiCBzttEsBzKcRqYne/R2kS0uVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607989232;
        bh=lSvX6jnFQqoxIpPBccW/7g9EJN/cgkuyf1nA2W1wiv8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XSQOCR9KRlZI2AHdmt/ukZlEy89IoEm17SJs3lOD0fZiwwAd43Q1ReNJNrxkWj9gr
         8wXhz/am3uKMBcRbdr1lrKQ/1Zf+pLtwkh8TwbLCW8U6op3W87xpjiNg1yyvDCUit2
         TkxSp0wuaQE8Vq8OXCpT/74qRGMrMr8MsDwD3I5px5wT5ncNdVZQDmMHzzIuGPBB/p
         Gsw50I6FiXK/PC9gLUdx0JugG/usVDEiEnYyZQyK3OVJyaYjgq1rP0cmthpnJb+zLf
         tkzZIrMU6U9JLjKuKBK/ptdlAuYRnqx6XwrPMJJDlXbS8WInT9vAYTOCXh8FSM7X5q
         rfNwqP9PsJxFg==
X-Google-Smtp-Source: ABdhPJyMR1hWv0NrAVLxlYf3urPvZsTPggqomRIMAVMLDR99rCR51PGzTsrrsSQzNCxZ8SbUppoaI6FehtXfPLhv9Uw=
X-Received: by 2002:a05:6402:845:: with SMTP id b5mr44289edz.38.1607989230343;
 Mon, 14 Dec 2020 15:40:30 -0800 (PST)
MIME-Version: 1.0
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com> <1607746317-4696-13-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607746317-4696-13-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 15 Dec 2020 07:40:19 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9gzncFEFe8uyhNSO0Mr9SnQ0b5oCC31_4QSdMtwOx0Mw@mail.gmail.com>
Message-ID: <CAAOTY_9gzncFEFe8uyhNSO0Mr9SnQ0b5oCC31_4QSdMtwOx0Mw@mail.gmail.com>
Subject: Re: [PATCH v2, 12/17] drm/mediatek: fix gamma size config
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
=8812=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8812:13=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> fix gamma size config

I would like you to provide more information. The original code works
in mt8173, why do you modify this? The description may be something
like this:

According to data sheet, the width is in bits [31, 16] and height is
in bits [15, 0]. Even though wrong setting may works in some SoC such
as mt8173, but it does not work in mt8192.

Regards,
Chun-Kuang.

>
> Fixes: e0a5d3370245 (drm/mediatek: Add GAMMA engine basic function)
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 00d5687..52b6fc7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -297,7 +297,7 @@ static void mtk_gamma_config(struct mtk_ddp_comp *com=
p, unsigned int w,
>                              unsigned int h, unsigned int vrefresh,
>                              unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
>  {
> -       mtk_ddp_write(cmdq_pkt, h << 16 | w, comp, DISP_GAMMA_SIZE);
> +       mtk_ddp_write(cmdq_pkt, w << 16 | h, comp, DISP_GAMMA_SIZE);
>         mtk_dither_set(comp, bpc, DISP_GAMMA_CFG, cmdq_pkt);
>  }
>
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
