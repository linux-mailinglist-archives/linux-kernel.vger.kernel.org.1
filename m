Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9034726F55C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 07:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgIRFWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 01:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgIRFWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:22:08 -0400
Received: from localhost (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C4C21D43;
        Fri, 18 Sep 2020 05:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600406528;
        bh=M2L6Nhwv2Jf3Qkvji6FJCO0fIsaAe+TTYGoQo4TMliM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2cs8pSMEyPObFx93eofQrBq5o39O70ZPdhN1V0rbGoqERxcW6WvoYYqM4xuT+Wxy
         AxW+gIeAn6BwLwQnSyIo7X1zHey+znBJQ/gnoUjutniEl37PfjxG+KvONG1FMptFSF
         DmB4u4unswq8FmnrMlw0eKwntMVTREDX3kW7d478=
Date:   Fri, 18 Sep 2020 10:52:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/2] dt-bindings: phy: cdns,torrent-phy: add reset-names
Message-ID: <20200918052204.GD2968@vkoul-mobl>
References: <20200916124711.166643-1-tomi.valkeinen@ti.com>
 <20200916124711.166643-2-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916124711.166643-2-tomi.valkeinen@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-20, 15:47, Tomi Valkeinen wrote:
> Add reset-names as a required property.
> 
> There are no dts files using torrent phy yet, so it is safe to add a new
> required property.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-torrent.yaml         | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> index 4071438be2ba..12ce022e4764 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -54,6 +54,10 @@ properties:
>        Torrent PHY reset.
>        See Documentation/devicetree/bindings/reset/reset.txt
>  
> +  reset-names:
> +    items:
> +      - const: torrent_reset
> +
>  patternProperties:
>    '^phy@[0-7]+$':
>      type: object
> @@ -111,6 +115,7 @@ required:
>    - reg
>    - reg-names
>    - resets
> +  - reset-names

Update the example as well please.
>  
>  additionalProperties: false
>  
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
