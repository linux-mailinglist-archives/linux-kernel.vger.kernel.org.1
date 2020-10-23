Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0108A2972D9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463805AbgJWPtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463676AbgJWPtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:49:24 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 956F022254;
        Fri, 23 Oct 2020 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603468163;
        bh=8rC8JAv/ZvbLKMGSVzWGE/gWAOObW9y+163pOgJE734=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eEMMCin3DbmL/T9VnL09w6YGkmRahFquStX7PwBv6i768kDe2YF3dQvTjsN0+lvj3
         DTzXuudR9H6h4tlOKW1CVGnLat2WhIiYUNA3VUmjmx9pJozWLqgTEwNDfEzyOeIFCa
         4fRKMdvUUGILKjzyCLk6xELDl3Kg0IRM7AYuxj0o=
Received: by mail-ej1-f49.google.com with SMTP id o26so3030946ejc.8;
        Fri, 23 Oct 2020 08:49:23 -0700 (PDT)
X-Gm-Message-State: AOAM530/L5kWjhWOWnswmAg3yDw41fjSh9c3dYv84A8PewyqTThHyNQy
        NPpT+HWZFwWGwXPaduohx1AgEb9USVK3+8d4gg==
X-Google-Smtp-Source: ABdhPJw1PDvJSraa+neHMAgIfWWTxOH+reRWWuRSaRPlwJ3vt+DK5mhM/16fgvV4BGg8vj7cvWu44cDBA15ePkriZ84=
X-Received: by 2002:a17:906:9511:: with SMTP id u17mr2597628ejx.194.1603468161912;
 Fri, 23 Oct 2020 08:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201023133130.194140-1-fparent@baylibre.com> <20201023133130.194140-3-fparent@baylibre.com>
In-Reply-To: <20201023133130.194140-3-fparent@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 23 Oct 2020 23:49:11 +0800
X-Gmail-Original-Message-ID: <CAAOTY__5mWnrRJetok2VRhCN9ga9mez55jDVturLNWPYnQAVDg@mail.gmail.com>
Message-ID: <CAAOTY__5mWnrRJetok2VRhCN9ga9mez55jDVturLNWPYnQAVDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: display: mediatek: dsi: add
 documentation for MT8167 SoC
To:     Fabien Parent <fparent@baylibre.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fabien:

Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8823=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:31=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Add binding documentation for the MT8167 SoC.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

In [1], Mediatek DPI binding document has been changed to yaml format,
would you please also change this document to yaml? Ditto for
mediatek,disp.txt.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/2020091707330=
5.25738-1-jitao.shi@mediatek.com/

Regards,
Chun-Kuang.


>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>
> Changelog:
>
> V2: removed part that added a new clock
>
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt     | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t=
xt
> index f06f24d405a5..6a10de812158 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> @@ -7,7 +7,7 @@ channel output.
>
>  Required properties:
>  - compatible: "mediatek,<chip>-dsi"
> -- the supported chips are mt2701, mt7623, mt8173 and mt8183.
> +- the supported chips are mt2701, mt7623, mt8167, mt8173 and mt8183.
>  - reg: Physical base address and length of the controller's registers
>  - interrupts: The interrupt signal from the function block.
>  - clocks: device clocks
> @@ -26,7 +26,7 @@ The MIPI TX configuration module controls the MIPI D-PH=
Y.
>
>  Required properties:
>  - compatible: "mediatek,<chip>-mipi-tx"
> -- the supported chips are mt2701, 7623, mt8173 and mt8183.
> +- the supported chips are mt2701, 7623, mt8167, mt8173 and mt8183.
>  - reg: Physical base address and length of the controller's registers
>  - clocks: PLL reference clock
>  - clock-output-names: name of the output clock line to the DSI encoder
> --
> 2.28.0
>
