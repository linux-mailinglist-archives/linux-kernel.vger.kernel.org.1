Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699AE2F3397
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbhALPIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:08:09 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:42760 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbhALPIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:08:09 -0500
Received: by mail-oi1-f179.google.com with SMTP id l200so2605632oig.9;
        Tue, 12 Jan 2021 07:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YURvgP9BUjHljOosNLiDIA3f2KWxkQAmrOPayfecXYk=;
        b=TeyHgU6DNPn6e7Mno7l+52gs7oBQ3oVoot8wXttwk6tPnZGU5bUuJoUlHS2WYfeRy9
         grN/0tymHHqw55FYwSEYU3qMstUHk1DH6bSiumL333IMojCDLUQO70pSM1F7nZGArLur
         Oo1Md1wp9bm/lhPHgcfsHTkjft0WkXVvgLjltxX1i7cO4xLQi2DRhS6E67lnh2c+N1om
         Y+YiscEohQ4+Y+UBnkbX1M8bED3n6bZH3sITRQ4q/wqcELi1A5TPGuavJiW1TSigj3HW
         UfyXy7QmYwSNzLKsKKy908wSzYjBNenuwaKTMB3+3cWXJmZJwgJR01FSE7vSADKHcj5m
         Ea5A==
X-Gm-Message-State: AOAM5321kDienADbHk2Zn6TowVnvB4jGM2q0O1tvXa2Toz/5dfJCKx3E
        80vdymGR6e0LRfQBlpB7YA==
X-Google-Smtp-Source: ABdhPJxRuf1QKqeifgfkDYrkLo0q/suBbG48tctoUk5301xqgCa7AnfdCV5cTj3rX+62Im9zvPvjRg==
X-Received: by 2002:aca:cf03:: with SMTP id f3mr2312654oig.39.1610464048303;
        Tue, 12 Jan 2021 07:07:28 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p4sm693676oib.24.2021.01.12.07.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:07:27 -0800 (PST)
Received: (nullmailer pid 353855 invoked by uid 1000);
        Tue, 12 Jan 2021 15:07:26 -0000
Date:   Tue, 12 Jan 2021 09:07:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        fshao@chromium.org, hoegsberg@chromium.org, hsinyi@chromium.org,
        boris.brezillon@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v9 1/4] dt-bindings: gpu: mali-bifrost: Add Mediatek
 MT8183
Message-ID: <20210112150726.GA330364@robh.at.kernel.org>
References: <20210108011011.4061575-1-drinkcat@chromium.org>
 <20210108091005.v9.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108091005.v9.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 09:10:08AM +0800, Nicolas Boichat wrote:
> Define a compatible string for the Mali Bifrost GPU found in
> Mediatek's MT8183 SoCs.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> ---
> 
> (no changes since v6)
> 
> Changes in v6:
>  - Rebased, actually tested with recent mesa driver.
>  - No change
> 
> Changes in v5:
>  - Rename "2d" power domain to "core2"
> 
> Changes in v4:
>  - Add power-domain-names description
>    (kept Alyssa's reviewed-by as the change is minor)
> 
> Changes in v3:
>  - No change
> 
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index 184492162e7e..71b613ee5bd7 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -17,6 +17,7 @@ properties:
>      items:
>        - enum:
>            - amlogic,meson-g12a-mali
> +          - mediatek,mt8183-mali
>            - realtek,rtd1619-mali
>            - rockchip,px30-mali
>        - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
> @@ -87,6 +88,30 @@ allOf:
>      then:
>        required:
>          - resets
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8183-mali
> +    then:
> +      properties:
> +        sram-supply: true

This has to be defined at the top-level or there will be an error when 
it is present (due to additionalProperties).

In this if/then you can do:

else:
  sram-supply: false

to disallow it if not 'mediatek,mt8183-mali'

> +        power-domains:
> +          description:
> +            List of phandle and PM domain specifier as documented in
> +            Documentation/devicetree/bindings/power/power_domain.txt
> +          minItems: 3
> +          maxItems: 3
> +        power-domain-names:
> +          items:
> +            - const: core0
> +            - const: core1
> +            - const: core2
> +
> +      required:
> +        - sram-supply
> +        - power-domains
> +        - power-domains-names
>  
>  examples:
>    - |
> -- 
> 2.29.2.729.g45daf8777d-goog
> 
