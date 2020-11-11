Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DBB2AF2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgKKOBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:01:52 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:52506 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgKKOB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:01:26 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 13F31A19;
        Wed, 11 Nov 2020 15:01:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1605103285;
        bh=51fAu1UeFFm6MkvjlJ3Z548fg6LgDLTNEsnQQ2v2WDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YK1ye34235uVBRBLgpgCH3uPTmFkOlbs8ZY5HvxtVKhQ0py+uaGaUEuW0kk9BZKL+
         SUMeaW8IPPbHhY7T18lV4G4GhXTY9ntLM8wVJtSteAeL877OaEDnxqUjcHFGhLRvaw
         lkduxzDfKLRo3JMNpqTYBH7QegLx26S/6JpkOeeA=
Date:   Wed, 11 Nov 2020 16:01:21 +0200
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
Subject: Re: [PATCH v3 2/3] dt-bindings: usb-connector: Add reference to
 graph schema
Message-ID: <20201111140121.GE4115@pendragon.ideasonboard.com>
References: <20201102203656.220187-1-robh@kernel.org>
 <20201102203656.220187-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102203656.220187-3-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Mon, Nov 02, 2020 at 02:36:55PM -0600, Rob Herring wrote:
> Now that we have a graph schema, reference it from the usb-connector
> schema.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v3: new patch
> 
>  .../devicetree/bindings/connector/usb-connector.yaml   | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 728f82db073d..64f2e1246ddb 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -125,11 +125,13 @@ properties:
>        power dual role.
> 
>    ports:
> -    description: OF graph bindings (specified in bindings/graph.txt) that model
> -      any data bus to the connector unless the bus is between parent node and
> -      the connector. Since a single connector can have multiple data buses every
> -      bus has an assigned OF graph port number as described below.
> +    $ref: /schemas/graph.yaml#/properties/ports
>      type: object
> +    description: OF graph bindings modeling any data bus to the connector
> +      unless the bus is between parent node and the connector. Since a single
> +      connector can have multiple data buses every bus has an assigned OF graph
> +      port number as described below.
> +
>      properties:
>        port@0:
>          type: object

-- 
Regards,

Laurent Pinchart
