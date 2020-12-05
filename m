Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF642CFE79
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 20:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgLETg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 14:36:28 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:54728 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLETg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 14:36:28 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 61D80804E5;
        Sat,  5 Dec 2020 20:35:39 +0100 (CET)
Date:   Sat, 5 Dec 2020 20:35:38 +0100
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
Subject: Re: [PATCH v6 2/8] dt-bindings: display: simple: add EDT compatibles
 already supported by the driver
Message-ID: <20201205193538.GG332836@ravnborg.org>
References: <20201202081826.29512-1-o.rempel@pengutronix.de>
 <20201202081826.29512-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202081826.29512-3-o.rempel@pengutronix.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=MkekYUGvB1qRkAwlPMUA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

On Wed, Dec 02, 2020 at 09:18:20AM +0100, Oleksij Rempel wrote:
> Some EDT compatibles are already supported by the driver but will fail
> on checkpatch script. Fix it by syncing dt-bindings documentation with the
> driver.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 428b03342fea..0bb3e67fb58c 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -108,10 +108,12 @@ properties:
>          # Emerging Display Technology Corp. 480x272 TFT Display with capacitive touch
>        - edt,et057090dhu
>          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> +      - edt,et070080dh6
>        - edt,etm043080dh6gp
>          # Emerging Display Technology Corp. 480x272 TFT Display
>        - edt,etm0430g0dh6
>          # Emerging Display Technology Corp. 5.7" VGA TFT LCD panel
> +      - edt,etm0700g0bdh6
>        - edt,etm070080bdh6
The order is wrong here. edt,etm070080bdh6 comes before edt,etm0700g0bdh6.
I checked with "sort" in my editor just to make sure.

>          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
>          # Same display as the ETM0700G0BDH6, but with changed hardware for the
> @@ -124,6 +126,7 @@ properties:
>        - edt,etm0700g0dh6
>          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
>          # Same as ETM0700G0DH6 but with inverted pixel clock.
> +      - edt,etm0700g0edh6
>        - evervision,vgg804821
>          # Foxlink Group 5" WVGA TFT LCD panel
>        - foxlink,fl500wvr00-a0t

	Sam
