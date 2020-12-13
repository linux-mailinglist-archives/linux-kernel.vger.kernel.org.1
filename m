Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485412D8E76
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 16:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392235AbgLMP7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 10:59:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbgLMP7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:59:12 -0500
X-Gm-Message-State: AOAM533lAUJlq1RylAguuMFUGbjov9HABwrgxuNf+kHhhjtC94Y5vS82
        0vIu91tf9a02jmbmBE2CN9Xg2fN7EtsWpRrMtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607875112;
        bh=TUEXd1NufKhBjH3w0YLBQgI4G4nF26Jpf12BZg2DdkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vJRnrzs7P6heS4pWkFfwEyWeiYDaKgI8pRS8Vf5gSRcEtXB5EwUnu+gviqkUk2kx8
         UJtwlNtQFpdWCpJJ4Q3u99L6dtww4ZH8/QzHtnR4TT/9kBlGAdZibwxZquibbdFPsS
         JGPg4q+sP/2ZD4BbS7ZoMFGDLMxOIH2Z2yJs/3Jx0XM8fVZ523kAmK2y/BRM8MRbkh
         oVcZLY0MU6VthHzq/YwAAnRAEfeoyBmjEQbReRd3FxlEhBVGXJRShrQfO3VIw4VWUQ
         vlais4qeT+kLJAkJBZOomUre3HjGXg7d/q5yBUmmKzbjIunjf3i/EbN4EMXzfQNWVv
         ps7CcvvE3qjjA==
X-Google-Smtp-Source: ABdhPJzQ7X5J5ZOuZiSIqmWQH6RPNRgCbzq8nEgfd2GgED4aXNSwfqseLuR73PpirrPAI1Pa+7yPj6L3B8AH6G4uL4U=
X-Received: by 2002:aa7:dbca:: with SMTP id v10mr5100096edt.219.1607875110439;
 Sun, 13 Dec 2020 07:58:30 -0800 (PST)
MIME-Version: 1.0
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com> <1607746317-4696-4-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607746317-4696-4-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 13 Dec 2020 23:58:18 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9p0J0uMRu1gzkgCzj3uf=1gKPjubAbkx-aYY=rRuc3Pw@mail.gmail.com>
Message-ID: <CAAOTY_9p0J0uMRu1gzkgCzj3uf=1gKPjubAbkx-aYY=rRuc3Pw@mail.gmail.com>
Subject: Re: [PATCH v2, 03/17] dt-bindings: mediatek: add description for
 mt8192 display
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
=8812=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8812:12=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add description for mt8192 display

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 2=
 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp=
.txt
> index dfbec76..b4e62ae 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> @@ -44,7 +44,7 @@ Required properties (all function blocks):
>         "mediatek,<chip>-dpi"                   - DPI controller, see med=
iatek,dpi.txt
>         "mediatek,<chip>-disp-mutex"            - display mutex
>         "mediatek,<chip>-disp-od"               - overdrive
> -  the supported chips are mt2701, mt7623, mt2712, mt8173 and mt8183.
> +  the supported chips are mt2701, mt7623, mt2712, mt8173, mt8183 and mt8=
192.
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
