Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA35F2D5F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391836AbgLJPVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:21:09 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46177 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391405AbgLJPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:16:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id k2so6039595oic.13;
        Thu, 10 Dec 2020 07:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TU5SQIV+L1Qh1aETHl0Fje+jDI0iozpBANZIdOFfGJw=;
        b=eMLLvPowxbH27v6nULkVPBay40+1urpzC1YK2kKmFr/Y41LsXICA6iwVYDYzlztYUq
         YBpdXcFTvtBzbOHHWz6YXNkIamAUP55gtPIQ9RzfqyV5uGwkqcBuR/EPRQbGlMbuuj7M
         tD97nAwHJFcBxW0H4w3PsLwpELn1b2KEFhqgTQdXrBBmngrzTc2GzktlGg0gUu7WqprF
         nYTFpjHHxOxPK0onrqXs7N0z3TzUruTYqkWq/gULQ83a9/1af3kuGAzw0OPPo6zzxRnw
         Zm3t0K1kS3OyJHR5XZfACxDIFk47ttKrZQPPHxlOC516tjwI+gFgI0zQmkJjRalPljT1
         LRwA==
X-Gm-Message-State: AOAM532qh9UsjL/JTpQ+yFXVWIIRO0mQ2oJ0I2+p0UMQcszqQGvy5plG
        6ISOpbU3/epv+WeQ4WNmQA==
X-Google-Smtp-Source: ABdhPJwaXTvEM7JvgePPAzzhRA/CQPFw36bWt9jEwVGHCaqf7gBHmmOR3I44LXa/XUD3aA8hrUrDuQ==
X-Received: by 2002:aca:f1c1:: with SMTP id p184mr5834808oih.54.1607613371692;
        Thu, 10 Dec 2020 07:16:11 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r204sm667814oif.0.2020.12.10.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 07:16:10 -0800 (PST)
Received: (nullmailer pid 2520024 invoked by uid 1000);
        Thu, 10 Dec 2020 15:16:09 -0000
Date:   Thu, 10 Dec 2020 09:16:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lee.jones@linaro.org, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Message-ID: <20201210151609.GA2518014@robh.at.kernel.org>
References: <1607442886-13046-1-git-send-email-u0084500@gmail.com>
 <1607442886-13046-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607442886-13046-2-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 11:54:44PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds DT binding document for Richtek RT4831 backlight.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> since v3
> - Move inlcude/dt-bindings/leds/rt4831-backlight.h from patch 0004 to here.
> - Add dual license tag in header and backlight binding document.
> - Left backlight dt-binding example only.
> ---
>  .../leds/backlight/richtek,rt4831-backlight.yaml   | 76 ++++++++++++++++++++++
>  include/dt-bindings/leds/rt4831-backlight.h        | 23 +++++++
>  2 files changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
>  create mode 100644 include/dt-bindings/leds/rt4831-backlight.h
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> new file mode 100644
> index 00000000..f24c8d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/richtek,rt4831-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT4831 Backlight
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  RT4831 is a mutifunctional device that can provide power to the LCD display
> +  and LCD backlight.
> +
> +  For the LCD backlight, it can provide four channel WLED driving capability.
> +  Each channel driving current is up to 30mA
> +
> +  Datasheet is available at
> +  https://www.richtek.com/assets/product_file/RT4831A/DS4831A-05.pdf
> +
> +properties:
> +  compatible:
> +    const: richtek,rt4831-backlight
> +
> +  default-brightness:
> +    description: |
> +      The default brightness that applied to the system on start-up.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 2048
> +
> +  max-brightness:
> +    description: |
> +      The max brightness for the H/W limit
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 2048
> +
> +  richtek,pwm-enable:
> +    description: |
> +      Specify the backlight dimming following by PWM duty or by SW control.
> +    type: boolean
> +
> +  richtek,bled-ovp-sel:
> +    description: |
> +      Backlight OVP level selection, currently support 17V/21V/25V/29V.
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    default: 1
> +    minimum: 0
> +    maximum: 3
> +
> +  richtek,channel-use:
> +    description: |
> +      Backlight LED channel to be used.
> +      BIT 0/1/2/3 is used to indicate led channel 1/2/3/4 enable or disable.
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    minimum: 1
> +    maximum: 15
> +
> +required:
> +  - compatible
> +  - richtek,channel-use
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/rt4831-backlight.h>
> +    backlight {
> +      compatible = "richtek,rt4831-backlight";
> +      default-brightness = <1024>;
> +      max-brightness = <2048>;
> +      richtek,bled-ovp-sel = /bits/ 8 <RT4831_BLOVPLVL_21V>;
> +      richtek,channel-use = /bits/ 8 <RT4831_BLED_ALLCHEN>;
> +    };

Also, drop the example here and in the regulator schema as it's in the 
mfd schema.

Rob
