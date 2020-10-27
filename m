Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E49D29CD16
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 02:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgJ1Bj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 21:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1833046AbgJ0Xit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 19:38:49 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 248EC22275;
        Tue, 27 Oct 2020 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603841928;
        bh=DSTkC5KLEySxuOgJIXhx4r8CGCV8SZykJdCrHvPLS3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kVq2WnrlZADRQR5lW2fEQA21p3jZ4zfdjjAewDx6TaV11LG1oJ1UBLd6ycgO9v/Y7
         GmvgcWm1gVVG1cvRVNvA9ytm/DHZZ+gssbXRPpgN/a91D144X8OIzC6BBivcYgW7QY
         gaAxCZyBMIPPo0IZ6HTclLnL9Pid/dFsSg1o9vF8=
Received: by mail-ej1-f44.google.com with SMTP id h24so4632641ejg.9;
        Tue, 27 Oct 2020 16:38:48 -0700 (PDT)
X-Gm-Message-State: AOAM533UxMwT+NhvoXcPRGLLY4JJz1U+F0I3K3Sb6oJObg1++rIY3BJe
        +IFYrVFswI95Krh5QQ8bHmhOqHCO210h93xTSw==
X-Google-Smtp-Source: ABdhPJzQlEglkYa6D7ubjNdMCkkeNzxjD0WQcilxpNfNSAd06/sNj6pyDK/JItntgOHe0L6l5haqvTeZePZHZvUPb9w=
X-Received: by 2002:a17:906:3b8e:: with SMTP id u14mr4751527ejf.127.1603841926757;
 Tue, 27 Oct 2020 16:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201027160631.608503-1-fparent@baylibre.com>
In-Reply-To: <20201027160631.608503-1-fparent@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 28 Oct 2020 07:38:35 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9eBU06WGKcB61OzXYOgOOQY+45MQba9ELAZAi7rDGj6A@mail.gmail.com>
Message-ID: <CAAOTY_9eBU06WGKcB61OzXYOgOOQY+45MQba9ELAZAi7rDGj6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: mmsys: add mt1867 binding
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fabien:

Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:07=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add binding documentation for MT8167 SoC.
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>


> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsy=
s.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> index d8c9108c3b4a..78c50733985c 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> @@ -13,6 +13,7 @@ Required Properties:
>         - "mediatek,mt6779-mmsys", "syscon"
>         - "mediatek,mt6797-mmsys", "syscon"
>         - "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys", "syscon"
> +       - "mediatek,mt8167-mmsys", "syscon"
>         - "mediatek,mt8173-mmsys", "syscon"
>         - "mediatek,mt8183-mmsys", "syscon"
>  - #clock-cells: Must be 1
> --
> 2.28.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
