Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E562E71D0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 16:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgL2PZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 10:25:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgL2PZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 10:25:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D696F22242;
        Tue, 29 Dec 2020 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609255490;
        bh=eilapBpeoN7sFfsn0ggyc6cG1SRv9g+vbu+jGX2ZpLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZuE4S5P8hITqz1X0escxosAV3o1TcBsgoMQeesxCNTHHQe/plvD7FZCCTDiLIcLPE
         M7e05HXO+CUT6e9Zff8a3+X20r4zbjxf9KiwqenvAwvk33wV6ALdsIms9sLlVdGmXk
         wKIm59mqBicAYE6HeMrLt25t6akFJyCSSC/9/5braxafr3QejL9ZRxfkyeAbczYOEm
         qKKy5AYZLr0MtZmYvZwxrDuOBZTHMj7lnCAcxD9+/QrnlhHgcwBxC4DKfk/WnxUnBy
         L4k732YoW7feYNMHf8FXVjHhUD05rVVwtC5tpm68hyzs1KiJc4wX/zoZe+E40WpW/k
         syBd7vI0wl4Pg==
Received: by mail-wr1-f47.google.com with SMTP id i9so14960866wrc.4;
        Tue, 29 Dec 2020 07:24:49 -0800 (PST)
X-Gm-Message-State: AOAM531ReujgvT47JiX8HA6mi05pn7Kkv6BAFEfRBvpYlgNL9Cb9mK10
        JQHpLnAT02KSONsPcOlEnl5TLa6SXqv8AaCmcw==
X-Google-Smtp-Source: ABdhPJwfw4rYEsYu8nEniPGc6G6JHID1nl4QlJyDYtZF/WHawvurk6lDHUtip9QnXX+NOG2EV9QTm0HD335QYsb/xq8=
X-Received: by 2002:adf:e60f:: with SMTP id p15mr55674939wrm.60.1609255488542;
 Tue, 29 Dec 2020 07:24:48 -0800 (PST)
MIME-Version: 1.0
References: <1609144630-14721-1-git-send-email-yongqiang.niu@mediatek.com> <1609144630-14721-7-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1609144630-14721-7-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 29 Dec 2020 23:24:36 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9ZL9FEMKT_3xARh51hxK6_AbYJHci9ENXDwzCwNGo8Fg@mail.gmail.com>
Message-ID: <CAAOTY_9ZL9FEMKT_3xARh51hxK6_AbYJHci9ENXDwzCwNGo8Fg@mail.gmail.com>
Subject: Re: [PATCH v3, 6/8] soc: mediatek: mmsys: add component RDMA4
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
=8828=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:37=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This patch add component RDMA4

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  include/linux/soc/mediatek/mtk-mmsys.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index 09ee424..aa4f60e 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -38,6 +38,7 @@ enum mtk_ddp_comp_id {
>         DDP_COMPONENT_RDMA0,
>         DDP_COMPONENT_RDMA1,
>         DDP_COMPONENT_RDMA2,
> +       DDP_COMPONENT_RDMA4,
>         DDP_COMPONENT_UFOE,
>         DDP_COMPONENT_WDMA0,
>         DDP_COMPONENT_WDMA1,
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
