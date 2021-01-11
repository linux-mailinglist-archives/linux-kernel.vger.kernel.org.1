Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA1A2F1F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391063AbhAKTY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:24:56 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:45693 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390986AbhAKTYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:24:53 -0500
Received: by mail-ot1-f49.google.com with SMTP id n42so736020ota.12;
        Mon, 11 Jan 2021 11:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lAthSiAq7J3RcLV6EaiwcZWNg7iBMPB+BIcB8NuQCQQ=;
        b=KKVmIp86L7hI495LDmgPDxoDQFp9RM/3x0Mp1Z5meXnnPmmQC71+/BBvQizlJfNy3G
         tXuaIKtzSZTmXX4moP1LO7/PZCf6IV6kDAvSqwt8DkNWDAd7la//0067k4zVsIPabnrb
         M4n9kmT8v/XXbm51Aly55mry88quvw1OqgWyOPBhEbKSOu12snVU6eLlSb+/ge79QGno
         9AEsN6EGlvMZJ0U6XAkfBC1UjOuSMa3sHzwvDPKsCeAUSeApoDOOErdafum9QC4Zq13j
         o2ywNhOZyPvJN0v0CiYw9oYHt5Z61jd9OqY5kMQ+/Hl33V7XTDtewevJeoAmA7T9T7YW
         H7ew==
X-Gm-Message-State: AOAM532S+g4Iy2Wa0Wq/wYWp+ZvfOWuiSOUWye68kRWTnaJKYkKYNjYW
        v7qn2RFNJie+0Zjr7ZnXOA==
X-Google-Smtp-Source: ABdhPJxMj9HLfCnfHJ8XDV/zKpg0cfFnBYcX+UWn5fOjVCIsKjwQiF2ng1fDDxTOFgWHoSYUK5IxNA==
X-Received: by 2002:a05:6830:12cf:: with SMTP id a15mr461586otq.217.1610393052159;
        Mon, 11 Jan 2021 11:24:12 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z3sm136125ota.80.2021.01.11.11.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:24:11 -0800 (PST)
Received: (nullmailer pid 2920901 invoked by uid 1000);
        Mon, 11 Jan 2021 19:24:10 -0000
Date:   Mon, 11 Jan 2021 13:24:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, shawnguo@kernel.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        Paul Murphy <paul.j.murphy@intel.com>,
        devicetree@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: Re: [PATCH v2 06/34] dt-bindings: Add bindings for Keem Bay VPU IPC
 driver
Message-ID: <20210111192410.GA2906041@robh.at.kernel.org>
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-7-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108212600.36850-7-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 01:25:32PM -0800, mgross@linux.intel.com wrote:
> From: Paul Murphy <paul.j.murphy@intel.com>
> 
> Add DT bindings documentation for the Keem Bay VPU IPC driver.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Paul Murphy <paul.j.murphy@intel.com>
> Co-developed-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Needs your Sob.

> ---
>  .../soc/intel/intel,keembay-vpu-ipc.yaml      | 153 ++++++++++++++++++

This doesn't fit somewhere else?

>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml b/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
> new file mode 100644
> index 000000000000..cd1c4abe8bc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (c) Intel Corporation. All rights reserved.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/intel/intel,keembay-vpu-ipc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel Keem Bay VPU IPC
> +
> +maintainers:
> +  - Paul Murphy <paul.j.murphy@intel.com>
> +
> +description:
> +  The VPU IPC driver facilitates loading of firmware, control, and communication
> +  with the VPU over the IPC FIFO in the Intel Keem Bay SoC.

VPU is never defined. 

Bindings are for h/w blocks, not drivers.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - const: intel,keembay-vpu-ipc
> +
> +  reg:
> +    items:
> +      - description: NCE WDT registers
> +      - description: NCE TIM_GEN_CONFIG registers
> +      - description: MSS WDT registers
> +      - description: MSS TIM_GEN_CONFIG registers
> +
> +  reg-names:
> +    items:
> +      - const: nce_wdt
> +      - const: nce_tim_cfg
> +      - const: mss_wdt
> +      - const: mss_tim_cfg
> +
> +  memory-region:
> +    items:
> +      - description: reference to the VPU reserved memory region
> +      - description: reference to the X509 reserved memory region
> +      - description: reference to the MSS IPC area
> +
> +  clocks:
> +    items:
> +      - description: cpu clock
> +      - description: pll 0 out 0 rate
> +      - description: pll 0 out 1 rate
> +      - description: pll 0 out 2 rate
> +      - description: pll 0 out 3 rate
> +      - description: pll 1 out 0 rate
> +      - description: pll 1 out 1 rate
> +      - description: pll 1 out 2 rate
> +      - description: pll 1 out 3 rate
> +      - description: pll 2 out 0 rate
> +      - description: pll 2 out 1 rate
> +      - description: pll 2 out 2 rate
> +      - description: pll 2 out 3 rate
> +
> +  clock-names:
> +    items:
> +      - const: cpu_clock
> +      - const: pll_0_out_0
> +      - const: pll_0_out_1
> +      - const: pll_0_out_2
> +      - const: pll_0_out_3
> +      - const: pll_1_out_0
> +      - const: pll_1_out_1
> +      - const: pll_1_out_2
> +      - const: pll_1_out_3
> +      - const: pll_2_out_0
> +      - const: pll_2_out_1
> +      - const: pll_2_out_2
> +      - const: pll_2_out_3
> +
> +  interrupts:
> +    items:
> +      - description: number of NCE sub-system WDT timeout IRQ
> +      - description: number of MSS sub-system WDT timeout IRQ
> +
> +  interrupt-names:
> +    items:
> +      - const: nce_wdt
> +      - const: mss_wdt
> +
> +  intel,keembay-vpu-ipc-nce-wdt-redirect:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description:
> +      Number to which we will request that the NCE sub-system
> +      re-directs it's WDT timeout IRQ
> +
> +  intel,keembay-vpu-ipc-mss-wdt-redirect:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description:
> +      Number to which we will request that the MSS sub-system
> +      re-directs it's WDT timeout IRQ

These look like the same value as the interrupt numbers?

> +
> +  intel,keembay-vpu-ipc-imr:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description:
> +      IMR (isolated memory region) number which we will request
> +      the runtime service uses to protect the VPU memory region
> +      before authentication
> +
> +  intel,keembay-vpu-ipc-id:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: The VPU ID to be passed to the VPU firmware.
> +
> +additionalProperties: False
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    vpu-ipc@3f00209c {
> +        compatible = "intel,keembay-vpu-ipc";
> +        reg = <0x3f00209c 0x10>,
> +              <0x3f003008 0x4>,
> +              <0x2082009c 0x10>,
> +              <0x20821008 0x4>;
> +        reg-names = "nce_wdt",
> +                    "nce_tim_cfg",
> +                    "mss_wdt",
> +                    "mss_tim_cfg";
> +        memory-region = <&vpu_reserved>,
> +                        <&vpu_x509_reserved>,
> +                        <&mss_ipc_reserved>;
> +        clocks = <&scmi_clk 0>,
> +                 <&scmi_clk 0>,
> +                 <&scmi_clk 1>,
> +                 <&scmi_clk 2>,
> +                 <&scmi_clk 3>,
> +                 <&scmi_clk 4>,
> +                 <&scmi_clk 5>,
> +                 <&scmi_clk 6>,
> +                 <&scmi_clk 7>,
> +                 <&scmi_clk 8>,
> +                 <&scmi_clk 9>,
> +                 <&scmi_clk 10>,
> +                 <&scmi_clk 11>;
> +        clock-names = "cpu_clock",
> +                      "pll_0_out_0", "pll_0_out_1",
> +                      "pll_0_out_2", "pll_0_out_3",
> +                      "pll_1_out_0", "pll_1_out_1",
> +                      "pll_1_out_2", "pll_1_out_3",
> +                      "pll_2_out_0", "pll_2_out_1",
> +                      "pll_2_out_2", "pll_2_out_3";
> +        interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "nce_wdt", "mss_wdt";
> +        intel,keembay-vpu-ipc-nce-wdt-redirect = <63>;
> +        intel,keembay-vpu-ipc-mss-wdt-redirect = <47>;
> +        intel,keembay-vpu-ipc-imr = <9>;
> +        intel,keembay-vpu-ipc-id = <0>;
> +    };
> -- 
> 2.17.1
> 
