Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D112DA99C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgLOJCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:02:44 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35628 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgLOJC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:02:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id u19so20179709edx.2;
        Tue, 15 Dec 2020 01:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F4vRukCKvqFEIrZ2H5b8tzXK0BYA4USmfObGCnfAqpE=;
        b=pRWzFL1qcXAhfn1otQJvmT5IwH1ytK6HlenjBzpvh8Sn5V41V/46DYjRQLXHXvKtUG
         bgCg7tpznVQnMpTcd8Ba7rjsKowDakY2rMKoSjkmyHFqkb/1Sp/E5xpbJawNHKzVOx0A
         +AiD5WJwk4kUGBSQLL7X9p2f9ZQR78jlnlcKOIDdzG6ofpV/QE28cVvchTxTfzCU0pfP
         B7P0cMnhM7U8h0Zi+gKP9QFpRsfAUkNJp5D3s6iZh0nQNxFrBnwYxlWxmi3aDOZw2eAs
         gHqNtNrXfjDR6EOAr3rGgqmEOd+SUWLgXspIbirAXH0foD0BppPkLx9DkUvboiwc9YDk
         PJiw==
X-Gm-Message-State: AOAM530z5ulCeeor3FXtD7cZ1IpiqaxGHRwX9srzf21PP756oV1TYo8h
        242wJ4L71wrFKEdRhBFk+mg=
X-Google-Smtp-Source: ABdhPJx4Smf6KzfER0xVFHs1AUb6Fxaji6LV/3m3B63/AXJZtZOpwkyVvcxpG4yaafLyfoyiUrbzOA==
X-Received: by 2002:aa7:cccf:: with SMTP id y15mr28927982edt.112.1608022902097;
        Tue, 15 Dec 2020 01:01:42 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b17sm886945eju.76.2020.12.15.01.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 01:01:40 -0800 (PST)
Date:   Tue, 15 Dec 2020 10:01:39 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v7 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201215090139.GA9386@kozik-lap>
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

Why do you need a select for this (not as usual way - part of
"properties:")?

Best regards,
Krzysztof


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
