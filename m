Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBB32F24BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391624AbhALAZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404206AbhAKXvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:51:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66F9922D2C;
        Mon, 11 Jan 2021 23:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610409021;
        bh=7YRMvE845hC7SAVXz/U/NF9WxBp7q4L/HB0jlWcqqVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lrzp2zbK7APcbmjCCCv0vJu/ty5To01Fq6cbVVmMwxYiiv2J2JwFrIfphZetDHv3/
         pxoAVneTZnJX7oghB1xRLmSFyup0O/+Jy020Ov3u7psjAxu7mzIl73WpRvmR053r+u
         7csdeeuUyBxtANKtSjtf7hd7TnOL4sXEebmM1Ktk97XAxIoKYZ+0Nf+mHzsTAbiuoR
         GHfHFoP2Y8cj3RMDVwbanwcg1gMxn3AP1SjCVvMFmbyiRjlJOKUB8RScGwfkz9vzWu
         JYQknH1DyE1VTzeYkxdil6aTTgV2dbBra9atRqx+TmSMb5IWImmkMQLLz0UiGbGbKa
         Ovx5cxzbSllpQ==
Received: by mail-ej1-f49.google.com with SMTP id lt17so919837ejb.3;
        Mon, 11 Jan 2021 15:50:21 -0800 (PST)
X-Gm-Message-State: AOAM533Lqw0/Q90kl7D+5I6ROH5vEcf5lDx7TJaZ3t7MYbcXZaPoUtN9
        r1sSg+PSYSsCvRC+65IFih1fuYdszx2O7py0Og==
X-Google-Smtp-Source: ABdhPJxVy9VDMMYfYRVMs9afxI0l5RRiNtKc2yMSb9lG3FiW9P61v7cZ+yR5sHJHLZMW2E0QIlo4LzB1ZzkCSbrrWtg=
X-Received: by 2002:a17:907:2108:: with SMTP id qn8mr1236249ejb.127.1610409019978;
 Mon, 11 Jan 2021 15:50:19 -0800 (PST)
MIME-Version: 1.0
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com> <1610351031-21133-7-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1610351031-21133-7-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 12 Jan 2021 07:50:09 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8CaUr-zZXoBsQTXvxeO88WhHm0neg5RuDR1KG6NsaWwA@mail.gmail.com>
Message-ID: <CAAOTY_8CaUr-zZXoBsQTXvxeO88WhHm0neg5RuDR1KG6NsaWwA@mail.gmail.com>
Subject: Re: [PATCH v3, 06/15] drm/mediatek: add component RDMA4
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
> This patch add component RDMA4

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index bc6b10a..fc01fea 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -392,6 +392,7 @@ struct mtk_ddp_comp_match {
>         [DDP_COMPONENT_RDMA0]   =3D { MTK_DISP_RDMA,      0, NULL },
>         [DDP_COMPONENT_RDMA1]   =3D { MTK_DISP_RDMA,      1, NULL },
>         [DDP_COMPONENT_RDMA2]   =3D { MTK_DISP_RDMA,      2, NULL },
> +       [DDP_COMPONENT_RDMA4]   =3D { MTK_DISP_RDMA,      4, NULL },
>         [DDP_COMPONENT_UFOE]    =3D { MTK_DISP_UFOE,      0, &ddp_ufoe },
>         [DDP_COMPONENT_WDMA0]   =3D { MTK_DISP_WDMA,      0, NULL },
>         [DDP_COMPONENT_WDMA1]   =3D { MTK_DISP_WDMA,      1, NULL },
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
