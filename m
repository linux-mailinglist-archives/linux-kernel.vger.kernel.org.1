Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2428C28CE8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgJMMmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:42:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40234 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgJMMmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:42:06 -0400
Received: by mail-oi1-f196.google.com with SMTP id m128so22292429oig.7;
        Tue, 13 Oct 2020 05:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9a9S8jqFI1z/da5IKYstSGsQ5P0heyKtA+nDpAbWxis=;
        b=ae0JiDRUGc6UhmD2+npHtsX8/Co/tEckAlfJgyZ2ekhWEdLLjluqcdHHgkocSNuVL0
         dpQ3ZwXEsYaNblb8oN+VnCPcCaLoUsgYTCTXkEoYLkMQnAzToeV5tksKtoUQB68lKoBV
         l86jnp4pVyjGR6gWzI3sPdngFR0X3+Gex5dU3O1gNTw+5VakzOJFWQgQfaWRWEvzdikY
         R9aJ8b4cLVFsUqaZ1LGkzT1vAXyRc13IGkJE08OXLWPWPfaE1sS2wNZ/HftbjBKZ3psv
         1wyGuoxnzdqo/VmsZkI+/zmKdZXRosytEUaC6rAeMmSZW8FN38PT6+Ytplsy70yHJhvI
         muBA==
X-Gm-Message-State: AOAM5333Z8cyzkIFNQ+kHlKMsbSoNPgIWvgI6R/k1gmwi6DYmzLVEX29
        zgYhdMRnc90Y6NIrZR7i6Q==
X-Google-Smtp-Source: ABdhPJzik5HzirfRUO8Rt3aNEPIrxservslx8BbKUyJWQUJ9c+zphQ1dJb0v+CV4goeTVMBvVtFbNg==
X-Received: by 2002:aca:fc85:: with SMTP id a127mr14056058oii.125.1602592925132;
        Tue, 13 Oct 2020 05:42:05 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o15sm10002746otj.3.2020.10.13.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 05:42:04 -0700 (PDT)
Received: (nullmailer pid 3312154 invoked by uid 1000);
        Tue, 13 Oct 2020 12:42:03 -0000
Date:   Tue, 13 Oct 2020 07:42:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Roger Quadros <rogerq@ti.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 16/18] dt-bindings: usb: meson-g12a-usb: Validate
 DWC2/DWC3 sub-nodes
Message-ID: <20201013124203.GE3269269@bogus>
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-17-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010224121.12672-17-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 01:41:19AM +0300, Serge Semin wrote:
> Amlogic G12A USB DT sub-nodes are supposed to be compatible with the
> generic DWC USB2 and USB3 devices. Since now we've got DT schemas for
> both of the later IP cores let's make sure that the Amlogic G12A USB
> DT nodes are fully evaluated including the DWC sub-nodes.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> index 88184d7e26cc..3e8ac0ff90de 100644
> --- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> @@ -78,7 +78,20 @@ properties:
>  
>  patternProperties:
>    "^usb@[0-9a-f]+$":
> -    type: object
> +    allOf:
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: snps,dwc2
> +        then:
> +          $ref: dwc2.yaml#
> +      - if:
> +          properties:
> +            compatible:
> +              const: snps,dwc3
> +        then:
> +          $ref: snps,dwc3.yaml#

It should be enough to do just:

oneOf:
  - $ref: dwc2.yaml#
  - $ref: snps,dwc3.yaml#
