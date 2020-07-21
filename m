Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1D82284DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 18:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgGUQGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 12:06:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45424 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgGUQGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:06:16 -0400
Received: by mail-io1-f67.google.com with SMTP id e64so21966984iof.12;
        Tue, 21 Jul 2020 09:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xmFiyYVAXh8dLGcqP1mUgHDGPOUnEx9ltZZJeHm/90U=;
        b=BgCnRSBMuc6+yGI6PMHGqPiH3hK8Vewze/VGgj851XgysHKRNJheCYl5lj+O1yPcp3
         pArTMzbusj2sVcfpD1K5UdxodmVbwWxmXouhnDe96wTcWPCuddYupLYDmxZRlYNLkfFo
         FfzpNV0fksGcFrpXNr33Vq5m5jyIEitm5gn8x8MzsiWX0KzzhzAEhglV/obpW/6q1SmW
         VZeq7WuQ1B40Mo1Saa+80Vq0bpJzvBmk9y2NVqwqgLUxU2PjeGaM7zcf4eJHPSrqqH+1
         jIBJHlH0P60E4aBVJPlFpXDVH7pnnlxd0BS86hynZjdVpc5bhrRk35/rvxBf1VKoY/gl
         fHHA==
X-Gm-Message-State: AOAM533qVudyJnv2nFD2fe10suKoNnN6pVnOVuN+uxAjRt7vrokGH57C
        EXEus/rgrjpUfrQbsOoBMw==
X-Google-Smtp-Source: ABdhPJz/byD3lCIAK+KOCr8tkp6iytOXF67GXPOZHcVpAtLQmMBl43jbmfyqhruhjKTJCj0McCmYNA==
X-Received: by 2002:a02:8308:: with SMTP id v8mr32365035jag.101.1595347575497;
        Tue, 21 Jul 2020 09:06:15 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v13sm10694113iox.12.2020.07.21.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:06:12 -0700 (PDT)
Received: (nullmailer pid 382755 invoked by uid 1000);
        Tue, 21 Jul 2020 16:06:10 -0000
Date:   Tue, 21 Jul 2020 10:06:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     maz@kernel.org, devicetree@vger.kernel.org, ssantosh@kernel.org,
        jason@lakedaemon.net, tglx@linutronix.de, t-kristo@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, nm@ti.com, p.zabel@pengutronix.de
Subject: Re: [PATCH] firmware: ti_sci: Replace HTTP links with HTTPS ones
Message-ID: <20200721160610.GA382708@bogus>
References: <20200718105538.9542-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718105538.9542-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 12:55:38 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
> 
>  If there are any URLs to be removed completely
>  or at least not (just) HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
> 
>  .../devicetree/bindings/interrupt-controller/ti,sci-intr.txt    | 2 +-
>  drivers/firmware/ti_sci.c                                       | 2 +-
>  drivers/firmware/ti_sci.h                                       | 2 +-
>  drivers/irqchip/irq-ti-sci-inta.c                               | 2 +-
>  drivers/irqchip/irq-ti-sci-intr.c                               | 2 +-
>  drivers/reset/reset-ti-sci.c                                    | 2 +-
>  include/linux/soc/ti/ti_sci_inta_msi.h                          | 2 +-
>  include/linux/soc/ti/ti_sci_protocol.h                          | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
