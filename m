Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714E1302F42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 23:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbhAYWnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 17:43:07 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:34893 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732562AbhAYWms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 17:42:48 -0500
Received: by mail-oi1-f172.google.com with SMTP id w8so16576256oie.2;
        Mon, 25 Jan 2021 14:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C16k2tPv0ywSlhxsEf4kr9GhjRN4cyYWhe3TJNuKzzI=;
        b=IeVigiuXiM81Dl6uQ/dZSO+rEN7qh6fWTaA8WO/ic5uL0LquiCXI0P+fhPn2OU2mU3
         sOzUkXRs5SyOa1E6qIb/sSzBkh+9ZqFGfnPJBdGXV5JT5o5ME8CFDtionm2PtH6i1un0
         ydpPkFZUK0gyvgf1fF16t0On7+Ek3qqW/D8pcOXq9jD5qOLD69nYfpQdo30ZJHjiOCjM
         bQttrEDENZZtt+PEyPaVKLrYYQWFCKEhc+D/O5hdp1tdaVMpQSsFlKIZwNoPqHICqmZV
         hYrHYhxMLGKEGAXBnIp6ROtXP3YdlRXHqg9d3x296HVUiRonlGk4CVluQROzYjLa6Xt7
         J0OQ==
X-Gm-Message-State: AOAM532kpp4PKRL+9eqtn5r7go3RjNATKV65NPKBhap6QAtvKI4gt9TZ
        z0E/NTbUFMz+TLdrYjEK5g==
X-Google-Smtp-Source: ABdhPJxNAlUnSs1N3aeHo57kzd72x7tcnq/Np938jOWY7EEaiSXUXNM8ZPQuNIrsiTsmANBV4oAnsQ==
X-Received: by 2002:aca:c085:: with SMTP id q127mr1504728oif.70.1611614527227;
        Mon, 25 Jan 2021 14:42:07 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a28sm391910ook.24.2021.01.25.14.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 14:42:06 -0800 (PST)
Received: (nullmailer pid 1163692 invoked by uid 1000);
        Mon, 25 Jan 2021 22:42:05 -0000
Date:   Mon, 25 Jan 2021 16:42:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: add binding from BCM4908 partitions
Message-ID: <20210125224205.GA1131879@robh.at.kernel.org>
References: <20210115153901.31052-1-zajec5@gmail.com>
 <20210115153901.31052-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210115153901.31052-2-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 04:39:00PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> BCM4908 uses fixed partitions layout but function of some partitions may
> vary. Some devices use multiple firmware partitions and those should be
> marked to let system discover their purpose.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../partitions/brcm,bcm4908-partitions.yaml   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
> new file mode 100644
> index 000000000000..4090b61a3da7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/brcm,bcm4908-partitions.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM4908 partitioning
> +
> +description: |
> +  Broadcom BCM4908 CFE bootloader supports two firmware partitions. One is used
> +  for regular booting, the other is treated as fallback.
> +
> +  This binding allows defining all fixed partitions and marking those containing
> +  firmware. System can use that information e.g. for booting or flashing
> +  purposes.
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm4908-partitions
> +
> +  "#address-cells": true
> +
> +  "#size-cells": true

limit these to 1 and 2? 

> +
> +patternProperties:
> +  "@[0-9a-f]+$":

^partition@...

> +    allOf:

You can drop 'allOf'.

> +      - $ref: "partition.yaml#"
> +      - properties:
> +          compatible:
> +            const: brcm,bcm4908-firmware

Also needs 'unevaluatedProperties: false'

> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible = "brcm,bcm4908-partitions";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        partition@0 {
> +            label = "cferom";
> +            reg = <0x0 0x100000>;
> +        };
> +
> +        partition@100000 {
> +            compatible = "brcm,bcm4908-firmware";
> +            reg = <0x100000 0xf00000>;
> +        };
> +
> +        partition@1000000 {
> +            compatible = "brcm,bcm4908-firmware";
> +            reg = <0x1000000 0xf00000>;
> +        };
> +
> +        partition@1f00000 {
> +            label = "calibration";
> +            reg = <0x1f00000 0x100000>;
> +        };
> +    };
> -- 
> 2.26.2
> 
