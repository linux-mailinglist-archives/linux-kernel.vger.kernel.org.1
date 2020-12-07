Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328E32D16A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgLGQm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:42:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42741 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgLGQm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:42:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id 11so13021644oty.9;
        Mon, 07 Dec 2020 08:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K6bF1FaDZgAy7/ZWg1y1G3uqHa1w8BX8au5vZBaRRY4=;
        b=HgXJX+umJMfPzieoaDwP3SsQevdG6e05MXDKDVNLsFNpkwkL44hIk7Re9R15IPn5TI
         o8Rsw00Y3mvFhExA6RlVn9EpKYSlLqXCh7oCyRxQseicQV2a7ErcZ1/L81Fz4VTaUQaY
         O0UMOJGOd2HHPYGNbX/TzjeHlUvqzBNdH3hWBD8JOa385lX4WYujTfhBe1lGYNcsAHVs
         TSEqyo2wWWg4Hfb3inl+b546nR5XUsE2hLoUP+aY977b2r4beZXY8UsXLs9X4bbkcSUz
         iwBsa7is0XL5dvCh5hBOUUZQ9uLUnu5mAnHenMsDjXz0NPEVGVGa+k/4f1pZ+GR+91Hn
         tRFA==
X-Gm-Message-State: AOAM5320alS/JGrZEKEEZEoxe6VLj5Dyjx96BEDf6MimAdrGVkenDsxo
        lQozGkIb3s5VBNIEiJKlbg==
X-Google-Smtp-Source: ABdhPJwZCARGwwYDP6mzbqlj6ZfdfIZO95tfx53NZh7qmOuWmCN5pXCjW7eakQOGZ0P5pX1eDf5jlA==
X-Received: by 2002:a9d:be1:: with SMTP id 88mr13823281oth.210.1607359305966;
        Mon, 07 Dec 2020 08:41:45 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y15sm2736476otq.79.2020.12.07.08.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:41:45 -0800 (PST)
Received: (nullmailer pid 409772 invoked by uid 1000);
        Mon, 07 Dec 2020 16:41:44 -0000
Date:   Mon, 7 Dec 2020 10:41:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lee.jones@linaro.org, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mfd: rt4831: Adds DT binding document for Richtek
 RT4831 MFD core
Message-ID: <20201207164144.GA398093@robh.at.kernel.org>
References: <1607011595-13603-1-git-send-email-u0084500@gmail.com>
 <1607011595-13603-4-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607011595-13603-4-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 12:06:35AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds DT binding document for Richtek RT4831 MFD core.
> 
> This patch depends on
> 
> "backlight: rt4831: Adds DT binding document for Richtek RT4831 backlight".
> "regulator: rt4831: Adds DT binding document for Richtek RT4831 DSV regulator".

You generally don't need to state dependencies on other patches in the 
series. You need to state dependencies that are either pending in a 
maintainers tree or patches not yet applied. IOW, anything not in Linus' 
tree. And that information goes below the '---'.

> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Changes since v2
> - Add "patch depends on" in commit description.
> - Adds regulator-allow-bypass flag in DSVLCM.
> ---
>  .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 90 ++++++++++++++++++++++
>  include/dt-bindings/leds/rt4831-backlight.h        | 23 ++++++

This goes in the backlight binding patch.

>  2 files changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
>  create mode 100644 include/dt-bindings/leds/rt4831-backlight.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
> new file mode 100644
> index 00000000..c6ca953
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: GPL-2.0

For new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/richtek,rt4831.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT4831 DSV and Backlight Integrated IC
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  RT4831 is a multifunctional device that can provide power to the LCD display
> +  and LCD backlight.
> +
> +  For Display Bias Voltage DSVP and DSVN, the output range is about 4V to 6.5V.
> +  It's sufficient to meet the current LCD power requirement.
> +
> +  For the LCD backlight, it can provide four channel WLED driving capability.
> +  Each channel driving current is up to 30mA
> +
> +  Datasheet is available at
> +  https://www.richtek.com/assets/product_file/RT4831A/DS4831A-05.pdf
> +
> +properties:
> +  compatible:
> +    const: richtek,rt4831
> +
> +  reg:
> +    description: I2C device address.
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description: |
> +      GPIO to enable/disable the chip. It is optional.
> +      Some usage directly tied this pin to follow VIO 1.8V power on sequence.
> +    maxItems: 1
> +
> +  regulators:
> +    $ref: ../regulator/richtek,rt4831-regulator.yaml
> +
> +  backlight:
> +    $ref: ../leds/backlight/richtek,rt4831-backlight.yaml
> +
> +required:
> +  - compatible
> +  - reg
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
> +        regulators {
> +          DSVLCM {
> +            regulator-min-microvolt = <4000000>;
> +            regulator-max-microvolt = <7150000>;
> +            regulator-allow-bypass;
> +          };
> +          DSVP {
> +            regulator-name = "rt4831-dsvp";
> +            regulator-min-microvolt = <4000000>;
> +            regulator-max-microvolt = <6500000>;
> +            regulator-boot-on;
> +          };
> +          DSVN {
> +            regulator-name = "rt4831-dsvn";
> +            regulator-min-microvolt = <4000000>;
> +            regulator-max-microvolt = <6500000>;
> +            regulator-boot-on;
> +          };
> +        };
> +
> +        backlight {
> +          compatible = "richtek,rt4831-backlight";
> +          default-brightness = <1024>;
> +          max-brightness = <2048>;
> +          richtek,bled-ovp-sel = /bits/ 8 <RT4831_BLOVPLVL_21V>;
> +          richtek,channel-use = /bits/ 8 <RT4831_BLED_ALLCHEN>;
> +        };
> +      };
> +    };
> diff --git a/include/dt-bindings/leds/rt4831-backlight.h b/include/dt-bindings/leds/rt4831-backlight.h
> new file mode 100644
> index 00000000..7084906
> --- /dev/null
> +++ b/include/dt-bindings/leds/rt4831-backlight.h
> @@ -0,0 +1,23 @@
> +/*
> + * This header provides constants for rt4831 backlight bindings.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.

Use SPDX tag. Also, probably should be dual licensed too if you want to 
use your DTs with non-GPL OS.

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
