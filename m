Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C564A2EEB96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 04:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbhAHDAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 22:00:31 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:41200 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbhAHDA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 22:00:27 -0500
Received: by mail-io1-f52.google.com with SMTP id t8so8379193iov.8;
        Thu, 07 Jan 2021 19:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aRDOzceSiC2MKPyin3oT66DoO1V8WX4nYOJ/ciyOtNA=;
        b=mZVuw0b8yyD7nR4zZf67JxvrSgUyzLobR+OuRwrcFIT2C0EjUCNHrE+4Jm/Af9MvHK
         RmnPt2E2YYN0TnT/iVB7OdpMZf4woVjzZDB8rVQ7t6V5ipVaiAumRZVrQMKJzt0+1kaq
         fxAUSA/sr5RbTIXD+0dYaw9r2HTnJyDtd6QTVlX5Dw+zAYL9D+pR7JkTwI7PlfU3yfJ6
         5ErryAFgT45wGZX1d7NNwnMYvfJPuzwAKv27N4/NYN5F7FFoMSZLNcdtsvdSrrKr9GfP
         3KSWSkusrLzSI3EmyR880nZcp9hO11OF3nDNvS9HLwdNcmCVtYwr9Lz8b1AVpMezSVNE
         ETcA==
X-Gm-Message-State: AOAM532TsSefZ12Qh0GnJciSBO/5RRSrGRi7+3znh4cYNROG4Q8FwSW8
        HezNrQdbpk6tpv8x37nTWg==
X-Google-Smtp-Source: ABdhPJxAb6S26IEYN/ViRSvSZ5C+4V2OpFaOEzLulP5hBbFez4eCy7IT5x66JICgQAWjCUPAEn1eaA==
X-Received: by 2002:a02:2a4f:: with SMTP id w76mr1497447jaw.50.1610074786553;
        Thu, 07 Jan 2021 18:59:46 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y5sm5686183ilj.35.2021.01.07.18.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 18:59:45 -0800 (PST)
Received: (nullmailer pid 1792516 invoked by uid 1000);
        Fri, 08 Jan 2021 02:59:43 -0000
Date:   Thu, 7 Jan 2021 19:59:43 -0700
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/7] dt-bindings: phy: ti,phy-j721e-wiz: Add binding for
 phy_en_refclk
Message-ID: <20210108025943.GA1790601@robh.at.kernel.org>
References: <20201224114250.1083-1-kishon@ti.com>
 <20201224114250.1083-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224114250.1083-3-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 05:12:45PM +0530, Kishon Vijay Abraham I wrote:
> Add DT binding for phy_en_refclk used to route the refclk out of the
> SERDES.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml   | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> index 4a1f9c27b5f0..14823588bc94 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -149,6 +149,19 @@ patternProperties:
>        - assigned-clocks
>        - assigned-clock-parents
>  
> +  "^phy-en-refclk$":

Not really a pattern. Move to 'properties'.

> +    type: object
> +    description: |
> +      In order to drive the refclk out from the SERDES (Cadence Torrent),
> +      PHY_EN_REFCLK should be set in SERDES_RST of WIZ. Model phy-en-refclk
> +      as a clock so that it can be enabled directly or as a parent clock.
> +    properties:
> +      "#clock-cells":
> +        const: 0
> +
> +    required:
> +      - "#clock-cells"

Though not really any need for a child node here. Just add 
'#clock-cells' to the parent node.

> +
>    "^serdes@[0-9a-f]+$":
>      type: object
>      description: |
> -- 
> 2.17.1
> 
