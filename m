Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3FA2DA411
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgLNXT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:19:29 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:44688 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgLNXTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:19:19 -0500
Received: by mail-oo1-f65.google.com with SMTP id j21so1777880oou.11;
        Mon, 14 Dec 2020 15:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gz6RZjvTy9oUAq3/SV0rx+zO1XkSdKeASLSSAtga9pc=;
        b=Sw1iQ99i7OeZh5IiyqMWOrRzJ5CaLT3qm9LKW4lFFFyWixzXBaYp8ZXbZW2si5ipBM
         FxfG3Ifsm/1mXfkMe1ADXagw2MQNfJs1MRQiipd7JuKBuotDee5LaTBPrq5zQwnrj0hE
         ku413oksI/RU0ho/B5k3TqDyTpYG3Lkc9CpFVi93TJNnK/heKY5BE14f9s5nSwYmkxUx
         J0ZErlCITH3qkQ5AzqWFzezi4ePrHupeXTWke3MCYlCYP2DGFCbCxJ3zUEefJZg0jXuS
         hh2TGrCG6VJYfsNERxMu0x3WvyQ4+XFxWQJ5sMjAPanxOFzrLDiGc+MBVP/PeYU4Cci4
         LZpA==
X-Gm-Message-State: AOAM531xvGqhI95SbGOlmyNhI5flxuoYNzlGOZc3yl5QIpojVl4EVYUL
        RpZoWJQSNvzahdSuDmLOYw==
X-Google-Smtp-Source: ABdhPJxnye+p+dAjJoGUHSgNXf4suQ0cgyJzdmc7OtobsMvZjyFuHEKNmf6h3mXHc+qun7dsCzst1A==
X-Received: by 2002:a4a:8c73:: with SMTP id v48mr5682467ooj.53.1607987917887;
        Mon, 14 Dec 2020 15:18:37 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e81sm4610512oia.30.2020.12.14.15.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:18:37 -0800 (PST)
Received: (nullmailer pid 2565959 invoked by uid 1000);
        Mon, 14 Dec 2020 23:18:36 -0000
Date:   Mon, 14 Dec 2020 17:18:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lee.jones@linaro.org, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Message-ID: <20201214231836.GB2560842@robh.at.kernel.org>
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
 <1607704424-16223-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607704424-16223-2-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 12:33:43AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds DT binding document for Richtek RT4831 backlight.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> since v3
> - Move inlcude/dt-bindings/leds/rt4831-backlight.h from v3 mfd binding patch to here.
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

This is in the MFD schema already, so drop the example.

> +    };
> diff --git a/include/dt-bindings/leds/rt4831-backlight.h b/include/dt-bindings/leds/rt4831-backlight.h
> new file mode 100644
> index 00000000..125c635
> --- /dev/null
> +++ b/include/dt-bindings/leds/rt4831-backlight.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * This header provides constants for rt4831 backlight bindings.
> + *
> + * Copyright (C) 2020, Richtek Technology Corp.
> + * Author: ChiYuan Huang <cy_huang@richtek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_RT4831_BACKLIGHT_H
> +#define _DT_BINDINGS_RT4831_BACKLIGHT_H
> +
> +#define RT4831_BLOVPLVL_17V	0
> +#define RT4831_BLOVPLVL_21V	1
> +#define RT4831_BLOVPLVL_25V	2
> +#define RT4831_BLOVPLVL_29V	3
> +
> +#define RT4831_BLED_CH1EN	(1 << 0)
> +#define RT4831_BLED_CH2EN	(1 << 1)
> +#define RT4831_BLED_CH3EN	(1 << 2)
> +#define RT4831_BLED_CH4EN	(1 << 3)
> +#define RT4831_BLED_ALLCHEN	((1 << 4) - 1)
> +
> +#endif /* _DT_BINDINGS_RT4831_BACKLIGHT_H */
> -- 
> 2.7.4
> 
