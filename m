Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E6627F987
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbgJAGfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:35:24 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:32773 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAGfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:35:23 -0400
Received: by mail-ej1-f67.google.com with SMTP id j11so6398769ejk.0;
        Wed, 30 Sep 2020 23:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LXuSgrjhDPSmJ5UAPkcchoivbEqdncR+oeY8bDsU/Q0=;
        b=eZTf/IgJWRUwhsq7TbQOilgsNXssj2J1ADn4JjBceF/Uq80q3J5JF7hRlrLZGbEp77
         9qLaD9ikjwvHw4OrXiYj1NI6uU/w5cj4SBFGh+wEvFN9ljOBiZO9ddWuBPYGOLVxJJj2
         /NagmIjU/+1vlUxvPXPA5+9cg8KDa+8eUeQKUXJ1wC58didNm7qC0ceAqFcpZnvsqVyw
         k/jdCl26yBSj1qSKCVT3yixaRjadgkKLCh1tkYW1abkzXhzfXGlQjAloktLqY58cDJGY
         5o0cV76hqTeylLp5H6/+xRwWxu0hxcp7OO9Uy4OaqeLSF0I/FZEsLP8qmnIxZVlz3tyT
         n3XQ==
X-Gm-Message-State: AOAM530ezWgM5N7xcMYkzm85+tOTyNEnft8TpurN8tcR994J9k0KExh7
        5Lspsd+TmyvNFP3c7EvTP5CNl+nBLh8=
X-Google-Smtp-Source: ABdhPJz6kjWms5IH3vUaqD9eMV/onHLYjcqLMirzoTyiGOh+MXPa3Z3gXMIrhsdnvIydW2y9zgZ3oA==
X-Received: by 2002:a17:907:40c1:: with SMTP id nv1mr6799441ejb.318.1601534121122;
        Wed, 30 Sep 2020 23:35:21 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id v25sm3278265edr.29.2020.09.30.23.35.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 23:35:19 -0700 (PDT)
Date:   Thu, 1 Oct 2020 08:35:17 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v6 16/17] dt-bindings: arm: hisilicon: convert
 hisilicon,hi3798cv200-perictrl bindings to json-schema
Message-ID: <20201001063517.GC3018@kozik-lap>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
 <20200930031712.2365-17-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930031712.2365-17-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:17:11AM +0800, Zhen Lei wrote:
> Convert the Hisilicon Hi3798CV200 Peripheral Controller binding to DT
> schema format using json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../hisilicon/controller/hi3798cv200-perictrl.yaml | 64 ++++++++++++++++++++++
>  .../controller/hisilicon,hi3798cv200-perictrl.txt  | 21 -------
>  2 files changed, 64 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml
> new file mode 100644
> index 000000000000000..cba1937aad9a8d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/hi3798cv200-perictrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon Hi3798CV200 Peripheral Controller
> +
> +maintainers:
> +  - Wei Xu <xuwei5@hisilicon.com>
> +
> +description: |
> +  The Hi3798CV200 Peripheral Controller controls peripherals, queries
> +  their status, and configures some functions of peripherals.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: hisilicon,hi3798cv200-perictrl
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties:
> +  type: object

You need to describe all additional properties or objects.

Best regards,
Krzysztof
