Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1A62D5FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391882AbgLJPhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:37:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391093AbgLJPhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:37:22 -0500
X-Gm-Message-State: AOAM531k2S5AXD1XS10FCH7ab8YBNLEkcTRDHlS+doXheDw1Yg/DgW2E
        kAjvzuwTCtz/C8c2VE6EpAYHwifvhi/lgyz51Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607614602;
        bh=gfjKDkgsUzlSXkLKgAEbUS/Mv1PVZmFwSXCS39LAV6E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RPP7Y3MYJM2iQesQl1tK8TgtLyQQ6J9Ev+RMitEYdSKe8iLqjuQnttGueriC7nRs1
         yuACw7ty0/BdVxriEJmAeQZxm712jHoB5tYWv/KSHXEv4rcE49/Ht5N3Kt5rg9yVz7
         Nxn8EgiIObUWH6Dyk5R1pJ7yMf2qsJaPF5h6B9dVEKMCMzMNoAO8DBVxlKy0g7YzWT
         KIozGCXi7YygbAmetK3gVGRuJo30f8EGOVUKqY4HcNLb2pKVBDYTiw3AuhW3hT9egn
         7l620dqQkOgWD1ZQmafHhDQCJzMM9KW/3/7kX4xnuBV9Oq99W71s5inSsJy3mfEWAb
         mB7F5FWrPmGaQ==
X-Google-Smtp-Source: ABdhPJxSRwBGAkP+9mfLM02WdsbbFX5lBks02URQV937lg/PC5OBCOeM7kRWkYp0bnV7bJe0ZjiglASvX2KGwpziqho=
X-Received: by 2002:a50:c3c5:: with SMTP id i5mr7382571edf.166.1607614600133;
 Thu, 10 Dec 2020 07:36:40 -0800 (PST)
MIME-Version: 1.0
References: <1607591262-21736-1-git-send-email-yongqiang.niu@mediatek.com> <1607591262-21736-3-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607591262-21736-3-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 10 Dec 2020 23:36:29 +0800
X-Gmail-Original-Message-ID: <CAAOTY_90gcnGFiV2uZ-y2TrQYSowhvoM5k36+0zG6+tG9bj3Mw@mail.gmail.com>
Message-ID: <CAAOTY_90gcnGFiV2uZ-y2TrQYSowhvoM5k36+0zG6+tG9bj3Mw@mail.gmail.com>
Subject: Re: [PATCH v8, 2/6] dt-bindings: mediatek: add description for mt8183 display
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
=8810=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:22=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add description for mt8183 display

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
> index 64c64ee..5ca693a 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> @@ -43,7 +43,7 @@ Required properties (all function blocks):
>         "mediatek,<chip>-dpi"                   - DPI controller, see med=
iatek,dpi.txt
>         "mediatek,<chip>-disp-mutex"            - display mutex
>         "mediatek,<chip>-disp-od"               - overdrive
> -  the supported chips are mt2701, mt7623, mt2712 and mt8173.
> +  the supported chips are mt2701, mt7623, mt2712, mt8173 and mt8183.
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
