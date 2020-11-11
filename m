Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E302AF2FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgKKOCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:02:50 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:52558 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgKKOCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:02:09 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7AAC3A19;
        Wed, 11 Nov 2020 15:02:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1605103327;
        bh=6Z1/wh+8hONI84xujrOkT9PwzR2zTz2ecP9q5IMUpkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNF3y0w9hT1PxFIpbQ3Vygjq+QpdQ2u7/xwliTUJVDq9Gi6Vc6kTCnDq+q3Ua5tXZ
         VkM40KBSKeGwNlv4LwmV8P55FHum94Cnj5cQRFafdl4CNn10QDgLvYvw/EnblHI1EW
         324vBFazsY7Wk5AF4oA/AXAKc+HtjkJ4GuiPwChI=
Date:   Wed, 11 Nov 2020 16:02:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        kuninori.morimoto.gx@renesas.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: panel: common: Add reference to
 graph schema
Message-ID: <20201111140204.GF4115@pendragon.ideasonboard.com>
References: <20201102203656.220187-1-robh@kernel.org>
 <20201102203656.220187-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102203656.220187-4-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Mon, Nov 02, 2020 at 02:36:56PM -0600, Rob Herring wrote:
> Now that we have a graph schema, reference it from the common panel
> schema.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v3: new patch
> 
>  .../devicetree/bindings/display/panel/panel-common.yaml    | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> index cd6dc5461721..a3a72c574213 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> @@ -68,16 +68,15 @@ properties:
> 
>    # Connectivity
>    port:
> -    type: object
> +    $ref: /schemas/graph.yaml#/properties/port
> 
>    ports:
> -    type: object
> +    $ref: /schemas/graph.yaml#/properties/ports
>      description:
>        Panels receive video data through one or multiple connections. While
>        the nature of those connections is specific to the panel type, the
>        connectivity is expressed in a standard fashion using ports as specified
> -      in the device graph bindings defined in
> -      Documentation/devicetree/bindings/graph.txt.
> +      in the device graph bindings.
> 
>    ddc-i2c-bus:
>      $ref: /schemas/types.yaml#/definitions/phandle

-- 
Regards,

Laurent Pinchart
