Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D107427626F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIWUtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:49:15 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35406 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWUtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:49:15 -0400
Received: by mail-il1-f196.google.com with SMTP id y9so982248ilq.2;
        Wed, 23 Sep 2020 13:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbPN0IsTe/AzYliyDTAEb4gLEMtnTq3id+26NLSo9hs=;
        b=rRpH1+Citm79etiArqEXa8wgtgDTiua3WopmD0YgqHxlWc3Qqwfx805GQvpl0PFy0s
         W3QqNj1Cv298CJg5zStvvhEYkvLahhTtryhyNaon2E8RuCSgDQR0CO+umce2AiHmnGd5
         lyKbfpBbSbYUNs8Oae4GpLxhx/sBQwY7g4TuO3YHFMoJMta3rN2YAtohVp0Q4kACXWMh
         h+qklRCpZSZsKzHgqo/UF3DDii0smIt05pjcTRQsicBKCqM/xJbBcxn/+HG5YCp15/U/
         EmWM0suTqnUMlJWxtT1VTxburbWiY/T0i+hjx2i5Hz6etTVH13+wx8lLyi+AIJYj0VLX
         h1Bg==
X-Gm-Message-State: AOAM5319cavJkINDC03TXx8Iza3DTBvR5CoAw8eihuPHV7AeC3UTQgit
        3bnVZP6bVqyVXl9f84rg+Q==
X-Google-Smtp-Source: ABdhPJx2NYFLXdhLRlVGU3qRt4AeTTUVd5Jg+bpArf4OM3OVNhdYph/XlROi4NQ5tYzY7v5uuT+5eA==
X-Received: by 2002:a92:405d:: with SMTP id n90mr1372340ila.58.1600894153546;
        Wed, 23 Sep 2020 13:49:13 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r8sm409462iot.51.2020.09.23.13.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:49:12 -0700 (PDT)
Received: (nullmailer pid 1281407 invoked by uid 1000);
        Wed, 23 Sep 2020 20:49:11 -0000
Date:   Wed, 23 Sep 2020 14:49:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-snps-arc <linux-snps-arc@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v5 5/6] dt-bindings: dw-apb-ictl: convert to json-schema
Message-ID: <20200923204911.GA1271664@bogus>
References: <20200918112202.3418-1-thunder.leizhen@huawei.com>
 <20200918112202.3418-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918112202.3418-6-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 07:22:01PM +0800, Zhen Lei wrote:
> Convert the Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
> binding to DT schema format using json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../interrupt-controller/snps,dw-apb-ictl.txt      | 43 -------------
>  .../interrupt-controller/snps,dw-apb-ictl.yaml     | 75 ++++++++++++++++++++++
>  2 files changed, 75 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
> deleted file mode 100644
> index 2db59df9408f4c6..000000000000000
> --- a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
> -
> -Synopsys DesignWare provides interrupt controller IP for APB known as
> -dw_apb_ictl. The IP is used as secondary interrupt controller in some SoCs with
> -APB bus, e.g. Marvell Armada 1500. It can also be used as primary interrupt
> -controller in some SoCs, e.g. Hisilicon SD5203.
> -
> -Required properties:
> -- compatible: shall be "snps,dw-apb-ictl"
> -- reg: physical base address of the controller and length of memory mapped
> -  region starting with ENABLE_LOW register
> -- interrupt-controller: identifies the node as an interrupt controller
> -- #interrupt-cells: number of cells to encode an interrupt-specifier, shall be 1
> -
> -Additional required property when it's used as secondary interrupt controller:
> -- interrupts: interrupt reference to primary interrupt controller
> -
> -The interrupt sources map to the corresponding bits in the interrupt
> -registers, i.e.
> -- 0 maps to bit 0 of low interrupts,
> -- 1 maps to bit 1 of low interrupts,
> -- 32 maps to bit 0 of high interrupts,
> -- 33 maps to bit 1 of high interrupts,
> -- (optional) fast interrupts start at 64.
> -
> -Example:
> -	/* dw_apb_ictl is used as secondary interrupt controller */
> -	aic: interrupt-controller@3000 {
> -		compatible = "snps,dw-apb-ictl";
> -		reg = <0x3000 0xc00>;
> -		interrupt-controller;
> -		#interrupt-cells = <1>;
> -		interrupt-parent = <&gic>;
> -		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> -	};
> -
> -	/* dw_apb_ictl is used as primary interrupt controller */
> -	vic: interrupt-controller@10130000 {
> -		compatible = "snps,dw-apb-ictl";
> -		reg = <0x10130000 0x1000>;
> -		interrupt-controller;
> -		#interrupt-cells = <1>;
> -	};
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml
> new file mode 100644
> index 000000000000000..70c12979c843bf0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/snps,dw-apb-ictl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
> +
> +maintainers:
> +  - Marc Zyngier <marc.zyngier@arm.com>

Usually this would be an owner for this IP block, not the subsystem 
maintainer.

> +
> +description:
> +  Synopsys DesignWare provides interrupt controller IP for APB known as
> +  dw_apb_ictl. The IP is used as secondary interrupt controller in some SoCs
> +  with APB bus, e.g. Marvell Armada 1500. It can also be used as primary
> +  interrupt controller in some SoCs, e.g. Hisilicon SD5203.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#

You can drop this, it's already applied based on node name.

> +
> +properties:
> +  compatible:
> +    const: snps,dw-apb-ictl
> +
> +  interrupt-controller: true
> +
> +  reg:
> +    description:
> +      Physical base address of the controller and length of memory mapped
> +      region starting with ENABLE_LOW register.

Need to define how many reg regions (maxItems: 1).

> +
> +  interrupts:
> +    description:
> +      Interrupt reference to primary interrupt controller.
> +
> +      The interrupt sources map to the corresponding bits in the interrupt
> +      registers, i.e.
> +      - 0 maps to bit 0 of low interrupts,
> +      - 1 maps to bit 1 of low interrupts,
> +      - 32 maps to bit 0 of high interrupts,
> +      - 33 maps to bit 1 of high interrupts,
> +      - (optional) fast interrupts start at 64.
> +    minItems: 1
> +    maxItems: 65

65 connections to the primary interrupt controller? I think this is for 
the child interrupts? If so, move to #interrupt-cells description 
instead.

> +
> +  "#interrupt-cells":
> +    description:
> +      Number of cells to encode an interrupt-specifier.

Drop. No need to redefine common properties.

> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +examples:
> +  - |
> +    /* dw_apb_ictl is used as secondary interrupt controller */
> +    aic: interrupt-controller@3000 {
> +        compatible = "snps,dw-apb-ictl";
> +        reg = <0x3000 0xc00>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +        interrupt-parent = <&gic>;
> +        interrupts = <0 3 4>;
> +    };
> +
> +    /* dw_apb_ictl is used as primary interrupt controller */
> +    vic: interrupt-controller@10130000 {
> +        compatible = "snps,dw-apb-ictl";
> +        reg = <0x10130000 0x1000>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +    };
> -- 
> 1.8.3
> 
> 
