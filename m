Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9CA2DDC2A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 00:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbgLQXud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 18:50:33 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44205 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbgLQXub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 18:50:31 -0500
Received: by mail-ot1-f47.google.com with SMTP id f16so289274otl.11;
        Thu, 17 Dec 2020 15:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B4zCGaNlp+KrExdt4xkJP2WRtO1LNObzQ+pHXnbCS0c=;
        b=eg7pXRAERkcAXNT93xBSylFZJU1YQbM6UbYjeUIa1Xn7OXB2YO4uWf7+wovot/eyx8
         ONicDUnlG4BgsIeEMcurm8DKnq2LBRpI0ODQmhWg6BFpk4P/AoaobQgXha+LHkgGml+g
         7ypk6Suqty9GafJBY7JGFwoZW9HGgLmuKez2ABP11l8jOJ4r07/JRHOV34WMwVSeWIZS
         vo90O8Ex83o5zp1owcxr3yW5u9cFTXxyvKXdAp0rqVj0slWaVbCXSf/9HKr5jgmDnkfG
         IeB+ngdwSc9+gEbudH1gZ78Z7p+TwR2asS1dOie+U67GEGm7grDsYnepam+fRKlQAb/7
         LMiA==
X-Gm-Message-State: AOAM531hZRLvMc+TtFr7WtmPrC4M3D6eVq/I2O4teARUWJ9zNzkHbrqX
        bVHV6hQzqeDbEcLlPuVSMKD0G6Cetw==
X-Google-Smtp-Source: ABdhPJyUzeyjQ0RMOqTe/h+KLcEyYIdd0plSrvq3FMiavaqduwfXRv5TSWiaz82tlmIQdfC2nGAE2g==
X-Received: by 2002:a9d:3d64:: with SMTP id a91mr1045379otc.144.1608248990682;
        Thu, 17 Dec 2020 15:49:50 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l5sm1536599otj.57.2020.12.17.15.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:49:49 -0800 (PST)
Received: (nullmailer pid 453576 invoked by uid 1000);
        Thu, 17 Dec 2020 23:49:48 -0000
Date:   Thu, 17 Dec 2020 17:49:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, troy.kisky@boundarydevices.com
Subject: Re: [PATCH v2 1/7] regulator: dt-bindings: remove useless properties
Message-ID: <20201217234948.GA451916@robh.at.kernel.org>
References: <20201215235639.31516-1-adrien.grassein@gmail.com>
 <20201215235639.31516-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215235639.31516-2-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 12:56:33AM +0100, Adrien Grassein wrote:
> regulator-name is a generic property of the regulator.
> Don't repeat it here.

Yes, but the values aren't generic.

> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../regulator/nxp,pf8x00-regulator.yaml         | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> index a6c259ce9785..913532d0532e 100644
> --- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> @@ -36,12 +36,6 @@ properties:
>          description:
>            Properties for single LDO regulator.
>  
> -        properties:
> -          regulator-name:
> -            pattern: "^ldo[1-4]$"
> -            description:
> -              should be "ldo1", ..., "ldo4"
> -
>          unevaluatedProperties: false
>  
>        "^buck[1-7]$":
> @@ -51,11 +45,6 @@ properties:
>            Properties for single BUCK regulator.
>  
>          properties:
> -          regulator-name:
> -            pattern: "^buck[1-7]$"
> -            description:
> -              should be "buck1", ..., "buck7"
> -
>            nxp,ilim-ma:
>              $ref: "/schemas/types.yaml#/definitions/uint32"
>              minimum: 2100
> @@ -94,12 +83,6 @@ properties:
>          description:
>            Properties for single VSNVS regulator.
>  
> -        properties:
> -          regulator-name:
> -            pattern: "^vsnvs$"
> -            description:
> -              should be "vsnvs"
> -
>          unevaluatedProperties: false
>  
>      additionalProperties: false
> -- 
> 2.20.1
> 
