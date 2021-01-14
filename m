Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D752F6BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbhANUMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:12:10 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:35047 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbhANUMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:12:09 -0500
Received: by mail-ot1-f51.google.com with SMTP id i6so6398585otr.2;
        Thu, 14 Jan 2021 12:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gqqq+fMHkEpgHgpA0O4FcNTUfXZo6tu9q7RhXRCTixs=;
        b=fae0QKIfRVgJB4FfAyyi3c7Zll4jyZ162dvnLzNuPV0GMfhE/CabczIvTojcPiao8F
         t2GAQ20Oxtcr8/D3XuF2Dd7A4OfF9Oy8LTzTkcpEDHGB0pFn4adwxMVzhsjxnknNFW+d
         Ppr4h5L4utR2+2w2f+ogE6fRVQK7V8ounNugXfwFyB2sq2qQJEgm4yA+JS354oHBxBFE
         n310cnuu8B/V1edvuAKpcC9vGd3kAd1EtZ3lC/pTybqmzp+V/7+X8vBse+YLY2LySlw7
         kLKFr/1XEExJZkkhGLsWVJKBwps3rCixGBwynVl4kMUztoMh2lCdJ8YB34QMCTeoEWCS
         yohg==
X-Gm-Message-State: AOAM530aB9wFc70mzzgwiFC2Dd3lpxUSU45mYYSchkfwApl6oQZjBoIc
        CTFbdGjO6YdGJR813bMdog==
X-Google-Smtp-Source: ABdhPJzUAspNmh+1Adxo+Z/qLjyL/qp2ewL2ZVCRVvAggfRb4+fY4cnYDFMIX9o1IPxhR5fOQcGk2w==
X-Received: by 2002:a05:6830:1d58:: with SMTP id p24mr6083765oth.286.1610655088615;
        Thu, 14 Jan 2021 12:11:28 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 8sm1276191oii.45.2021.01.14.12.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 12:11:27 -0800 (PST)
Received: (nullmailer pid 3509247 invoked by uid 1000);
        Thu, 14 Jan 2021 20:11:26 -0000
Date:   Thu, 14 Jan 2021 14:11:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] dt-bindings: irq: sun6i-r: Split the binding
 from sun7i-nmi
Message-ID: <20210114201126.GA3509187@robh.at.kernel.org>
References: <20210112055950.21209-1-samuel@sholland.org>
 <20210112055950.21209-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112055950.21209-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 23:59:41 -0600, Samuel Holland wrote:
> The R_INTC in the A31 and newer sun8i/sun50i SoCs has additional
> functionality compared to the sun7i/sun9i NMI controller. Among other
> things, it multiplexes access to up to 128 interrupts corresponding to
> (and in parallel to) the first 128 GIC SPIs. This means the NMI is no
> longer the lowest-numbered hwirq at this irqchip, since it is SPI 32 or
> 96 (depending on SoC). hwirq 0 now corresponds to SPI 0, usually UART0.
> 
> To allow access to all multiplexed IRQs, the R_INTC requires a new
> binding where the interrupt number matches the GIC interrupt number.
> Otherwise, interrupts with hwirq numbers below the NMI would not be
> representable in the device tree.
> 
> For simplicity, copy the three-cell GIC binding; this disambiguates
> interrupt 0 in the old binding (the NMI) from interrupt 0 in the new
> binding (SPI 0) by the number of cells.
> 
> Because the H6 R_INTC has a different mapping from multiplexed IRQs to
> top-level register bits, it is no longer compatible with the A31 R_INTC.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../allwinner,sun6i-a31-r-intc.yaml           | 66 +++++++++++++++++++
>  .../allwinner,sun7i-a20-sc-nmi.yaml           | 10 ---
>  2 files changed, 66 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
