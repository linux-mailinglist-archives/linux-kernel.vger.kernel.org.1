Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE89527B512
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgI1TO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:14:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33182 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1TO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:14:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id m12so2092859otr.0;
        Mon, 28 Sep 2020 12:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1JIJzGGaHdOoQP4SDw9UfVl9yOZsYe+t3slPNmQzKFY=;
        b=RuDst7j4j/LJ+osgvu8GmLZS5MjuviBTVV9MEKbsyItdztGW0yFrpnqtx15gYFAsw3
         P887RDtpouJ5yckC3P/OjeUkRxoebm/Pq7mohai0p1aB35ALA07NcBpkmwNAnU2Twczt
         PcGgJsI1z+FZkkWTszGGx/Rc2RBEg3Y5huUwHjt2L0ghjguT0pLEz1mq1vmlClmcusfO
         ctw80nwrdRUao5+4kkQLo9uNbVKY+ukfp/V9XdFTQAvMoey1oisjL9W5DpQoQ1UyDFoY
         zOANhly+9nAmKIaqTaeUW3MC51bBPsD73LbwCm1qIXUKIPURz86hJpDY8OLExpsEcBKr
         t4zQ==
X-Gm-Message-State: AOAM530QzNCi/xKdNVqYT9ScDFdB6p4OMekCkPl+1x9dTvde09yUkOc+
        70AbLGRGB5iYrjDpvjSxaQ==
X-Google-Smtp-Source: ABdhPJzURsjQV/scxNdBnQCd+ydJGcjSQAYXD8PPYosyE1W292Ude8z1UvwjJ3OBWiMBntSYfORBUA==
X-Received: by 2002:a9d:7f89:: with SMTP id t9mr345255otp.206.1601320467174;
        Mon, 28 Sep 2020 12:14:27 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k73sm462615otk.63.2020.09.28.12.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:14:26 -0700 (PDT)
Received: (nullmailer pid 3100610 invoked by uid 1000);
        Mon, 28 Sep 2020 19:14:25 -0000
Date:   Mon, 28 Sep 2020 14:14:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 12/20] dt-bindings: arm: hisilicon: convert
 hisilicon,hi3798cv200-perictrl bindings to json-schema
Message-ID: <20200928191425.GA3099266@bogus>
References: <20200928151324.2134-1-thunder.leizhen@huawei.com>
 <20200928151324.2134-13-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928151324.2134-13-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:13:16PM +0800, Zhen Lei wrote:
> Convert the Hisilicon Hi3798CV200 Peripheral Controller binding to DT
> schema format using json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../controller/hisilicon,hi3798cv200-perictrl.txt  | 21 ----------
>  .../controller/hisilicon,hi3798cv200-perictrl.yaml | 45 ++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
> deleted file mode 100644
> index 0d5282f4670658d..000000000000000
> --- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Hisilicon Hi3798CV200 Peripheral Controller
> -
> -The Hi3798CV200 Peripheral Controller controls peripherals, queries
> -their status, and configures some functions of peripherals.
> -
> -Required properties:
> -- compatible: Should contain "hisilicon,hi3798cv200-perictrl", "syscon"
> -  and "simple-mfd".
> -- reg: Register address and size of Peripheral Controller.
> -- #address-cells: Should be 1.
> -- #size-cells: Should be 1.
> -
> -Examples:
> -
> -	perictrl: peripheral-controller@8a20000 {
> -		compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
> -			     "simple-mfd";
> -		reg = <0x8a20000 0x1000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -	};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml
> new file mode 100644
> index 000000000000000..4e547017e368393
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml#
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
> +    description: Register address and size
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1

That implies child nodes. You need some sort of schema for them.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    perictrl: peripheral-controller@8a20000 {
> +        compatible = "hisilicon,hi3798cv200-perictrl", "syscon", "simple-mfd";
> +        reg = <0x8a20000 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +    };
> +...
> -- 
> 1.8.3
> 
> 
