Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513E82EEB41
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 03:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhAHC03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 21:26:29 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:38853 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbhAHC02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 21:26:28 -0500
Received: by mail-il1-f172.google.com with SMTP id v3so8858784ilo.5;
        Thu, 07 Jan 2021 18:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hre6xfB6NrLqQ3dXVlKDAfHEjfp9rD+sjidZkUWhifo=;
        b=BX/0MWIlQ9MLS4r5jP5he2u/aZOTita9KTO2kOiiIhFtNy40zs+nhb1p+EfyNWPS8V
         ByPgrXnvSrrh/ml3ykTMKc+1W2f5pkgEkPoKrZP3nxz4u1eQptBoGu1LrE19MWzN50yD
         h+K4SiiUGRMyNLAuwnYLLLn/X0h40I/86mFVrvxwbg/yERZZwiZy2ZyWE97OUka654j9
         qiJ0Gh+OuyvM2kyEw7rhRyXoKboPDis3I2MiZA+3SXLMsChRH6Sw8tiCkIG1X699DVDE
         fPuI3T8+yP1x181zBm9HNO8ETgBBAoxZhELxI7N1uDOzKNQPmuedi4WfbnSS5CrwkT3A
         5u/Q==
X-Gm-Message-State: AOAM530jRTVHpcxXGvuP774aqUcClKBxrRhwiuYB4A7+uU1y1vLJdG9H
        hhlrCMUWiI0jY3NCZjR8aQ==
X-Google-Smtp-Source: ABdhPJy6+5gcSiBXjrC4K+yGR0iKJSoDzy7Ki/YVuyrvV6OQ5PDNXOa+TAV4NklLz8zbiPyYZrPUSw==
X-Received: by 2002:a05:6e02:1786:: with SMTP id y6mr1718502ilu.74.1610072747732;
        Thu, 07 Jan 2021 18:25:47 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h17sm4536936ioz.12.2021.01.07.18.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 18:25:46 -0800 (PST)
Received: (nullmailer pid 1747334 invoked by uid 1000);
        Fri, 08 Jan 2021 02:25:45 -0000
Date:   Thu, 7 Jan 2021 19:25:45 -0700
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Kevin Tang <kevin.tang@unisoc.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: iommu: add bindings for sprd iommu
Message-ID: <20210108022545.GA1744725@robh.at.kernel.org>
References: <20201223111633.1711477-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223111633.1711477-1-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 07:16:32PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> This patch only adds bindings to support display iommu, support for others
> would be added once finished tests with those devices, such as Image
> codec(jpeg) processor, a few signal processors, including VSP(video),
> GSP(graphic), ISP(image), and camera CPP, etc.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../devicetree/bindings/iommu/sprd,iommu.yaml | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> new file mode 100644
> index 000000000000..4d9a578a7cc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2020 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc IOMMU and Multi-media MMU
> +
> +maintainers:
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sprd,iommu-disp

Needs to be Soc specific. Is this block specific to display subsys or 
that just happens to be where the instance is?

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#iommu-cells":
> +    const: 0
> +    description:
> +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
> +      additional information needs to associate with its master device.
> +      Please refer to the generic bindings document for more details,
> +      Documentation/devicetree/bindings/iommu/iommu.txt
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#iommu-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    iommu_disp: iommu@63000000 {
> +      compatible = "sprd,iommu-disp";
> +      reg = <0x63000000 0x880>;
> +      #iommu-cells = <0>;
> +    };
> +
> +...
> -- 
> 2.25.1
> 
