Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B1B2AFC2F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgKLBdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:33:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38526 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbgKKWum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:50:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so3761213otf.5;
        Wed, 11 Nov 2020 14:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oe8Trn0rh4GUI+osEdBmwuarl9l3QobQEYdZ1Nxtnys=;
        b=LLMbDHiniYE2Vw5G8QKw9cgPjhY4OqQebMdbBG/EQCcm2j0SLJWd7UVy8Cd7XD1TAk
         4xecgWxZ/clmc/1hyOPdTQgL63ZTWIPsksI2gpeq0txS0xphLUKJwk4gWLygmMPN16gl
         idXVBVvmlzx7Z2JRb+/MMMdRqKUDObWiZeNj6Tg8Rvh9QNyg+is/PSzfMa/mTqG92pFb
         PMgHi9up074kHxynad7OdLc546MFsEJ6eCI4RB+YW4/ez+DNTA6F8Z/hG5Y1graIGpv6
         oml0MT5bjc0vRpmfuamMx5nU/mpP/x5C6YKRCdOtoHTqTL2ks07DISmPfpymet2hbVzs
         VmgQ==
X-Gm-Message-State: AOAM530tWJlaNBEDXtevKiTu+5sRH/lW0m16GDMkdOOPUOsaVLMAB4d9
        CdkPfqFsaOT4a5dcLYVN7Q==
X-Google-Smtp-Source: ABdhPJySmi0OCWmbGuGKV0MBO/vl/T6YZudO7K0ZMEqS/69OE5D0SaQbbltnyj5oOkEcZlTcPN9YKQ==
X-Received: by 2002:a9d:8d7:: with SMTP id 81mr19790315otf.345.1605135041695;
        Wed, 11 Nov 2020 14:50:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m10sm866796oon.27.2020.11.11.14.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 14:50:40 -0800 (PST)
Received: (nullmailer pid 2190873 invoked by uid 1000);
        Wed, 11 Nov 2020 22:50:39 -0000
Date:   Wed, 11 Nov 2020 16:50:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     tiny.windzz@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [RESEND PATCH 12/19] dt-bindings: Add bindings for USB phy on
 Allwinner A100
Message-ID: <20201111225039.GA2185181@bogus>
References: <cover.1604988979.git.frank@allwinnertech.com>
 <1ce71bac2732620f8fe77b23ca84e062385e7e8a.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ce71bac2732620f8fe77b23ca84e062385e7e8a.1604988979.git.frank@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 02:39:42PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> Add a device tree binding for the A100's USB PHY.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  .../phy/allwinner,sun50i-a100-usb-phy.yaml    | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun50i-a100-usb-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a100-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a100-usb-phy.yaml
> new file mode 100644
> index 000000000000..cc9bbebe2bd7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a100-usb-phy.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings. checkpatch.pl will tell you which ones.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/allwinner,sun50i-a100-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner A100 USB PHY Device Tree Bindings
> +
> +maintainers:
> +  - Yangtao Li <tiny.windzz@gmail.com>
> +
> +properties:
> +  "#phy-cells":
> +    const: 1
> +
> +  compatible:
> +    const: allwinner,sun50i-a100-usb-phy
> +
> +  reg:
> +    items:
> +      - description: PHY Control registers
> +      - description: PHY PMU0 registers
> +      - description: PHY PMU1 registers
> +
> +  reg-names:
> +    items:
> +      - const: phy_ctrl
> +      - const: pmu0
> +      - const: pmu1
> +
> +  clocks:
> +    items:
> +      - description: USB OTG PHY bus clock
> +      - description: USB Host 0 PHY bus clock
> +
> +  clock-names:
> +    items:
> +      - const: usb0_phy
> +      - const: usb1_phy
> +
> +  resets:
> +    items:
> +      - description: USB OTG reset
> +      - description: USB Host 1 Controller reset
> +
> +  reset-names:
> +    items:
> +      - const: usb0_reset
> +      - const: usb1_reset
> +
> +  usb0_id_det-gpios:
> +    description: GPIO to the USB OTG ID pin

Needs 'maxItems: 1'

> +
> +  usb0_vbus_det-gpios:
> +    description: GPIO to the USB OTG VBUS detect pin
> +
> +  usb0_vbus_power-supply:
> +    description: Power supply to detect the USB OTG VBUS
> +
> +  usb0_vbus-supply:
> +    description: Regulator controlling USB OTG VBUS
> +
> +  usb1_vbus-supply:
> +    description: Regulator controlling USB1 Host controller

Are ID and VBus actually connected to the phy h/w? Really, all this 
should be in a USB connector node for which we have bindings.

> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - reg
> +  - reg-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/clock/sun50i-a100-ccu.h>
> +    #include <dt-bindings/reset/sun50i-a100-ccu.h>
> +
> +    phy@5100400 {
> +        #phy-cells = <1>;
> +        compatible = "allwinner,sun50i-a100-usb-phy";
> +        reg = <0x05100400 0x14>,
> +              <0x05101800 0x4>,
> +              <0x05200800 0x4>;
> +        reg-names = "phy_ctrl",
> +                    "pmu0",
> +                    "pmu1";
> +        clocks = <&ccu CLK_USB_PHY0>,
> +                 <&ccu CLK_USB_PHY1>;
> +        clock-names = "usb0_phy",
> +                      "usb1_phy";
> +        resets = <&ccu RST_USB_PHY0>,
> +                 <&ccu RST_USB_PHY1>;
> +        reset-names = "usb0_reset",
> +                      "usb1_reset";
> +        usb0_id_det-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
> +        usb0_vbus_power-supply = <&usb_power_supply>;
> +        usb0_vbus-supply = <&reg_drivevbus>;
> +        usb1_vbus-supply = <&reg_usb1_vbus>;
> +    };
> -- 
> 2.28.0
> 
