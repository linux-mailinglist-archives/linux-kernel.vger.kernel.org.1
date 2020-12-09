Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891392D4EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 00:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbgLIXkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 18:40:02 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42968 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgLIXkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:40:01 -0500
Received: by mail-oi1-f193.google.com with SMTP id l200so3682323oig.9;
        Wed, 09 Dec 2020 15:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SFT17arAX3QzX+potzyy3sA+XqrQCe7LbGy3QO6aSow=;
        b=YezHHha6RI30PpJtNy9G8ep4S6NFXOMIHMiAFe1gDrSBMgNPw0p/ESTpFQ/vn2Fnk6
         YK1hi6MwY30Q0Olwm4ymKSJC7HZ4ypwMQxL2QLzYkucqLqPE5QU+33+kOc2xkiHE6FJl
         B5hYkBpNFkwV1Zu2QjjRDpRkp9LBeLPUQmiEfijJeruycDKOrJKHCSFMTwa6YU5TQep0
         SMn164asWzXdPzrLpfND7ihjCs9UkDrILFJITRNE6dQjzq4XiZG6P7NTw/cSWmaRB02k
         CkfacU9WO/Z5EwATm++Qz/DPdMdSSrM1zfg6srqAGMN2AfeUpy04VpA5qeHQPP6IyXJ+
         2Kig==
X-Gm-Message-State: AOAM533p1u2Fv0XkpEuhdUQR1+s6kiipKvULK12d7BrhpnDMMmzRLRiC
        nrQs4jtqhHAVUIf3to11Qw==
X-Google-Smtp-Source: ABdhPJxoqYsVOjY/x0eh60WbRbLSsfKU5dh6z3CPHRGW0B5d5eg5F4chbVgJE22yCXT9Pex7xpKGjA==
X-Received: by 2002:aca:c492:: with SMTP id u140mr3622948oif.51.1607557159616;
        Wed, 09 Dec 2020 15:39:19 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r12sm651245ooo.25.2020.12.09.15.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 15:39:18 -0800 (PST)
Received: (nullmailer pid 1293162 invoked by uid 1000);
        Wed, 09 Dec 2020 23:39:17 -0000
Date:   Wed, 9 Dec 2020 17:39:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mfd: db8500-prcmu: Add devicetree bindings
Message-ID: <20201209233917.GA1288773@robh.at.kernel.org>
References: <20201204130655.1591181-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204130655.1591181-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 02:06:55PM +0100, Linus Walleij wrote:
> This driver was merged in the early days of device tree
> on Arm in 2012 and somehow we failed to provide bindings
> for it. Fix it up with some YAML bindings.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/mfd/stericsson,db8500-prcmu.yaml | 282 ++++++++++++++++++
>  1 file changed, 282 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
> new file mode 100644
> index 000000000000..10cb7d40ebf2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
> @@ -0,0 +1,282 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/stericsson,db8500-prcmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST-Ericsson DB8500 PRCMU - Power Reset and Control Management Unit
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description:
> +  The DB8500 Power Reset and Control Management Unit is an XP70 8-bit
> +  microprocessor that is embedded in the always-on power domain of the
> +  DB8500 SoCs to manage the low power states, powering up and down parts
> +  of the silicon, and controlling reset of different IP blocks.
> +
> +properties:
> +  $nodename:
> +    pattern: '^prcmu@80157000$'

That's awfully specific. While I guess this will only ever be this one 
platform, it could still have some address translations that would 
change the unit-addresses. So I wouldn't enforce the unit-addresses 
here.

> +
> +  compatible:
> +    description: The device is compatible both to the device-specific
> +      compatible "stericsson,db8500-prcmu" and "syscon". The latter
> +      compatible is needed for the device to be exposed as a system
> +      controller so that arbitrary registers can be access by
> +      different operating system components.
> +    items:
> +      - const: stericsson,db8500-prcmu
> +      - const: syscon
> +
> +  reg:
> +    items:
> +      - description: Main PRCMU register area
> +      - description: PRCMU TCPM register area
> +      - description: PRCMU TCDM register area
> +
> +  reg-names:
> +    items:
> +      - const: prcmu
> +      - const: prcmu-tcpm
> +      - const: prcmu-tcdm
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  db8500-prcmu-regulators:
> +    description: Node describing the DB8500 regulators. These are mainly
> +      power rails inside the silicon but some of those are also routed
> +      out to external pins.
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: stericsson,db8500-prcmu-regulator
> +
> +      db8500_vape:
> +        description: The voltage for the application processor, the
> +          main voltage domain for the chip.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_varm:
> +        description: The voltage for the ARM Cortex A-9 CPU.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_vmodem:
> +        description: The voltage for the modem subsystem.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_vpll:
> +        description: The voltage for the phase locked loop clocks.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_vsmps1:
> +        description: Also known as VIO12, is a step-down voltage regulator
> +          for 1.2V I/O. SMPS means System Management Power Source.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_vsmps2:
> +        description: Also known as VIO18, is a step-down voltage regulator
> +          for 1.8V I/O. SMPS means System Management Power Source.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_vsmps3:
> +        description: This is a step-down voltage regulator
> +          for 0.87 thru 1.875V I/O. SMPS means System Management Power Source.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_vrf1:
> +        description: RF transciever voltage regulator.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_sva_mmdsp:
> +        description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
> +          voltage regulator. This is the voltage for the accelerator DSP
> +          for video encoding and decoding.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_sva_mmdsp_ret:
> +        description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
> +          voltage regulator for retention mode.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_sva_pipe:
> +        description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
> +          voltage regulator for the data pipe.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_sia_mmdsp:
> +        description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
> +          voltage regulator. This is the voltage for the accelerator DSP
> +          for image encoding and decoding.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_sia_mmdsp_ret:
> +        description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
> +          voltage regulator for retention mode.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_sia_pipe:
> +        description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
> +          voltage regulator for the data pipe.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_sga:
> +        description: Smart Graphics Accelerator (SGA) voltage regulator.
> +          This is in effect controlling the power to the MALI400 3D
> +          accelerator block.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_b2r2_mcde:
> +        description: Blit Blend Rotate and Rescale (B2R2), and Multi-Channel
> +          Display Engine (MCDE) voltage regulator. These are two graphics
> +          blocks.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_esram12:
> +        description: Embedded Static RAM (ESRAM) 1 and 2 voltage regulator.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_esram12_ret:
> +        description: Embedded Static RAM (ESRAM) 1 and 2 voltage regulator for
> +          retention mode.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_esram34:
> +        description: Embedded Static RAM (ESRAM) 3 and 4 voltage regulator.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +      db8500_esram34_ret:
> +        description: Embedded Static RAM (ESRAM) 3 and 4 voltage regulator for
> +          retention mode.
> +        type: object
> +        $ref: ../regulator/regulator.yaml#
> +
> +    required:
> +      - compatible
> +      - db8500_vape
> +      - db8500_varm
> +      - db8500_vmodem
> +      - db8500_vpll
> +      - db8500_vsmps1
> +      - db8500_vsmps2
> +      - db8500_vsmps3
> +      - db8500_vrf1
> +      - db8500_sva_mmdsp
> +      - db8500_sva_mmdsp_ret
> +      - db8500_sva_pipe
> +      - db8500_sia_mmdsp
> +      - db8500_sia_mmdsp_ret
> +      - db8500_sia_pipe
> +      - db8500_sga
> +      - db8500_b2r2_mcde
> +      - db8500_esram12
> +      - db8500_esram12_ret
> +      - db8500_esram34
> +      - db8500_esram34_ret
> +
> +    additionalProperties: false
> +
> +  thermal@801573c0:
> +    description: Node describing the DB8500 thermal control functions.
> +      This binds to an operating system driver that monitors the
> +      temperature of the SoC.
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: stericsson,db8500-thermal
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        items:
> +          - description: Hotmon low interrupt (falling temperature)
> +          - description: Hotmon high interrupt (rising temperature)
> +
> +      interrupt-names:
> +        items:
> +          - const: IRQ_HOTMON_LOW
> +          - const: IRQ_HOTMON_HIGH
> +
> +      '#thermal-sensor-cells':
> +        const: 0
> +
> +    additionalProperties: false
> +
> +  prcmu-timer-4@80157450:
> +    description: Node describing the externally visible timer 4 in the
> +      PRCMU block. This timer is interesting to the operating system
> +      since even thought it has a very low resolution (32768 Hz) it is
> +      always on, and thus provides a consistent monotonic timeline for
> +      the system.
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: stericsson,db8500-prcmu-timer-4
> +
> +      reg:
> +        maxItems: 1
> +
> +    additionalProperties: false
> +
> +patternProperties:
> +  "^ab850[05]$":
> +    description: Node describing the Analog Baseband 8500 mixed-signals
> +      ASIC AB8500 and subcomponents. The AB8500 is accessed through the
> +      PRCMU and hence it appears here. This component has a separate
> +      set of devicetree bindings. The AB8505 is a newer version of the
> +      same ASIC.
> +    type: object
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - ranges
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - db8500-prcmu-regulators
> +  - thermal@801573c0
> +  - prcmu-timer-4@80157450
> +
> +dependencies:
> +  interrupt-controller: [ interrupts ]
> +
> +additionalProperties: false
> -- 
> 2.26.2
> 
