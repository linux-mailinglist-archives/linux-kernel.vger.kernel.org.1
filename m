Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C753121CEA5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 07:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgGMFMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 01:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgGMFMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:12:14 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C229B20724;
        Mon, 13 Jul 2020 05:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594617133;
        bh=Hx+pRtNi0iTQ1DbURjqI/VqDS50Exu9ChZk0ytZdFcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JzxgyM6XzL+PHrSUqqOnawdqk+KU78WRHiEuSiSLBeFomMDFURB9XzSz6i90qfCnW
         B2D6YqQrSelpHaqRNU9t4GpzqOwf0BqzztNYTHvCi83V11yOPMXyVtpfyxZeeLdNcW
         sqYKO/u+r8zQ0SFteTxosUQ/BwNmwICVgAE9CKaU=
Date:   Mon, 13 Jul 2020 10:42:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: uniphier: Fix incorrect clocks and
 clock-names for PXs3 usb3-hsphy
Message-ID: <20200713051209.GV34333@vkoul-mobl>
References: <1594198664-29381-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594198664-29381-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-07-20, 17:57, Kunihiko Hayashi wrote:
> The usb3-hsphy for PXs3 SoC needs to accept 3 clocks like usb3-ssphy.

Applied, thanks

> 
> Fixes: 134ab2845acb ("dt-bindings: phy: Convert UniPhier USB3-PHY conroller to json-schema")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml    | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
> index f88d362..c871d46 100644
> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
> @@ -31,12 +31,16 @@ properties:
>  
>    clocks:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 3
>  
>    clock-names:
>      oneOf:
>        - const: link          # for PXs2
> -      - items:               # for PXs3
> +      - items:               # for PXs3 with phy-ext
> +        - const: link
> +        - const: phy
> +        - const: phy-ext
> +      - items:               # for others
>          - const: link
>          - const: phy
>  
> -- 
> 2.7.4

-- 
~Vinod
