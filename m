Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41FB27B51E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgI1TQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:16:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42781 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1TQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:16:39 -0400
Received: by mail-oi1-f195.google.com with SMTP id x14so2562595oic.9;
        Mon, 28 Sep 2020 12:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6+st6an7MqcsVXc1YPFb8ho1mH2DvuZcgY3z5eO9A5Y=;
        b=osEoD/3PtdPdX3iw2vn/y8XLIfXrJhIymWZW6+U5MMKn17C/2OzZdc2w4yZOjq45e9
         D2QRwB/qzmKnHlkIJSozdbKcXDpF4LdLMk8RGDEFhJj9JfzZiK9pGYLh1ZJA1//0SjDI
         7Nauc8KKYMbJJotF4sAaN0qWjsxwr5aOX/4qJthdJ0wsfmDZxFSR7oFzYZ0660QSi6c5
         5a9F7j46Z2W5mXILTTDKHIkWWcx6lm0PjyVs8P6feczcw7FKoq2UB8Jv0aMZ2MV6W9Rn
         SgBrMUs0SU0R5ne+i1J2UkOPgP/iSKtYFHDu3ZuTBPnJGyZhhmYfHbT1QzeNSVkpz6/4
         ujsw==
X-Gm-Message-State: AOAM532C25IpErnYHJ5BfnHpmrpfObv4tku2ijjBH84JRv79xq6jNCQV
        Snmh+5WhXew6rvYi1upproEYASVUxAa/
X-Google-Smtp-Source: ABdhPJwhE6wYHSaAwrOr7WuzClM39tOKjYW6BMJ1tZhHLDWTB6Q6UygphqUsFWpFRJVtTV0L2NyesA==
X-Received: by 2002:aca:4e84:: with SMTP id c126mr244906oib.94.1601320597217;
        Mon, 28 Sep 2020 12:16:37 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t5sm437749otp.76.2020.09.28.12.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:16:36 -0700 (PDT)
Received: (nullmailer pid 3103444 invoked by uid 1000);
        Mon, 28 Sep 2020 19:16:35 -0000
Date:   Mon, 28 Sep 2020 14:16:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 20/20] dt-bindings: arm: hisilicon: convert LPC
 controller bindings to json-schema
Message-ID: <20200928191635.GB3099266@bogus>
References: <20200928151324.2134-1-thunder.leizhen@huawei.com>
 <20200928151324.2134-21-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928151324.2134-21-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:13:24PM +0800, Zhen Lei wrote:
> Convert the Hisilicon Hip06 SoCs implement a Low Pin Count (LPC)
> controller binding to DT schema format using json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../arm/hisilicon/hisilicon-low-pin-count.txt      | 33 ------------
>  .../arm/hisilicon/hisilicon-low-pin-count.yaml     | 61 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
> deleted file mode 100644
> index 10bd35f9207f2ee..000000000000000
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -Hisilicon Hip06 Low Pin Count device
> -  Hisilicon Hip06 SoCs implement a Low Pin Count (LPC) controller, which
> -  provides I/O access to some legacy ISA devices.
> -  Hip06 is based on arm64 architecture where there is no I/O space. So, the
> -  I/O ports here are not CPU addresses, and there is no 'ranges' property in
> -  LPC device node.
> -
> -Required properties:
> -- compatible:  value should be as follows:
> -	(a) "hisilicon,hip06-lpc"
> -	(b) "hisilicon,hip07-lpc"
> -- #address-cells: must be 2 which stick to the ISA/EISA binding doc.
> -- #size-cells: must be 1 which stick to the ISA/EISA binding doc.
> -- reg: base memory range where the LPC register set is mapped.
> -
> -Note:
> -  The node name before '@' must be "isa" to represent the binding stick to the
> -  ISA/EISA binding specification.
> -
> -Example:
> -
> -isa@a01b0000 {
> -	compatible = "hisilicon,hip06-lpc";
> -	#address-cells = <2>;
> -	#size-cells = <1>;
> -	reg = <0x0 0xa01b0000 0x0 0x1000>;
> -
> -	ipmi0: bt@e4 {
> -		compatible = "ipmi-bt";
> -		device_type = "ipmi";
> -		reg = <0x01 0xe4 0x04>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.yaml b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.yaml
> new file mode 100644
> index 000000000000000..83ca10adce71b62
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/hisilicon/hisilicon-low-pin-count.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon Hip06 Low Pin Count device
> +
> +maintainers:
> +  - Wei Xu <xuwei5@hisilicon.com>
> +
> +description: |
> +  Hisilicon Hip06 SoCs implement a Low Pin Count (LPC) controller, which
> +  provides I/O access to some legacy ISA devices.
> +  Hip06 is based on arm64 architecture where there is no I/O space. So, the
> +  I/O ports here are not CPU addresses, and there is no 'ranges' property in
> +  LPC device node.
> +
> +properties:
> +  $nodename:
> +    pattern: '^isa@[0-9a-f]+$'
> +    description: |
> +      The node name before '@' must be "isa" to represent the binding stick
> +      to the ISA/EISA binding specification.
> +
> +  compatible:
> +    enum:
> +      - hisilicon,hip06-lpc
> +      - hisilicon,hip07-lpc
> +
> +  reg:
> +    description: base memory range where the LPC register set is mapped.

Drop description.

> +    maxItems: 1
> +
> +  '#address-cells':
> +    description: must be 2 which stick to the ISA/EISA binding doc.

Drop.

> +    const: 2
> +
> +  '#size-cells':
> +    description: must be 1 which stick to the ISA/EISA binding doc.

Drop.

> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg

additionalProperties:
  type: object

> +
> +examples:
> +  - |
> +    isa@a01b0000 {
> +        compatible = "hisilicon,hip06-lpc";
> +        #address-cells = <2>;
> +        #size-cells = <1>;
> +        reg = <0xa01b0000 0x1000>;
> +
> +        ipmi0: bt@e4 {
> +            compatible = "ipmi-bt";
> +            device_type = "ipmi";
> +            reg = <0x01 0xe4 0x04>;
> +        };
> +    };
> +...
> -- 
> 1.8.3
> 
> 
