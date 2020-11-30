Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F762C9066
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbgK3V6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:58:12 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:47030 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgK3V6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:58:11 -0500
Received: by mail-il1-f194.google.com with SMTP id b8so12827342ila.13;
        Mon, 30 Nov 2020 13:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q/HzlOoNpMld/PKw4A/VNclXjAqEao2yRcGSeU0Y00A=;
        b=JyvVjg6sNbFlEBK+yPsNj16BvjvSzA5USv5ZrZwzUkZWF2FWud/mRj7sQuxM2GPVuI
         a0Hh3IUrsi6kRBOlpexk2P24Pj0df9rUGbG45okdVTsmx4jWJfiAUEYcEHNZaN5GWokW
         ARF/O55uEaONXQ+7gr25AsIuyKk0QhH7cFVHtcmyE4zeSshiMIv//2S8HM5wyQR19iWU
         WfKD/f/cbRyYmd18o/WkQZvIJGkI23vMJRajC/qdvU3KghaNI5xGHwAini2QNVE/Bde2
         IzmVTD+KIUZkoKPXG7RMckKuoPaZgUGv41lW2I3itbw8xeebEz4SLNygrgufjGEfzNfY
         8ldg==
X-Gm-Message-State: AOAM5332+cbEhRTkIxTN5j5wR33gwYb2Gzv0LmtQvmG83EyBOWIewRwv
        +xDqoHWF93eyPeNMdrVpuA==
X-Google-Smtp-Source: ABdhPJz63mwCftctBFHW1rb/euu8T+n1MpOhxShPnfXCX61MPx0puzzfFTGGCozE9bo4dgq1Q6HtMw==
X-Received: by 2002:a05:6e02:168c:: with SMTP id f12mr10637919ila.105.1606773444789;
        Mon, 30 Nov 2020 13:57:24 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m19sm11143329ila.81.2020.11.30.13.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 13:57:23 -0800 (PST)
Received: (nullmailer pid 3101256 invoked by uid 1000);
        Mon, 30 Nov 2020 21:57:21 -0000
Date:   Mon, 30 Nov 2020 14:57:21 -0700
From:   Rob Herring <robh@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, krzk@kernel.org,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201130215721.GA3090303@robh.at.kernel.org>
References: <20201124015949.29262-1-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124015949.29262-1-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 09:59:46AM +0800, Alice Guo wrote:
> Add DT Binding doc for the Unique ID of i.MX 8M series.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> 
> v2: remove the subject prefix "LF-2571-1"
> v3: put it into Documentation/devicetree/bindings/arm/fsl.yaml

No, I prefer this be a separate schema file and not clutter board/soc 
schemas with child nodes.

>     modify the description of nvmem-cells
>     use "make ARCH=arm64 dtbs_check" to test it and fix errors
> v4: use allOf to limit new version DTS files for i.MX8M to include
>     "fsl,imx8mm/n/p/q-soc", nvmem-cells and nvmem-cells-names
> v5: correct the error of using allOf
> v6: none
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 67980dcef66d..7132ffd41abb 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -918,6 +918,53 @@ properties:
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

Fix your dts files and drop this.

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8mm
> +              - fsl,imx8mn
> +              - fsl,imx8mp
> +              - fsl,imx8mq
> +
> +    then:
> +      patternProperties:
> +        "^soc@[0-9a-f]+$":

And this is just wrong. First you say the node is 'soc' and then here it 
has a unit address.

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
> +            - compatible
> +            - nvmem-cells
> +            - nvmem-cell-names
> +
>  additionalProperties: true
> 
>  ...
> --
> 2.17.1
> 
