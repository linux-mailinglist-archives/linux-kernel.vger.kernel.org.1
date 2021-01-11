Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2B22F24B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405029AbhALAZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404193AbhAKXqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:46:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BDF222D57;
        Mon, 11 Jan 2021 23:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610408733;
        bh=y8VmMFX/CwJMC+FISkp4wyPeCZWTR2wk4gtw3cMWOuI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WMtQVsJHQtrQ2effqQyf1fLeyeLjCq1nK7PvIMKXYaQluEcq7X3sGbjVrp5vG7EaD
         9fpoV5B8h38pUpAFkvCaABVvO9jHkdqiN5RQPS7z63pu9JYHBdbOW70BxquKK11DIj
         7+QJFBw0fMJlbrRSBPf+O5CC4wHpWtkwpKUuGPVuJ/Ta1Ck/UxPZDVSO24iNLK2WP1
         taJR/FPmkFAVmMDjzhwgfTY0b5LwV+zvLZCfnl5DKIW/tqT09Bf03WLWNMjknWqouP
         U4z02X8naqdB5OEp5xuqHm4JB81jva5BLyPRUkV4xbVvT79cwkMovDGakQLbxvUQKR
         lPcBV7fe5eRHA==
Received: by mail-ej1-f44.google.com with SMTP id 6so884446ejz.5;
        Mon, 11 Jan 2021 15:45:33 -0800 (PST)
X-Gm-Message-State: AOAM533RKS3m38Zo/xM0uGx/KNnBcTLplIA4Be89Kpj0bhnetpAAkxnL
        aDOmyUPHetKcNU/L6pOg4aQCvIzN48/wWLoZrQ==
X-Google-Smtp-Source: ABdhPJxCQ7+JqQlCXU4rJnwOHfKTlzTErG573sDackMZHFooxXdVlewp+enT7XUtpEahPvCk4yRAUbKpSdQbplQxJyQ=
X-Received: by 2002:a17:907:d8b:: with SMTP id go11mr1213697ejc.303.1610408731872;
 Mon, 11 Jan 2021 15:45:31 -0800 (PST)
MIME-Version: 1.0
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com> <1610351031-21133-5-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1610351031-21133-5-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 12 Jan 2021 07:45:21 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9LkCs5qsCCBtekr2jqKovZVsC471a4DA_RQ3PRRn4U3w@mail.gmail.com>
Message-ID: <CAAOTY_9LkCs5qsCCBtekr2jqKovZVsC471a4DA_RQ3PRRn4U3w@mail.gmail.com>
Subject: Re: [PATCH v3, 04/15] drm/mediatek: add component OVL_2L2
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
> This patch add component OVL_2L2

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 81ed076..a715127 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -383,6 +383,7 @@ struct mtk_ddp_comp_match {
>         [DDP_COMPONENT_OVL1]    =3D { MTK_DISP_OVL,       1, NULL },
>         [DDP_COMPONENT_OVL_2L0] =3D { MTK_DISP_OVL_2L,    0, NULL },
>         [DDP_COMPONENT_OVL_2L1] =3D { MTK_DISP_OVL_2L,    1, NULL },
> +       [DDP_COMPONENT_OVL_2L2] =3D { MTK_DISP_OVL_2L,    2, NULL },
>         [DDP_COMPONENT_PWM0]    =3D { MTK_DISP_PWM,       0, NULL },
>         [DDP_COMPONENT_PWM1]    =3D { MTK_DISP_PWM,       1, NULL },
>         [DDP_COMPONENT_PWM2]    =3D { MTK_DISP_PWM,       2, NULL },
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
