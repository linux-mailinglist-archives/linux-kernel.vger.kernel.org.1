Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C20C298ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780922AbgJZODZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:03:25 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35442 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780899AbgJZODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:03:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id w191so10586526oif.2;
        Mon, 26 Oct 2020 07:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yQxCiGiE7NlPiloxFNOWyASBwj4I+02Aby8eDq3BwvA=;
        b=gXLbk9s66qOcwEISHScNu4//+fdfyJt+KP98hIw03EQI1N5mmXjRjcx3LU5LLAdae9
         ZCraOCZByflwuhEXWCAryyWanE36YhI6k+kku7YZl7nzBQYY4oAZVHm7NXrrZNdFWUjD
         4AUTY7tP/Lh7KwBnGvCYTkrVZ7d2XqjC3cZyyHLmgxPV89q5+Q1RIdEvdwRcGQNhqZsu
         tKTjVSJWQi2QKhv1MtTnr6uoUYaVAKgJrMyycxz3aE7u1mySsAsQRIKLo5qF51XAhJVa
         28iLrkMw7HsOsEGBNkWJ/oAwQviyZmjpUBUvQwG+RieCDX6HE3YXxdmqIEdR0tPwC0Qt
         LGkg==
X-Gm-Message-State: AOAM532FwJUanJUip95cMsjytSqHhnLXmgzSbUoAyQdd3nLggzN25Arz
        FoAhF98fSgd+Yy8chW5JxQ==
X-Google-Smtp-Source: ABdhPJwBgb/kRoqMlR8y8yxrn2+kkR7ptzRTb5/SIg4FuVbYd/YN5Ca9yXxPi6QzUO6OrkEilgZ53g==
X-Received: by 2002:a05:6808:a90:: with SMTP id q16mr12745941oij.17.1603721003220;
        Mon, 26 Oct 2020 07:03:23 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h3sm3911140oom.18.2020.10.26.07.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:03:22 -0700 (PDT)
Received: (nullmailer pid 77066 invoked by uid 1000);
        Mon, 26 Oct 2020 14:03:21 -0000
Date:   Mon, 26 Oct 2020 09:03:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v11 02/10] dt-bindings: usb: Maxim type-c controller
 device tree binding document
Message-ID: <20201026140321.GA73964@bogus>
References: <20201020093627.256885-1-badhri@google.com>
 <20201020093627.256885-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020093627.256885-3-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:36:19AM -0700, Badhri Jagan Sridharan wrote:
> Add device tree binding document for Maxim 33359 Type-C chip driver
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
> 
> Changes since v6:
> - Migrated to yaml format.
> 
> Changes since v7:
> - Rebase on usb-next
> 
> Changes since v8:
> - Fix errors from make dt_binding_check as suggested by
>   Rob Herring.
> 
> Changes since v9:
> - additionalProperties: false as suggested by Rob Herring.
> 
> Changes since v10:
> - Added the chip number to the binding as suggested by Rob Herring.
> - Renamed the filename as well.
> 
> ---
>  .../devicetree/bindings/usb/maxim,33359.yaml  | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/maxim,33359.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/maxim,33359.yaml b/Documentation/devicetree/bindings/usb/maxim,33359.yaml
> new file mode 100644
> index 000000000000..b02e7b228cde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/maxim,33359.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/maxim,33359.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Maxim TCPCI Type-C PD controller DT bindings
> +
> +maintainers:
> +  - Badhri Jagan Sridharan <badhri@google.com>
> +
> +description: Maxim TCPCI Type-C PD controller
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,33359

Maxim parts are generally named 'maxim,max[0-9]+'

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  connector:
> +    type: object
> +    $ref: ../connector/usb-connector.yaml#
> +    description:
> +      Properties for usb c connector.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - connector
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/usb/pd.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        maxtcpc@25 {
> +            compatible = "maxim,33359";
> +            reg = <0x25>;
> +            interrupt-parent = <&gpa8>;
> +            interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> +
> +            connector {
> +                compatible = "usb-c-connector";
> +                label = "USB-C";
> +                data-role = "dual";
> +                power-role = "dual";
> +                try-power-role = "sink";
> +                self-powered;
> +                op-sink-microwatt = <2600000>;
> +                new-source-frs-typec-current = <FRS_5V_1P5A>;
> +                source-pdos = <PDO_FIXED(5000, 900,
> +                                         PDO_FIXED_SUSPEND |
> +                                         PDO_FIXED_USB_COMM |
> +                                         PDO_FIXED_DATA_SWAP |
> +                                         PDO_FIXED_DUAL_ROLE)>;
> +                sink-pdos = <PDO_FIXED(5000, 3000,
> +                                       PDO_FIXED_USB_COMM |
> +                                       PDO_FIXED_DATA_SWAP |
> +                                       PDO_FIXED_DUAL_ROLE)
> +                                       PDO_FIXED(9000, 2000, 0)>;
> +            };
> +        };
> +    };
> +...
> -- 
> 2.29.0.rc1.297.gfa9743e501-goog
> 
