Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BEB270322
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIRRWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:22:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46058 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:22:16 -0400
Received: by mail-io1-f65.google.com with SMTP id y74so7591742iof.12;
        Fri, 18 Sep 2020 10:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k1EuzziNIfH0W9CSUnyG0xJ1k0k5Ooz2vHssxk2DGNg=;
        b=gLG8ulC101sKttSx3DgEzmn98sQGBlbE/dsYSe15VCyFy65ICmWoK0L7KmxaHmSvyx
         jOQKVrMVFyeS0FczvNTFM9kIKwtcMM75H9Y9QRb+w+BgrpIonPMeTSjrok6sBP56u2a8
         4oOKxof6+XnTqFlC0ygPMNx8fXWd1ztWffBmvXTHGoEZ1AIwB2qTDln6LlKNc/O8pspK
         UTnLOLyaIBlEA0HQyyISnZ7ukc+DCBZiWQGRoVKVv8MxoKEpiLU6TsOqYcPmtItPUFwS
         ZLx1QrXyrK8TqeJ1i/fuUAzlYA/7pHxMf4B2rsE9TxXyLzImmyqxufqqWQ4/VJXgipXK
         3hyg==
X-Gm-Message-State: AOAM5320ut/kXkM8PnM0K9un6824vy6kaS7qtLdnW6gFH9d+D6SkWZyJ
        D2cDcWXp1HH3IMDdTXo6Ng==
X-Google-Smtp-Source: ABdhPJyQYDqPtxJjRsCHOk/fAO1lChIYLchpwd80CVr4QRmooFnYH09UJNLWHrWhP4xDTqTNalzTzw==
X-Received: by 2002:a5e:890c:: with SMTP id k12mr27741896ioj.75.1600449735309;
        Fri, 18 Sep 2020 10:22:15 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s85sm2060631ilk.35.2020.09.18.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 10:22:14 -0700 (PDT)
Received: (nullmailer pid 3817633 invoked by uid 1000);
        Fri, 18 Sep 2020 17:22:13 -0000
Date:   Fri, 18 Sep 2020 11:22:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: Add bindings for BrcmSTB SCMI
 mailbox driver
Message-ID: <20200918172213.GA3813066@bogus>
References: <20200915193109.16034-1-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915193109.16034-1-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 03:31:04PM -0400, Jim Quinlan wrote:
> Bindings are added.  Only one interrupt is needed because
> we do not yet employ the SCMI p2a channel.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  .../bindings/mailbox/brcm,brcmstb-mbox.yaml   | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,brcmstb-mbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/brcm,brcmstb-mbox.yaml b/Documentation/devicetree/bindings/mailbox/brcm,brcmstb-mbox.yaml
> new file mode 100644
> index 000000000000..c2359f3a2b13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/brcm,brcmstb-mbox.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/mailbox/brcm,brcmstb-mbox.yaml#
> +
> +title: Broadcom STB SCMI mailbox driver bindings

I thought SCMI was a mailbox consumer, not provider?

> +
> +maintainers:
> +  - Jim Quinlan <james.quinlan@broadcom.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,brcmstb-mbox
> +
> +  interrupts:
> +    items:
> +      - description: SCMI a2p return interrupt
> +
> +  "#mbox-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mailbox0: mailbox@0 {

Drop the label and unit-address.

Run 'make dt_binding_check' as it will tell you the latter.

> +      compatible = "brcm,brcmstb-mailbox";
> +      #mbox-cells = <1>;
> +      interrupts = <GIC_SPI 0xc6 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +...
> -- 
> 2.17.1
> 


