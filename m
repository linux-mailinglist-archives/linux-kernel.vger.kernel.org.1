Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26C72A8934
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbgKEVnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:43:53 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:36528 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732046AbgKEVnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:43:53 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 59BE720068;
        Thu,  5 Nov 2020 22:43:50 +0100 (CET)
Date:   Thu, 5 Nov 2020 22:43:49 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: Convert graph bindings to json-schema
Message-ID: <20201105214349.GH216923@ravnborg.org>
References: <20201102203656.220187-1-robh@kernel.org>
 <20201102203656.220187-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102203656.220187-2-robh@kernel.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=7gkXJVJtAAAA:8
        a=DR-ePR37AQyPKWWUk0YA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob/Sameer


On Mon, Nov 02, 2020 at 02:36:54PM -0600, Rob Herring wrote:
> From: Sameer Pujar <spujar@nvidia.com>
> 
> Convert device tree bindings of graph to YAML format. Currently graph.txt
> doc is referenced in multiple files and all of these need to use schema
> references. For now graph.txt is updated to refer to graph.yaml.
> 
> For users of the graph binding, they should reference to the graph
> schema from either 'ports' or 'port' property:
> 
> properties:
>   ports:
>     type: object
>     $ref: graph.yaml#/properties/ports
Please fix so this example is correct - append /schemas/

> 
>     properties:
>       port@0:
>         description: What data this port has
> 
>       ...
> 
> Or:
> 
> properties:
>   port:
>     description: What data this port has
>     type: object
>     $ref: graph.yaml#/properties/port
Likewise.

Otherwise I could be confused when looking it up later.

> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Rob Herring <robh@kernel.org>

With the changelog fixed:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
