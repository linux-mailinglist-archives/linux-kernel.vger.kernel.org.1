Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFB295543
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 01:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507209AbgJUXkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 19:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507158AbgJUXkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 19:40:18 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D21BC24171;
        Wed, 21 Oct 2020 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603323617;
        bh=60CB1P6lj5vilv39JcGYocCEwfSkX0XlX0Q2dSY3mnY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OQrLTALI6RqWKnh7pzPyUOp9HHoZ280Nw/C7Iw8eOrjJ4XzofJDiEVzqHh6lV+yuv
         R+I/EubKjpWUOLMxjd2SbRyjf9889KdfMFEUoXxOkaSK4iFuMaIdnCvLUQqc3n8Smo
         utwKykVJ20PAqcQ2QcqiWbaGXpBgzXGZYQDYXIe4=
Received: by mail-ej1-f51.google.com with SMTP id a3so5653003ejy.11;
        Wed, 21 Oct 2020 16:40:16 -0700 (PDT)
X-Gm-Message-State: AOAM5317iO1Job3oi+UR6a0XFbLdRQi/TEyk1OUAZh4qpsg67pvxvoeA
        SRde0fj2ej9LUaT2zNEZX99rT7JW9XfrFHPf4A==
X-Google-Smtp-Source: ABdhPJxx6xQUTYR8DUpWL6giPFZWBpFC3XJxcgE4mykKR3QL/7w8AP7UsYeOQzysJO0h74S6Fp4Owl4F/mPKkzzwQJo=
X-Received: by 2002:a17:906:c293:: with SMTP id r19mr5629737ejz.63.1603323615300;
 Wed, 21 Oct 2020 16:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201020174253.3757771-1-fparent@baylibre.com> <20201020174253.3757771-2-fparent@baylibre.com>
In-Reply-To: <20201020174253.3757771-2-fparent@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 22 Oct 2020 07:40:03 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8oFA8ug1QRcK=OyEbFQGRZJioQXtnE=3y6JT+WFCd3bg@mail.gmail.com>
Message-ID: <CAAOTY_8oFA8ug1QRcK=OyEbFQGRZJioQXtnE=3y6JT+WFCd3bg@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: display: mediatek: disp: add
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

Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Add binding documentation for the MT8167 SoC
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp=
.txt
> index 121220745d46..33977e15bebd 100644
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
> +  the supported chips are mt2701, mt7623, mt2712, mt8167 and mt8173.
>  - reg: Physical base address and length of the function block register s=
pace
>  - interrupts: The interrupt signal from the function block (required, ex=
cept for
>    merge and split function blocks).
> @@ -59,7 +59,7 @@ Required properties (DMA function blocks):
>         "mediatek,<chip>-disp-ovl"
>         "mediatek,<chip>-disp-rdma"
>         "mediatek,<chip>-disp-wdma"
> -  the supported chips are mt2701 and mt8173.
> +  the supported chips are mt2701, mt8167 and mt8173.
>  - larb: Should contain a phandle pointing to the local arbiter device as=
 defined
>    in Documentation/devicetree/bindings/memory-controllers/mediatek,smi-l=
arb.txt
>  - iommus: Should point to the respective IOMMU block with master port as
> --
> 2.28.0
>
