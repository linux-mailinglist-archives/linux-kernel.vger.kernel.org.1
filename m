Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBEF2D4A6E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbgLITft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:35:49 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44314 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgLITfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:35:36 -0500
Received: by mail-oi1-f195.google.com with SMTP id d189so2945756oig.11;
        Wed, 09 Dec 2020 11:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RU5yctnzYeNVxzZwWCnH+ltBDI3DWm+U/FWQam3xCNA=;
        b=ZkHpm+7rUNQrNLF68bqYeFVBz2aY3wGgND9HB59/9Gm38eDwoil19/KrXtvLGlNePH
         aOBt3uls/BKletg8IvaTttwEmwexL6KU+c1nEvClasZr1Dspsk6RDctBuDnf3gr63/Lg
         KLeGFukv+U3Kt3JgW4xLfDIL02QQRIpuVG+nD8WUfoM3asAF2GmfsPd921A9tcUQd8W3
         JfmcSStRrTzUyBwcfYLUzmccnQvDAYD7a/VZkWRJqfqFzB/icCPh+Erw2+C2eNr/UWF4
         sNzvl8CK10NUq/hRPlBv6zOdOFcUy+OHf+bE9D6khdgvltntz4d/blKqTb2bnpjxPMXF
         rijA==
X-Gm-Message-State: AOAM533JX6WbZ33CbBYzdxCO1cVkrGwSs72AJ3r4u9FOWaS2wrLS0k9q
        jrT1CviMiXg1xQdTJn/EEg==
X-Google-Smtp-Source: ABdhPJz0Jyha2RK/z+ELIcnxxEQ3d0izZ2dHAsyKzikNSYaFJ6BFQsOI5ZtHAe4cdW6u/9EMAxOVUA==
X-Received: by 2002:aca:d06:: with SMTP id 6mr3024679oin.13.1607542495212;
        Wed, 09 Dec 2020 11:34:55 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t19sm618802otp.36.2020.12.09.11.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:34:54 -0800 (PST)
Received: (nullmailer pid 810040 invoked by uid 1000);
        Wed, 09 Dec 2020 19:34:53 -0000
Date:   Wed, 9 Dec 2020 13:34:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: Add new compatible string for AM64 SoC
Message-ID: <20201209193417.GB807821@robh.at.kernel.org>
References: <20201209165733.8204-1-a-govindraju@ti.com>
 <20201209165733.8204-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209165733.8204-2-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 10:27:32PM +0530, Aswath Govindraju wrote:
> Add compatible string in j721e-usb binding file as similar USB subsystem
> is present in AM64.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Acked-by: Roger Quadros <rogerq@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> index 388245b91a55..05d976bb06d0 100644
> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> @@ -11,8 +11,11 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> -      - const: ti,j721e-usb
> +    anyOf:
> +      - items:
> +	  - const: ti,j721e-usb
> +      - items:
> +	  - const: ti,am64-usb

Use 'enum'.

>  
>    reg:
>      description: module registers
> -- 
> 2.17.1
> 
