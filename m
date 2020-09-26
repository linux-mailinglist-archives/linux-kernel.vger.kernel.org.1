Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D0F279BEC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgIZSmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 14:42:20 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:46024 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgIZSmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 14:42:20 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 36874806AC;
        Sat, 26 Sep 2020 20:42:15 +0200 (CEST)
Date:   Sat, 26 Sep 2020 20:42:13 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Mark Brown <broonie@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] dt-bindings: display: sii902x: Add supply bindings
Message-ID: <20200926184213.GA98875@ravnborg.org>
References: <20200924200507.1175888-1-mr.nuke.me@gmail.com>
 <20200924200507.1175888-2-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924200507.1175888-2-mr.nuke.me@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=A5ZCwZeG c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
        a=2LU-NbLpax7TFHrha1gA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandru

On Thu, Sep 24, 2020 at 03:05:06PM -0500, Alexandru Gagniuc wrote:
> The sii902x chip family requires IO and core voltages to reach the
> correct voltage before chip initialization. Add binding for describing
> the two supplies.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

It is not mandatory but encouraged to convert a binding to DT schema
format before updating it. This is in order to reach a point
in time where all bindings are in DT Schema format thus
allowing much better verification of the DT files.

	Sam

> ---
>  Documentation/devicetree/bindings/display/bridge/sii902x.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> index 0d1db3f9da84..02c21b584741 100644
> --- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> @@ -8,6 +8,8 @@ Optional properties:
>  	- interrupts: describe the interrupt line used to inform the host
>  	  about hotplug events.
>  	- reset-gpios: OF device-tree gpio specification for RST_N pin.
> +	- iovcc-supply: I/O Supply Voltage (1.8V or 3.3V)
> +	- cvcc12-supply: Digital Core Supply Voltage (1.2V)
>  
>  	HDMI audio properties:
>  	- #sound-dai-cells: <0> or <1>. <0> if only i2s or spdif pin
> @@ -54,6 +56,8 @@ Example:
>  		compatible = "sil,sii9022";
>  		reg = <0x39>;
>  		reset-gpios = <&pioA 1 0>;
> +		iovcc-supply = <&v3v3_hdmi>;
> +		cvcc12-supply = <&v1v2_hdmi>;
>  
>  		#sound-dai-cells = <0>;
>  		sil,i2s-data-lanes = < 0 1 2 >;
> -- 
> 2.25.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
