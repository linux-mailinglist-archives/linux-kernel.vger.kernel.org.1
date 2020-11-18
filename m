Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD7B2B867A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgKRVUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 16:20:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33745 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKRVUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:20:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id i18so3268314ots.0;
        Wed, 18 Nov 2020 13:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xxDQzbtN51ZM9RWc+QApDYZ4ouwW+tWVnWkPA7oZTzs=;
        b=Cyww4UA7wByllH+2i2pRYY8/jTUXdbtnLu/LZn+r8EHfIeO32BAxkuLLfiw8j0bcso
         ++WT0+P74hwDoFpAu+sR9P7TV57mImqvgeBhhZ9U6s2TeSHAXIPqT7bZJTTlFRqVADhd
         5y7RelqKYepS1AXKDkOpJXjlYRf13jmCHlT4FuWE94YurKSMepXjCwei91rY8L+WluNr
         owvNqZ2CiJD6SYYO/2sQed7fVbtKGLbi604ObwzDoYJp0RpXcoPOcEU6NRV3xu4rZfyn
         2QY04TYr7zLi/NCix1oC/eqY8NYnLcdr4eo6c+NGfLfWHq1BiJqfSCOnDBRqv2D8O+ET
         lgwg==
X-Gm-Message-State: AOAM5318t/AKw2y9Put5m/MO0yCLXStLQ50ALCYaDAju/1Dy+qrFZNwo
        uEKhvqkdo9+aUMzLxF4REA==
X-Google-Smtp-Source: ABdhPJzTp+5QpsJ3xGzP56XqMirz+h4CUFzlcSskH6wQZ3G8qsykknAlwlmGgxwYQfYncrrndRyjBg==
X-Received: by 2002:a9d:7a97:: with SMTP id l23mr8213906otn.232.1605734410372;
        Wed, 18 Nov 2020 13:20:10 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z77sm8513784ooa.37.2020.11.18.13.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:20:09 -0800 (PST)
Received: (nullmailer pid 1834694 invoked by uid 1000);
        Wed, 18 Nov 2020 21:20:09 -0000
Date:   Wed, 18 Nov 2020 15:20:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: dvfs: Add support for generic
 performance domains
Message-ID: <20201118212009.GB1827746@bogus>
References: <20201116181356.804590-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116181356.804590-1-sudeep.holla@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 06:13:56PM +0000, Sudeep Holla wrote:
> The CLKSCREW attack [0] exposed security vulnerabilities in energy management
> implementations where untrusted software had direct access to clock and
> voltage hardware controls. In this attack, the malicious software was able to
> place the platform into unsafe overclocked or undervolted configurations. Such
> configurations then enabled the injection of predictable faults to reveal
> secrets.
> 
> Many Arm-based systems used to or still use voltage regulator and clock
> frameworks in the kernel. These frameworks allow callers to independently
> manipulate frequency and voltage settings. Such implementations can render
> systems susceptible to this form of attack.
> 
> Attacks such as CLKSCREW are now being mitigated by not having direct and
> independent control of clock and voltage in the kernel and moving that
> control to a trusted entity, such as the SCP firmware or secure world
> firmware/software which are to perform sanity checking on the requested
> performance levels, thereby preventing any attempted malicious programming.
> 
> With the advent of such an abstraction, there is a need to replace the
> generic clock and regulator bindings used by such devices with a generic
> performance domains bindings.
> 
> [0] https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/tang
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  .../bindings/dvfs/performance-domain.yaml     | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> 
> v1[1]->v2:
> 	- Changed to Dual License
> 	- Added select: true, enum for #performance-domain-cells and
> 	  $ref for performance-domain
> 	- Changed the example to use real existing compatibles instead
> 	  of made-up ones
> 
> [1] https://lore.kernel.org/lkml/20201105173539.1426301-1-sudeep.holla@arm.com
> 
> diff --git a/Documentation/devicetree/bindings/dvfs/performance-domain.yaml b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> new file mode 100644
> index 000000000000..29fb589a5192
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dvfs/performance-domain.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic performance domains
> +
> +maintainers:
> +  - Sudeep Holla <sudeep.holla@arm.com>
> +
> +description: |+
> +  This binding is intended for performance management of groups of devices or
> +  CPUs that run in the same performance domain. Performance domains must not
> +  be confused with power domains. A performance domain is defined by a set
> +  of devices that always have to run at the same performance level. For a given
> +  performance domain, there is a single point of control that affects all the
> +  devices in the domain, making it impossible to set the performance level of
> +  an individual device in the domain independently from other devices in
> +  that domain. For example, a set of CPUs that share a voltage domain, and
> +  have a common frequency control, is said to be in the same performance
> +  domain.
> +
> +  This device tree binding can be used to bind performance domain consumer
> +  devices with their performance domains provided by performance domain
> +  providers. A performance domain provider can be represented by any node in
> +  the device tree and can provide one or more performance domains. A consumer
> +  node can refer to the provider by a phandle and a set of phandle arguments
> +  (so called performance domain specifiers) of length specified by the
> +  \#performance-domain-cells property in the performance domain provider node.
> +
> +select: true

So apply to every node and...

> +
> +properties:
> +  "#performance-domain-cells":
> +    description:
> +      Number of cells in a performance domain specifier. Typically 0 for nodes
> +      representing a single performance domain and 1 for nodes providing
> +      multiple performance domains (e.g. performance controllers), but can be
> +      any value as specified by device tree binding documentation of particular
> +      provider.
> +    enum: [ 0, 1 ]
> +
> +  performance-domains:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    description:
> +      A phandle and performance domain specifier as defined by bindings of the
> +      performance controller/provider specified by phandle.
> +
> +required:
> +  - "#performance-domain-cells"

Every node must have this!

It can only be required in actual users.

> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    performance: performance-controller@12340000 {
> +        compatible = "qcom,cpufreq-hw";
> +        reg = <0x12340000 0x1000>;
> +        #performance-domain-cells = <1>;
> +    };
> +
> +    // The node above defines a performance controller that is a performance
> +    // domain provider and expects one cell as its phandle argument.
> +    cpus {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +
> +        cpu@0 {
> +            device_type = "cpu";
> +            compatible = "arm,cortex-a57";
> +            reg = <0x0 0x0>;
> +            performance-domains = <&performance 1>;

Looks like the cpu schema needs an addition.

> +        };
> +    };
> +
> -- 
> 2.25.1
> 
