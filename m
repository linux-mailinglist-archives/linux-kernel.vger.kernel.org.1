Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C575427D21C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 17:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbgI2PG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 11:06:29 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33697 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgI2PG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:06:29 -0400
Received: by mail-oi1-f196.google.com with SMTP id m7so5828487oie.0;
        Tue, 29 Sep 2020 08:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q51+0kpKG++If96JY4iuqEBJznPYKCQMZac66BlnnGw=;
        b=VqEy4ijeSzI1wMl6jymnVhR+T4Up90bWeS/k1nXIRvHCYeul4T8K6f/s+oFMA2pR8U
         pxA+M7ftSrmOZtk5Izm7JM7ibmN5uGTNs8bV1y/46xPRb4dsSRzUXqI2YpcXNCJybFRd
         J6zBC0axq8wlEGMwaCT3xI2Pdd9i8Oi46pQ/zKfPDw6yKnUmMd6rnu4gdVSQis6JeiIm
         I83/Ln9pVCjscg3PP9QdXSih+3C0VkpuwYF7YT0/nRuj7hrYOpOQBX2s+6oK1FCf3sny
         8xjb/KWavG0tteOuE5hwE13lAizyhpt6XG9LUbC59fl+AE57WJdr8kv/E2yy/BlTgfoi
         Wg8g==
X-Gm-Message-State: AOAM530QWFoEQb1+6JxlJ9KtsuLIC06DkN9UfnKwuOlSo1RUAbfy0+4R
        iz4hwNK71h2L5XY48pwpPg==
X-Google-Smtp-Source: ABdhPJzBjAHj06FvIaZPnGZgvzAtwqvCwwRaR5pjRc8W15jVZfnm3inQMHKlEFZ6EXKMgDXx0LYZdw==
X-Received: by 2002:a54:4783:: with SMTP id o3mr2954476oic.89.1601391986131;
        Tue, 29 Sep 2020 08:06:26 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 17sm1034575oth.70.2020.09.29.08.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 08:06:25 -0700 (PDT)
Received: (nullmailer pid 597943 invoked by uid 1000);
        Tue, 29 Sep 2020 15:06:24 -0000
Date:   Tue, 29 Sep 2020 10:06:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] regulator: rtmv20: Add DT-binding document for
 Richtek RTMV20
Message-ID: <20200929150624.GA583524@bogus>
References: <1601277584-5526-1-git-send-email-u0084500@gmail.com>
 <1601277584-5526-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601277584-5526-2-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 03:19:44PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add DT-binding document for Richtek RTMV20
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../regulator/richtek,rtmv20-regulator.yaml        | 168 +++++++++++++++++++++
>  1 file changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
> new file mode 100644
> index 00000000..4cb4b68
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
> @@ -0,0 +1,168 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rtmv20-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RTMV20 laser diode regulator
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  Richtek RTMV20 is a load switch current regulator that can supply up to 6A.
> +  It is used to drive laser diode. There're two signals for chip controls
> +  (Enable/Fail), Enable pin to turn chip on, and Fail pin as fault indication.
> +  There're still four pins for camera control, two inputs (strobe and vsync),
> +  the others for outputs (fsin1 and fsin2). Strobe input to start the current
> +  supply, vsync input from IR camera, and fsin1/fsin2 output for the optional.
> +
> +properties:
> +  compatible:
> +    const: richtek,rtmv20
> +
> +  reg:
> +    maxItems: 1
> +
> +  wakeup-source: true
> +
> +  interrupts-extend:

You mean interrupts-extended?

In any case, use 'interrupts' here and the tooling allows for either.

> +    maxItems: 1
> +
> +  enable-gpios:
> +    description: A connection of the 'enable' gpio line.
> +    maxItems: 1
> +
> +  ld-pulse-delay-us:
> +    description: |
> +      load current pulse delay in microsecond after strobe pin pulse high.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Don't need a type ref when you have a standard property unit suffix, so 
drop.

This and all the following need a vendor prefix too.

> +    minimum: 0
> +    maximum: 100000
> +    default: 0
> +
> +  ld-pulse-width-us:
> +    description: |
> +      Load current pulse width in microsecond after strobe pin pulse high.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 0
> +    maximum: 10000
> +    default: 1200
> +
> +  fsin1-delay-us:
> +    description: |
> +      Fsin1 pulse high delay in microsecond after vsync signal pulse high.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 0
> +    maximum: 100000
> +    default: 23000
> +
> +  fsin1-width-us:
> +    description: |
> +      Fsin1 pulse high width in microsecond after vsync signal pulse high.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 40
> +    maximum: 10000
> +    default: 160
> +
> +  fsin2-delay-us:
> +    description: |
> +      Fsin2 pulse high delay in microsecond after vsync signal pulse high.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 0
> +    maximum: 100000
> +    default: 23000
> +
> +  fsin2-width-us:
> +    description: |
> +      Fsin2 pulse high width in microsecond after vsync signal pulse high.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 40
> +    maximum: 10000
> +    default: 160
> +
> +  es-pulse-width-us:
> +    description: Eye safety function pulse width limit in microsecond.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 0
> +    maximum: 10000
> +    default: 1200
> +
> +  es-ld-current-microamp:
> +    description: Eye safety function load current limit in microamp.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 0
> +    maximum: 6000000
> +    default: 3000000
> +
> +  lbp-level-microvolt:
> +    description: Low battery protection level in microvolt.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 2400000
> +    maximum: 3700000
> +    default: 2700000
> +
> +  lbp-enable:
> +    description: Low battery protection function enable control.
> +    type: boolean
> +
> +  strobe-polarity-high:
> +    description: Strobe pin active polarity control.
> +    type: boolean
> +
> +  vsync-polarity-high:
> +    description: Vsync pin active polarity control.
> +    type: boolean
> +
> +  fsin-enable:
> +    description: Fsin function enable control.
> +    type: boolean
> +
> +  fsin-output:
> +    description: Fsin function output control.
> +    type: boolean
> +
> +  es-enable:
> +    description: Eye safety function enable control.
> +    type: boolean
> +
> +patternProperties:
> +  "lsw":

This matches ".*lsw.*". What you wanted? If just 'lsw', then it's not a 
pattern.

> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +required:
> +  - compatible
> +  - reg
> +  - wakeup-source
> +  - interrupts-extend
> +  - enable-gpios
> +  - lsw
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      rtmv20@34 {
> +        compatible = "richtek,rtmv20";
> +        reg = <0x34>;
> +        wakeup-source;
> +        interrupts-extend = <&gpio26 2 IRQ_TYPE_LEVEL_LOW>;

2 wrongs make a right... But your driver interrupt probably doesn't work 
too well.

> +        enable-gpios = <&gpio26 3 0>;
> +
> +        strobe-polarity-high;
> +        vsync-polarity-high;
> +
> +        lsw {
> +                regulator-name = "rtmv20,lsw";
> +                regulator-min-microamp = <0>;
> +                regulator-max-microamp = <6000000>;
> +        };
> +      };
> +    };
> +...
> -- 
> 2.7.4
> 
