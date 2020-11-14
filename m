Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550AD2B2E9E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 17:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKNQtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 11:49:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56208 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgKNQtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 11:49:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id c9so19343640wml.5;
        Sat, 14 Nov 2020 08:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aRVBRsu67VpMNiZV0EvzM3D1WLASw6LIRYkR/+s56bw=;
        b=Eo2ZZrqb5VXwI8gBWt50IgtPcTHKc/UsTF+9AQ9MIrEtqHmmt/uwA5IFfzOAXa93K7
         y81P9yzghvoGeZIZAGjObuVFLh7G+Fmc0f11xe4+NU80+y4irgUya3XIikJwfSrhLjNZ
         kVauopNlUHb921Q6IpvWfTeWYRL/rL+0z4/V8rBp+Hk860yhIK8xG3x/d5GA/BkCrvck
         pFkvq7NwtyI5zGM8rntA6vcMM7eR/YvLDt7tw96grhRakzmefxe7XJC3RElcr0yXK9k2
         V31tsv85CFBAcJ2OcSaeZO/VATFVoWYR0s1KNPnzyCUKq9r15ClxspC+M2pD16hZ5EJG
         L6rA==
X-Gm-Message-State: AOAM531xhp0fH2o01hwG2gJ1bRFlm7r5DchSEKlsMpiRlchrY2qVR2Zx
        /zyiNkvi0hznL7vF5cvEmQ8=
X-Google-Smtp-Source: ABdhPJwq2D7Rvw2ZUQBiEZWQanL6hXtdBRNRqgVAkVmPPA6FduDAyK2pI/jr3bF6VaqOWR9wVKTE9g==
X-Received: by 2002:a1c:6302:: with SMTP id x2mr7873931wmb.121.1605372579340;
        Sat, 14 Nov 2020 08:49:39 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k81sm24654429wma.2.2020.11.14.08.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 08:49:38 -0800 (PST)
Date:   Sat, 14 Nov 2020 17:49:36 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201114164936.GA32552@kozik-lap>
References: <20201113110409.13546-1-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113110409.13546-1-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 07:04:06PM +0800, Alice Guo wrote:
> Add DT Binding doc for the Unique ID of i.MX 8M series.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index e4db0f9ed664..f4faebbb57da 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -901,6 +901,31 @@ properties:
>                - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
>            - const: fsl,s32v234
> 
> +  soc:
> +    type: object
> +    properties:
> +      compatible:
> +        oneOf:
> +          - description: i.MX8M SoCs
> +            items:
> +              - enum:
> +                  - fsl,imx8mm-soc
> +                  - fsl,imx8mn-soc
> +                  - fsl,imx8mp-soc
> +                  - fsl,imx8mq-soc
> +              - const: simple-bus
> +
> +          - description: Other SoCs
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
>  additionalProperties: true

The "soc" node should be required for these compatibles. Otherwise you
will have to stay with this
backwards-compatible-DTB-device-initcall-glue for many years... I think
you can achieve it with allOf.

Best regards,
Krzysztof

