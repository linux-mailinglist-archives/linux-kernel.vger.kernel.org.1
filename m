Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB152DC2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgLPPLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgLPPLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:11:50 -0500
X-Gm-Message-State: AOAM5335Yn7BBxuAdGP5ljlcsdO8QrCdM2b0/TqqwbHYPD8t2h+GaUZb
        SNBMF15s/EnakevHp/vXCdpfzaWaLC2XP8CMwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608131469;
        bh=qJnz4jINEHnwylSMSs8ygzcSuobmntS82hFNu7/S1oQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lRAsTNDWesqlzQ3DfHEKOK3sUEih3R8sZvgqKu7FOxscR2Jx2o64DlAWsbq5aOfPs
         L/+MntDsLzLCCDpILOstBBLRMb061S5uGGRj1DM4HAXGtO2W8YYjN43oWvKR77qeSg
         MNsoGkyZOHXa+SJtpvYX2kJAqkdZh+G6x7z/V/PZaGr/U5pDDY/6s8Vzq52gVAv8Op
         NSiBaxK3AQKLvK5wc6xNwdNWW5tDbPLKIxvHwb1WwEvNUPv4Wm5bU609c4aYdqnJ5A
         6lYHM1a2YCCahcw8rHFeKVsYCj75XkJSHfpaJTy+R5RO+Z/sY/Rwc/1xIbUMzWQTOK
         O4UFAPVEjkZvg==
X-Google-Smtp-Source: ABdhPJwS/YraW4qyb0Dm3f675N42jAY1oC2Y8j8EzHOplVWPvcJ8f3cI6/ZgJvdjQ83rFs2emQdjBQ/MA4j9o6AQcBc=
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr3796965wmg.145.1608131467393;
 Wed, 16 Dec 2020 07:11:07 -0800 (PST)
MIME-Version: 1.0
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com> <1607746317-4696-11-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607746317-4696-11-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 16 Dec 2020 23:10:53 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9JNdL-huHYKq=W5gRMUHVRWeUzDunNa7q_d7DPp4P2pg@mail.gmail.com>
Message-ID: <CAAOTY_9JNdL-huHYKq=W5gRMUHVRWeUzDunNa7q_d7DPp4P2pg@mail.gmail.com>
Subject: Re: [PATCH v2, 10/17] drm/mediatek: fix aal size config
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
> fix aal size config
>
> Fixes: 0664d1392c26 (drm/mediatek: Add AAL engine basic function)
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index be61d11..e7d481e0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -33,8 +33,13 @@
>  #define DISP_REG_UFO_START                     0x0000
>
>  #define DISP_AAL_EN                            0x0000
> +#define DISP_AAL_CFG                           0x0020
> +#define AAL_RELAY_MODE                                 BIT(0)
> +#define AAL_ENGINE_EN                                  BIT(1)
>  #define DISP_AAL_SIZE                          0x0030
>
> +#define DISP_AAL_OUTPUT_SIZE                   0x04d8
> +
>  #define DISP_CCORR_EN                          0x0000
>  #define CCORR_EN                               BIT(0)
>  #define DISP_CCORR_CFG                         0x0020
> @@ -184,7 +189,11 @@ static void mtk_aal_config(struct mtk_ddp_comp *comp=
, unsigned int w,
>                            unsigned int h, unsigned int vrefresh,
>                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
>  {
> -       mtk_ddp_write(cmdq_pkt, h << 16 | w, comp, DISP_AAL_SIZE);
> +       mtk_ddp_write(cmdq_pkt, w << 16 | h, comp, DISP_AAL_SIZE);
> +       mtk_ddp_write(cmdq_pkt, w << 16 | h, comp, DISP_AAL_OUTPUT_SIZE);
> +
> +       mtk_ddp_write_mask(NULL, AAL_RELAY_MODE, comp, DISP_AAL_CFG,

cmdq_pkt

> +                          AAL_RELAY_MODE | AAL_ENGINE_EN);

This patch is to fix size config, so move this statement to another patch.

Regards,
Chun-Kuang.

>  }
>
>  static void mtk_aal_start(struct mtk_ddp_comp *comp)
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
