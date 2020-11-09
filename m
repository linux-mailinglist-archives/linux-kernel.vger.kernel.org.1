Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE02AC5CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgKIUPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:15:21 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36136 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKIUPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:15:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id d9so11608508oib.3;
        Mon, 09 Nov 2020 12:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F5EgBqHSsg3337J37Szr1ll+3yrL35lLTUXhCzN8XDc=;
        b=CDQijuchdcDGnEHTfS+g3x20CUSHsk2DSxnoAJncEeNhRRVb8rewfa0h3xplElanBY
         RmTgrnQuA42zy5A50NV7xYNlutJd/qeXZ0D2+XShlxCkKeykCQ4V//KD+oDmiZbNH2lL
         yClVN0ma8jNNr+cMGhNsfgn3hbQGFmG4oW7yqU6teMv7aX3xt114pnqlb/4LMYIrogmp
         vooHr8InmB3rWXwbTiwWIVdgn3ZPpFSSUdXTqI0gh7pAZR/8shB3gtFzZjfNW86KUOOG
         x+9nRCYF0gXgUxIhXh26poFKbfZK1MHj4MvhQUZzpnirn14gkL3fmM3pjJ0oFCn4R5oe
         /OMg==
X-Gm-Message-State: AOAM531tgtB6FZjTV+QQu9TcrheRtIHBzCHtNyi6LJoRvesTcPJho8yO
        8dZsIS2kKLpG12EBAlMR+g==
X-Google-Smtp-Source: ABdhPJyelEAUCL5wGtsXAmfJvwjFakE43fqMhA/XDynov3qtXwp4ObxS4mcK4n4z6n5QjBfi/K3nUw==
X-Received: by 2002:a05:6808:3af:: with SMTP id n15mr593805oie.65.1604952920248;
        Mon, 09 Nov 2020 12:15:20 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 132sm2685696oid.54.2020.11.09.12.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:15:19 -0800 (PST)
Received: (nullmailer pid 1689983 invoked by uid 1000);
        Mon, 09 Nov 2020 20:15:18 -0000
Date:   Mon, 9 Nov 2020 14:15:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] dt-bindings: dvfs: Add support for generic performance
 domains
Message-ID: <20201109201518.GA1679536@bogus>
References: <20201105173539.1426301-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105173539.1426301-1-sudeep.holla@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 05:35:39PM +0000, Sudeep Holla wrote:
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
>  .../bindings/dvfs/performance-domain.yaml     | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dvfs/performance-domain.yaml b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> new file mode 100644
> index 000000000000..fa0151f63ac9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings.

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

select: true

Otherwise, this schema is never used.

> +
> +properties:
> +  "#performance-domain-cells":
> +    description:
> +      Number of cells in a performance domain specifier. Typically 0 for nodes
> +      representing a single performance domain and 1 for nodes providing
> +      multiple performance domains (e.g. performance controllers), but can be
> +      any value as specified by device tree binding documentation of particular
> +      provider.

enum: [ 0, 1 ]

If we need more, it can be extended.

> +
> +  performance-domains:

Needs a type ref (phandle-array).

> +    description:
> +      A phandle and performance domain specifier as defined by bindings of the
> +      performance controller/provider specified by phandle.
> +
> +required:
> +  - "#performance-domain-cells"
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    performance: performance-controller@12340000 {
> +        compatible = "foo,performance-controller";

At some point in the future, this is going to generate warnings as an 
undocumented binding. So we'll have to remove it, add a schema for it, 
or replace with a real example. This is a standard DT design pattern, so 
I'd lean toward removing the example.

Rob

> +        reg = <0x12340000 0x1000>;
> +        #performance-domain-cells = <1>;
> +    };
> +
> +    // The node above defines a performance controller that is a performance
> +    // domain provider and expects one cell as its phandle argument.
> +
> +    device1: foo@56780000 {
> +        compatible = "foo,bar-controller";
> +        reg = <0x56780000 0x1000>;
> +        performance-domains = <&performance 1>;
> +    };
> +
> -- 
> 2.25.1
> 
