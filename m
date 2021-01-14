Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4719E2F62B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbhANOIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:08:38 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40940 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbhANOIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:08:37 -0500
Received: by mail-ot1-f43.google.com with SMTP id j12so5248129ota.7;
        Thu, 14 Jan 2021 06:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G3qssVyonRjps8ihp/C/PMHKlXEjV5UX8OHRldAZeG8=;
        b=Qak5fX3Kb0T/turhlcEnxF8P5eqhwmlv/z+b4QkMYDCAUVC+RtQehTFBKwvufBtC8e
         9ilUg3O1QIiDIzH3T9l6CjKJsqkEsajy2KWNQggIc7F1bTHk1lDrBydBcDpE0HE2vth2
         juNolQdg55wEPC8655+8IKZbvpvYSuM4Yv3zn+hLYrMSsK/pHx2n5fZbG+VU9p3083VJ
         y6IUj9t2MjObWrmX1XKW7KMhMTbR0gQQApqkf9buaBY6MFgOEx4GSKpdLr4a18fb4C2Z
         eoSgGSbvf1YUGW4X7O6eoilp9IF+um7Pg+YAgHTK7AV8xJMyxvv8ypybpAtrBU5IXsIE
         8bbQ==
X-Gm-Message-State: AOAM5323pJ4+pxv4xrYjo13PtOfbSZIGfzomTJ69YrpGC4DxsFisGH6Y
        pkeQAVZzYCwEzM7TqnZJxw==
X-Google-Smtp-Source: ABdhPJwVtCF6IxBm1ri0k7zeacKkkqtY0V0s84gaPnBb33BhOs+QNF5sum09OLklXfLJcLNhR4WmSA==
X-Received: by 2002:a9d:a61:: with SMTP id 88mr4680079otg.18.1610633276788;
        Thu, 14 Jan 2021 06:07:56 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c14sm1064336otp.19.2021.01.14.06.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 06:07:55 -0800 (PST)
Received: (nullmailer pid 2822961 invoked by uid 1000);
        Thu, 14 Jan 2021 14:07:54 -0000
Date:   Thu, 14 Jan 2021 08:07:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 11/11] dts: bindings: Document device tree bindings
 for Arm TRBE
Message-ID: <20210114140754.GA2816889@robh.at.kernel.org>
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
 <1610511498-4058-12-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610511498-4058-12-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 09:48:18AM +0530, Anshuman Khandual wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Document the device tree bindings for Trace Buffer Extension (TRBE).
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/trbe.yaml | 46 +++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/trbe.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/trbe.yaml b/Documentation/devicetree/bindings/arm/trbe.yaml
> new file mode 100644
> index 0000000..2258595
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/trbe.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +# Copyright 2021, Arm Ltd
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/trbe.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: ARM Trace Buffer Extensions
> +
> +maintainers:
> +  - Anshuman Khandual <anshuman.khandual@arm.com>
> +
> +description: |
> +  Description of TRBE hw

Huh?

> +
> +properties:
> +  $nodename:
> +    pattern: "trbe"

const: trbe

> +  compatible:
> +    items:
> +      - const: arm,trace-buffer-extension

Any versioning to this? Or is that discoverable?

> +
> +  interrupts:
> +    description: |
> +       Exactly 1 PPI must be listed. For heterogeneous systems where
> +       TRBE is only supported on a subset of the CPUs, please consult
> +       the arm,gic-v3 binding for details on describing a PPI partition.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - interrupts
> +
> +additionalProperties: false
> +
> +

Extra blank line.

> +examples:
> +
> + - |
> +   #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +   trbe {
> +     compatible = "arm,trace-buffer-extension";
> +     interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +   };
> +...
> -- 
> 2.7.4
> 
