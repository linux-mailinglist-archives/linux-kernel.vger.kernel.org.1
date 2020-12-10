Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2F62D5F47
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389882AbgLJPPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:15:07 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:44507 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbgLJPPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:15:06 -0500
Received: by mail-oo1-f67.google.com with SMTP id n20so1337000ooq.11;
        Thu, 10 Dec 2020 07:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/2ICDieRWjmXwB0t0DO2OEVIf1oMZ1c+b9dpFDL5Kao=;
        b=pKVu/hZ5abJtc3rsh5u9lx8wpWzNlx7aJhTOZjpp1l+f/3cuuX60pRTjRfHOHZ7j6o
         4pG1R+HS/X/gb1JHqpAJH9lPfgfRjxH4BinPQqrWpaHqsFAwm7mGQZj1WYOuRK9Ru1kB
         0BF4exhSMYnu2g3znIEQ9bWiveD8bnKYm099cwnNTmiot5NywlhkWW2LYGQkVFcu8GBi
         WuAk5WoaGCKWh7Fv+69p1vjxcp5LkbvJ61wtJVOvikgRWH+potXc/pbcNGyyAYD9+5ue
         ND8zqFr2XUcCGZCg0Tmg2xpbpdChQOOqYw8QPxJji9y3dY5jeFk2qk6B4bSTNdS8ucMI
         ahIg==
X-Gm-Message-State: AOAM531ARzS66/MRY3y6ziuleKmVWfLmSAzLZS0LMFpPM8pif3lNdUBm
        2RHC7AcMOYcFv4pj29DBNQ==
X-Google-Smtp-Source: ABdhPJzNOv68yvYApWCJzaHbEeBuqZ6ntvMljIV3HNrnWVYHNsXivrrPTziyBmaRS8N6ocGSmvYPzg==
X-Received: by 2002:a4a:d5d3:: with SMTP id a19mr6248719oot.61.1607613265659;
        Thu, 10 Dec 2020 07:14:25 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j73sm1127856otj.37.2020.12.10.07.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 07:14:24 -0800 (PST)
Received: (nullmailer pid 2517623 invoked by uid 1000);
        Thu, 10 Dec 2020 15:14:23 -0000
Date:   Thu, 10 Dec 2020 09:14:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lee.jones@linaro.org, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Message-ID: <20201210151423.GA2513215@robh.at.kernel.org>
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

We have common schema for these. You need to reference that and drop 
'description' and the type ref.

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
