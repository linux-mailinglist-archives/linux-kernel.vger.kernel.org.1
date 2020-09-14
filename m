Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444CA2696A2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgINUa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:30:29 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37100 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgINUTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:19:31 -0400
Received: by mail-il1-f195.google.com with SMTP id q4so846675ils.4;
        Mon, 14 Sep 2020 13:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sMeehxv3Gb7sjHMmPviqXYOIhmDchXkrPq1M27qz98E=;
        b=elaaVzsub01ndBekWD/LjRV9q/BN48YLiBTE1UWsfpRKM6iKpLZyJnIe1J0XxNQ3HK
         K/+9IXzEhy0l3tKbRH9p6U5iGx+hMHVfyys/UnE+nE/mmSLKiwJ2kiJ2Xf/mn5wfdE/A
         66oWygB4DYyC5QKyXF7muakTc4HlhpkKAGNuczg9J/D9u55Dg7D6Cr0P4Q/eBzKfMr/N
         GRO9R43+p1C60gHJ0x6sEyHln24go6AFOBePdXz9M0JCNkGSzy8xmaxM/v/rDwpoTTvn
         vvbBXIaBdUyCUIu6/6tfNw8Y+px8YrwaIdZ2OacUOqQ3ksBxpVWkEa7sq1pzIAFcVZsW
         5bkw==
X-Gm-Message-State: AOAM530vNhU/MKe5rmX1iNChsX1N7RAJNkZmBSNvkfgh0+C0aYPR57oA
        v442FH4+xjj1VwMaoIxGYg==
X-Google-Smtp-Source: ABdhPJySTE4mZblBlptg9Qdk+m9xeXoohZZHGi7tj6EUbJEUe3x2mJGLCUSiTE1FRnCIwkAk65TPKw==
X-Received: by 2002:a92:c5ac:: with SMTP id r12mr12914441ilt.274.1600114768571;
        Mon, 14 Sep 2020 13:19:28 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p17sm7505498ilj.81.2020.09.14.13.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:19:27 -0700 (PDT)
Received: (nullmailer pid 171940 invoked by uid 1000);
        Mon, 14 Sep 2020 20:19:25 -0000
Date:   Mon, 14 Sep 2020 14:19:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     balbi@kernel.org, pawell@cadence.com, kurahul@cadence.com,
        nsekhar@ti.com, vigneshr@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: Convert cdns-usb3.txt to YAML
 schema
Message-ID: <20200914201925.GA167594@bogus>
References: <20200902133543.17222-1-rogerq@ti.com>
 <20200902133543.17222-2-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902133543.17222-2-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 04:35:41PM +0300, Roger Quadros wrote:
> Converts cdns-usb3.txt to YAML schema cdns,usb3.yaml
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../devicetree/bindings/usb/cdns,usb3.yaml    | 89 +++++++++++++++++++
>  .../devicetree/bindings/usb/cdns-usb3.txt     | 45 ----------
>  2 files changed, 89 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>  delete mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> new file mode 100644
> index 000000000000..7bc0263accee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/cdns,usb3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence USBSS-DRD controller bindings
> +
> +maintainers:
> +  - Pawel Laszczak <pawell@cadence.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cdns,usb3

Don't need 'oneOf' with only 1 entry.

> +
> +  reg:
> +    items:
> +      - description: OTG controller registers
> +      - description: XHCI Host controller registers
> +      - description: DEVICE controller registers
> +
> +  reg-names:
> +    items:
> +      - const: otg
> +      - const: xhci
> +      - const: dev
> +
> +  interrupts:
> +    items:
> +      - description: OTG/DRD controller interrupt
> +      - description: XHCI host controller interrupt
> +      - description: Device controller interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: host
> +      - const: peripheral
> +      - const: otg
> +
> +  dr_mode:
> +    enum: [host, otg, peripheral]
> +
> +  maximum-speed:
> +    enum: [super-speed, high-speed, full-speed]
> +
> +  phys:
> +   minItems: 1
> +   maxItems: 2
> +
> +  phy-names:
> +    minItems: 1
> +    maxItems: 2

Need to define the names and what each entry is.

> +
> +  cdns,on-chip-buff-size:
> +    description:
> +      size of memory intended as internal memory for endpoints
> +      buffers expressed in KB
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        usb@6000000 {
> +            compatible = "cdns,usb3";
> +            reg = <0x00 0x6000000 0x00 0x10000>,
> +                  <0x00 0x6010000 0x00 0x10000>,
> +                  <0x00 0x6020000 0x00 0x10000>;
> +            reg-names = "otg", "xhci", "dev";
> +            interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "host", "peripheral", "otg";
> +            maximum-speed = "super-speed";
> +            dr_mode = "otg";
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3.txt b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
> deleted file mode 100644
> index b7dc606d37b5..000000000000
> --- a/Documentation/devicetree/bindings/usb/cdns-usb3.txt
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -Binding for the Cadence USBSS-DRD controller
> -
> -Required properties:
> - - reg: Physical base address and size of the controller's register areas.
> -	 Controller has 3 different regions:
> -	 - HOST registers area
> -	 - DEVICE registers area
> -	 - OTG/DRD registers area
> - - reg-names - register memory area names:
> -	"xhci" - for HOST registers space
> -	"dev" - for DEVICE registers space
> -	"otg" - for OTG/DRD registers space
> - - compatible: Should contain: "cdns,usb3"
> - - interrupts: Interrupts used by cdns3 controller:
> -	"host" - interrupt used by XHCI driver.
> -	"peripheral" - interrupt used by device driver
> -	"otg" - interrupt used by DRD/OTG  part of driver
> -
> -Optional properties:
> - - maximum-speed : valid arguments are "super-speed", "high-speed" and
> -                   "full-speed"; refer to usb/generic.txt
> - - dr_mode: Should be one of "host", "peripheral" or "otg".
> - - phys: reference to the USB PHY
> - - phy-names: from the *Generic PHY* bindings;
> -	Supported names are:
> -	- cdns3,usb2-phy
> -	- cdns3,usb3-phy
> -
> - - cdns,on-chip-buff-size : size of memory intended as internal memory for endpoints
> -	buffers expressed in KB
> -
> -Example:
> -	usb@f3000000 {
> -		compatible = "cdns,usb3";
> -		interrupts = <GIC_USB_IRQ 7 IRQ_TYPE_LEVEL_HIGH>,
> -				<GIC_USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>,
> -				<GIC_USB_IRQ  8 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "host", "peripheral", "otg";
> -		reg = <0xf3000000 0x10000>,	/* memory area for HOST registers */
> -			<0xf3010000 0x10000>,	/* memory area for DEVICE registers */
> -			<0xf3020000 0x10000>;	/* memory area for OTG/DRD registers */
> -		reg-names = "xhci", "dev", "otg";
> -		phys = <&usb2_phy>, <&usb3_phy>;
> -		phy-names = "cdns3,usb2-phy", "cnds3,usb3-phy";
> -	};
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
