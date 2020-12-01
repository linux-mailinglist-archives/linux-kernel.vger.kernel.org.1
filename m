Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3F62CA1FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389943AbgLAL5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:57:06 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:59224 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387433AbgLAL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:57:05 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 08B5B804D0;
        Tue,  1 Dec 2020 12:56:13 +0100 (CET)
Date:   Tue, 1 Dec 2020 12:56:12 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 1/6] dt-bindings: display: simple: Add EDT
 ETM0700G0BDH6 display
Message-ID: <20201201115612.GA1989765@ravnborg.org>
References: <20201201092742.17658-1-o.rempel@pengutronix.de>
 <20201201092742.17658-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201092742.17658-2-o.rempel@pengutronix.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=8OBsB-vj1QKdv3JTGIwA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij

On Tue, Dec 01, 2020 at 10:27:37AM +0100, Oleksij Rempel wrote:
> This display is already supported by the panel-simple driver, so add it
> to the bindings documentation.
> 
> This patch is needed to fix checkpatch warnings for the PLYM2M dts.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index edb53ab0d9eb..a011d9e44af3 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -117,6 +117,8 @@ properties:
>        - edt,etm0700g0dh6
>          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
>          # Same as ETM0700G0DH6 but with inverted pixel clock.
> +      - edt,etm0700g0bdh6
> +        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
>        - edt,etm070080bdh6
>          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
>          # Same display as the ETM0700G0BDH6, but with changed hardware for the

The panels should be listed in alphabetic order which is not the case
here. Could you fix the alphabetic order for the edt panels and then
insert the new panel in the right spot?

	Sam
