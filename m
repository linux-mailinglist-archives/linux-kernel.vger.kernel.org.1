Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9BA27E8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgI3MoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:44:21 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36629 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3MoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:44:20 -0400
Received: by mail-ej1-f68.google.com with SMTP id qp15so1671118ejb.3;
        Wed, 30 Sep 2020 05:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/hHv7crbuPPcZ8O24fi/9ABcUnPC2V7L6JnV4Pec22g=;
        b=fHbEQa3u4LXB241onmfeT87J0CaTo6q+HvoZN/WRdg6LafKCDSRUVKdGxdgPhdC8Vg
         aj3Uqa0xcI5NxoR4fjbIrkN6CDGxjIaadlXTUw5jutbATWUZ5cWHj0THTFjxNZAyYCsK
         zbBd+b5p3GoOkUuaAlQX3GOdGuZtPolV57rBQAmMGrSlwel+RpmwOZmw7I5WAv4rUn02
         oVtP6UY8dDaw9jD4pNq88UywES+zVKpo96ShQXzjQ6oG35BEc9XK9Ym7ws6qfd6YAprA
         C6XZW/MLje7mRyE8qyCcOY/DMUO5vhzlvcBdS7/YVuqNCUyEnwcu0CjWKSFgZ6t81pE7
         rfcg==
X-Gm-Message-State: AOAM533gULb86hfloKmLfYX57KHhBxGa+POsbW3nnnnOOZcf3kUROLON
        jykHkD4yvRbs8nGVAIGfSg0=
X-Google-Smtp-Source: ABdhPJwRBBp520JmNI6HJgmUGt2690ofwx2x8c8xK5fF5dMUZDJgSjSsKfrGcfQAZDVruzha5RLM2Q==
X-Received: by 2002:a17:906:5509:: with SMTP id r9mr2681632ejp.12.1601469858294;
        Wed, 30 Sep 2020 05:44:18 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id n12sm303950edr.56.2020.09.30.05.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 05:44:17 -0700 (PDT)
Date:   Wed, 30 Sep 2020 14:44:14 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/14] dt-bindings: arm: fsl: document i.MX51 boards
Message-ID: <20200930124414.GC1368@pi3>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-7-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-7-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 06:28:04PM +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX51 based boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 24 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 93229f9746c7..b6e5691ddbd1 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -129,13 +129,31 @@ properties:
>                - kobo,aura
>            - const: fsl,imx50
>  
> -      - description: i.MX51 Babbage Board
> +      - description: i.MX51 based Boards
>          items:
>            - enum:
> -              - armadeus,imx51-apf51    # APF51 SoM
> -              - armadeus,imx51-apf51dev # APF51 SoM on APF51Dev board
> +              - armadeus,imx51-apf51      # Armadeus Systems APF51 module
>                - fsl,imx51-babbage
>                - technologic,imx51-ts4800
> +              - zii,imx51-scu3-esb

I missed two i.MX51 boards, so there will be a v2 for this one.

Best regards,
Krzysztof
