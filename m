Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533122B8672
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgKRVRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 16:17:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44223 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKRVRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:17:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id t16so3819186oie.11;
        Wed, 18 Nov 2020 13:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CrO86IqWPbTbsc39/JXRXWCmzImNuk67BHzeZAf8HpM=;
        b=fxk0HMYuEub6u1NeKeroTdNjuets4ePHKeVvWl2cojeS70rKuRJYWtYpuvwxAZsycJ
         71gZ7U9wAjsSPTZXFLMrRwsgyud5AvtL8LSUa56mDS9mnU1ZRL4tUpiuXtLYvS/89S7p
         ounP+9hcRMeuLzAbTekzFTf+jBu+NfeMie1SZyAqnEZomMydW7lmhV8G2hgktl+lWG6s
         6xD6LdYk+YvaT3EyCvyfUj3GjVLy6LCxcppp08WO4QP4gGExAFG7jIzMAbWCZLzpKapP
         2vzNFPoZzT8nBVxCUAW6/C/ax+RFrfk7w2sME3Qq0TaspDET4JD1qVq0qXKIYosERc7g
         0jCw==
X-Gm-Message-State: AOAM531KkTj0P12DRieIHIxYcSWUt4ATaPMb9191qYuPYzuv14cgAo99
        US9+fvv5TEFQ/AU/5Uo5TTPJDe/Q/w==
X-Google-Smtp-Source: ABdhPJy2LH7KNJfnAqtIiOaBIWsRT+PWtGAfzx9WCDFVCR2EG1cgHL21bS++4cjS441xxMV8OhUucQ==
X-Received: by 2002:aca:5710:: with SMTP id l16mr795508oib.24.1605734260797;
        Wed, 18 Nov 2020 13:17:40 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u66sm873142otb.48.2020.11.18.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:17:39 -0800 (PST)
Received: (nullmailer pid 1831435 invoked by uid 1000);
        Wed, 18 Nov 2020 21:17:34 -0000
Date:   Wed, 18 Nov 2020 15:17:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Hector Yuan <hector.yuan@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: dvfs: Add support for generic
 performance domains
Message-ID: <20201118211734.GA1827746@bogus>
References: <20201116181356.804590-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116181356.804590-1-sudeep.holla@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 18:13:56 +0000, Sudeep Holla wrote:
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


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ata/pata-common.example.dt.yaml: /: '#performance-domain-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ata/sata-common.example.dt.yaml: /: '#performance-domain-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ata/allwinner,sun8i-r40-ahci.example.dt.yaml: /: '#performance-domain-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ata/allwinner,sun8i-r40-ahci.example.dt.yaml: example-0: '#performance-domain-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ata/allwinner,sun8i-r40-ahci.example.dt.yaml: sata@1c18000: '#performance-domain-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ata/imx-sata.example.dt.yaml: /: '#performance-domain-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.yaml

and on and on...


