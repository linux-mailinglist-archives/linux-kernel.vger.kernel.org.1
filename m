Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6DD2ECDA9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbhAGKS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:18:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbhAGKS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:18:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFE2923341;
        Thu,  7 Jan 2021 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610014668;
        bh=6sb108ac5UVxYYGp+wjKpmn1DM3i6z83ytBYRl9cEg0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hH6B8lh70ZD1mRAhDD95qQrPQi2eJCkyxPUKdRaHXGFWvk5kWwkOpr8JGcMmr4J9g
         tu2A3ECZvMyoWTbpWGwp5BHqUdchbi6Q8GBZRvQ+0trW3ZhHIs1eYG4zlYmkXC5KeE
         I344mDb8l3ZW5ICrBovpiJY73YrVHCsP9U4pmfCyvSS6uI3S3mgYxOphgWLsTeu4+d
         CM42hJyJ7xFqID70fcHXWW4UYMb3L5Xqwq2aiQgj91ICb0b+4oYHRXa178czbrZy99
         RIXe8jg0ozfDjyn/YJtnFll+VCC8dHpma9ZlgM0xLu4JMBp+meDvvoawSCOZQb4Ypa
         1/yiKd1F/Q0ag==
Received: by mail-ed1-f45.google.com with SMTP id c7so7227855edv.6;
        Thu, 07 Jan 2021 02:17:47 -0800 (PST)
X-Gm-Message-State: AOAM533wcOX5i1xP2motWBCUpiANf/gO5tuhWOKVeUtpCDe7qD0Fttqk
        ycS3tY8+WgNhNcdgQbDlx5U9wyR6FCP/RT1avQ==
X-Google-Smtp-Source: ABdhPJwFY76DPb4xZJOUEweB/1qZGG9xebnYuDZQduz4K7shnS7SUrqlKleXXx7W6MP7D9rlLuURfDRF0VERLMbkyZY=
X-Received: by 2002:a50:c3c5:: with SMTP id i5mr1159187edf.166.1610014666156;
 Thu, 07 Jan 2021 02:17:46 -0800 (PST)
MIME-Version: 1.0
References: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com> <1609989081-29353-3-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1609989081-29353-3-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 7 Jan 2021 18:17:34 +0800
X-Gmail-Original-Message-ID: <CAAOTY_85Ks5pa244K_G2Lp-XwmMFvK74X6M4vdM-M5Et_9Y9sQ@mail.gmail.com>
Message-ID: <CAAOTY_85Ks5pa244K_G2Lp-XwmMFvK74X6M4vdM-M5Et_9Y9sQ@mail.gmail.com>
Subject: Re: [PATCH v9, 02/11] dt-bindings: mediatek: add description for
 mt8183 display
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
=887=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:11=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add description for mt8183 display

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 2=
 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp=
.txt
> index b07881e..c562cda 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> @@ -43,7 +43,7 @@ Required properties (all function blocks):
>         "mediatek,<chip>-dpi"                   - DPI controller, see med=
iatek,dpi.txt
>         "mediatek,<chip>-disp-mutex"            - display mutex
>         "mediatek,<chip>-disp-od"               - overdrive
> -  the supported chips are mt2701, mt7623, mt2712, mt8167 and mt8173.
> +  the supported chips are mt2701, mt7623, mt2712, mt8167, mt8173 and mt8=
183.
>  - reg: Physical base address and length of the function block register s=
pace
>  - interrupts: The interrupt signal from the function block (required, ex=
cept for
>    merge and split function blocks).
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
