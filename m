Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9263036E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389280AbhAZG4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:56:42 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:40255 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729933AbhAYPg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:36:27 -0500
Received: by mail-oi1-f177.google.com with SMTP id p5so15130008oif.7;
        Mon, 25 Jan 2021 07:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qBbmNURV0SzSgAA2gXwlstv90vMPi1N+gnPtfxuvFaA=;
        b=g8q0SlslsWxheOzYHHSTpJN0xMXf0pK9Wua1wWChMJiMHkddETFWOJ8gj7CkVjHzN7
         /SoazFMnZBw//QxeInMbpsIjAzK311+s7xW4BW3LerN2z8maHJh8pEf9+9zi5Zyrb+Wp
         LoH3iUKUGSy/Iib7emY2NVxLsEXw46hYxUDtj7+wrMHmL6X2TJ5YrvtjweU5bjiqTgG5
         dGgCIlxAgT659UU/ckurvLEFwznoASqh1tymn4OYFwQxTlNcdVg2WTvqIQOcfXc008R/
         a2v+C4RaGoKdugrBhCxK/SmulENn7ZsTSMpbUTDW7IDQCNNAvo7gbrRBHpeiBVxBwh3z
         /DyA==
X-Gm-Message-State: AOAM5318Wkbkxelmbtvq2H04kfmqE8Mw4+3EJUMrhkF2Rt30/UQuHNhM
        wHgXZkHLpV+MZWtrOuStnAxigaZpZQ==
X-Google-Smtp-Source: ABdhPJyTZvSQswq59TsmpY1YeHCkm2gJXLeQpFRuR0Kc9e8Qt7reUkrjY1w0RBKCXX0TFC2tgkGRhA==
X-Received: by 2002:aca:d504:: with SMTP id m4mr460011oig.158.1611588085320;
        Mon, 25 Jan 2021 07:21:25 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m7sm3525492otq.33.2021.01.25.07.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:21:23 -0800 (PST)
Received: (nullmailer pid 381099 invoked by uid 1000);
        Mon, 25 Jan 2021 15:21:22 -0000
Date:   Mon, 25 Jan 2021 09:21:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, petre.minciunescu@analog.com
Subject: Re: [PATCH 2/2] dt-bindings: clock: ad9545: Add documentation
Message-ID: <20210125152122.GA348771@robh.at.kernel.org>
References: <20210124221304.51007-1-alexandru.tachici@analog.com>
 <20210124221304.51007-3-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124221304.51007-3-alexandru.tachici@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:13:04AM +0200, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add dt bindings for ad9545.

This is kind of verbose just for a clock chip...

Maybe some of the configuration should be encoded into the clock cells 
at least where the config is determined by the consumer of a clock.

> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../devicetree/bindings/clock/clk-ad9545.yaml | 352 ++++++++++++++++++
>  1 file changed, 352 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/clk-ad9545.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/clk-ad9545.yaml b/Documentation/devicetree/bindings/clock/clk-ad9545.yaml
> new file mode 100644
> index 000000000000..3611eaaa145c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/clk-ad9545.yaml
> @@ -0,0 +1,352 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/clk-ad9545.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD9545 Quad Input, 10-Output, Dual DPLL/IEEE 1588
> +
> +maintainers:
> +  - Alexandru Tachici <alexandru.tachici@analog.com>
> +
> +description: |
> +  Analog Devices AD9545 Quad Input, 10-Output, Dual DPLL/IEEE 1588,
> +  1 pps Synchronizer and Jitter Cleaner
> +
> +  Relevant documents:
> +    [1] ad9545 datasheet:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/ad9545.pdf
> +
> +    [2] Defines used: include/dt-bindings/clock/ad9545.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad9545
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#clock-cells":
> +    description: |
> +      The first cell indicates the clock type and the second number is the clock address (see [2]).
> +    const: 2
> +
> +  reg:
> +    description: |
> +      I2C address of the secondary device.
> +    minimum: 0
> +    maximum: 0xFF

Isn't 0x7f the max? In any case, that's something for the I2C bus schema 
to define. If you don't have specific addresses (I doubt all addresses 
are possible), then just:

reg:
  maxItems: 1

> +
> +  avcc-supply:
> +    description: |
> +      Phandle to the Avcc power supply.
> +
> +  adi,freq-doubler:
> +    description: |
> +      The system clock PLL provides the user with the option of doubling the reference frequency.
> +    type: boolean
> +
> +  adi,ref-crystal:
> +    description: |
> +      At XOA,XOB there is a crystal connected that needs maintaining.
> +      Otherwise it is assumed that there is a TCXO or OCXO connected.
> +    type: boolean
> +
> +  adi,ref-frequency-hz:
> +    description: |
> +      Reference input frequency at XOA,XOB. This is used for the system clock.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type for standard units.

> +
> +  clocks:
> +    items:
> +      - description: Ref A clock input
> +      - description: Ref AA clock input
> +      - description: Ref B clock input
> +      - description: Ref BB clock input
> +    maxItems: 4
> +
> +  clock-output-names:
> +    minItems: 1
> +    maxItems: 10
> +
> +  assigned-clocks:
> +     minItems: 1
> +     maxItems: 14
> +
> +  assigned-clock-rates:
> +    description: |
> +      Can initialize frequency of the 2 auxiliary NCOs, 2 PLLs and 10 clock outputs.
> +      Output clock rates must be one of the divisors of PLL assigned frequency.
> +    minItems: 1
> +    maxItems: 14
> +
> +patternProperties:
> +  "^ref-input-clk@[0-3]$":
> +    description: |
> +      Represents a reference clock input.
> +    type: object
> +
> +    properties:
> +      reg:
> +        description: |
> +          The reference input number. It can have up to 4 input clocks numbered from 0 to 3.
> +          (mapped: [refa, refaa, refb, refbb] -> [0, 1, 2, 3])
> +        maxItems: 1
> +
> +      adi,single-ended-mode:
> +        description: |
> +          Single-ended configuration mode.
> +        allOf:

Don't need allOf.

> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0, 1, 2, 3]
> +        maxItems: 1

'maxItems' is for an array. This is a scalar.

> +
> +      adi,differential-mode:
> +        description: |
> +          Differential configuration mode.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0, 1, 2]
> +        maxItems: 1
> +
> +      adi,r-divider-ratio:
> +        description: |
> +          Each reference input has a dedicated divider.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 1
> +          - maximum: 1073741824
> +        maxItems: 1
> +
> +      adi,ref-dtol-pbb:
> +        description: |
> +          REFx offset limit. Constitutes a fractional portion of the corresponding nominal period.
> +          The 24-bit number represents fractional units of parts per billion (ppb) up to a
> +          maximum of approximately 17 million ppb (1.7%).
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 0
> +          - maximum: 16777215
> +          - default: 100000
> +
> +      adi,ref-monitor-hysteresis-pbb:
> +        description: |
> +          Basis points of the offset limit representing per ten thousand of REFx offset limit.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0, 3125, 6250, 12500, 25000, 50000, 75000, 87500]
> +          - default: 12500
> +
> +      adi,ref-validation-timer-ms:
> +        description: |
> +          Time required for a reference to remain in tolerance condition before being
> +          available to be used.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 1
> +          - maximum: 1048574
> +          - default: 10
> +
> +      adi,freq-lock-threshold-ps:
> +        description: |
> +          Phase lock detector threshold (in picoseconds).
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 1
> +          - maximum: 16777215
> +        maxItems: 1
> +
> +      adi,phase-lock-threshold-ps:
> +        description: |
> +          Profile 0 frequency lock threshold. Frequency lock detector threshold (in picoseconds).
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 1
> +          - maximum: 16777215
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +      - adi,r-divider-ratio
> +      - adi,ref-dtol-pbb
> +      - adi,ref-monitor-hysteresis-pbb
> +      - adi,ref-validation-timer-ms
> +      - adi,freq-lock-threshold-ps
> +      - adi,phase-lock-threshold-ps
> +
> +  "^pll-clk@[0-1]$":

You already used addresses 0-1 above. There should only be 1 address 
space at a given level.

> +    description: |
> +      Represents a PLL.
> +    type: object
> +
> +    properties:
> +      reg:
> +        description: |
> +          PLL number. AD9545 has two PLLs.
> +        maxItems: 1
> +
> +      adi,pll-source:
> +        description: |
> +          Each PLL can have 1 signal source. Choose from Ref-A to Ref-BB [0-3] or aux NCOs [4-5].

Sounds like what the assigned-clocks binding is for...

> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0, 1, 2, 3, 4, 5]
> +        maxItems: 1
> +
> +      adi,pll-loop-bandwidth-hz:
> +        description: |
> +          PLL loop bandwidth.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 1
> +          - maximum: 1850
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +      - adi,pll-source
> +      - adi,pll-loop-bandwidth-hz
> +
> +  "^aux-nco-clk@[0-1]$":
> +    description: |
> +      Represents an auxiliary Numerical Controlled Oscilator. Generates timestamps that
> +      can be sent to the DPLL0 or DPLL1.
> +    type: object
> +
> +    properties:
> +      reg:
> +        description: |
> +          Auxiliary NCO address (see [2]).
> +        maxItems: 1
> +
> +      adi,freq-lock-threshold-ps:
> +        description: |
> +          Phase lock detector threshold (in picoseconds).
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 1
> +          - maximum: 16777215
> +        maxItems: 1
> +
> +      adi,phase-lock-threshold-ps:
> +        description: |
> +          Profile 0 frequency lock threshold. Frequency lock detector threshold (in picoseconds).
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 1
> +          - maximum: 16777215
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +      - adi,freq-lock-threshold-ps
> +      - adi,phase-lock-threshold-ps
> +
> +  "^output-clk@([0-9])$":
> +    description: |
> +      Represents a clock output.
> +    type: object
> +
> +    properties:
> +      reg:
> +        description: |
> +          The reference input number. It can have up to 10 output clocks mapped:
> +          (OUT0AP OUT0AN OUT0BP OUT0BN OUT0CP OUT0CN OUT1AP OUT1AN OUT1BP OUT1BN) ->
> +          (0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
> +        maxItems: 1
> +
> +      adi,current-source:
> +        description: |
> +          If specified output is set as current source.
> +        type: boolean
> +
> +      adi,current-source-microamp:
> +        description: |
> +          The magnitude of the driver current.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [7500, 12500, 15000]
> +        minItems: 1
> +
> +      adi,output-mode:
> +        description: |
> +          Output driver mode.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0, 1, 2]
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +      - adi,current-source-microamp
> +      - adi,output-mode
> +
> +  clocks: true
> +  assigned-clocks: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - adi,ref-frequency-hz
> +
> +"additionalProperties": false

Don't need quotes.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ad9545.h>
> +
> +    i2c1 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            ad9545_clock: ad9545@4A {
> +                compatible = "adi,ad9545";
> +                reg = <0x4A>;
> +
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                adi,ref-crystal;
> +                adi,ref-frequency-hz = <49152000>;
> +
> +                #clock-cells = <2>;
> +                clocks = <&ad9545_clock AD9545_CLK_NCO AD9545_NCO0>,
> +                         <&ad9545_clock AD9545_CLK_PLL AD9545_PLL1>,
> +                         <&ad9545_clock AD9545_CLK_OUT AD9545_Q1A>,
> +                         <&ad9545_clock AD9545_CLK_OUT AD9545_Q1B>;
> +                assigned-clocks = <&ad9545_clock AD9545_CLK_NCO AD9545_NCO0>,
> +                                  <&ad9545_clock AD9545_CLK_PLL AD9545_PLL1>,
> +                                  <&ad9545_clock AD9545_CLK_OUT AD9545_Q1A>,
> +                                  <&ad9545_clock AD9545_CLK_OUT AD9545_Q1B>;
> +                assigned-clock-rates = <10000>, <1875000000>, <156250000>, <156250000>;
> +
> +                aux-nco-clk@AD9545_NCO0 {
> +                        reg = <AD9545_NCO0>;
> +                        adi,freq-lock-threshold-ps = <16000000>;
> +                        adi,phase-lock-threshold-ps = <16000000>;
> +                };
> +
> +                ad9545_apll1: pll-clk@AD9545_PLL1 {
> +                        reg = <AD9545_PLL1>;
> +                        adi,pll-source = <4>;
> +                        adi,pll-loop-bandwidth-hz = <200>;
> +                };
> +
> +                output-clk@AD9545_Q1A {
> +                        reg = <AD9545_Q1A>;
> +                        adi,output-mode = <DRIVER_MODE_SINGLE_DIV_DIF>;
> +                        adi,current-source-microamp = <15000>;
> +                };
> +
> +                output-clk@AD9545_Q1B {
> +                        reg = <AD9545_Q1B>;
> +                        adi,output-mode = <DRIVER_MODE_SINGLE_DIV_DIF>;
> +                        adi,current-source-microamp = <15000>;
> +                };
> +            };
> +    };
> +...
> -- 
> 2.20.1
> 
