Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E182DDC2D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 00:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbgLQXvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 18:51:50 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:35960 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbgLQXvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 18:51:49 -0500
Received: by mail-oo1-f51.google.com with SMTP id j8so158615oon.3;
        Thu, 17 Dec 2020 15:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3sOGHwimDsVk895fxzByPvxMup8ISkAAqpsHjQHsFfI=;
        b=qba/wtDX2q8nGuE4TgpzQ4XPDGpgHwUMTvkBE50H3LJzTIRPT/3kZWNghzbIza72hB
         yYNJnhU3YnqSQnWFLfWC41NlKu00hC++kw/PDDgxtiKK5atpg5rqqNvVIxTLyDUOTzN5
         RYafsHuMgy3sVYbVeIHGfnVrMNbmqGeJB+dy27QIrclpkrnFZZxp5gdrPjxSlVned/b4
         RwN+IH4mzejum1POa/RV45YOPxTz4S2TMF5gxN0VvdWgMOl+/ztBVvVB+09jHw8UC4S4
         kQmYdtTZgr81GTFDKp8IjBhqnfOxdn2kJmv4FCyeobwhV2dDu2HY7IX72pSI1yv+6dXH
         nPUA==
X-Gm-Message-State: AOAM530wrpjcoyioJejI4S/H9rdaGhBXilYC2bfBrmFqgR93+NsbyV2f
        XXQ95exYJ1SN11l9h+Besg==
X-Google-Smtp-Source: ABdhPJzQMNPg4xpbZZw28Jofvl6X4nUNYXboWbRfViwIMQYGACtd81XBQYPmAb0ooQ3xFyyXTZi7hQ==
X-Received: by 2002:a4a:c503:: with SMTP id i3mr368721ooq.6.1608249068544;
        Thu, 17 Dec 2020 15:51:08 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m22sm1540032otr.79.2020.12.17.15.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:51:07 -0800 (PST)
Received: (nullmailer pid 455366 invoked by uid 1000);
        Thu, 17 Dec 2020 23:51:06 -0000
Date:   Thu, 17 Dec 2020 17:51:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, troy.kisky@boundarydevices.com
Subject: Re: [PATCH v2 3/7] regulator: dt-bindings: pf8x00: fix
 nxp,phase-shift doc
Message-ID: <20201217235106.GA454244@robh.at.kernel.org>
References: <20201215235639.31516-1-adrien.grassein@gmail.com>
 <20201215235639.31516-4-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215235639.31516-4-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 12:56:35AM +0100, Adrien Grassein wrote:
> nxp,phase-shift is an enum so use enum format to describe it.
> Minimum and maximum values are also wrong.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../bindings/regulator/nxp,pf8x00-regulator.yaml | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> index 913532d0532e..1da724c6e2ba 100644
> --- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> @@ -60,21 +60,13 @@ properties:
>  
>            nxp,phase-shift:
>              $ref: "/schemas/types.yaml#/definitions/uint32"
> -            minimum: 45
> -            maximum: 0
> +            minimum: 0
> +            maximum: 315

You can drop this. It's redundant with the enum.

> +            default: 0
> +            enum: [ 0, 45, 90, 135, 180, 225, 270, 315 ]
>              description:
>                BUCK regulators phase shift control in degrees.
>  
> -              Listed phase shift control values in degrees are,
> -              45
> -              90
> -              135
> -              180
> -              225
> -              270
> -              315
> -              0 (default)
> -
>          unevaluatedProperties: false
>  
>        "^vsnvs$":
> -- 
> 2.20.1
> 
