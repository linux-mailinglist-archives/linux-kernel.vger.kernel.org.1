Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45773005A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbhAVOjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:39:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbhAVOgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:36:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A208123A03;
        Fri, 22 Jan 2021 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611326155;
        bh=sxU5ASqXndusi2Pnkt13POYjDtxsqPbJSrYN5sC4qMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DspgRbbQSxH0UVx3G/npkwoGZzLfHbc2AnMNW3FldFQg0VCUjK6nbPTF2iRI4z742
         gwqpSx1PNPh3eZLiLQ4GYL3RiwYaQG+A/v6t1q6J15rl3svZx+eW+76QxqeSiXnTJH
         rTeMMmLQdgSqAK4rXjEm8zS614VC+QvY9LtTIFNa3r83MiGvLS580iHpYDu//o9lVv
         9kIb689VHgouJqQxklkqPVVOBOAME6iICW/1XHk2vYjKTDqF0KsqBPsN5VO1TJ4GR9
         vPb1cCn10nmhjCzV3Vz1kjKAbci2NLXTOAz1whWZpGyJeRRGZxhC7hJvvQBOeszY3q
         M0B3zUIvUkk8g==
Received: by mail-ej1-f50.google.com with SMTP id kg20so7480857ejc.4;
        Fri, 22 Jan 2021 06:35:55 -0800 (PST)
X-Gm-Message-State: AOAM530lWcs1YCpmlLNFGPRs/4+LxtNuBA0M9deqfuxyijE033ITV9o9
        g9itO37YF+4z4K0xTILFGXxpu+QrYUxCiDrIfg==
X-Google-Smtp-Source: ABdhPJytgMMsVBCluQGg80czJH2LtDa1jEg+wimwNUTBj1vfLN81d97r1tsHb5RSTOK+iRG6xynU/IIgkyijEkO3jd4=
X-Received: by 2002:a17:907:968e:: with SMTP id hd14mr2126942ejc.108.1611326154238;
 Fri, 22 Jan 2021 06:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20210120115945.29046-1-paul@crapouillou.net>
In-Reply-To: <20210120115945.29046-1-paul@crapouillou.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 Jan 2021 08:35:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLS-oFn4kGm7GeU+W2BvVeon9k9+gzVojypcJCJLwbaEQ@mail.gmail.com>
Message-ID: <CAL_JsqLS-oFn4kGm7GeU+W2BvVeon9k9+gzVojypcJCJLwbaEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings/phy: ingenic: Add compatibles for
 JZ4760(B) SoCs
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, od@zcrc.me,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 5:59 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Add the ingenic,jz4760-phy and ingenic,jz4760b-phy compatible strings,
> and make the ingenic,jz4770-phy compatible string require
> ingenic,jz4760-phy as a fallback, since both work the same, and the
> JZ4760 SoC is older.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/phy/ingenic,phy-usb.yaml         | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
> index 0fd93d71fe5a..3c65dfcf352b 100644
> --- a/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
> +++ b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
> @@ -15,13 +15,19 @@ properties:
>      pattern: '^usb-phy@.*'
>
>    compatible:
> -    enum:
> -      - ingenic,jz4770-phy
> -      - ingenic,jz4775-phy
> -      - ingenic,jz4780-phy
> -      - ingenic,x1000-phy
> -      - ingenic,x1830-phy
> -      - ingenic,x2000-phy
> +    oneOf:
> +      - enum:
> +        - ingenic,jz4760-phy

This should be 2 more spaces indentation. Indent is always 2 more than
the above keyword and ignores '-'.

> +        - ingenic,jz4775-phy
> +        - ingenic,jz4780-phy
> +        - ingenic,x1000-phy
> +        - ingenic,x1830-phy
> +        - ingenic,x2000-phy
> +      - items:
> +        - enum:
> +          - ingenic,jz4760b-phy
> +          - ingenic,jz4770-phy
> +        - const: ingenic,jz4760-phy
>
>    reg:
>      maxItems: 1
> @@ -48,7 +54,7 @@ examples:
>    - |
>      #include <dt-bindings/clock/jz4770-cgu.h>
>      otg_phy: usb-phy@3c {
> -      compatible = "ingenic,jz4770-phy";
> +      compatible = "ingenic,jz4770-phy", "ingenic,jz4760-phy";
>        reg = <0x3c 0x10>;
>
>        vcc-supply = <&vcc>;
> --
> 2.29.2
>
