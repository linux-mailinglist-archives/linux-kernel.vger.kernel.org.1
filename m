Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8542F22C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 23:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390298AbhAKWaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 17:30:20 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:45296 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387685AbhAKWaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:30:18 -0500
Received: by mail-oi1-f180.google.com with SMTP id f132so256087oib.12;
        Mon, 11 Jan 2021 14:30:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i7Idf40NH7Ty9nJrx5Yaxf+ob9NMOeW9pdgHg1LM+oA=;
        b=ROk83dSRQJoH4v9dfH9BHXa6TWyQdspwnJPoIsMjt0O8cb8PkLif5gaUppBBI8rlDv
         N/se/PvNE3MVEmNGq4AxcZL3w4wwSD7Y75JzXU5n+AGfG2nNC8BOQk9gOBU/5C587Tv8
         16I8ffHafTvFjt4Sewnq72dlAsY1rTcbKJ3WsV0A4asASx+Fx4puRfzbIJUhWbJqBpIL
         pADEPc4CQBG7pdrqvib+1N778dZX1qgXo/DdPciUwx5vzq4PO/n5lMGxuUjITw9+iALK
         Hi879lPu5+R115fKorn9pQPMFkoj4o64tjgROCdOY0KnKLmvCQc/l+uaPVSmHkSKSIzZ
         R0MA==
X-Gm-Message-State: AOAM530oQR9wA/PVNU7uwV3EbZ96YYsIVqRfAUb/nrzr852jGx09leya
        XTaHvc8M5ecUcW1wgnojUw==
X-Google-Smtp-Source: ABdhPJyxysdtVo0vwJ1eOHRxjvbTi5a5YO13vF6QU/7rmwqWO0hfG4aR4KwmMMe8Rv0cXVIbi5+Qpw==
X-Received: by 2002:aca:efc6:: with SMTP id n189mr587120oih.161.1610404176501;
        Mon, 11 Jan 2021 14:29:36 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h7sm243118otq.21.2021.01.11.14.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 14:29:35 -0800 (PST)
Received: (nullmailer pid 3174164 invoked by uid 1000);
        Mon, 11 Jan 2021 22:29:34 -0000
Date:   Mon, 11 Jan 2021 16:29:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 01/10] dt-bindings: irq: sun6i-r: Split the binding
 from sun7i-nmi
Message-ID: <20210111222934.GA3170411@robh.at.kernel.org>
References: <20210103103101.33603-1-samuel@sholland.org>
 <20210103103101.33603-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103103101.33603-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 03, 2021 at 04:30:52AM -0600, Samuel Holland wrote:
> The R_INTC in the A31 and newer sun8i/sun50i SoCs has additional
> functionality compared to the sun7i/sun9i NMI controller. Among other
> things, it multiplexes up to 128 interrupts corresponding to (and in
> parallel to) the first 128 GIC SPIs. This means the NMI is no longer the
> lowest-numbered interrupt, since it is SPI 32 or 96 (depending on SoC).
> 
> To allow access to all multiplexed IRQs, the R_INTC requires a new
> binding where the interrupt number matches the GIC interrupt number.
> For simplicity, copy the three-cell GIC binding; this disambiguates
> interrupt 0 in the old binding (the NMI) from interrupt 0 in the new
> binding (SPI 0) by the number of cells.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../allwinner,sun6i-a31-r-intc.yaml           | 64 +++++++++++++++++++
>  .../allwinner,sun7i-a20-sc-nmi.yaml           | 10 ---
>  2 files changed, 64 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
> new file mode 100644
> index 000000000000..18805b6555c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner A31 NMI/Wakeup Interrupt Controller Device Tree Bindings
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  "#interrupt-cells":
> +    const: 3
> +    description:
> +      The first cell is GIC_SPI (0), the second cell is the IRQ number, and
> +      the third cell is the trigger type as defined in interrupt.txt in this
> +      directory.
> +
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - allwinner,sun8i-a83t-r-intc
> +              - allwinner,sun50i-a64-r-intc
> +              - allwinner,sun50i-h6-r-intc
> +          - const: allwinner,sun6i-a31-r-intc
> +      - const: allwinner,sun6i-a31-r-intc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +required:
> +  - "#interrupt-cells"
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +
> +unevaluatedProperties: false

additionalProperties: false

(a bit stricter and actually implemented ATM)

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    r_intc: interrupt-controller@1f00c00 {
> +            compatible = "allwinner,sun50i-a64-r-intc",
> +                         "allwinner,sun6i-a31-r-intc";
> +            interrupt-controller;
> +            #interrupt-cells = <3>;
> +            reg = <0x01f00c00 0x400>;
> +            interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
> index 8acca0ae3129..f34ecc8c7093 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
> @@ -22,23 +22,13 @@ properties:
>  
>    compatible:
>      oneOf:
> -      - const: allwinner,sun6i-a31-r-intc
>        - const: allwinner,sun6i-a31-sc-nmi
>          deprecated: true
>        - const: allwinner,sun7i-a20-sc-nmi
> -      - items:
> -          - const: allwinner,sun8i-a83t-r-intc
> -          - const: allwinner,sun6i-a31-r-intc
>        - const: allwinner,sun9i-a80-nmi
> -      - items:
> -          - const: allwinner,sun50i-a64-r-intc
> -          - const: allwinner,sun6i-a31-r-intc
>        - items:
>            - const: allwinner,sun50i-a100-nmi
>            - const: allwinner,sun9i-a80-nmi
> -      - items:
> -          - const: allwinner,sun50i-h6-r-intc
> -          - const: allwinner,sun6i-a31-r-intc
>  
>    reg:
>      maxItems: 1
> -- 
> 2.26.2
> 
