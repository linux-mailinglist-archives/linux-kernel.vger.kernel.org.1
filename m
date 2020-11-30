Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C332C8821
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgK3PfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgK3PfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:35:20 -0500
Received: from localhost (unknown [122.171.214.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5FD02076C;
        Mon, 30 Nov 2020 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606750478;
        bh=n20D+/Y5vTS9xKJv9aHowCaS3OlPRr1jLxQk2PopG+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NfCNSNb8EqX9I5fP7vNaFjNJHRpjInOso2fe5DbKjaZweyjB3UK74VVgV72pkhU82
         jqmuduB0Kd7Eb+ouUG4I6wlMzXJ1sdf66z8OtjQyMllx02UQb0InLtQyXvPj8lVMjq
         A2mpaQmTdp8zomc8HhK/jHkZqh3Bzs+s+/FVzK+U=
Date:   Mon, 30 Nov 2020 21:04:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: Convert Broadcom SATA PHY to YAML
Message-ID: <20201130153434.GT8403@vkoul-mobl>
References: <20201122032926.2185026-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122032926.2185026-1-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,


On 21-11-20, 19:29, Florian Fainelli wrote:
> Update the Broadcom SATA PHY Device Tree binding to a YAML format.
> 
> Suggested-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

I am getting these warns:

Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:19:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:20:12: [warning] wrong indentation: expected 12 but found 11 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:26:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:28:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:30:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:51:6: [warning] wrong indentation: expected 4 but found 5 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:71:11: [warning] wrong indentation: expected 9 but found 10 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:80:11: [warning] wrong indentation: expected 9 but found 10 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:88:11: [warning] wrong indentation: expected 9 but found 10 (indentation)

Documentation/devicetree/bindings/phy/brcm,sata-phy.example.dt.yaml: sata-phy@f0458100: '#phy-cells' is a required property
	From schema: /usr/local/lib/python3.8/site-packages/dtschema/schemas/phy/phy-provider.yaml

> ---
> This is based on phy/next and it depends on the following commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?h=next&id=6d3b3f88423e4edc0fad5853c10558b42e1a91dd
> 
> it would make sense to have Vinod apply this change.
> 
>  .../bindings/phy/brcm,sata-phy.yaml           | 148 ++++++++++++++++++
>  .../devicetree/bindings/phy/brcm-sata-phy.txt |  61 --------
>  2 files changed, 148 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
> new file mode 100644
> index 000000000000..979b7419dc69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
> @@ -0,0 +1,148 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/brcm,sata-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Broadcom SATA3 PHY
> +
> +maintainers:
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^sata[-|_]phy(@.*)?$"
> +
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +           - brcm,bcm7216-sata-phy
> +           - brcm,bcm7425-sata-phy
> +           - brcm,bcm7445-sata-phy
> +           - brcm,bcm63138-sata-phy
> +        - const: brcm,phy-sata3
> +      - items:
> +        - const: brcm,iproc-nsp-sata-phy
> +      - items:
> +        - const: brcm,iproc-ns2-sata-phy
> +      - items:
> +        - const: brcm,iproc-sr-sata-phy
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: phy
> +      - const: phy-ctrl
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^sata-phy@[0-9]+$":
> +     type: object
> +     description: |
> +       Each port's PHY should be represented as a sub-node.
> +
> +     properties:
> +       reg:
> +         description: The SATA PHY port number
> +         maxItems: 1
> +
> +       "#phy-cells":
> +         const: 0
> +
> +       "brcm,enable-ssc":
> +         $ref: /schemas/types.yaml#/definitions/flag
> +         description: |
> +           Use spread spectrum clocking (SSC) on this port
> +           This property is not applicable for "brcm,iproc-ns2-sata-phy",
> +           "brcm,iproc-nsp-sata-phy" and "brcm,iproc-sr-sata-phy".
> +
> +       "brcm,rxaeq-mode":
> +          $ref: /schemas/types.yaml#/definitions/string
> +          description:
> +            String that indicates the desired RX equalizer mode.
> +          enum:
> +            - off
> +            - auto
> +            - manual
> +
> +       "brcm,rxaeq-value":
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          description: |
> +            When 'brcm,rxaeq-mode' is set to "manual", provides the RX
> +            equalizer value that should be used.
> +          minimum: 0
> +          maximum: 63
> +
> +       "brcm,tx-amplitude-millivolt":
> +          description: |
> +            Transmit amplitude voltage in millivolt.
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          enum: [400, 500, 600, 800]
> +
> +     required:
> +       - reg
> +       - "#phy-cells"
> +
> +     additionalProperties: false
> +
> +if:
> +  properties:
> +    compatible:
> +      items:
> +        const: brcm,iproc-ns2-sata-phy
> +then:
> +  properties:
> +    reg:
> +      maxItems: 2
> +    reg-names:
> +      items:
> +        - const: "phy"
> +        - const: "phy-ctrl"
> +else:
> +  properties:
> +    reg:
> +      maxItems: 1
> +    reg-names:
> +      maxItems: 1
> +      items:
> +        - const: "phy"
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - reg
> +  - reg-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sata-phy@f0458100 {
> +        compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
> +        reg = <0xf0458100 0x1e00>;
> +        reg-names = "phy";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sata-phy@0 {
> +                reg = <0>;
> +                #phy-cells = <0>;
> +        };
> +
> +        sata-phy@1 {
> +                reg = <1>;
> +                #phy-cells = <0>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
> deleted file mode 100644
> index e5abbace93a3..000000000000
> --- a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -* Broadcom SATA3 PHY
> -
> -Required properties:
> -- compatible: should be one or more of
> -     "brcm,bcm7216-sata-phy"
> -     "brcm,bcm7425-sata-phy"
> -     "brcm,bcm7445-sata-phy"
> -     "brcm,iproc-ns2-sata-phy"
> -     "brcm,iproc-nsp-sata-phy"
> -     "brcm,phy-sata3"
> -     "brcm,iproc-sr-sata-phy"
> -     "brcm,bcm63138-sata-phy"
> -- address-cells: should be 1
> -- size-cells: should be 0
> -- reg: register ranges for the PHY PCB interface
> -- reg-names: should be "phy" and "phy-ctrl"
> -     The "phy-ctrl" registers are only required for
> -     "brcm,iproc-ns2-sata-phy" and "brcm,iproc-sr-sata-phy".
> -
> -Sub-nodes:
> -  Each port's PHY should be represented as a sub-node.
> -
> -Sub-nodes required properties:
> -- reg: the PHY number
> -- phy-cells: generic PHY binding; must be 0
> -
> -Sub-nodes optional properties:
> -- brcm,enable-ssc: use spread spectrum clocking (SSC) on this port
> -     This property is not applicable for "brcm,iproc-ns2-sata-phy",
> -     "brcm,iproc-nsp-sata-phy" and "brcm,iproc-sr-sata-phy".
> -
> -- brcm,rxaeq-mode: string that indicates the desired RX equalizer
> -  mode, possible values are:
> -	"off" (equivalent to not specifying the property)
> -	"auto"
> -	"manual" (brcm,rxaeq-value is used in that case)
> -
> -- brcm,rxaeq-value: when 'rxaeq-mode' is set to "manual", provides the RX
> -  equalizer value that should be used. Allowed range is 0..63.
> -
> -- brcm,tx-amplitude-millivolt: transmit amplitude voltage in millivolt.
> -  Possible values are 400, 500, 600 or 800 mV.
> -
> -Example
> -	sata-phy@f0458100 {
> -		compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
> -		reg = <0xf0458100 0x1e00>, <0xf045804c 0x10>;
> -		reg-names = "phy";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		sata-phy@0 {
> -			reg = <0>;
> -			#phy-cells = <0>;
> -		};
> -
> -		sata-phy@1 {
> -			reg = <1>;
> -			#phy-cells = <0>;
> -		};
> -	};
> -- 
> 2.25.1

-- 
~Vinod
