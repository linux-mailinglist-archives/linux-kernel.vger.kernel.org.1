Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DEC2A6FD1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 22:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbgKDVmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 16:42:37 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44370 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731404AbgKDVmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 16:42:36 -0500
Received: by mail-oi1-f196.google.com with SMTP id t16so6438759oie.11;
        Wed, 04 Nov 2020 13:42:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ToIj3qn6LC7L7pM0HaNTYsjdGwuX7RSbyNOYuS4MIXY=;
        b=sen5iuFcOOz9Tqk9EnIcpBolgVRmY1mpNSkKDwA618QPMxPWUAHCjjb8EDcfxr7COY
         RTCH44ZA3qzFjDBjb//HWbX0o7824zWJiv6CZOriXjVzP7G0VHyuBqcCcu2r6pH2vgt7
         yt+sDNQ1G6bjPuxIZwfzO3WrKiwkjYQk31WW8tFTuZAfK4EnOYysJ7sKeyLydUVRofF3
         4yt/wLDEdmJvhb9Te46mr5MXjwlzqE1xOQgiBRone8qTSMFhpnkIJpj0CaQJaKN32UqV
         D2D9Blbo4GV9YrgqLQyE/l3E/1UMRFsVh25DG59oMeECJb5NQSBH12C8fxuUy6gOPnPM
         FFdA==
X-Gm-Message-State: AOAM533tN9TRm3cAIciLrdvO4W15W+m5eCzNZmeMcrj/y39DgdigKTYV
        srlNsJvuKi+XLj8xWH6mkUsLyHahIw==
X-Google-Smtp-Source: ABdhPJwCkSpwP9Sk/Zsgc40Vavl3t/cXC+e77Qeb662HOtR1vtRPoh/6/T+FgFCAATxUtw1cMsBJAA==
X-Received: by 2002:aca:1a16:: with SMTP id a22mr1795494oia.50.1604526155853;
        Wed, 04 Nov 2020 13:42:35 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l9sm760308otn.53.2020.11.04.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 13:42:35 -0800 (PST)
Received: (nullmailer pid 4172829 invoked by uid 1000);
        Wed, 04 Nov 2020 21:42:34 -0000
Date:   Wed, 4 Nov 2020 15:42:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4] dt-bindings: mtd: gpmi-nand: Fix matching of clocks
 on different SoCs
Message-ID: <20201104214234.GA4172794@bogus>
References: <20201029162021.80839-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029162021.80839-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 17:20:21 +0100, Krzysztof Kozlowski wrote:
> Driver requires different amount of clocks for different SoCs.  Describe
> these requirements properly to fix dtbs_check warnings like:
> 
>     arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: nand-controller@33002000: clock-names:1: 'gpmi_apb' was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v3:
> 1. Go back to fixed order of clocks, after explanation from Rob.
> 
> Changes since v1:
> 1. Do not require order of clocks (use pattern).
> ---
>  .../devicetree/bindings/mtd/gpmi-nand.yaml    | 76 +++++++++++++++----
>  1 file changed, 61 insertions(+), 15 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
