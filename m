Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B2D2FA3D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392948AbhARO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:58:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbhARO5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:57:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18BB622CA1;
        Mon, 18 Jan 2021 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610981799;
        bh=Han/yBiP7YCv1DXxaRT5BucStPwaHvat3bP/RRDdIcU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=avLtiyDQmnR9BLa+wtOvaFsMFXNbe1OmFAoxgLQkXH0IEdgaE75ZVyjzlyMov/hQ7
         W2qi1DcjEyu/UvCF3CNjQ+truPkhUjN2RBEExIROxXkqy5XCa0kC1z5Nvw7j5/wCle
         hVEiqpdTgj3qSrL3Nl7umSk+NETXx8QVdf8qIck/dc6q3fk7kOrlOhJ4G/N4/bOzqD
         uZY3Bw3s9+FIJVgFValBTrFZcA+gvjo/O95OBgs7rA9ExusVsBbvwR+vy5CzrLa++q
         JA3gF6hT9ZZ+uKbh+fM+ZskKfu1j+pGh7cvaedstV0rV7zw3fOhJObJILZRmUCAQ1n
         C2UMHnJ7kHpTA==
Received: by mail-ej1-f41.google.com with SMTP id 6so24082386ejz.5;
        Mon, 18 Jan 2021 06:56:39 -0800 (PST)
X-Gm-Message-State: AOAM5330uGqGn3ZFF5AuVUY1IylC6/88GEYLrl8P3zVD+EffpZ5Lm3kv
        vvyaUjFbo1mfA0YO5cfOk9f8wpyOhQA8d//9bg==
X-Google-Smtp-Source: ABdhPJzQmiS9/MsRXPQe1QLclHpEy2erv8VURiXmHTwJ59O6sI9r4nQ58rZnC7a+vUSVQmEFf565IppWMasuz6EtwSo=
X-Received: by 2002:a17:906:35c9:: with SMTP id p9mr77562ejb.310.1610981797653;
 Mon, 18 Jan 2021 06:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com> <20210116090656.11752-3-chunfeng.yun@mediatek.com>
In-Reply-To: <20210116090656.11752-3-chunfeng.yun@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 18 Jan 2021 22:56:25 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8FV87MTSi_Mc2MA3uWzCUBcpCC5Sne2Wc6X1R57EiCkw@mail.gmail.com>
Message-ID: <CAAOTY_8FV87MTSi_Mc2MA3uWzCUBcpCC5Sne2Wc6X1R57EiCkw@mail.gmail.com>
Subject: Re: [PATCH next 03/15] dt-bindings: phy: mediatek: dsi-phy: modify
 compatible dependence
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chunfeng:

Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=881=
6=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=885:07=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> The compatilbe "mediatek,mt7623-mipi-tx" is not supported in driver,
> and in fact uses "mediatek,mt2701-mipi-tx" instead on MT7623, so changes
> the compatible items to make dependence clear.
>
> And add an optional "clock-names" property, it's not used to get the cloc=
k,
> but some DTS files provide it.

Separate the clock part to another patch.

Regards,
Chun-Kuang.

>
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../bindings/phy/mediatek,dsi-phy.yaml          | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml =
b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> index 71d4acea1f66..af6e554c5b69 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> @@ -19,11 +19,14 @@ properties:
>      pattern: "^dsi-phy@[0-9a-f]+$"
>
>    compatible:
> -    enum:
> -      - mediatek,mt2701-mipi-tx
> -      - mediatek,mt7623-mipi-tx
> -      - mediatek,mt8173-mipi-tx
> -      - mediatek,mt8183-mipi-tx
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt7623-mipi-tx
> +          - const: mediatek,mt2701-mipi-tx
> +      - const: mediatek,mt2701-mipi-tx
> +      - const: mediatek,mt8173-mipi-tx
> +      - const: mediatek,mt8183-mipi-tx
>
>    reg:
>      maxItems: 1
> @@ -32,6 +35,10 @@ properties:
>      items:
>        - description: PLL reference clock
>
> +  clock-names:
> +    items:
> +      - const: ref
> +
>    clock-output-names:
>      maxItems: 1
>
> --
> 2.18.0
