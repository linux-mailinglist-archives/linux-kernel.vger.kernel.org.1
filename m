Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE2F2DE01E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbgLRIxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:53:07 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:38479 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgLRIxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:53:07 -0500
Received: by mail-ed1-f46.google.com with SMTP id cw27so1546577edb.5;
        Fri, 18 Dec 2020 00:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0csNOja+WKBRpwxt14NEEdfV8rsfLIdAaIbOthj2HVU=;
        b=KIsesOOmB+JHoVSvkEyjx4hhPmzhH5+QSmva3YQJq8fzMaX3XE6a1r+pk7qDOmXQhI
         MX7QXrwVS3SgpiKxCyV/yt0DUtKjhBm0DdDAebw/dBtpeaNAhhhCW7WhZN/K3zbNf5hk
         tbNfg5k3yidgJW4ohG59DxWLggl7ekly28RFwIU5yUIMjaxZe+gOXXRsxcwH/Eoddcgt
         rDadbj7mqCzcqRLvKyIePTjIoGJjNFPnw9xMPYTSaVGylmUzYJ7Lzq41yReNl+1kwbQP
         ijXdrCltpqNUNEIDWIL0aLD5v2XO15wAzaijON6QoGJyWTce875ypKoCJA2g4iT5xR1o
         r9QQ==
X-Gm-Message-State: AOAM532ESVnJGD4rMeWVHQ/lutpZGnIQnomuHxh9oFv1NyQe0rlb3vjz
        h2iIMEPkf4cfyrxOXvrNOlY=
X-Google-Smtp-Source: ABdhPJxLBgM6Ei7flL0dbggRC5UrRw7NGVH6EFLkDPBWlFDfBqvepMbckaowWLUL++7eEbESAL/U0w==
X-Received: by 2002:a05:6402:687:: with SMTP id f7mr3282876edy.314.1608281545935;
        Fri, 18 Dec 2020 00:52:25 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id c14sm24884111edy.56.2020.12.18.00.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 00:52:25 -0800 (PST)
Date:   Fri, 18 Dec 2020 09:52:23 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201218085223.GA17306@kozik-lap>
References: <20201218083726.16427-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201218083726.16427-1-alice.guo@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 04:37:23PM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Add DT Binding doc for the Unique ID of i.MX 8M series.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> 
> Changes for v8:
>  - match soc node with regular expression
> Changes for v7:
>  - change to a separate schema file
> Changes for v6:
>  - none
> Changes for v5:
>  - correct the error of using allOf
> Changes for v4:
>  - use allOf to limit new version DTS files for i.MX8M to include
>    "fsl,imx8m*-soc", nvmem-cells and nvmem-cells-names
> Changes for v3:
>  - put it into Documentation/devicetree/bindings/arm/fsl.yaml
>  - modify the description of nvmem-cells
>  - use "make ARCH=arm64 dtbs_check" to make sure it is right
> Changes for v2:
>  - remove the subject prefix "LF-2571-1"
> 
>  .../bindings/soc/imx/imx8m-soc.yaml           | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml b/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
> new file mode 100644
> index 000000000000..f0b0fc7b3ac6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/imx/imx8m-soc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8M Series SoC
> +
> +maintainers:
> +  - Alice Guo <alice.guo@nxp.com>
> +
> +description: |
> +  NXP i.MX8M series SoCs contain fuse entries from which SoC Unique ID can be
> +  obtained.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - fsl,imx8mm
> +          - fsl,imx8mn
> +          - fsl,imx8mp
> +          - fsl,imx8mq
> +  required:
> +    - compatible
> +
> +patternProperties:
> +  "^soc@[0-9a-f]+$":

Thanks, now it works.

> +    type: object
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - fsl,imx8mm-soc
> +              - fsl,imx8mn-soc
> +              - fsl,imx8mp-soc
> +              - fsl,imx8mq-soc
> +          - const: simple-bus
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
> +additionalProperties: true

Don't leave comments unresolved (or resolve them against review without
discussion). Rob asked for changing it. The same as with all schemas -
you need to describe the missing properties.

Best regards,
Krzysztof
