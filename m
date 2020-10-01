Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214B827F993
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbgJAGkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:40:15 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40638 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbgJAGkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:40:14 -0400
Received: by mail-ej1-f66.google.com with SMTP id p15so6328184ejm.7;
        Wed, 30 Sep 2020 23:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WhyZhPx4o3B9rJABzjKuvZD1Rwacyg1op0jxwEIXRR8=;
        b=s/O1SGBb9UiI04x/3MMnzP3djgkJVPpIsKm+EQYu18C5h5MqSFbAMzim6BqsOmHRcV
         R6aHT14LNO923g5G4KglOcFACY8vRrYTFXh7Bl1OpcHafv9zi8E8CCceWG9+U2HpK6JU
         JYWzpiYQVK+OKR3a3xNYgJumQHvaARnWA9wIMt3FMqQGWrScTpOe/7+gdZW3EkcGEemh
         nMj3hoCurRE8qraL9reWvK3m2/B4XzlC0T0QgnbLkUZFcfVgGC3gQCZ/6yo5G/mtE1gL
         IE9tF/BHzCzb1f9rgQmRPNt6HK6PVdcowTd72LU08oadovXXsijT4ueBNmm478SIfiBA
         x4PA==
X-Gm-Message-State: AOAM532v6/ZLYhaobFA2tXRknUgsrBaHzZtRSLBSqSXcNSQny3ELaUJL
        Sm0KoEY3OUU/mu9OqHXMJY8=
X-Google-Smtp-Source: ABdhPJy8yjHLF+PREU6khE4vpidm/Qv4TXoYbXacr+BCO2G/tqzQIxMt5WwQAPdOLHarrBtYZ6DFbg==
X-Received: by 2002:a17:906:95d1:: with SMTP id n17mr6858761ejy.324.1601534410816;
        Wed, 30 Sep 2020 23:40:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id f17sm3200981eds.45.2020.09.30.23.40.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 23:40:09 -0700 (PDT)
Date:   Thu, 1 Oct 2020 08:40:08 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v6 11/17] dt-bindings: arm: hisilicon: convert
 hisilicon,cpuctrl bindings to json-schema
Message-ID: <20201001064008.GE3018@kozik-lap>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
 <20200930031712.2365-12-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930031712.2365-12-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:17:06AM +0800, Zhen Lei wrote:
> Convert the Hisilicon CPU controller binding to DT schema format using
> json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../bindings/arm/hisilicon/controller/cpuctrl.yaml | 29 ++++++++++++++++++++++
>  .../arm/hisilicon/controller/hisilicon,cpuctrl.txt |  8 ------
>  2 files changed, 29 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
> new file mode 100644
> index 000000000000000..f6a314db3a59416
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/cpuctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon CPU controller
> +
> +maintainers:
> +  - Wei Xu <xuwei5@hisilicon.com>
> +
> +description: |
> +  The clock registers and power registers of secondary cores are defined
> +  in CPU controller, especially in HIX5HD2 SoC.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: hisilicon,cpuctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

Your own DTS file (arch/arm/boot/dts/hisi-x5hd2.dtsi) does not validate
against this dtschema.

Best regards,
Krzysztof
