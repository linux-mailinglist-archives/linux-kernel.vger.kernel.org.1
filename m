Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA1228530B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgJFUYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:24:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36661 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgJFUYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:24:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id u17so7839428oie.3;
        Tue, 06 Oct 2020 13:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j0R+qNf60pujZO2IxFZ4pVwkxPTg3N4G3MQO77gzqGY=;
        b=qHeHUTO9B5gauX4uwI4yPdaHp68iTNAgismtxXdKP02xyf+EN3amRPn2xVhNMHHfFs
         84NfnrZyomyOZRJ3mTy54BZxLHTKk5b8QonzTSAmJHv0l8j5ffMMkylyWsNwQy0ftsxq
         ssKzgpEZ9IYr+Np40E6cBIoSvAfON0etN36oeWx69ZjWs0t5uyvgfw9P1D3R1YrQuB6c
         lAfjVtt5N+CUN4eRgqxgw2tSG2Z6tXp17fyXkezyOGwcPdZ/fODQXce4bPDEPWUUKD3h
         ZGQS5P0weaO7wexlsNSMnWfMtp+6k/A51FinRpxtxCvOs2kVvpidP/I/jxybSUvLedGv
         IogA==
X-Gm-Message-State: AOAM531+5fEALJaWyfI8pB7JM84krKUTkaawzXNnzGMkaO7pPkVTRzyi
        fiwb+mbi7zHobyhp+6NDHQ==
X-Google-Smtp-Source: ABdhPJzFJ4rYV0ze/kierLkp5YmG1cNDHgkOodkrqk8/6flQwQKg0utzq+NwtXTgabpS2qeLdNorlQ==
X-Received: by 2002:aca:db06:: with SMTP id s6mr29937oig.64.1602015890728;
        Tue, 06 Oct 2020 13:24:50 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b3sm1652102oie.49.2020.10.06.13.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:24:50 -0700 (PDT)
Received: (nullmailer pid 2774384 invoked by uid 1000);
        Tue, 06 Oct 2020 20:24:49 -0000
Date:   Tue, 6 Oct 2020 15:24:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
        lars@metafoo.de, sboyd@kernel.org, mturquette@baylibre.com,
        mdf@kernel.org
Subject: Re: [PATCH] dt-bindings: clock: adi,axi-clkgen: convert old binding
 to yaml format
Message-ID: <20201006202449.GA2769322@bogus>
References: <20201001085035.82938-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001085035.82938-1-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 11:50:35AM +0300, Alexandru Ardelean wrote:
> This change converts the old binding for the AXI clkgen driver to a yaml
> format.
> 
> As maintainers, added:
>  - Lars-Peter Clausen <lars@metafoo.de> - as original author of driver &
>    binding

Do you have permission for relicensing? The default was GPL-2.0.

>  - Michael Hennerich <michael.hennerich@analog.com> - as supporter of
>    Analog Devices drivers
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/clock/adi,axi-clkgen.yaml        | 52 +++++++++++++++++++
>  .../devicetree/bindings/clock/axi-clkgen.txt  | 25 ---------
>  2 files changed, 52 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
>  delete mode 100644 Documentation/devicetree/bindings/clock/axi-clkgen.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
> new file mode 100644
> index 000000000000..45497f370cb3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/adi,axi-clkgen.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binding for Analog Devices AXI clkgen pcore clock generator
> +
> +maintainers:
> +  - Lars-Peter Clausen <lars@metafoo.de>
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  The axi_clkgen IP core is a software programmable clock generator,
> +  that can be synthesized on various FPGA platforms.
> +
> +  Link: https://wiki.analog.com/resources/fpga/docs/axi_clkgen
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,axi-clkgen-2.00.a
> +
> +  clocks:
> +    description:
> +      Phandle and clock specifier for the parent clock(s). 

Drop, that's every 'clocks'.

> This must either
> +      reference one clock if only the first clock input is connected or two
> +      if both clock inputs are connected. For the later case the clock
> +      connected to the first input must be specified first.

That doesn't really say what the 2 clocks are.

> +    minItems: 1
> +    maxItems: 2
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'

additionalProperties: false

> +
> +examples:
> +  - |
> +    clock@ff000000 {

clock-controller@...

> +      compatible = "adi,axi-clkgen-2.00.a";
> +      #clock-cells = <0>;
> +      reg = <0xff000000 0x1000>;
> +      clocks = <&osc 1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/clock/axi-clkgen.txt b/Documentation/devicetree/bindings/clock/axi-clkgen.txt
> deleted file mode 100644
> index aca94fe9416f..000000000000
> --- a/Documentation/devicetree/bindings/clock/axi-clkgen.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Binding for the axi-clkgen clock generator
> -
> -This binding uses the common clock binding[1].
> -
> -[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -
> -Required properties:
> -- compatible : shall be "adi,axi-clkgen-1.00.a" or "adi,axi-clkgen-2.00.a".
> -- #clock-cells : from common clock binding; Should always be set to 0.
> -- reg : Address and length of the axi-clkgen register set.
> -- clocks : Phandle and clock specifier for the parent clock(s). This must
> -	either reference one clock if only the first clock input is connected or two
> -	if both clock inputs are connected. For the later case the clock connected
> -	to the first input must be specified first.
> -
> -Optional properties:
> -- clock-output-names : From common clock binding.
> -
> -Example:
> -	clock@ff000000 {
> -		compatible = "adi,axi-clkgen";
> -		#clock-cells = <0>;
> -		reg = <0xff000000 0x1000>;
> -		clocks = <&osc 1>;
> -	};
> -- 
> 2.17.1
> 
