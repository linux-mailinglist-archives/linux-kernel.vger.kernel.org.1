Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81382AC5B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgKIUFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:05:08 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46980 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIUFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:05:07 -0500
Received: by mail-oi1-f196.google.com with SMTP id q206so11547307oif.13;
        Mon, 09 Nov 2020 12:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GuoDtFshBo0hoJJ60im92Bs8Z4Fwx/fzMQNnSPUeOIY=;
        b=PXNIee9Aj5pUmuwiEvuqZdbLHy+KAF4k7oOj0lfBspFrZz/Cl4xc0mZPG2+0SYuh7C
         AOCKCdp/OqlexMDlX6TW88lLCE66IyNjDbf8gRg9BS4Bykuie/NARrXqloE1IOQ+VAPj
         89XOjbfmpkNdhGa9EvKfPGreo31JauIJJ3Z+FCYFyaxqBhd5IOOEQL/dI1HtiYjRc/Vh
         47xrXaidljKPfHijw1cd152sfbhdovpTMR393RigOZQyCjOguf2u5X1XV5hQbyI9D8HI
         5uUHx7ssNPCbzPedjnuZF3/nneawHE2TjwaoYgG096tBPH7G7e5Nlggj7KZW7wg/I1Tk
         dIYA==
X-Gm-Message-State: AOAM532N8bUdpsL3SbTNmCMEMWlRS7T19JVBLlnFADkINSkwzrgaMhpT
        YeIWYMM6oqQKdBmWIFRgrQ==
X-Google-Smtp-Source: ABdhPJyUj/aVccVoP5g+mV181MABiravzQIqPw5e0SX+/Fj4BD/4rW9TqtZoBeDTHxd/yGT5GrRsNg==
X-Received: by 2002:aca:5110:: with SMTP id f16mr575283oib.94.1604952306783;
        Mon, 09 Nov 2020 12:05:06 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z19sm2743224otm.58.2020.11.09.12.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:05:06 -0800 (PST)
Received: (nullmailer pid 1676297 invoked by uid 1000);
        Mon, 09 Nov 2020 20:05:04 -0000
Date:   Mon, 9 Nov 2020 14:05:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen.Hegelund@microchip.com
Subject: Re: [PATCH 1/6] dt-bindings: interrupt-controller: Add binding for
 the Microsemi Luton interrupt controller
Message-ID: <20201109200504.GA1673414@bogus>
References: <20201105171535.923570-1-gregory.clement@bootlin.com>
 <20201105171535.923570-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105171535.923570-2-gregory.clement@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 06:15:30PM +0100, Gregory CLEMENT wrote:
> Add the Device Tree binding documentation for the Microsemi Luton
> interrupt controller that is part of the ICPU. It is connected directly to
> the MIPS core interrupt controller.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt   | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

The patches look fine, but can you convert this to schema first.

> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
> index f5baeccb689f..94dc95cb815c 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
> @@ -1,8 +1,10 @@
>  Microsemi Ocelot SoC ICPU Interrupt Controller
>  
> +Luton belongs the same family of Ocelot: the VCoreIII family
> +
>  Required properties:
>  
> -- compatible : should be "mscc,ocelot-icpu-intr"
> +- compatible : should be "mscc,ocelot-icpu-intr" or "mscc,luton-icpu-intr"
>  - reg : Specifies base physical address and size of the registers.
>  - interrupt-controller : Identifies the node as an interrupt controller
>  - #interrupt-cells : Specifies the number of cells needed to encode an
> -- 
> 2.28.0
> 
