Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733CC302E29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbhAYVmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:42:36 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40577 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732885AbhAYVlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:41:25 -0500
Received: by mail-ot1-f48.google.com with SMTP id i20so14294325otl.7;
        Mon, 25 Jan 2021 13:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jFvGGF+GApXU3mEuRZRMts4wWuIR4lLZDNcLcWjS4Os=;
        b=eVxweh7NTtj1/fKXW4BOPet3i5InnQlEvt1aUGGbFRWPd7Ce5TeymPQXju8jUL1jFU
         AsRR+TK16HA9xVibGZ0oaagDFp4xqFcRo/AvbSrDqb1mVbz6B1hOJdKLk7XTbkkB2zIb
         RGiza9b8wARo+If5RId0iAv8ogYxDfAR4YII6EUlZlB4Zrn2/ul85g60zkHcCwV231Bn
         BQ0xo425Dbm/t/zhGKgnDBTqlQNpkRej1/+t/TnvpZwD3Gxnnw1MTI3dmEhxVYay+mBy
         qiqpkI0gWke/S6u95/u6A2UcyDmr2D59G57mmF22OwjVUBRg3/wqCPgLXRAXheBuILOx
         tW9Q==
X-Gm-Message-State: AOAM530XpzeTA4yfRYwj8Nyj8w5w+KJ5zD44Xv2ljTwv7fSxMzGhivwU
        4/evg/YhFMW4NIcNxr4EEQ==
X-Google-Smtp-Source: ABdhPJzZDgcSoRHUG+fj06W9B8eAhd0yh8E5shntkS8AUWYZc/Zr9QKzD38zD0jd0vq74wHnVHC4iA==
X-Received: by 2002:a05:6830:1589:: with SMTP id i9mr1772550otr.127.1611610844768;
        Mon, 25 Jan 2021 13:40:44 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t65sm3726614oie.25.2021.01.25.13.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:40:43 -0800 (PST)
Received: (nullmailer pid 1053015 invoked by uid 1000);
        Mon, 25 Jan 2021 21:40:42 -0000
Date:   Mon, 25 Jan 2021 15:40:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: phy-stm32-usbphyc: add
 #clock-cells required property
Message-ID: <20210125214042.GA1049362@robh.at.kernel.org>
References: <20210114171314.18946-1-amelie.delaunay@foss.st.com>
 <20210114171314.18946-2-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114171314.18946-2-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 06:13:13PM +0100, Amelie Delaunay wrote:
> usbphyc provides a unique clock called ck_usbo_48m.
> STM32 USB OTG needs a 48Mhz clock (utmifs_clk48) for Full-Speed operation.
> ck_usbo_48m is a possible parent clock for USB OTG 48Mhz clock.
> 
> ck_usbo_48m is available as soon as the PLL is enabled.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
> No change in v2.
> ---
>  .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> index 46df6786727a..4e4da64b8e01 100644
> --- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> @@ -51,6 +51,10 @@ properties:
>    vdda1v8-supply:
>      description: regulator providing 1V8 power supply to the PLL block
>  
> +  '#clock-cells':
> +    description: number of clock cells for ck_usbo_48m consumer
> +    const: 0
> +
>  #Required child nodes:
>  
>  patternProperties:
> @@ -102,6 +106,7 @@ required:
>    - "#size-cells"
>    - vdda1v1-supply
>    - vdda1v8-supply
> +  - '#clock-cells'

You can't really make new properties required as it's not backwards 
compatible. If things can never work without or the binding has never 
been used, then you can. You just need to spell this out in the commit 
msg.

>    - usb-phy@0
>    - usb-phy@1
>  
> @@ -120,6 +125,7 @@ examples:
>          vdda1v8-supply = <&reg18>;
>          #address-cells = <1>;
>          #size-cells = <0>;
> +        #clock-cells = <0>;
>  
>          usbphyc_port0: usb-phy@0 {
>              reg = <0>;
> -- 
> 2.17.1
> 
