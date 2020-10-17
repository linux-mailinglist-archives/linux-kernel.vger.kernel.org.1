Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC7291078
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 09:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411772AbgJQHRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 03:17:45 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:39972 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411713AbgJQHRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 03:17:45 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 812DD8055B;
        Sat, 17 Oct 2020 09:17:42 +0200 (CEST)
Date:   Sat, 17 Oct 2020 09:17:40 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-amarula@amarulasolutions.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Yes Optoelectronics
Message-ID: <20201017071740.GJ2242298@ravnborg.org>
References: <20200904180821.302194-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904180821.302194-1-jagan@amarulasolutions.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=iP-xVBlJAAAA:8 a=e5mUnYsNAAAA:8
        a=9mebZdXVrDbmM0H2kEcA:9 a=CjuIK1q_8ugA:10 a=lHLH-nfn2y1bM_0xSXwp:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

On Fri, Sep 04, 2020 at 11:38:19PM +0530, Jagan Teki wrote:
> Add vendor dt-bindings for Yes Optoelectronics Co.,Ltd.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

I have applied the full series to drm-misc-next.
Sorry for the delay.

	Sam

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 9aeab66be85f..15a6a8e7260d 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1167,6 +1167,8 @@ patternProperties:
>      description: Shenzhen Xunlong Software CO.,Limited
>    "^xylon,.*":
>      description: Xylon
> +  "^yes-optoelectronics,.*":
> +    description: Yes Optoelectronics Co.,Ltd.
>    "^yna,.*":
>      description: YSH & ATIL
>    "^yones-toptech,.*":
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
