Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068532D95B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395401AbgLNKAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 05:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395150AbgLNKAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:00:02 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FC5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:59:20 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so15840949wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lag9BmrNw8b/MOCts4/jnsH9iFI4r4mDqHN8etcAzkk=;
        b=rUGR8XR8KoYIHB3MtJ2p0Xu9+jgAKhbnGQpbq6QPKF//wLn5LPZaXFElAunSnv3EJJ
         xehNjFbIHS4u1gUhJlIYMrwzrNTQamoc/lBiFtmdnhaIWbSpeSbczKKKBdevtaiR9S3P
         eJqyZp2kM0LZ0NvzrNmeaOa2Qa9Bm/PJKf/No32FNBVfhbM4SUKdns6wiMjC9nE2vL0f
         UpTXy7zBGxpYajnmvjyH3Vd27ces/XJwt8+nsbJ5n6MOdU95qKh1HsQ10DyrXuffbies
         1nAH+QslpRVgUfI9S0nBFOXExt9zLolMDZCic0f6IxHalEXysivH6nR7FQKf0aqA7X04
         yHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lag9BmrNw8b/MOCts4/jnsH9iFI4r4mDqHN8etcAzkk=;
        b=enE3CtF43wPpqQJfDxV0oTKgVVJpv1UB5WNiTmW3sYRBpawYInLF4bJMDnILQ/33ej
         Cau//+Q/ZHeozMFZx2bjhF+VoTcd9OYXd6WCS+m9/ZsNkCdzFZNr7am7ft2BesHg4WdS
         Y76iAbNfy25oTDHfjytBdnSW/btAqGJHo080Kgud1edJrPJ8E3ButCEai4celPR6IX7o
         qmacknn908M8XVul3cVxwTVVpTt38m05D9b3czydFnD/FR4nuBXipDGDokqPaPtHnM+K
         exjagnGIGul+PstlUKdVGlQK/7a5IRxedSiBtQGvUKEQNQ7YFO88MdNUl7auxIa4W0eT
         Lxww==
X-Gm-Message-State: AOAM530HpOVyYQvzK8yPqz482gSkBbFwuo/UeAjsd9/NvYnTjcFmyk8R
        n9eU+evbtd7MtSrkpKKWV43nyw==
X-Google-Smtp-Source: ABdhPJyMIkTpli5gAUjbz2gC0YP8CJHtKSrB+oj1RlvI5oaFGKWTB3U7Hek4nJfmVTTlj/DP697eGQ==
X-Received: by 2002:adf:ab4b:: with SMTP id r11mr11898993wrc.282.1607939959088;
        Mon, 14 Dec 2020 01:59:19 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id 138sm33360453wma.41.2020.12.14.01.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 01:59:17 -0800 (PST)
Date:   Mon, 14 Dec 2020 09:59:16 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Message-ID: <20201214095916.4g47zlueng4wa3hv@holly.lan>
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
 <1607704424-16223-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607704424-16223-2-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CY

On Sat, Dec 12, 2020 at 12:33:43AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds DT binding document for Richtek RT4831 backlight.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

This patch got keyword filtered and brought to my attention
but the rest of the series did not.

If it was a backlight patch series you need to send it To: the
all the backlight maintainers.


Daniel.


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
