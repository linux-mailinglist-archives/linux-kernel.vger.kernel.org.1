Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56F72E8D14
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 17:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbhACQYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 11:24:18 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:36303 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhACQYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 11:24:14 -0500
Received: by mail-il1-f180.google.com with SMTP id u12so23122965ilv.3;
        Sun, 03 Jan 2021 08:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IlCUvEAT67GfF7KTq7eRQuQrEKjdxSn/gV3xWDoeAWM=;
        b=gugBf+OZtLsJWszLgm4v5O78uDg65m6oy3TGjBn14I6U1pvRnZwD6Wr1nQl3g82Kw3
         +fUHuMnYgaKZjkXgwIugMzxDtAAgJhKLmL0sGGG8efJu08lCJEpz8OSDdK1C48sVwpg1
         6xgAhMQGW5sSLMhYwHq9WEMIyCHizkkD3dnMowjBRYvCD1ZHnMMKUKwG9Bzl6oOKd8dS
         htIYTSUUqn8eOV2kVPTAXFNXyBPffDsdtXS5bL/aJH4zL5i93K8WU5uSU2NW7CsALOqk
         sIqn8saUKC6yNTGqRj8dp12DaaKmJmFuWZD2+ToXZPdf3yFNiJcuk5YuCKE1fFbcqEyU
         aeYQ==
X-Gm-Message-State: AOAM532rnVYK8vLUL4jVQLMHgigkALcp2qrUlNL+COyBgK3quTbvmE5n
        dL4i0t+ToJKQnEMSY6ZVIw==
X-Google-Smtp-Source: ABdhPJwBqYfM41M9dd/KeBL3oSNlyouz8xDjVDRKfzxFzG86I7tmrWtk48l1LeW7GxMv6vatY7BgjQ==
X-Received: by 2002:a92:c5a7:: with SMTP id r7mr65560994ilt.219.1609691012931;
        Sun, 03 Jan 2021 08:23:32 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v10sm38703758ilu.58.2021.01.03.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 08:23:31 -0800 (PST)
Received: (nullmailer pid 3981855 invoked by uid 1000);
        Sun, 03 Jan 2021 16:23:29 -0000
Date:   Sun, 3 Jan 2021 09:23:29 -0700
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 1/3] dt-bindings: phy: brcm,brcmstb-usb-phy: convert
 to the json-schema
Message-ID: <20210103162329.GA3961287@robh.at.kernel.org>
References: <20201221052339.10100-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201221052339.10100-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 06:23:37AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Changes that require mentioning:
> 1. interrupt-names
>    Name "wakeup" was changed to the "wake". It matches example and what
>    Linux driver looks for in the first place
> 2. brcm,ipp and brcm,ioc
>    Both were described as booleans with 0 / 1 values. In examples they
>    were integers and Linux driver checks for int as well.
>    I made both uint32 but that probably should be refactored later.

Why? You're stuck with that now.

> 3. Added minimal description
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Add Al as maintainer
> ---
>  .../bindings/phy/brcm,brcmstb-usb-phy.txt     |  86 --------
>  .../bindings/phy/brcm,brcmstb-usb-phy.yaml    | 196 ++++++++++++++++++
>  2 files changed, 196 insertions(+), 86 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
> deleted file mode 100644
> index 698aacbdcfc4..000000000000
> --- a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
> +++ /dev/null
> @@ -1,86 +0,0 @@
> -Broadcom STB USB PHY
> -
> -Required properties:
> -- compatible: should be one of
> -	"brcm,brcmstb-usb-phy"
> -	"brcm,bcm7216-usb-phy"
> -	"brcm,bcm7211-usb-phy"
> -
> -- reg and reg-names properties requirements are specific to the
> -  compatible string.
> -  "brcm,brcmstb-usb-phy":
> -    - reg: 1 or 2 offset and length pairs. One for the base CTRL registers
> -           and an optional pair for systems with USB 3.x support
> -    - reg-names: not specified
> -  "brcm,bcm7216-usb-phy":
> -    - reg: 3 offset and length pairs for CTRL, XHCI_EC and XHCI_GBL
> -           registers
> -    - reg-names: "ctrl", "xhci_ec", "xhci_gbl"
> -  "brcm,bcm7211-usb-phy":
> -    - reg: 5 offset and length pairs for CTRL, XHCI_EC, XHCI_GBL,
> -           USB_PHY and USB_MDIO registers and an optional pair
> -	   for the BDC registers
> -    - reg-names: "ctrl", "xhci_ec", "xhci_gbl", "usb_phy", "usb_mdio", "bdc_ec"
> -
> -- #phy-cells: Shall be 1 as it expects one argument for setting
> -	      the type of the PHY. Possible values are:
> -	      - PHY_TYPE_USB2 for USB1.1/2.0 PHY
> -	      - PHY_TYPE_USB3 for USB3.x PHY
> -
> -Optional Properties:
> -- clocks : clock phandles.
> -- clock-names: String, clock name.
> -- interrupts: wakeup interrupt
> -- interrupt-names: "wakeup"
> -- brcm,ipp: Boolean, Invert Port Power.
> -  Possible values are: 0 (Don't invert), 1 (Invert)
> -- brcm,ioc: Boolean, Invert Over Current detection.
> -  Possible values are: 0 (Don't invert), 1 (Invert)
> -- dr_mode: String, PHY Device mode.
> -  Possible values are: "host", "peripheral ", "drd" or "typec-pd"
> -  If this property is not defined, the phy will default to "host" mode.
> -- brcm,syscon-piarbctl: phandle to syscon for handling config registers
> -NOTE: one or both of the following two properties must be set
> -- brcm,has-xhci: Boolean indicating the phy has an XHCI phy.
> -- brcm,has-eohci: Boolean indicating the phy has an EHCI/OHCI phy.
> -
> -
> -Example:
> -
> -usbphy_0: usb-phy@f0470200 {
> -	reg = <0xf0470200 0xb8>,
> -		<0xf0471940 0x6c0>;
> -	compatible = "brcm,brcmstb-usb-phy";
> -	#phy-cells = <1>;
> -	dr_mode = "host"
> -	brcm,ioc = <1>;
> -	brcm,ipp = <1>;
> -	brcm,has-xhci;
> -	brcm,has-eohci;
> -	clocks = <&usb20>, <&usb30>;
> -	clock-names = "sw_usb", "sw_usb3";
> -};
> -
> -usb-phy@29f0200 {
> -	reg = <0x29f0200 0x200>,
> -		<0x29c0880 0x30>,
> -		<0x29cc100 0x534>,
> -		<0x2808000 0x24>,
> -		<0x2980080 0x8>;
> -	reg-names = "ctrl",
> -		"xhci_ec",
> -		"xhci_gbl",
> -		"usb_phy",
> -		"usb_mdio";
> -	brcm,ioc = <0x0>;
> -	brcm,ipp = <0x0>;
> -	compatible = "brcm,bcm7211-usb-phy";
> -	interrupts = <0x30>;
> -	interrupt-parent = <&vpu_intr1_nosec_intc>;
> -	interrupt-names = "wake";
> -	#phy-cells = <0x1>;
> -	brcm,has-xhci;
> -	syscon-piarbctl = <&syscon_piarbctl>;
> -	clocks = <&scmi_clk 256>;
> -	clock-names = "sw_usb";
> -};
> diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
> new file mode 100644
> index 000000000000..1dad1e3df1a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
> @@ -0,0 +1,196 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/brcm,brcmstb-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom STB USB PHY
> +
> +description: Broadcom's PHY that handles EHCI/OHCI and/or XHCI
> +
> +maintainers:
> +  - Al Cooper <alcooperx@gmail.com>
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm7211-usb-phy
> +      - brcm,bcm7216-usb-phy
> +      - brcm,brcmstb-usb-phy
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: sw_usb
> +      - const: sw_usb3
> +
> +  interrupts:
> +    description: wakeup interrupt
> +
> +  interrupt-names:
> +    const: wake
> +
> +  brcm,ipp:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Invert Port Power
> +    minimum: 0
> +    maximum: 1
> +
> +  brcm,ioc:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Invert Over Current detection
> +    minimum: 0
> +    maximum: 1
> +
> +  dr_mode:
> +    description: PHY Device mode. If this property is not defined, the PHY will
> +      default to "host" mode.
> +    enum:
> +      - host
> +      - peripheral
> +      - drd
> +      - typec-pd
> +
> +  brcm,syscon-piarbctl:
> +    description: phandle to syscon for handling config registers
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  brcm,has-xhci:
> +    description: Indicates the PHY has an XHCI PHY.
> +    type: boolean
> +
> +  brcm,has-eohci:
> +    description: Indicates the PHY has an EHCI/OHCI PHY.
> +    type: boolean
> +
> +  "#phy-cells":
> +    description: |
> +      Cell allows setting the type of the PHY. Possible values are:
> +      - PHY_TYPE_USB2 for USB1.1/2.0 PHY
> +      - PHY_TYPE_USB3 for USB3.x PHY
> +    const: 1
> +
> +required:
> +  - reg
> +  - "#phy-cells"
> +
> +anyOf:
> +  - required:
> +      - brcm,has-xhci
> +  - required:
> +      - brcm,has-eohci
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,brcmstb-usb-phy
> +    then:
> +      properties:
> +        reg:
> +          minItems: 1
> +          maxItems: 2
> +          items:
> +            - description: the base CTRL register
> +            - description: XHCI EC register
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm7211-usb-phy
> +    then:
> +      properties:
> +        reg:
> +          minItems: 5
> +          maxItems: 6
> +          items:
> +            - description: the base CTRL register
> +            - description: XHCI EC register
> +            - description: XHCI GBL register
> +            - description: USB PHY register
> +            - description: USB MDIO register
> +            - description: BDC register
> +        reg-names:
> +          minItems: 5
> +          maxItems: 6
> +          items:
> +            - const: ctrl
> +            - const: xhci_ec
> +            - const: xhci_gbl
> +            - const: usb_phy
> +            - const: usb_mdio
> +            - const: bdc_ec
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm7216-usb-phy
> +    then:
> +      properties:
> +        reg:
> +          minItems: 3
> +          maxItems: 3
> +          items:
> +            - description: the base CTRL register
> +            - description: XHCI EC register
> +            - description: XHCI GBL register
> +        reg-names:
> +          minItems: 3
> +          maxItems: 3
> +          items:
> +            - const: ctrl
> +            - const: xhci_ec
> +            - const: xhci_gbl

Given the names are always the same, you can define them in the main 
section and then the if/then schemas just need minItems/maxItems.

> +
> +additionalProperties: true

Define reg/reg-names in the main section and make this false.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/phy/phy.h>
> +
> +    usb-phy@f0470200 {
> +        compatible = "brcm,brcmstb-usb-phy";
> +        reg = <0xf0470200 0xb8>,
> +              <0xf0471940 0x6c0>;
> +        #phy-cells = <1>;
> +        dr_mode = "host";
> +        brcm,ioc = <1>;
> +        brcm,ipp = <1>;
> +        brcm,has-xhci;
> +        brcm,has-eohci;
> +        clocks = <&usb20>, <&usb30>;
> +        clock-names = "sw_usb", "sw_usb3";
> +    };
> +  - |
> +    #include <dt-bindings/phy/phy.h>
> +
> +    usb-phy@29f0200 {
> +        compatible = "brcm,bcm7211-usb-phy";
> +        reg = <0x29f0200 0x200>,
> +              <0x29c0880 0x30>,
> +              <0x29cc100 0x534>,
> +              <0x2808000 0x24>,
> +              <0x2980080 0x8>;
> +        reg-names = "ctrl",
> +            "xhci_ec",
> +            "xhci_gbl",
> +            "usb_phy",
> +            "usb_mdio";
> +        brcm,ioc = <0x0>;
> +        brcm,ipp = <0x0>;
> +        interrupts = <0x30>;
> +        interrupt-parent = <&vpu_intr1_nosec_intc>;
> +        interrupt-names = "wake";
> +        #phy-cells = <0x1>;
> +        brcm,has-xhci;
> +        syscon-piarbctl = <&syscon_piarbctl>;
> +        clocks = <&scmi_clk 256>;
> +        clock-names = "sw_usb";
> +    };
> -- 
> 2.26.2
> 
