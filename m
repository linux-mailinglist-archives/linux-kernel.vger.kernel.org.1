Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67B42CFE69
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 20:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgLETdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 14:33:22 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:54506 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgLETdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 14:33:19 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 53A6D804C8;
        Sat,  5 Dec 2020 20:32:30 +0100 (CET)
Date:   Sat, 5 Dec 2020 20:32:29 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/8] dt-bindings: display: simple: fix alphabetical
 order for EDT compatibles
Message-ID: <20201205193229.GF332836@ravnborg.org>
References: <20201202081826.29512-1-o.rempel@pengutronix.de>
 <20201202081826.29512-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202081826.29512-2-o.rempel@pengutronix.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=0SxC7ohpVnCXmJXPVTcA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij

On Wed, Dec 02, 2020 at 09:18:19AM +0100, Oleksij Rempel wrote:
> Reorder it alphabetically and remove one double entry.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/display/panel/panel-simple.yaml     | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index edb53ab0d9eb..428b03342fea 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -106,26 +106,24 @@ properties:
>          # Emerging Display Technology Corp. 3.5" QVGA TFT LCD panel
>        - edt,et035012dm6
>          # Emerging Display Technology Corp. 480x272 TFT Display with capacitive touch
> +      - edt,et057090dhu
> +        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
>        - edt,etm043080dh6gp
>          # Emerging Display Technology Corp. 480x272 TFT Display
>        - edt,etm0430g0dh6
>          # Emerging Display Technology Corp. 5.7" VGA TFT LCD panel
> -      - edt,et057090dhu
> -        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> -      - edt,etm070080dh6
> -        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> -      - edt,etm0700g0dh6
> -        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> -        # Same as ETM0700G0DH6 but with inverted pixel clock.
>        - edt,etm070080bdh6
>          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
>          # Same display as the ETM0700G0BDH6, but with changed hardware for the
>          # backlight and the touch interface.
> +      - edt,etm070080dh6
> +        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
>        - edt,etm070080edh6
>          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
>          # Same timings as the ETM0700G0DH6, but with resistive touch.
> -      - edt,etm070080dh6
> -        # Evervision Electronics Co. Ltd. VGG804821 5.0" WVGA TFT LCD Panel
> +      - edt,etm0700g0dh6
> +        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> +        # Same as ETM0700G0DH6 but with inverted pixel clock.
>        - evervision,vgg804821
>          # Foxlink Group 5" WVGA TFT LCD panel
>        - foxlink,fl500wvr00-a0t

Thanks for fixing this, but something is not correct.
I think you switched around the order of comment and compatible.

It goes like this

	  # This is the comment
	- compatible,for-the-comment

I always look at the first entry when I need to check the order.
Also the comment for evervision,vgg804821 seems to be lost in the above.

	Sam
