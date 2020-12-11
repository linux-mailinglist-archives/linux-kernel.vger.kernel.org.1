Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463232D6EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395172AbgLKDis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:38:48 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42249 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391319AbgLKDiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:38:20 -0500
Received: by mail-oi1-f194.google.com with SMTP id l200so8348682oig.9;
        Thu, 10 Dec 2020 19:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kj9TRow5ixi6n52trMSsYRJlPAgtK6fpG4a/kDC7DG4=;
        b=I/1ABVM5LnM24wcLWoWqKuQM5zDwZ49GlOCg/L4pohE+0tci4crl1mXCpSXtFVnEMh
         PRfUQR9PCt4sXXnPgytddgG8Xu9ZIntbcbR2YRBhcQ4S3CbLh5U8Amq/JTr0T32UyO2p
         y7B4+Miv11vzmF2n0ex8RRqFjbD7pzCWs49f/kBa1paDPOKHweGs3oTTJHGn0Q+4ysEn
         StGyvgNmI8Wk6XVz/9t2aJjhU/lQgAZwuoJgOTxSyyJcv1mt/YyHmjV/WZN93X5Frhnp
         6MW5bPQ5Z7ItthzR4lB3ddjmfRO+29C7fTRNv0lgIUy049Lk0DdNKQ1kjkftdktOipXR
         5BHg==
X-Gm-Message-State: AOAM533EanJUtvdKXPSRh7VyTKtMK0dx0pj8kJdsqnzRXOU1kiJ/8Tws
        WDrmndM3kZhsMqI45ZbsFb3xRo4WqA==
X-Google-Smtp-Source: ABdhPJzRSKyyTI9lwb9FSOjw2V0rwsEbdCl+o53S7KFXJHRRiMskVIjUijZZ/SmgCOdPueog7xxpMA==
X-Received: by 2002:aca:4257:: with SMTP id p84mr7638245oia.68.1607657859814;
        Thu, 10 Dec 2020 19:37:39 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o135sm1469382ooo.38.2020.12.10.19.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:37:39 -0800 (PST)
Received: (nullmailer pid 3590416 invoked by uid 1000);
        Fri, 11 Dec 2020 03:37:38 -0000
Date:   Thu, 10 Dec 2020 21:37:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: usb: Add new compatible string for AM64
 SoC
Message-ID: <20201211033726.GA3588782@robh.at.kernel.org>
References: <20201210065450.16663-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210065450.16663-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 12:24:50PM +0530, Aswath Govindraju wrote:
> Add compatible string in j721e-usb binding file as the same USB subsystem
> is present in AM64.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Acked-by: Roger Quadros <rogerq@ti.com>
> ---
> 
> Changes since v2:
> - added changes done over the versions
> 
> Changes since v1:
> - replaced the '\t' at the beginning of the lines with spaces as it was
>   causing the dt_binding_check to fail
> 
> 
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> index 388245b91a55..453587f6d304 100644
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
> +          - const: ti,j721e-usb
> +      - items:
> +          - const: ti,am64-usb

compatible:
  enum:
    - ti,j721e-usb
    - ti,am64-usb

>  
>    reg:
>      description: module registers
> -- 
> 2.17.1
> 
