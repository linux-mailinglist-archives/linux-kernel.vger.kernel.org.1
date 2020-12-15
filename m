Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFE12DA9D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgLOJMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:12:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41308 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgLOJMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:12:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id i24so20151339edj.8;
        Tue, 15 Dec 2020 01:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=76YNNvedxwQavmwaTRQKT3yfhwPKPqBSFxsGhUfBxyc=;
        b=NKIQoT9DpTCaUXTaOxSi0JzurYt/hqac+5vIy6US5UOkgLJC7LNWWjfaXj6fEuTu+P
         h1CnDD3q7Ddo3S6ZspSugdHPjAY9eujQHI0NbMWv/L+fhiYKZ47YSP6OfbB3AAix6zoA
         Ktv2+UhmKTLbvKp7PUhvc/fMNCvOP1aiibHS3HS3bbDi+w22rQABk4jDyUgn2QksVD2v
         7H2xZnX3bZSLy/28pGIis07tTnM02n709IisVKJ/S4ichpi+X0pWGo1bCL6zV0MW0U76
         +ypBuPgPlr2HM+vWA0pHqVpdHkmbK963hWLoH/bt8Fbnv93Qi89lWE8QIai/Nhjq93gX
         +cVQ==
X-Gm-Message-State: AOAM531pL8zlRhHZRbViA80u0idfwROqIWge2ukBf0I1fAWnmwzqKUc9
        k9dc6yhJsiCSkiI1iV/NKiA=
X-Google-Smtp-Source: ABdhPJxiThtphqQmSV9KKflcAj0vuSGsG4tG5fs8gYfwTz2ko3RETBBR9qsNQj6TcljGF9n3m7sdfA==
X-Received: by 2002:aa7:d6d8:: with SMTP id x24mr29163229edr.105.1608023480321;
        Tue, 15 Dec 2020 01:11:20 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id d8sm14289205edm.75.2020.12.15.01.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 01:11:19 -0800 (PST)
Date:   Tue, 15 Dec 2020 10:11:18 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v7 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201215091118.GB9386@kozik-lap>
References: <20201215083551.6067-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201215083551.6067-1-alice.guo@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 04:35:48PM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Add DT Binding doc for the Unique ID of i.MX 8M series.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> 
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
> index 000000000000..a2f7dc0c9b35
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

Mhm, there are other compatibles here so indeed, select is needed.

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

This does not work - does not match anything. It seems you missed proper
"required" for the matched node.

Provide also an example.

Best regards,
Krzysztof


> +
> +properties:
> +  soc:
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
> +...
> --
> 2.17.1
> 
