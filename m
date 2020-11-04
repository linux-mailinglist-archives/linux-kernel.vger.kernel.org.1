Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3406E2A6FE2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 22:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgKDVuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 16:50:54 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38579 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKDVuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 16:50:54 -0500
Received: by mail-oi1-f194.google.com with SMTP id 9so23815613oir.5;
        Wed, 04 Nov 2020 13:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FNWVwzg63G5BUshuzobQWOcIMNKpfF8Jan6eWjyNIYk=;
        b=BptcDdh6hUYTqWrxRztvLGJYargy9BaHTYlq9H/pB3km62vfmrhTaN2BTpim5RZTpE
         m7AOPm900m0BtQ2GS36uBJWP3kAe7bkjPL2805C33E/PFfBaeciS9mi+hfumSpWT5gTk
         hAayxoyEelrCSs7lFsbwSUD22ZepC/+h/jI0soda/iCkLtL54DNbl+P2I8mcmWtE0//s
         GpTfNADkapuPT30wEEl5HnmMOY2ShXU1B1fNAlHAesP5zwaHoDyRHJOqxpW+rT+0pk8G
         rFdcMxIRGSq5jkQKiPe5hZHCO3r0CsoMH4cYWRWjytLESs3gheQiLhTNvRzPX3ahfXI9
         fZ4Q==
X-Gm-Message-State: AOAM532mg9f4rkjU3W2wbp35plECJ1F73Satbip1UapynJmvh2N3mUus
        lWgY/n7FBGQZMZ3NmkXLNVzoNjfi2g==
X-Google-Smtp-Source: ABdhPJzwvcFvE7h0BVHYnnPw5WN+AERV/+OxNdM09WmWN/PZ2XZI5A0xuksvYRtqA24b2s3PP0ojEg==
X-Received: by 2002:aca:c084:: with SMTP id q126mr4004947oif.129.1604526651953;
        Wed, 04 Nov 2020 13:50:51 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t20sm774378oic.1.2020.11.04.13.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 13:50:51 -0800 (PST)
Received: (nullmailer pid 4183876 invoked by uid 1000);
        Wed, 04 Nov 2020 21:50:50 -0000
Date:   Wed, 4 Nov 2020 15:50:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     sudeep.holla@arm.com, bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: Add bindings for BrcmSTB SCMI
 mailbox driver
Message-ID: <20201104215050.GA4180546@bogus>
References: <20201029195913.5927-1-james.quinlan@broadcom.com>
 <20201029195913.5927-2-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029195913.5927-2-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:59:06PM -0400, Jim Quinlan wrote:
> Bindings are added.  Only one interrupt is needed because
> we do not yet employ the SCMI p2a channel.

I still don't understand what this is. To repeat from v1: I thought SCMI 
was a mailbox consumer, not provider?

> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  .../bindings/mailbox/brcm,brcmstb-mbox.yaml   | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,brcmstb-mbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/brcm,brcmstb-mbox.yaml b/Documentation/devicetree/bindings/mailbox/brcm,brcmstb-mbox.yaml
> new file mode 100644
> index 000000000000..797c0cc609a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/brcm,brcmstb-mbox.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/mailbox/brcm,brcmstb-mbox.yaml#
> +
> +title: Broadcom STB mailbox driver bindings
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
> +      - description: a2p return interrupt, indicates SCMI msg completion.
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
> +    mailbox {
> +      compatible = "brcm,brcmstb-mailbox";
> +      #mbox-cells = <1>;
> +      interrupts = <GIC_SPI 0xc6 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +...
> -- 
> 2.17.1
> 


