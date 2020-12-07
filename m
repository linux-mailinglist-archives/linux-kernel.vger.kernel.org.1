Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72092D1572
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgLGQCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:02:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40937 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgLGQCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:02:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id j12so12876742ota.7;
        Mon, 07 Dec 2020 08:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Up7sXnB2c6vZaz+m2PrHh/xp7KLftn1PV5oTPnNyZ0=;
        b=Vrl3h02Cs3GxGqmL/JN3jHnCmTW7z03V8EP/uhYPVIhZObdZ4z2k1wrDA6p43PCZZ8
         OI2dgmyYqs4B5KQlW/D4xemRI6tLg7ZeVGubZEy1SnsdefEHu6rwZwktALRCMz5mUc68
         RBJwU+1RPRqXh7TTJllxXqTAViDe1OUIZWOVAyEbWY0/RDqmgjvPLhNL2G/y0HP7X1kp
         LQhXvVh4KwV5e+UrJ5zQFb8YIKMKmQlujWO2gJbvs84Pa0S6FWzWPNhwvW1A6t41l1mQ
         TdhPqdNB1ap6WkU6hP7H09IMXP1DHh0C3jg8FjT01B1HtaGMjpzslm+EbSEwMesphIqD
         tOUg==
X-Gm-Message-State: AOAM532Mb2/YY/S4CrCr1TQWBlcA+EkFo/8kssJaxQThxwWu/3XBPaYY
        w4jzYvKLUv32oxDtFc1BLg==
X-Google-Smtp-Source: ABdhPJzX49ljwwVCcQiMRTpBUmb3BRoUJUDj2ur/KpbeWgXI+1yHRVzcpuP9OtpUpqeht1RiCXQFGA==
X-Received: by 2002:a9d:4588:: with SMTP id x8mr13647618ote.169.1607356915199;
        Mon, 07 Dec 2020 08:01:55 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r7sm2978913oih.21.2020.12.07.08.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:01:54 -0800 (PST)
Received: (nullmailer pid 356839 invoked by uid 1000);
        Mon, 07 Dec 2020 16:01:52 -0000
Date:   Mon, 7 Dec 2020 10:01:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 02/22] dt-bindings: Add bindings for Keem Bay IPC driver
Message-ID: <20201207160152.GB351233@robh.at.kernel.org>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-3-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201223511.65542-3-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 02:34:51PM -0800, mgross@linux.intel.com wrote:
> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> 
> Add DT binding documentation for the Intel Keem Bay IPC driver, which
> enables communication between the Computing Sub-System (CSS) and the
> Multimedia Sub-System (MSS) of the Intel Movidius SoC code named Keem
> Bay.
> 
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> ---
>  .../bindings/soc/intel/intel,keembay-ipc.yaml | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> new file mode 100644
> index 000000000000..6e21c54d8f34
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Intel Corporation
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/intel/intel,keembay-ipc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Keem Bay IPC
> +
> +maintainers:
> +  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> +
> +description:
> +  The Keem Bay IPC driver enables Inter-Processor Communication (IPC) with the
> +  Visual Processor Unit (VPU) embedded in the Intel Movidius SoC code named
> +  Keem Bay.

Sounds like a mailbox. 

What's the relationship between this and the xlink thing?

> +
> +properties:
> +  compatible:
> +    const: intel,keembay-ipc
> +
> +  reg:
> +    items:
> +      - description: The CSS (CPU) FIFO registers
> +      - description: The MSS (VPU) FIFO registers
> +
> +  reg-names:
> +    items:
> +      - const: css_fifo
> +      - const: mss_fifo
> +
> +  interrupts:
> +    items:
> +      - description: CSS FIFO not-empty interrupt
> +
> +  interrupt-controller: true
> +
> +  memory-region:
> +    items:
> +      - description: Reserved memory region used for CSS IPC buffers
> +      - description: Reserved memory region used for MSS IPC buffers
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - memory-region
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    ipc@203300f0 {
> +          compatible = "intel,keembay-ipc";
> +          reg = <0x203300f0 0x310>, /* CPU TIM FIFO */
> +                <0x208200f0 0x310>; /* VPU TIM FIFO */
> +          reg-names = "css_fifo", "mss_fifo";
> +          interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +          memory-region = <&css_ipc_reserved>, <&mss_ipc_reserved>;
> +    };
> -- 
> 2.17.1
> 
