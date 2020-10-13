Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750EC28CE59
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgJMMaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:30:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43787 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgJMMaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:30:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id l85so22247287oih.10;
        Tue, 13 Oct 2020 05:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l13Z8xOhyqZIr9aWHDRCKKN9Zj5vewOvbiekjj4BpAw=;
        b=ZRvj5Ao+3SaaQ0QSn0xa0CzCJVuUlBYnOUcp6aGKNNtjAYxv/XC70PO9Ov3EcQW7er
         QT3OkIhEF/gSpazEXaSIgEFsU9crANhEkeqYHirsfgMYRHT/cR/cVu+J4PW8Omi2g0d6
         fb9LsthGCEQ16QseGT+DORCh8aeCjJVmeFga2DJ+jWrRE5I+xxysKRQvOWIyNd7TEAF4
         sRJDIbGE/S6WbsA7sNGdJga1denES0u91FKEg3EDbBkqWYCgPWCOfssssYtp4uOIQJwC
         hH3OQKLEJLF2J2JcZLsa8yG7XRVc/mHFNG9H4CepOXsL/OHRVDJDPRis0vi1oUX8SPpE
         I4Ug==
X-Gm-Message-State: AOAM533z8r2LVXb8cSEhG6B23V7inv/TKYLYvDChW3QNGRTDclLcvz7d
        BBdcI9hBNFscReYq0qm2ow==
X-Google-Smtp-Source: ABdhPJyndCBj97xf1NjGMItXcmgC5xw9dvQKbfGQbJ9/OHzCsjt3Y6QB40qIJ1XALueJlWUrAlMaeQ==
X-Received: by 2002:aca:38c1:: with SMTP id f184mr12823576oia.145.1602592205767;
        Tue, 13 Oct 2020 05:30:05 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v22sm11015668oia.7.2020.10.13.05.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 05:30:05 -0700 (PDT)
Received: (nullmailer pid 3296068 invoked by uid 1000);
        Tue, 13 Oct 2020 12:30:04 -0000
Date:   Tue, 13 Oct 2020 07:30:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Roger Quadros <rogerq@ti.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/18] dt-bindings: usb: Convert xHCI bindings to DT
 schema
Message-ID: <20201013123004.GB3269269@bogus>
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010224121.12672-8-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 01:41:10AM +0300, Serge Semin wrote:
> Currently the DT bindings of Generic xHCI Controllers are described by means
> of the legacy text file. Since such format is deprecated in favor of the
> DT schema, let's convert the Generic xHCI Controllers bindings file to the
> corresponding yaml files. There will be two of them: a DT schema for the
> xHCI controllers on a generic platform and a DT schema validating a generic
> xHCI controllers properties. The later will be used to validate the xHCI
> controllers, which aside from some vendor-specific features support the
> basic xHCI functionality.
> 
> An xHCI-compatible DT node shall support the standard USB HCD properties
> and custom ones like: usb2-lpm-disable, usb3-lpm-capable,
> quirk-broken-port-ped and imod-interval-ns. In addition if a generic xHCI
> controller is being validated against the DT schema it is also supposed to
> be equipped with mandatory compatible string, single registers range,
> single interrupts source, and is supposed to optionally contain up to two
> reference clocks for the controller core and CSRs.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../devicetree/bindings/usb/generic-xhci.yaml | 63 +++++++++++++++++++
>  .../devicetree/bindings/usb/usb-xhci.txt      | 41 ------------
>  .../devicetree/bindings/usb/usb-xhci.yaml     | 40 ++++++++++++
>  3 files changed, 103 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/generic-xhci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/usb/usb-xhci.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/usb-xhci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic-xhci.yaml b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
> new file mode 100644
> index 000000000000..1ea1d49a8175
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB xHCI Controller Device Tree Bindings
> +
> +maintainers:
> +  - Mathias Nyman <mathias.nyman@intel.com>
> +
> +allOf:
> +  - $ref: "usb-xhci.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Generic xHCI device
> +        const: generic-xhci
> +      - description: Armada 37xx/375/38x/8k SoCs
> +        items:
> +          - enum:
> +              - marvell,armada3700-xhci
> +              - marvell,armada-375-xhci
> +              - marvell,armada-380-xhci
> +              - marvell,armada-8k-xhci
> +          - const: generic-xhci
> +      - description: Broadcom STB SoCs with xHCI
> +        const: brcm,bcm7445-xhci
> +      - description: Generic xHCI device
> +        const: xhci-platform
> +        deprecated: true
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: core
> +      - const: reg
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    usb@f0931000 {
> +      compatible = "generic-xhci";
> +      reg = <0xf0931000 0x8c8>;
> +      interrupts = <0x0 0x4e 0x0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> deleted file mode 100644
> index 0c5cff84a969..000000000000
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -USB xHCI controllers
> -
> -Required properties:
> -  - compatible: should be one or more of
> -
> -    - "generic-xhci" for generic XHCI device
> -    - "marvell,armada3700-xhci" for Armada 37xx SoCs
> -    - "marvell,armada-375-xhci" for Armada 375 SoCs
> -    - "marvell,armada-380-xhci" for Armada 38x SoCs
> -    - "brcm,bcm7445-xhci" for Broadcom STB SoCs with XHCI
> -    - "xhci-platform" (deprecated)
> -
> -    When compatible with the generic version, nodes must list the
> -    SoC-specific version corresponding to the platform first
> -    followed by the generic version.
> -
> -  - reg: should contain address and length of the standard XHCI
> -    register set for the device.
> -  - interrupts: one XHCI interrupt should be described here.
> -
> -Optional properties:
> -  - clocks: reference to the clocks
> -  - clock-names: mandatory if there is a second clock, in this case
> -    the name must be "core" for the first clock and "reg" for the
> -    second one
> -  - usb2-lpm-disable: indicate if we don't want to enable USB2 HW LPM
> -  - usb3-lpm-capable: determines if platform is USB3 LPM capable
> -  - quirk-broken-port-ped: set if the controller has broken port disable mechanism
> -  - imod-interval-ns: default interrupt moderation interval is 5000ns
> -  - phys : see usb-hcd.yaml in the current directory
> -
> -additionally the properties from usb-hcd.yaml (in the current directory) are
> -supported.
> -
> -
> -Example:
> -	usb@f0931000 {
> -		compatible = "generic-xhci";
> -		reg = <0xf0931000 0x8c8>;
> -		interrupts = <0x0 0x4e 0x0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.yaml b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> new file mode 100644
> index 000000000000..c5c177f2e055
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/usb-xhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic USB xHCI Controller Device Tree Bindings
> +
> +maintainers:
> +  - Mathias Nyman <mathias.nyman@intel.com>
> +
> +allOf:
> +  - $ref: "usb-hcd.yaml#"
> +
> +properties:
> +  usb2-lpm-disable:
> +    description: Indicates if we don't want to enable USB2 HW LPM
> +    type: boolean
> +
> +  usb3-lpm-capable:
> +    description: Determines if platform is USB3 LPM capable
> +    type: boolean
> +
> +  quirk-broken-port-ped:
> +    description: Set if the controller has broken port disable mechanism
> +    type: boolean
> +
> +  imod-interval-ns:
> +    description: Interrupt moderation interval
> +    default: 5000

Having additionalProperties or unevaluatedProperties is going to be 
mandatory, so for this add:

additionalProperties: true

> +
> +examples:
> +  - |
> +    usb@f0930000 {
> +      compatible = "generic-xhci";
> +      reg = <0xf0930000 0x8c8>;
> +      interrupts = <0x0 0x4e 0x0>;
> +      usb2-lpm-disable;
> +      usb3-lpm-capable;
> +    };
> -- 
> 2.27.0
> 
