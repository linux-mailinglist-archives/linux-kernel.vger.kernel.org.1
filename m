Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD15C26944A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgINSB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:01:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43558 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgINSAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:00:04 -0400
Received: by mail-io1-f68.google.com with SMTP id z25so1039950iol.10;
        Mon, 14 Sep 2020 11:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gzNN3HZZcC4xGOcBJqGS3DjMEJgqFY3enUUKhW0YfKM=;
        b=rV3L3m10PheHxKdTRO+NW0B2gKngHt4H1spRs4OZJYYXLCsHw85qnSSlYSMR4AyYZm
         4OG/GJR+zrfICtbGlI9Y1jUT7HpCBLGDpQIIxYYzxtY9/U+fCQI2if3VFdqYE/Rx0SWF
         Kzk7IyfZqZ6jkZWJ1nSwRz0fNwRy2FR9LY3Tdz4K56oRnKSDFj8Fw3ej3zIbiLeOVnOE
         s9TYkrzWHk6vp/63ylCoYba5BCpb+XRCaoL4WAcK7qp7OcLZ08YubgGKHyq3jxfZfXLf
         /sQNjlXDD6Gt1xN6B/wlLeCtnBD6uhQNutlSp27vOEgLzmy2dpaLDrZ/nVWaCEOowGWY
         aoIA==
X-Gm-Message-State: AOAM530TcgwFc/DojHGXtrFHA8/kjmngWzvGsZ3qlb5bgL0Rri2fqvs9
        LoARIiGF7nUZifB6+QSPcypSRlzFS73h
X-Google-Smtp-Source: ABdhPJy1fWF8jAS3tfIaj/ZZ32fOJcUmIOzJdJiLdBMrivkmifvH6f13QOTpJlSIyKsE8qAV9BgQBg==
X-Received: by 2002:a6b:8f10:: with SMTP id r16mr12351915iod.165.1600106403423;
        Mon, 14 Sep 2020 11:00:03 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l10sm1015753ilm.75.2020.09.14.11.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:00:02 -0700 (PDT)
Received: (nullmailer pid 4145728 invoked by uid 1000);
        Mon, 14 Sep 2020 18:00:00 -0000
Date:   Mon, 14 Sep 2020 12:00:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sagar Kadam <sagar.kadam@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, yash.shah@sifive.com
Subject: Re: [RESEND PATCH v2 1/1] dt-bindings: riscv: sifive-l2-cache:
 convert bindings to json-schema
Message-ID: <20200914180000.GA4136408@bogus>
References: <1598633743-1023-1-git-send-email-sagar.kadam@sifive.com>
 <1598633743-1023-2-git-send-email-sagar.kadam@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598633743-1023-2-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 10:25:43PM +0530, Sagar Kadam wrote:
> Convert the device tree bindings for the SiFive's FU540-C000 SoC's L2 Cache
> controller to YAML format.
> 
> Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> ---
>  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 ------------
>  .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 92 ++++++++++++++++++++++
>  2 files changed, 92 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> deleted file mode 100644
> index 73d8f19..0000000
> --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -SiFive L2 Cache Controller
> ---------------------------
> -The SiFive Level 2 Cache Controller is used to provide access to fast copies
> -of memory for masters in a Core Complex. The Level 2 Cache Controller also
> -acts as directory-based coherency manager.
> -All the properties in ePAPR/DeviceTree specification applies for this platform
> -
> -Required Properties:
> ---------------------
> -- compatible: Should be "sifive,fu540-c000-ccache" and "cache"
> -
> -- cache-block-size: Specifies the block size in bytes of the cache.
> -  Should be 64
> -
> -- cache-level: Should be set to 2 for a level 2 cache
> -
> -- cache-sets: Specifies the number of associativity sets of the cache.
> -  Should be 1024
> -
> -- cache-size: Specifies the size in bytes of the cache. Should be 2097152
> -
> -- cache-unified: Specifies the cache is a unified cache
> -
> -- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals)
> -
> -- reg: Physical base address and size of L2 cache controller registers map
> -
> -Optional Properties:
> ---------------------
> -- next-level-cache: phandle to the next level cache if present.
> -
> -- memory-region: reference to the reserved-memory for the L2 Loosely Integrated
> -  Memory region. The reserved memory node should be defined as per the bindings
> -  in reserved-memory.txt
> -
> -
> -Example:
> -
> -	cache-controller@2010000 {
> -		compatible = "sifive,fu540-c000-ccache", "cache";
> -		cache-block-size = <64>;
> -		cache-level = <2>;
> -		cache-sets = <1024>;
> -		cache-size = <2097152>;
> -		cache-unified;
> -		interrupt-parent = <&plic0>;
> -		interrupts = <1 2 3>;
> -		reg = <0x0 0x2010000 0x0 0x1000>;
> -		next-level-cache = <&L25 &L40 &L36>;
> -		memory-region = <&l2_lim>;
> -	};
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> new file mode 100644
> index 0000000..e14c8c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2020 SiFive, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/sifive-l2-cache.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive L2 Cache Controller
> +
> +maintainers:
> +  - Sagar Kadam <sagar.kadam@sifive.com>
> +  - Yash Shah <yash.shah@sifive.com>
> +  - Paul Walmsley  <paul.walmsley@sifive.com>
> +
> +description:
> +  The SiFive Level 2 Cache Controller is used to provide access to fast copies
> +  of memory for masters in a Core Complex. The Level 2 Cache Controller also
> +  acts as directory-based coherency manager.
> +  All the properties in ePAPR/DeviceTree specification applies for this platform.
> +
> +allOf:
> +  - $ref: /schemas/cache-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +     - enum:
> +        - sifive,fu540-c000-ccache
> +    description: |
> +      Should have "sifive,<soc>-cache" and "cache".

That's not what the schema describes or the example has (the 'cache' 
fallback).

> +
> +  cache-block-size:
> +    const: 64
> +
> +  cache-level:
> +    const: 2
> +
> +  cache-sets:
> +    const: 1024
> +
> +  cache-size:
> +    const: 2097152
> +
> +  cache-unified: true
> +
> +  interrupts:
> +    description: |
> +      Must contain entries for DirError, DataError and DataFail signals.
> +    minItems: 1

The old doc said must have 3 entries.

> +    maxItems: 3
> +
> +  reg:
> +    maxItems: 1
> +    description: address of cache controller's registers.

Drop this.

> +
> +

One blank line please.

> +  next-level-cache:
> +    description: |
> +      Phandle to the next level cache if present.

No need to re-describe common properties unless you have something 
unique to this device to say. Just:

'next-level-cache: true'

> +
> +  memory-region:
> +    description: |
> +      The reference to the reserved-memory for the L2 Loosely Integrated memory region.
> +      The reserved memory node should be defined as per the bindings in reserved-memory.txt.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - cache-block-size
> +  - cache-level
> +  - cache-sets
> +  - cache-size
> +  - cache-unified
> +  - interrupts
> +  - reg
> +
> +examples:
> +  - |
> +    cache-controller@2010000 {
> +        compatible = "sifive,fu540-c000-ccache";
> +        cache-block-size = <64>;
> +        cache-level = <2>;
> +        cache-sets = <1024>;
> +        cache-size = <2097152>;
> +        cache-unified;
> +        reg = <0x2010000 0x1000>;
> +        interrupt-parent = <&plic0>;
> +        interrupts = <1 2 3>;
> +        next-level-cache = <&L25>;
> +        memory-region = <&l2_lim>;
> +    };
> -- 
> 2.7.4
> 
