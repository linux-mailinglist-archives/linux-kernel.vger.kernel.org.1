Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D310D2FA8C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393688AbhARS1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:27:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392937AbhARPGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:06:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56C2422BF3;
        Mon, 18 Jan 2021 15:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610982338;
        bh=O6M1n/+xN3XivdFxg/+MeYf0/keKDicCppxhlPQcqAo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gu4q31Ni9yGfcWk46rz/cLDZVGk5skrlSQ0hEbFEU2l+cFzxD2LvJvCh+TMY7DNWw
         OsbMuu1lvYbvUuKIHXO2vMxoHqqzJLyqNyIPtzTWfpsXmIU87GkEjdXojUOOx9YY47
         Hv0daJ84K6I9xYWSAzqu3i/z6PMRjYZoNLUbNdh0TQ8358/2WoJ207Pm7xnMgLIwxX
         mhE8cPknJ6sm7Tb09I1hPPJLJRjFUfhJeLXDKka+a4aoXBEjfbzZah32BNKEMawIlp
         s96ecjh0LQnBQsbGQplb8R+rMfQqJS3imqFt81LxnkecaBOW4UJpysnFpD+wHYjbma
         akC2YMZzsTnxQ==
Received: by mail-ed1-f54.google.com with SMTP id b21so9122897edy.6;
        Mon, 18 Jan 2021 07:05:38 -0800 (PST)
X-Gm-Message-State: AOAM530x5bhKVGxke+aLaEpgIbZSf8GqITwKuyHLBMCnrYTJaFm0t3iW
        jkGgEfKLsd6UsMTB+RJ9wo47W22EhzctYr6B9Q==
X-Google-Smtp-Source: ABdhPJyfXzalDLfP+23Rji9ljj49KRJPNaWxn9PX5oQgRjG3us5FDJGuKT75vRlC9zwSL0fJPMRPsmGBGhMExyQutg0=
X-Received: by 2002:a05:6402:55:: with SMTP id f21mr20025590edu.38.1610982336942;
 Mon, 18 Jan 2021 07:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com> <20210116090656.11752-4-chunfeng.yun@mediatek.com>
In-Reply-To: <20210116090656.11752-4-chunfeng.yun@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 18 Jan 2021 23:05:25 +0800
X-Gmail-Original-Message-ID: <CAAOTY__DtGc85JNyxWcebof5h3_Os2ugyy1P0jZsOs0Yzj2miw@mail.gmail.com>
Message-ID: <CAAOTY__DtGc85JNyxWcebof5h3_Os2ugyy1P0jZsOs0Yzj2miw@mail.gmail.com>
Subject: Re: [PATCH next 04/15] dt-bindings: phy: mediatek: hdmi-phy: modify
 compatible items
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
> The compatilbe "mediatek,mt7623-hdmi-tx" is not supported in driver,
> and in fact uses "mediatek,mt2701-hdmi-tx" instead on MT7623, so changes
> the compatible items to make dependence clear.
>
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/phy/mediatek,hdmi-phy.yaml    | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml=
 b/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
> index 4752517a1446..0d94950b84ca 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
> @@ -21,10 +21,13 @@ properties:
>      pattern: "^hdmi-phy@[0-9a-f]+$"
>
>    compatible:
> -    enum:
> -      - mediatek,mt2701-hdmi-phy
> -      - mediatek,mt7623-hdmi-phy
> -      - mediatek,mt8173-hdmi-phy
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt7623-hdmi-phy
> +          - const: mediatek,mt2701-hdmi-phy
> +      - const: mediatek,mt2701-hdmi-phy
> +      - const: mediatek,mt8173-hdmi-phy
>

I like move 'items' to the bottom.

- const: mediatek,mt2701-hdmi-phy
- const: mediatek,mt8173-hdmi-phy

- items:
  - enum:
      - mediatek,mt7623-hdmi-phy
  - const: mediatek,mt2701-hdmi-phy

Regards,
Chun-Kuang.

>    reg:
>      maxItems: 1
> --
> 2.18.0
