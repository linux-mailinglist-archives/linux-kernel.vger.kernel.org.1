Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631C32B4C21
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732520AbgKPRGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:06:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33858 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731047AbgKPRGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:06:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id j14so16720928ots.1;
        Mon, 16 Nov 2020 09:06:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KPvpKH6+LKB7R68SiWJN9NhYtAnttNVjTnH/1NZUc0I=;
        b=ZC46rUk+dFPmJRskLhJqtvIJSyRjxjoSTLCTr/b5A4Us6s87HFc+Bdzc42zSVE5e4X
         7mByqYqgVdqK8wRRpdqFGRCrDaFrKQJ7gpwJ+oRzDozdRqh3w9rCGkOQu2ieU0dQHzFB
         V6xohYbr2bOQY9nhXC5kFiu0BMNjMZLQvF1HiqtTFUHaNcrhgRlB2SdsUc3cIiOmMuhQ
         N/BhLncf2Vl1PLqCXuthrC6qkDB4tErNznKFg60JhSiMIdRgAfIjtWI/jU2t2/f5fl98
         1IrhFwRFqhtv3H67N+Fkccxu0b0bax0742KquKgb2Dnu4nsJB4YUjRgCBE08cNMsuKFT
         zKbg==
X-Gm-Message-State: AOAM531naNukJnhVQltjFBZ6rPDa2aZTaM4hsbWSiAXfHVCSMtgSncoi
        hvIUeHw4d+h1QJG1JwSzPA==
X-Google-Smtp-Source: ABdhPJzqI5s8w9KWrJn83RgS+fvuIWeB4JWnfixA20V3EjOVBlNmEAMWSb2EXe5NpYAVpQwPXZJVVQ==
X-Received: by 2002:a9d:eeb:: with SMTP id 98mr173589otj.179.1605546369789;
        Mon, 16 Nov 2020 09:06:09 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v8sm5011022ooh.6.2020.11.16.09.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:06:09 -0800 (PST)
Received: (nullmailer pid 1813477 invoked by uid 1000);
        Mon, 16 Nov 2020 17:06:08 -0000
Date:   Mon, 16 Nov 2020 11:06:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/1] dt-bindings: phy: phy-stm32-usbphyc: convert
 bindings to json-schema
Message-ID: <20201116170608.GA1808716@bogus>
References: <20201110124326.4682-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110124326.4682-1-amelie.delaunay@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 01:43:26PM +0100, Amelie Delaunay wrote:
> Convert the STM32 USB PHY Controller (USBPHYC) bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../bindings/phy/phy-stm32-usbphyc.txt        |  73 ----------
>  .../bindings/phy/phy-stm32-usbphyc.yaml       | 136 ++++++++++++++++++
>  2 files changed, 136 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
> deleted file mode 100644
> index 725ae71ae653..000000000000
> --- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -STMicroelectronics STM32 USB HS PHY controller
> -
> -The STM32 USBPHYC block contains a dual port High Speed UTMI+ PHY and a UTMI
> -switch. It controls PHY configuration and status, and the UTMI+ switch that
> -selects either OTG or HOST controller for the second PHY port. It also sets
> -PLL configuration.
> -
> -USBPHYC
> -      |_ PLL
> -      |
> -      |_ PHY port#1 _________________ HOST controller
> -      |                    _                 |
> -      |                  / 1|________________|
> -      |_ PHY port#2 ----|   |________________
> -      |                  \_0|                |
> -      |_ UTMI switch_______|          OTG controller
> -
> -
> -Phy provider node
> -=================
> -
> -Required properties:
> -- compatible: must be "st,stm32mp1-usbphyc"
> -- reg: address and length of the usb phy control register set
> -- clocks: phandle + clock specifier for the PLL phy clock
> -- #address-cells: number of address cells for phys sub-nodes, must be <1>
> -- #size-cells: number of size cells for phys sub-nodes, must be <0>
> -
> -Optional properties:
> -- assigned-clocks: phandle + clock specifier for the PLL phy clock
> -- assigned-clock-parents: the PLL phy clock parent
> -- resets: phandle + reset specifier
> -
> -Required nodes: one sub-node per port the controller provides.
> -
> -Phy sub-nodes
> -==============
> -
> -Required properties:
> -- reg: phy port index
> -- phy-supply: phandle to the regulator providing 3V3 power to the PHY,
> -	      see phy-bindings.txt in the same directory.
> -- vdda1v1-supply: phandle to the regulator providing 1V1 power to the PHY
> -- vdda1v8-supply: phandle to the regulator providing 1V8 power to the PHY
> -- #phy-cells: see phy-bindings.txt in the same directory, must be <0> for PHY
> -  port#1 and must be <1> for PHY port#2, to select USB controller
> -
> -
> -Example:
> -		usbphyc: usb-phy@5a006000 {
> -			compatible = "st,stm32mp1-usbphyc";
> -			reg = <0x5a006000 0x1000>;
> -			clocks = <&rcc_clk USBPHY_K>;
> -			resets = <&rcc_rst USBPHY_R>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			usbphyc_port0: usb-phy@0 {
> -				reg = <0>;
> -				phy-supply = <&vdd_usb>;
> -				vdda1v1-supply = <&reg11>;
> -				vdda1v8-supply = <&reg18>
> -				#phy-cells = <0>;
> -			};
> -
> -			usbphyc_port1: usb-phy@1 {
> -				reg = <1>;
> -				phy-supply = <&vdd_usb>;
> -				vdda1v1-supply = <&reg11>;
> -				vdda1v8-supply = <&reg18>
> -				#phy-cells = <1>;
> -			};
> -		};
> diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> new file mode 100644
> index 000000000000..09064bbb68dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/phy-stm32-usbphyc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 USB HS PHY controller binding
> +
> +description:
> +
> +  The STM32 USBPHYC block contains a dual port High Speed UTMI+ PHY and a UTMI
> +  switch. It controls PHY configuration and status, and the UTMI+ switch that
> +  selects either OTG or HOST controller for the second PHY port. It also sets
> +  PLL configuration.
> +
> +  USBPHYC
> +  |_ PLL
> +  |
> +  |_ PHY port#1 _________________ HOST controller
> +  |                   __                 |
> +  |                  / 1|________________|
> +  |_ PHY port#2 ----|   |________________
> +  |                  \_0|                |
> +  |_ UTMI switch_______|          OTG controller
> +
> +maintainers:
> +  - Amelie Delaunay <amelie.delaunay@st.com>
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp1-usbphyc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +#Required child nodes:
> +
> +patternProperties:
> +  "^usb-phy@[0|1]$":
> +    type: object
> +    description:
> +      Each port the controller provides must be represented as a sub-node.
> +
> +    properties:
> +      reg:
> +        description: phy port index.
> +        maxItems: 1
> +
> +      phy-supply:
> +        description: regulator providing 3V3 power supply to the PHY.
> +
> +      vdda1v1-supply:
> +        description: regulator providing 1V1 power supply to the PLL block
> +
> +      vdda1v8-supply:
> +        description: regulator providing 1V8 power supply to the PLL block
> +
> +      "#phy-cells":
> +        enum: [ 0x0, 0x1 ]
> +
> +    allOf:
> +      - if:
> +          properties:
> +            reg:
> +              const: 0
> +        then:
> +          properties:
> +            "#phy-cells":
> +              const: 0
> +        else:
> +          properties:
> +            "#phy-cells":
> +              const: 1
> +              description:
> +                The value is used to select UTMI switch output.
> +                0 for OTG controller and 1 for Host controller.
> +
> +    required:
> +      - reg
> +      - phy-supply
> +      - vdda1v1-supply
> +      - vdda1v8-supply
> +      - "#phy-cells"

       additionalProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#address-cells"
> +  - "#size-cells"
> +  - usb-phy@0
> +  - usb-phy@1
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    usbphyc: usbphyc@5a006000 {
> +        compatible = "st,stm32mp1-usbphyc";
> +        reg = <0x5a006000 0x1000>;
> +        clocks = <&rcc USBPHY_K>;
> +        resets = <&rcc USBPHY_R>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        usbphyc_port0: usb-phy@0 {
> +            reg = <0>;
> +            phy-supply = <&vdd_usb>;
> +            vdda1v1-supply = <&reg11>;
> +            vdda1v8-supply = <&reg18>;
> +            #phy-cells = <0>;
> +        };
> +
> +        usbphyc_port1: usb-phy@1 {
> +            reg = <1>;
> +            phy-supply = <&vdd_usb>;
> +            vdda1v1-supply = <&reg11>;
> +            vdda1v8-supply = <&reg18>;
> +            #phy-cells = <1>;
> +        };
> +    };
> +...
> -- 
> 2.17.1
> 
