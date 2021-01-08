Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519442EEB8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 03:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbhAHC6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 21:58:53 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:34629 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbhAHC6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 21:58:52 -0500
Received: by mail-io1-f52.google.com with SMTP id i18so8404764ioa.1;
        Thu, 07 Jan 2021 18:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kdwvcSQe/BsoYAGJeSvP+ZzZ58dAp5TIxQnH80/cM+U=;
        b=FTwa6W3SiMwA9y4r6y1rrIB4H5XMKpLuTsHSYvuCRKGeYPN28wjxHceYiCT1AvyZx9
         RiYfKfCJCenoPkGjxVyGM/Dykf5JLUbFl2YClAgkz/hp2/OXQmzApC7YokWa/3Pjwexd
         6V1KSADyCP45bxZnvCNoxEIAgEytmNdx7UoTJeCX6EZUS31RqqihNKqOgzeQt4ddwUVf
         VhCGmJKwM+7yKJkps6keKSg89dLXI4wydkr22HhIzbvk/tr29JpEpNFk3dL6y94jhyiv
         m/98Tg3x9DUsorpSgjd5zWvFeOokkZMkST3pxqmRFCy+lAlLdJ1IssiFT93x/SrgGx7A
         uxgA==
X-Gm-Message-State: AOAM530mKEHviR8nAwdG/HSJ6k7Tn2RxLazVTNFYD+1GoCWaSFV5oRc+
        MTN8f9tvykfGPhwPG6xPFg==
X-Google-Smtp-Source: ABdhPJzlRgt30XO/nkuOW39uOtokST2Sb2dRPM9GTcV/24xif96JYMGwg8NGprhFyFY6jGkcCZmkZw==
X-Received: by 2002:a6b:7a09:: with SMTP id h9mr3778656iom.167.1610074691608;
        Thu, 07 Jan 2021 18:58:11 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p25sm4599947ioj.21.2021.01.07.18.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 18:58:10 -0800 (PST)
Received: (nullmailer pid 1790366 invoked by uid 1000);
        Fri, 08 Jan 2021 02:58:08 -0000
Date:   Thu, 7 Jan 2021 19:58:08 -0700
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/7] dt-bindings: phy: ti,phy-j721e-wiz: Add bindings for
 AM64 SERDES Wrapper
Message-ID: <20210108025808.GA1787492@robh.at.kernel.org>
References: <20201224114250.1083-1-kishon@ti.com>
 <20201224114250.1083-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224114250.1083-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 05:12:44PM +0530, Kishon Vijay Abraham I wrote:
> Add bindings for AM64 SERDES Wrapper.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml      | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> index c33e9bc79521..4a1f9c27b5f0 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -12,9 +12,13 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - ti,j721e-wiz-16g
> -      - ti,j721e-wiz-10g
> +    oneOf:
> +      - const: ti,j721e-wiz-16g
> +      - const: ti,j721e-wiz-10g

Pick one. This:

> +      - const: ti,am64-wiz-10g

Or this:

> +      - items:
> +          - const: ti,am64-wiz-10g
> +          - const: ti,j721e-wiz-10g

No reason to support both for ti,am64-wiz-10g.

>  
>    power-domains:
>      maxItems: 1
> -- 
> 2.17.1
> 
