Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E00247925
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 23:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgHQVwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 17:52:12 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39553 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgHQVwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:52:11 -0400
Received: by mail-io1-f67.google.com with SMTP id z6so19180823iow.6;
        Mon, 17 Aug 2020 14:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E11IGqe88Tc6Z0vOlOvE5ENGRj196p+lCtOlbpTnEuM=;
        b=TZNegIblZYVc6zm/EWEOaaWNRV0ClM1HEIWqH2wQjVVK3KMhplP9hrVHzUm/BNjCeq
         IglNDShCTEj4B80jUpsuqAnIZBQkH0G4CYcPS0GQYKfOIjdkf6XeL1TzfarRC/M8pE6P
         K9+mxdk67+HYZ0E0UoGT/pmY6VGFQTLAWShjqqnRWUQdZJ/uPLrusP05aXPHFoRpEnxx
         1Ir+gsEHXmr+6YCXebFmYNeyWB5fCduQzEr3fc2lntfMGkhfTAT61Rs/k5xPxtSKNalx
         428h9PToPnti/ZQDKpcTyBaTxc8ooyLoIcXGULFvRskRt4/STpDm6o9gqQZ4Dcu4oQjX
         aC8A==
X-Gm-Message-State: AOAM531t3y/9sYx3Y0noMwjk3HyARmvzhhwGvnegR71iceDESPf1DD6G
        eMwbwaxumvITq9DhP1s4Lg==
X-Google-Smtp-Source: ABdhPJyHSDK+5TEtfeg0k9BGNP6X9Atf/V18+ASpg7f0YjHh3/cYxf3H70kyY4EQqMZnas7g5GZrTg==
X-Received: by 2002:a6b:8dd2:: with SMTP id p201mr14037976iod.152.1597701129759;
        Mon, 17 Aug 2020 14:52:09 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id t187sm9556524iof.54.2020.08.17.14.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:52:09 -0700 (PDT)
Received: (nullmailer pid 1635439 invoked by uid 1000);
        Mon, 17 Aug 2020 21:52:08 -0000
Date:   Mon, 17 Aug 2020 15:52:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, shengjiu.wang@nxp.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] dt-bindings: sound: Convert NXP spdif to json-schema
Message-ID: <20200817215208.GA1632404@bogus>
References: <1596691077-30658-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596691077-30658-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 01:17:57PM +0800, Anson Huang wrote:
> Convert the NXP SPDIF binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,spdif.txt        |  68 -------------
>  .../devicetree/bindings/sound/fsl,spdif.yaml       | 108 +++++++++++++++++++++
>  2 files changed, 108 insertions(+), 68 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl,spdif.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> deleted file mode 100644
> index e1365b0..0000000
> --- a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -Freescale Sony/Philips Digital Interface Format (S/PDIF) Controller
> -
> -The Freescale S/PDIF audio block is a stereo transceiver that allows the
> -processor to receive and transmit digital audio via an coaxial cable or
> -a fibre cable.
> -
> -Required properties:
> -
> -  - compatible		: Compatible list, should contain one of the following
> -			  compatibles:
> -			  "fsl,imx35-spdif",
> -			  "fsl,vf610-spdif",
> -			  "fsl,imx6sx-spdif",
> -
> -  - reg			: Offset and length of the register set for the device.
> -
> -  - interrupts		: Contains the spdif interrupt.
> -
> -  - dmas		: Generic dma devicetree binding as described in
> -			  Documentation/devicetree/bindings/dma/dma.txt.
> -
> -  - dma-names		: Two dmas have to be defined, "tx" and "rx".
> -
> -  - clocks		: Contains an entry for each entry in clock-names.
> -
> -  - clock-names		: Includes the following entries:
> -	"core"		  The core clock of spdif controller.
> -	"rxtx<0-7>"	  Clock source list for tx and rx clock.
> -			  This clock list should be identical to the source
> -			  list connecting to the spdif clock mux in "SPDIF
> -			  Transceiver Clock Diagram" of SoC reference manual.
> -			  It can also be referred to TxClk_Source bit of
> -			  register SPDIF_STC.
> -	"spba"		  The spba clock is required when SPDIF is placed as a
> -			  bus slave of the Shared Peripheral Bus and when two
> -			  or more bus masters (CPU, DMA or DSP) try to access
> -			  it. This property is optional depending on the SoC
> -			  design.
> -
> -Optional properties:
> -
> -   - big-endian		: If this property is absent, the native endian mode
> -			  will be in use as default, or the big endian mode
> -			  will be in use for all the device registers.
> -
> -Example:
> -
> -spdif: spdif@2004000 {
> -	compatible = "fsl,imx35-spdif";
> -	reg = <0x02004000 0x4000>;
> -	interrupts = <0 52 0x04>;
> -	dmas = <&sdma 14 18 0>,
> -	       <&sdma 15 18 0>;
> -	dma-names = "rx", "tx";
> -
> -	clocks = <&clks 197>, <&clks 3>,
> -	       <&clks 197>, <&clks 107>,
> -	       <&clks 0>, <&clks 118>,
> -	       <&clks 62>, <&clks 139>,
> -	       <&clks 0>;
> -	clock-names = "core", "rxtx0",
> -		"rxtx1", "rxtx2",
> -		"rxtx3", "rxtx4",
> -		"rxtx5", "rxtx6",
> -		"rxtx7";
> -
> -	big-endian;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> new file mode 100644
> index 0000000..819f37f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Sony/Philips Digital Interface Format (S/PDIF) Controller
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +description: |
> +  The Freescale S/PDIF audio block is a stereo transceiver that allows the
> +  processor to receive and transmit digital audio via an coaxial cable or
> +  a fibre cable.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx35-spdif
> +      - fsl,vf610-spdif
> +      - fsl,imx6sx-spdif
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dmas:
> +    items:
> +      - description: DMA controller phandle and request line for RX
> +      - description: DMA controller phandle and request line for TX
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +  clocks:
> +    items:
> +      - description: The core clock of spdif controller.
> +      - description: Clock for tx0 and rx0.
> +      - description: Clock for tx1 and rx1.
> +      - description: Clock for tx2 and rx2.
> +      - description: Clock for tx3 and rx3.
> +      - description: Clock for tx4 and rx4.
> +      - description: Clock for tx5 and rx5.
> +      - description: Clock for tx6 and rx6.
> +      - description: Clock for tx7 and rx7.
> +      - description: The spba clock is required when SPDIF is placed as a bus
> +          slave of the Shared Peripheral Bus and when two or more bus masters
> +          (CPU, DMA or DSP) try to access it. This property is optional depending
> +          on the SoC design.
> +    minItems: 9
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: rxtx0
> +      - const: rxtx1
> +      - const: rxtx2
> +      - const: rxtx3
> +      - const: rxtx4
> +      - const: rxtx5
> +      - const: rxtx6
> +      - const: rxtx7
> +      - const: spba
> +    minItems: 9
> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      If this property is absent, the native endian mode will be in use
> +      as default, or the big endian mode will be in use for all the device
> +      registers. Set this flag for HCDs with big endian descriptors and big
> +      endian registers.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - dmas
> +  - dma-names
> +  - clocks
> +  - clock-names

Add:

additionalProperties: false

With that added,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +examples:
> +  - |
> +    spdif@2004000 {
> +        compatible = "fsl,imx35-spdif";
> +        reg = <0x02004000 0x4000>;
> +        interrupts = <0 52 0x04>;
> +        dmas = <&sdma 14 18 0>,
> +               <&sdma 15 18 0>;
> +        dma-names = "rx", "tx";
> +        clocks = <&clks 197>, <&clks 3>,
> +                 <&clks 197>, <&clks 107>,
> +                 <&clks 0>, <&clks 118>,
> +                 <&clks 62>, <&clks 139>,
> +                 <&clks 0>;
> +        clock-names = "core", "rxtx0",
> +                      "rxtx1", "rxtx2",
> +                      "rxtx3", "rxtx4",
> +                      "rxtx5", "rxtx6",
> +                      "rxtx7";
> +        big-endian;
> +    };
> -- 
> 2.7.4
> 
