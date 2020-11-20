Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710192BA7C0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgKTKuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:50:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37086 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgKTKuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:50:50 -0500
Received: by mail-ed1-f68.google.com with SMTP id cq7so9045635edb.4;
        Fri, 20 Nov 2020 02:50:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=It+D4YQDqmKcdjcjbq/4hP36Dz2LcB1jnl1T6CqVtu4=;
        b=gh16UBw8lEI6YYRrFggXiW693pnhtsnijta5KbRWtif4aE7iAgNfVDHaokIl8BpcCE
         PZe7fRnVJpHYy0iqIyvvXm64rP2laOyTJAcKS4XxkBg6lL67+cM+XE7fXNGoP/d9Twmr
         z+ulh1OsuAuISKvrZA2/lf60wT71KPRizS6229lH+mJ90Zei40v2nRu4/wVI+V5fHeOa
         4ucT+P2s6LfL9eX+xYlRjLprzgxvLKKAZ5pVT3lKY0AatxQDtmeVYvNxQWLrVcXF0oan
         TIoaY+Yuixi6NE1WLvYJapSZb0Vn7tT3dMvuuxwivlJrW7u7hQNQXP5VpV9ONT2pob5j
         /mZw==
X-Gm-Message-State: AOAM530mi/6zYlAP4za608qdmUfcS9DJ+gHtUT2tcdBr1lrVHkprUSkZ
        U/Hf5dwRaKY1C7KAZF3uCYw=
X-Google-Smtp-Source: ABdhPJwOgFAFmzsp7sleJCO2BGhXf7meuzi4Aj0kJqXk//7z8BdixlPZGgWt+vnNhCvpXWAuFhnSeA==
X-Received: by 2002:aa7:c512:: with SMTP id o18mr34240215edq.357.1605869447554;
        Fri, 20 Nov 2020 02:50:47 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j6sm923497edy.87.2020.11.20.02.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 02:50:46 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:50:45 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201120105045.GA18581@kozik-lap>
References: <20201120101112.31819-1-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120101112.31819-1-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 06:11:09PM +0800, Alice Guo wrote:
> Add DT Binding doc for the Unique ID of i.MX 8M series.
> 
> v2: remove the subject prefix "LF-2571-1"
> v3: put it into Documentation/devicetree/bindings/arm/fsl.yaml
>     modify the description of nvmem-cells
>     use "make ARCH=arm64 dtbs_check" to test it and fix errors
> v4: use allOf to limit new version DTS files for i.MX8M to include
>     "fsl,imx8mm/n/p/q-soc", nvmem-cells and nvmem-cells-names
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 67980dcef66d..d8048323a290 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -918,6 +918,57 @@ properties:
>                - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
>            - const: fsl,s32v234
> 
> +  soc:
> +    type: object
> +    properties:
> +      compatible:
> +        oneOf:
> +          - description: new version compatible for i.MX8M SoCs
> +            items:
> +              - enum:
> +                  - fsl,imx8mm-soc
> +                  - fsl,imx8mn-soc
> +                  - fsl,imx8mp-soc
> +                  - fsl,imx8mq-soc
> +              - const: simple-bus
> +
> +          - description: old version compatible for i.MX8M SoCs
> +            items:
> +              - const: simple-bus
> +
> +      nvmem-cells:
> +        maxItems: 1
> +        description: Phandle to the SOC Unique ID provided by a nvmem node
> +
> +      nvmem-cells-names:
> +        const: soc_unique_id
> +
> +    allOf:

Nothing changed here comparing to previous version. Still does not
work.

The allOf should not be part of soc node because the "if" below won't
match. Instead, it should be against root node.

Best regards,
Krzysztof

> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                enum:
> +                  - fsl,imx8mm
> +                  - fsl,imx8mn
> +                  - fsl,imx8mp
> +                  - fsl,imx8mq
> +
> +        then:
> +          properties:
> +            compatible:
> +              items:
> +                - enum:
> +                    - fsl,imx8mm-soc
> +                    - fsl,imx8mn-soc
> +                    - fsl,imx8mp-soc
> +                    - fsl,imx8mq-soc
> +                - const: simple-bus
> +
> +          required:
> +            - nvmem-cells
> +            - nvmem-cells-names
> +
>  additionalProperties: true
> 
>  ...
> --
> 2.17.1
> 
