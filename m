Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BEF2AC4BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgKITLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:11:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45146 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbgKITLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:11:02 -0500
Received: by mail-oi1-f195.google.com with SMTP id j7so11372983oie.12;
        Mon, 09 Nov 2020 11:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XLhjrbEcMV5bi076ZeGzCwJjkoRdVWyTomnb4TsCUyQ=;
        b=q5Pn0zhIXhH1Z8XCNb/+XofqgwOJ7fdxb0wCb54P60mQSIVM1E18WNoSL+sPMm4jZX
         0GqJQLJGaiwleCG13AmPuUaMFedkSyj45NeHxGmwTZUhNQRKO1+wDNhJyW0/Gv3oCizk
         2nBK5zCG9nSO97MnaHbJ/pu7cHHaMd7aavusbQ5ldoOyVTFRC2BoOs7eCr2Vu/TajS6w
         BS6MIznHffGgYo5BhZQzxkzhKLzwuWFtEHhpIaXh6vGwKaot4yrcPlf4bi9C/vEu9ISm
         zt+R+oRlbhfdMbV/MRhm8LB/XQvLd1qhbYQtpD7Vcwpjm8JT4JFG00DDi/lImcWkiz3w
         UAtA==
X-Gm-Message-State: AOAM532Vd1WSotIDHhgPxUvLbmKgf1hv9M2vhrb5arfShHu1htzWZQWb
        hHJlOHheR87NSwzRt+pafQ==
X-Google-Smtp-Source: ABdhPJyNRDLRB+Q/PCsvZe6htBWvosHDcpbfyiT0wNGJFbQ7YFboFfRPakz33POrB8GDA1reApdp/w==
X-Received: by 2002:aca:d941:: with SMTP id q62mr433946oig.33.1604949061091;
        Mon, 09 Nov 2020 11:11:01 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h3sm979817oou.3.2020.11.09.11.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 11:11:00 -0800 (PST)
Received: (nullmailer pid 1605155 invoked by uid 1000);
        Mon, 09 Nov 2020 19:10:59 -0000
Date:   Mon, 9 Nov 2020 13:10:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, krzk@kernel.org,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201109191059.GA1599099@bogus>
References: <20201105072629.24175-1-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105072629.24175-1-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 03:26:26PM +0800, Alice Guo wrote:
> Add DT Binding doc for the Unique ID of i.MX 8M series.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index e4db0f9ed664..0419f078502b 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -901,6 +901,39 @@ properties:
>                - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
>            - const: fsl,s32v234
> 
> +  soc:
> +    description:
> +      i.MX8M Family SoC must provide a soc node in the root of the device tree,
> +      representing the System-on-Chip since these test chips are rather complex.
> +    type: object
> +    properties:
> +      compatible:
> +        oneOf:
> +          - items:
> +              - const: fsl,imx8mm-soc
> +              - const: simple-bus
> +          - items:
> +              - const: fsl,imx8mn-soc
> +              - const: simple-bus
> +          - items:
> +              - const: fsl,imx8mp-soc
> +              - const: simple-bus
> +          - items:
> +              - const: fsl,imx8mq-soc
> +              - const: simple-bus

items:
  - enum:
      - fsl,imx8mm-soc
      - fsl,imx8mn-soc
      - fsl,imx8mp-soc
      - fsl,imx8mq-soc
  - const: simple-bus

> +
> +      nvmem-cells:
> +        maxItems: 1
> +        description: Phandle to the SOC Unique ID provided by a nvmem node
> +
> +      nvmem-cells-names:
> +        const: soc_unique_id
> +
> +    required:
> +      - compatible
> +      - nvmem-cells
> +      - nvmem-cell-names
> +

'soc' should be required?

>  additionalProperties: true
> 
>  ...
> --
> 2.17.1
> 
