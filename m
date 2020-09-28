Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F006E27B470
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgI1S0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:26:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46956 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgI1S0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:26:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id 95so1874909ota.13;
        Mon, 28 Sep 2020 11:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G1vwfsWv+nq29PSP/iaujHaq9i9b/1+o4mAfvtqnkwo=;
        b=WVeVqhG6tJFzYnVdRbpB6KdWLYq33pn3aEHkJ4C00UZvTJWA9U/z0oCb421onfbaHO
         kcKOUOlPgIUr5qODhwGmWoVUZxZDAQERaBQExk6YEgd8REwY8kZDWsTyWWXaDLej+z7k
         ZxxUTPIUJ9zQUN7uxg38KJIVAEpLipe+iMoPms/eeY9Hm+Bed6SbMzNW4H/k0HUiMJpr
         sH50ww/zTMEYj+xUgv94lFK4wdGYGNn9w5LO596kTLKTMUb50094g5xbxiG8uGlZzhbc
         2cqa4Qi4nnL9+EXGpZI+uMHWEQXQD6PIm1SohROgypjo/EUFoXCIs8bqs6l4/zX+wyrm
         uVgA==
X-Gm-Message-State: AOAM530Fem9oLvyZC7iDJEXqDuCH/G1VDvhfOdBkdTJQOIA70Z5kNnJG
        zY/7X/TonoZ8a9KVROtblfiDG85nJvS0
X-Google-Smtp-Source: ABdhPJzYAL9LwZzfn2QuSt+o6WBf2CTQqamn+zjxWQUMfB3YNQVhCn8BpjzmmQF5xSIIjJ5DUgbCfw==
X-Received: by 2002:a9d:4c0a:: with SMTP id l10mr208079otf.166.1601317606779;
        Mon, 28 Sep 2020 11:26:46 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s124sm382104oig.6.2020.09.28.11.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:26:46 -0700 (PDT)
Received: (nullmailer pid 3035690 invoked by uid 1000);
        Mon, 28 Sep 2020 18:26:45 -0000
Date:   Mon, 28 Sep 2020 13:26:45 -0500
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
Subject: Re: [PATCH v6 5/6] dt-bindings: dw-apb-ictl: convert to json-schema
Message-ID: <20200928182645.GA3030999@bogus>
References: <20200924071754.4509-1-thunder.leizhen@huawei.com>
 <20200924071754.4509-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924071754.4509-6-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 03:17:53PM +0800, Zhen Lei wrote:
> Convert the Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
> binding to DT schema format using json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../interrupt-controller/snps,dw-apb-ictl.txt      | 43 -------------
>  .../interrupt-controller/snps,dw-apb-ictl.yaml     | 74 ++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 43 deletions(-)
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
> index 000000000000000..1b05d36b5f7b943
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/snps,dw-apb-ictl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
> +
> +maintainers:
> +  - Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> +
> +description: |
> +  Synopsys DesignWare provides interrupt controller IP for APB known as
> +  dw_apb_ictl. The IP is used as secondary interrupt controller in some SoCs
> +  with APB bus, e.g. Marvell Armada 1500. It can also be used as primary
> +  interrupt controller in some SoCs, e.g. Hisilicon SD5203.
> +
> +  The interrupt sources map to the corresponding bits in the interrupt
> +  registers, i.e.
> +  - 0 maps to bit 0 of low interrupts,
> +  - 1 maps to bit 1 of low interrupts,
> +  - 32 maps to bit 0 of high interrupts,
> +  - 33 maps to bit 1 of high interrupts,
> +  - (optional) fast interrupts start at 64.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#

Don't need this. It's already selected based on node name.

> +
> +properties:
> +  compatible:
> +    const: snps,dw-apb-ictl
> +
> +  interrupt-controller: true
> +
> +  reg:
> +    description: |
> +      Physical base address of the controller and length of memory mapped
> +      region starting with ENABLE_LOW register.
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Interrupt reference to primary interrupt controller.

May not be primary. Could be another level in the middle. In any case, 
it's outside the scope of this binding, so just drop description.

> +    maxItems: 1
> +
> +  "#interrupt-cells":
> +    description: Number of cells to encode an interrupt-specifier.

Can drop this.

> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'

additionalProperties: false

> +
> +examples:
> +  - |
> +    /* dw_apb_ictl is used as secondary interrupt controller */
> +    aic: interrupt-controller@3000 {

Drop unused label (aic).

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

Same here.

> +        compatible = "snps,dw-apb-ictl";
> +        reg = <0x10130000 0x1000>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +    };
> +...
> -- 
> 1.8.3
> 
> 
