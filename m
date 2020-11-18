Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB7A2B7BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgKRK7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:59:48 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:6715 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKRK7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:59:48 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 72EBE240010;
        Wed, 18 Nov 2020 10:59:45 +0000 (UTC)
Date:   Wed, 18 Nov 2020 11:59:45 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen.Hegelund@microchip.com
Subject: Re: [PATCH 1/5] dt-bindings: reset: ocelot: Add documentation for
 'microchip,reset-switch-core' property
Message-ID: <20201118105945.GF4556@piout.net>
References: <20201116171159.1735315-1-gregory.clement@bootlin.com>
 <20201116171159.1735315-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116171159.1735315-2-gregory.clement@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2020 18:11:55+0100, Gregory CLEMENT wrote:
> From: Lars Povlsen <lars.povlsen@microchip.com>
> 
> This documents the 'microchip,reset-switch-core' property in the
> ocelot-reset driver.
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../devicetree/bindings/power/reset/ocelot-reset.txt        | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> index 4d530d815484..20fff03753ad 100644
> --- a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> +++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> @@ -9,9 +9,15 @@ microchip Sparx5 armv8 SoC's.
>  Required Properties:
>   - compatible: "mscc,ocelot-chip-reset" or "microchip,sparx5-chip-reset"
>  
> +Optional properties:
> +- microchip,reset-switch-core : Perform a switch core reset at the
> +  time of driver load. This is may be used to initialize the switch
> +  core to a known state (before other drivers are loaded).
> +

If this is to be used by the switchdev driver, then I would simply
register this reset as a proper reset controller (with the  driver/reset
API) and consume that from the switchdev driver.

However, the switch may also be configured from userspace in existing
products. In this case you'd have to expose a reset interface, either
from the drivers/reset core or with a specific consumer.

My point is that this property is not necessary.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
