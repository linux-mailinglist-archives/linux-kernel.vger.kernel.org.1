Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE0C2A9959
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgKFQTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:19:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39638 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFQTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:19:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id u127so1858005oib.6;
        Fri, 06 Nov 2020 08:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GlJWPQMKpytR+Wzp16P8vAZl+wi0w/kBk47RFIebuRU=;
        b=Jz7wydZSUgrkjmra4ORDN23dIbPgMr4LOq9DWVnzeaexjmh2Qzx3Q8aS/qc+eAKL/s
         8btCvirEeUd1Ae3om/S5kDlajs28WD68ZQWMYBtoQ4mtZKHd/dYtmyHCCnUXZCSpn5Uc
         kM5sqISWeddENyRc1UO5VsSV0YVXX2BsYR11eoZNwvbVK/T5Ydh7VbPZmYRBjonS21qM
         PIK8cQ5eGzC0aBHhhym5qYDclP+Ydgracmxkt20kd1fdF2q8N00FUCkFH1mcUlVg/PXV
         CeOkyN67VapqxMOF1gyom1MxlkD6cpsTiA9AhysLt4LYAcp9YoZYawlKm6RNj7SIpK/n
         RYeg==
X-Gm-Message-State: AOAM5300VKm00NSSkrholz8u5/VUfQHeHFr9sC4s964ovGhdS3Q/1D05
        aCbwiAAAt/aktskeBentMQ==
X-Google-Smtp-Source: ABdhPJyadslbAh4/pP5myzABAkUFw82hURptmN81E32nnjN/UPrxTO4o1dDy1vAZf6bUhPWiOxMY3g==
X-Received: by 2002:aca:4982:: with SMTP id w124mr1565952oia.71.1604679590178;
        Fri, 06 Nov 2020 08:19:50 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n15sm386099otj.41.2020.11.06.08.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 08:19:49 -0800 (PST)
Received: (nullmailer pid 3301877 invoked by uid 1000);
        Fri, 06 Nov 2020 16:19:48 -0000
Date:   Fri, 6 Nov 2020 10:19:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/5] dt-bindings: soc: imx: Add binding doc for spba
 bus
Message-ID: <20201106161948.GA3300756@bogus>
References: <20201106111543.1806809-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106111543.1806809-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 05:15:39AM -0600, Adam Ford wrote:
> Add binding doc for fsl,spba-bus.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  New to series

Please implement my review comments from the last version you sent.

> 
> diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> new file mode 100644
> index 000000000000..0a2add841145
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Shared Peripherals Bus Interface
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +
> +description: |
> +  A simple bus enabling access to shared peripherals.
> +
> +  The "spba-bus" follows the "simple-bus" set of properties, as
> +  specified in the Devicetree Specification.  It is an extension of
> +  "simple-bus" because the SDMA controller uses this compatible flag to
> +  determine which peripherals are available to it and the range over which
> +  the SDMA can access.  There are no special clocks for the bus, because
> +  the SDMA controller itself has its interrupt, and clock assignments.
> +
> +properties:
> +  $nodename:
> +    pattern: "^bus(@[0-9a-f]+)?$"
> +
> +  compatible:
> +    contains:
> +      const: fsl,spba-bus
> +    description:
> +      Shall contain "fsl,spba-bus" in addition to "simple-bus"
> +      compatible strings.
> +
> +  '#address-cells':
> +    enum: [ 1, 2 ]
> +
> +  '#size-cells':
> +    enum: [ 1, 2 ]
> +
> +  ranges: true
> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - '#size-cells'
> +  - ranges
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    bus {
> +        compatible = "fsl,spba-bus", "simple-bus";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +    };
> -- 
> 2.25.1
> 
