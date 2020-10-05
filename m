Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6915E28385C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgJEOqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:46:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43594 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgJEOqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:46:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id l85so8932709oih.10;
        Mon, 05 Oct 2020 07:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eg4ZUBIlL2zrsvoubzdptXm9kzivS1YXmcuLTutRd2A=;
        b=PLXV8eI9YaZf265cz9NVQWeHRMlYoHNgUM9YIbg0FZchR2wrdVYou/vsjX/sFuHk1J
         6P25jaUGMnaj+3P+Uac9hFfKwtjHPmOXgo9g5hmpODnLNNJXkPv6/3HDAyLQG2WVHT/a
         jKFQxNY+sBkP8XsnJw4mBDvn+wZgA3rBasBvpOU/XKV8F7DzLUJyoGTP339tusR1kG47
         nV8YZNP0VD0pio0IFhnpKbbyq9vpeG/2Y2yAExt5LCx/Gki1Z70v9H2kxJoTw4Dx4r1V
         TPaGF/oRoF1WQpGQ+F8LBDAxG1kCxn3ooz08kOoKfPRih+8tzmCtm31gVOHwR+ke/i9H
         xdDw==
X-Gm-Message-State: AOAM532yGW8MoacUKOXhHDgUrluZkuCJynti+vBm+/Ko2NoksHwzaHNy
        0gENM6FxC0YvloxzI+NNjw==
X-Google-Smtp-Source: ABdhPJzyCvlLjfu9dD2qxiBtg/5pGVvph6AzDdpf6U6YH3RzWGnFt+bxUcfQOWcZLl6t+JYivvisdQ==
X-Received: by 2002:a05:6808:a9a:: with SMTP id q26mr8541339oij.87.1601909179754;
        Mon, 05 Oct 2020 07:46:19 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z8sm10575oic.11.2020.10.05.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:46:19 -0700 (PDT)
Received: (nullmailer pid 161117 invoked by uid 1000);
        Mon, 05 Oct 2020 14:46:18 -0000
Date:   Mon, 5 Oct 2020 09:46:18 -0500
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
Subject: Re: [PATCH v9 03/15] dt-bindings: usb: Maxim type-c controller
 device tree binding document
Message-ID: <20201005144618.GA154206@bogus>
References: <20200929024004.244992-1-badhri@google.com>
 <20200929024004.244992-4-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929024004.244992-4-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 07:39:52PM -0700, Badhri Jagan Sridharan wrote:
> Add device tree binding document for Maxim TCPCI based Type-C chip driver
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
> ---
>  .../devicetree/bindings/usb/maxim,tcpci.yaml  | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/maxim,tcpci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/maxim,tcpci.yaml b/Documentation/devicetree/bindings/usb/maxim,tcpci.yaml
> new file mode 100644
> index 000000000000..f4b5f1a09b98
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/maxim,tcpci.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/maxim,tcpci.yaml#"
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
> +      - maxim,tcpci

Is there a datasheet for this? Searching for 'tcpci' doesn't really come 
up with anything other than this patch. Only chip I found is MAX77958. 
Bindings are for specific h/w devices.

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

additionalProperties: false

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
> +            compatible = "maxim,tcpc";
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
> 2.28.0.709.gb0816b6eb0-goog
> 
