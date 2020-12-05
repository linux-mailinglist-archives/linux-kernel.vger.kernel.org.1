Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36DF2CFE7D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 20:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgLETha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 14:37:30 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:54790 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgLETh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 14:37:28 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 88E3C804C8;
        Sat,  5 Dec 2020 20:36:40 +0100 (CET)
Date:   Sat, 5 Dec 2020 20:36:39 +0100
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
Subject: Re: [PATCH v6 3/8] dt-bindings: display: simple: Add Kyocera
 tcg070wvlq panel
Message-ID: <20201205193639.GH332836@ravnborg.org>
References: <20201202081826.29512-1-o.rempel@pengutronix.de>
 <20201202081826.29512-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202081826.29512-4-o.rempel@pengutronix.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8 a=j6nJQESatMUz3IOQuDcA:9
        a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 09:18:21AM +0100, Oleksij Rempel wrote:
> So far, this panel seems to be compatible with "lg,lb070wv8", on other
> hand it is better to set this compatible in the devicetree. So, let's
> add it for now only to the dt-binding documentation to fix the
> checkpatch warnings.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 0bb3e67fb58c..8f7a0e409eee 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -172,6 +172,7 @@ properties:
>        - koe,tx26d202vm0bwa
>          # Kaohsiung Opto-Electronics. TX31D200VM0BAA 12.3" HSXGA LVDS panel
>        - koe,tx31d200vm0baa
> +      - kyo,tcg070wvlq
Can you provine a comment here about what panel it is?

>          # Kyocera Corporation 12.1" XGA (1024x768) TFT LCD panel
>        - kyo,tcg121xglp
>          # LeMaker BL035-RGB-002 3.5" QVGA TFT LCD panel
> -- 
> 2.29.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
