Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E7C30198A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 05:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbhAXEsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 23:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbhAXEsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 23:48:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73B0422CAF;
        Sun, 24 Jan 2021 04:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611463641;
        bh=Urovf5esIrjfn93td/lp5lIed9NHT13uUhH0F2Cn2AE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KSpsFkG0QosDis5ZntAq3BALLTDdfLllUQ1vHIW43/I/qUcKF7JUHZywUSPKryVWg
         87e45AMYjjznsUfW/MXHxZuk8PyHEYB0MwfVb2WvqTdwrpG535Kh7UpnDKTnz7E6GT
         9iNBt1FjV8x8P7uigDDq42UfjX5JEL2e+pFqlvk9yKpkC3K0bCSQWxqbepZC0A7VMB
         ph+vVJjY00UAZ/Jk7yISk7auoP5UH0rX8Ll/jjoZwJu43TDwqX2SpR1YY2vjaRXPyb
         E3d0ui4JhzzECxOTVEqKCIWsnKmtsmzx84DVRm9bJikQ+SgN1ygIDxKoN6Pqq+xg6n
         21Myq0+TOCK9g==
Received: by mail-ej1-f41.google.com with SMTP id w1so13232426ejf.11;
        Sat, 23 Jan 2021 20:47:21 -0800 (PST)
X-Gm-Message-State: AOAM531VlLBMpCSoTYMOlmXKRLumShhh+9+3vFrDI2WgTRWh/8OybKi0
        TDB6+vgFDQMgTyJVnrzVz8i8djIgTDJWo0Cr0w==
X-Google-Smtp-Source: ABdhPJxoF6afPRUA0RYz8hTCdtGJdRPYVGO/FrQKiI+n8xlgMCnfU61vIVV6/1/0EI61xcYweAxdF9ZVs2LYKOZJMlA=
X-Received: by 2002:a17:906:a106:: with SMTP id t6mr691006ejy.63.1611463639987;
 Sat, 23 Jan 2021 20:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com> <20210122120323.4337-3-chunfeng.yun@mediatek.com>
In-Reply-To: <20210122120323.4337-3-chunfeng.yun@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 24 Jan 2021 12:47:09 +0800
X-Gmail-Original-Message-ID: <CAAOTY__O=z-AOo1RCRGfJYuSsXs1cUZgWFaTQz_3W_Tj=CeFBQ@mail.gmail.com>
Message-ID: <CAAOTY__O=z-AOo1RCRGfJYuSsXs1cUZgWFaTQz_3W_Tj=CeFBQ@mail.gmail.com>
Subject: Re: [PATCH next v2 03/17] dt-bindings: phy: mediatek: dsi-phy: modify
 compatible dependence
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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

Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=882=
2=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:04=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> The compatilbe "mediatek,mt7623-mipi-tx" is not supported in driver,
> and in fact uses "mediatek,mt2701-mipi-tx" instead on MT7623, so changes
> the compatible items to make dependence clear.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: separate two patches suggested by CK
> ---
>  .../devicetree/bindings/phy/mediatek,dsi-phy.yaml   | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml =
b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> index 71d4acea1f66..6e4d795f9b02 100644
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
> --
> 2.18.0
