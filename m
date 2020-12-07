Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8097B2D16A9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgLGQnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:43:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33849 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:43:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id h19so13066742otr.1;
        Mon, 07 Dec 2020 08:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CFlvQN+PdkdlNAjwkdSFmc/z0KRhFnG4zyN2I5c1VZY=;
        b=o7felVCKA+XYceV3sf/YecLOZ4WdBVH2eX0oSZvfolQ0vl2UN0gkf9JyX6LlCPGcJR
         ZMFimkDG/Ef56vzP970wWPmWYyVBKs78vkziKlLbDCCOriAa6Q8om8pAdx6PWcYcrnOu
         dci0RARoJZo6yU64xEmECOmxVap08L9HBaWi+OcxjNM1sEuMr+swWNVQF8Up+kD+Qf8A
         3Xg+6RGXAMNxGlawCzWcKrywP4Eag4flRX0Cv5SAZFqkDndW6z55A7JHZtAl/sn9l7HH
         zqvSnnvIk81PRhotOf+unvdLwRJxgP4aGAm4zb9Elhw8mTc2OXYTwDXrS2yn9OGKAsRh
         HPNg==
X-Gm-Message-State: AOAM53376WckiBEWbV1CqyZy/7cxCJORbta1yRLTL4XrlCRGFjvk1hav
        U6ue6L5WUBDJzQiaGfl8SS8XmExXcA==
X-Google-Smtp-Source: ABdhPJxLzMXfffs9sVwLUZQlyBgmKmK9vxHjiv008VNzfjweUiASreG9xwjpTKq67uv0l6MHRlfn+Q==
X-Received: by 2002:a9d:38e:: with SMTP id f14mr1134475otf.201.1607359369473;
        Mon, 07 Dec 2020 08:42:49 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y18sm2686328ooj.20.2020.12.07.08.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:42:48 -0800 (PST)
Received: (nullmailer pid 411198 invoked by uid 1000);
        Mon, 07 Dec 2020 16:42:47 -0000
Date:   Mon, 7 Dec 2020 10:42:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lee.jones@linaro.org, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Message-ID: <20201207164247.GB398093@robh.at.kernel.org>
References: <1607011595-13603-1-git-send-email-u0084500@gmail.com>
 <1607011595-13603-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607011595-13603-2-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 12:06:33AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds DT binding document for Richtek RT4831 backlight.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../leds/backlight/richtek,rt4831-backlight.yaml   | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> new file mode 100644
> index 00000000..df1439a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0
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
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      rt4831@11 {
> +        compatible = "richtek,rt4831";
> +        reg = <0x11>;
> +
> +        backlight {
> +          compatible = "richtek,rt4831-backlight";
> +          default-brightness = <1024>;
> +          max-brightness = <2048>;
> +          richtek,bled-ovp-sel = /bits/ 8 <RT4831_BLOVPLVL_21V>;
> +          richtek,channel-use = /bits/ 8 <RT4831_BLED_ALLCHEN>;
> +        };
> +      };

Just do 1 complete example in the mfd binding.

> +    };
> -- 
> 2.7.4
> 
