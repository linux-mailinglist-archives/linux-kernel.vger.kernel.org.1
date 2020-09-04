Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD0A25DC98
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgIDO7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 10:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730727AbgIDO6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:58:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CBDC061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 07:58:54 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kEDAm-0003H3-S0; Fri, 04 Sep 2020 16:58:40 +0200
Message-ID: <de6785c6450dd0c3f24ea758e2772f0f72d81ba9.camel@pengutronix.de>
Subject: Re: [PATCH 04/13] dt-bindings: gpu: vivante,gc: Add common
 properties
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Li Yang <leoyang.li@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 04 Sep 2020 16:59:01 +0200
In-Reply-To: <20200904145312.10960-5-krzk@kernel.org>
References: <20200904145312.10960-1-krzk@kernel.org>
         <20200904145312.10960-5-krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2020-09-04 at 16:53 +0200, Krzysztof Kozlowski wrote:
> Add common properties appearing in DTSes (cooling-cells, assigned-clocks
> and others) to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: gpu@38000000:
>     '#cooling-cells', 'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  Documentation/devicetree/bindings/gpu/vivante,gc.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/vivante,gc.yaml b/Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> index 4843df1ddbb6..67b71cad7b3b 100644
> --- a/Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> +++ b/Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> @@ -21,6 +21,13 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  '#cooling-cells':
> +    const: 2
> +
> +  assigned-clock-parents: true
> +  assigned-clock-rates: true
> +  assigned-clocks: true
> +
>    clocks:
>      items:
>        - description: AXI/master interface clock

