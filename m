Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320FF2A85A1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbgKESDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:03:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39857 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKESDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:03:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id z16so2255107otq.6;
        Thu, 05 Nov 2020 10:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oXCLaf3/tmMtFdlKf8NOILXkQGvPX5Ww/dhrD3bunx0=;
        b=hbJFlDxDKp3tZkqlM/lgoBzZlAsilWypmvSXTC7S2Kg5mvqmlU/975FY4VhkjUEssa
         vCoVIh0apk936hSBdhSOysKerF9kbGhiFXZLye+tfQInckZN4pndOrePcMBKKT6Hc00N
         r2rTMknUx2ElBgGxpK4vT2iN4Rs1erc9wnDKX1D2bSX66kHTdE9SQYs3Xy0Q0nXcOgkd
         3/XLrJzmupsf0J9VY5sELJX+f52g0VOhHXheuuNp71b+thJpXX+iJfZzCOxrmO17udp+
         x+hBP0+9TzQY41h9mTngTF/ewOFRQHehGP78COtFOhpnzSUAcHMSkqvR7AWsVQn9/BCO
         zMBg==
X-Gm-Message-State: AOAM532MWORwFGVWw47HbW1ODvi9iZRwBVU0a/K62ExT297D3zzwRUG+
        vqKqC4C8moYkuMPH5W1PAQ==
X-Google-Smtp-Source: ABdhPJxkMNWyijZHXfLe8WmFrLCkIxS3KCE6tREcLod1jUIZI/jDRRod7ZbjhB2MPvJC0VKAnfaq1Q==
X-Received: by 2002:a9d:27c9:: with SMTP id c67mr2000532otb.301.1604599389632;
        Thu, 05 Nov 2020 10:03:09 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g8sm526867oia.16.2020.11.05.10.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:03:09 -0800 (PST)
Received: (nullmailer pid 1560661 invoked by uid 1000);
        Thu, 05 Nov 2020 18:03:08 -0000
Date:   Thu, 5 Nov 2020 12:03:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: phy: cadence-sierra: Add bindings for
 the PLLs within SERDES
Message-ID: <20201105180308.GA1540220@bogus>
References: <20201103035556.21260-1-kishon@ti.com>
 <20201103035556.21260-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103035556.21260-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:25:48AM +0530, Kishon Vijay Abraham I wrote:
> Add binding for the PLLs within SERDES.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/phy/phy-cadence-sierra.yaml      | 89 ++++++++++++++++++-
>  1 file changed, 86 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
> index d210843863df..f574b8ed358c 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
> @@ -49,12 +49,14 @@ properties:
>      const: serdes
>  
>    clocks:
> -    maxItems: 2
> +    maxItems: 4
>  
>    clock-names:
>      items:
>        - const: cmn_refclk_dig_div
>        - const: cmn_refclk1_dig_div
> +      - const: pll_cmnlc
> +      - const: pll_cmnlc1
>  
>    cdns,autoconf:
>      type: boolean
> @@ -107,6 +109,58 @@ patternProperties:
>  
>      additionalProperties: false
>  
> +  "^refrcv1?$":
> +    type: object
> +    description: |
> +      Reference receivers that enables routing external clocks to the alternate
> +      PLLCMNLC.
> +    properties:
> +      clocks:
> +        maxItems: 1
> +        description: Phandle to clock nodes representing the input to the
> +          reference receiver.
> +
> +      clock-names:
> +        items:
> +          - const: pll_refclk
> +
> +      "#clock-cells":
> +        const: 0
> +
> +    required:
> +      - clocks
> +      - "#clock-cells"
> +
> +  "^pll_cmnlc1?$":
> +    type: object
> +    description: |
> +      SERDES node should have subnodes for each of the PLLs present in
> +      the SERDES.
> +    properties:
> +      clocks:
> +        maxItems: 2
> +        description: Phandle to clock nodes representing the two inputs to PLL.
> +
> +      clock-names:
> +        items:
> +          - const: pll_refclk
> +          - const: refrcv
> +
> +      "#clock-cells":
> +        const: 0
> +
> +      assigned-clocks:
> +        maxItems: 1
> +
> +      assigned-clock-parents:
> +        maxItems: 1
> +
> +    required:
> +      - clocks
> +      - "#clock-cells"
> +      - assigned-clocks
> +      - assigned-clock-parents
> +
>  required:
>    - compatible
>    - "#address-cells"
> @@ -130,10 +184,39 @@ examples:
>              reg = <0x0 0xfd240000 0x0 0x40000>;
>              resets = <&phyrst 0>, <&phyrst 1>;
>              reset-names = "sierra_reset", "sierra_apb";
> -            clocks = <&cmn_refclk_dig_div>, <&cmn_refclk1_dig_div>;
> -            clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
> +            clocks = <&cmn_refclk_dig_div>, <&cmn_refclk1_dig_div>, <&serdes_pll_cmnlc>, <&serdes_pll_cmnlc1>;
> +            clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div", "pll_cmnlc", "pll_cmnlc1";
>              #address-cells = <1>;
>              #size-cells = <0>;
> +
> +            serdes_refrcv: refrcv {
> +                    clocks = <&pll0_refclk>;
> +                    clock-names = "pll_refclk";
> +                    #clock-cells = <0>;
> +            };
> +
> +            serdes_refrcv1: refrcv1 {
> +                    clocks = <&pll1_refclk>;
> +                    clock-names = "pll_refclk";
> +                    #clock-cells = <0>;
> +            };
> +
> +            serdes_pll_cmnlc: pll_cmnlc {
> +                    clocks = <&pll0_refclk>, <&serdes_refrcv1>;
> +                    clock-names = "pll_refclk", "refrcv";
> +                    #clock-cells = <0>;
> +                    assigned-clocks = <&serdes_pll_cmnlc>;

Isn't assigned-clocks supposed to be one of the clocks in 'clocks'?

> +                    assigned-clock-parents = <&pll0_refclk>;

And this should not be a clock in 'clocks'...


More generally, why do we need to expose all these details in DT?

Rob
