Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AA62DB533
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgLOUei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:34:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33927 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgLOUdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:33:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id s75so24835962oih.1;
        Tue, 15 Dec 2020 12:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EtjKKd4TCSJPpocIsePkm7hGwgQtFCBsVHbK3e4JQ/A=;
        b=VcuD3vaUZPC+IIXogl2f1jR4o/6DqsylYeo1qc5TUG9dxWOUeauLt5O/L2nz/EfxCR
         FGovX2ZjjamcNiOR4gzORK8tZQWJ9RUTLT5Ca+CZL212CohjJT4A2hPRX9m3q9DcLa+b
         0Swpd0oXkws5zlr1CLArODVpX0Gz8+JmE1PDYtSon6dm+/3wrVIt/gGQ9gZaM81oBBo/
         jYG7GwefjnrdmLDLnTDA1b2FaeK4rgRO9Vn+Ju//miWJ+DdN+6GqwOVdw8QG4NFvzt8h
         38Co/bE2fTDU8TxrnTcFaCFEpwn6veGVUCKJ3HNFciFNZ/uK+BDDusgVCVr9tuWZMDLp
         tMkw==
X-Gm-Message-State: AOAM530oQCuDaNfV4abbSv40d6pBf6131oKu84S2aAcwSvucysp7oHXF
        /gMZPcsUA+KRVvuDbmCxp+PmArnauw==
X-Google-Smtp-Source: ABdhPJw1zNChVh3D0wCKjqWgGzDn+PAXtuD5gGraAOcBX5mba70IZ51cdakGWx1H4k8v2DDA3f6NKg==
X-Received: by 2002:aca:bdc4:: with SMTP id n187mr417086oif.154.1608064360624;
        Tue, 15 Dec 2020 12:32:40 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r204sm5056833oif.0.2020.12.15.12.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:32:39 -0800 (PST)
Received: (nullmailer pid 165386 invoked by uid 1000);
        Tue, 15 Dec 2020 20:32:38 -0000
Date:   Tue, 15 Dec 2020 14:32:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, krzk@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH v7 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201215203238.GA118912@robh.at.kernel.org>
References: <20201215083551.6067-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Anything else should be a node, so:

       additionalProperties:
         type: object

> +
> +additionalProperties: true
> +...
> --
> 2.17.1
> 
