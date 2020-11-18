Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724E12B7B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgKRKfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:35:21 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:59355 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgKRKfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:35:21 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 0932A24000E;
        Wed, 18 Nov 2020 10:35:17 +0000 (UTC)
Date:   Wed, 18 Nov 2020 11:35:17 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen.Hegelund@microchip.com
Subject: Re: [PATCH v3 2/5] dt-bindings: interrupt-controller: Add binding
 for few Microsemi interrupt controllers
Message-ID: <20201118103517.GA4556@piout.net>
References: <20201116162427.1727851-1-gregory.clement@bootlin.com>
 <20201116162427.1727851-3-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116162427.1727851-3-gregory.clement@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 16/11/2020 17:24:24+0100, Gregory CLEMENT wrote:
> Add the Device Tree binding documentation for the Microsemi Jaguar2,
> Luton and Serval interrupt controller that is part of the ICPU. It is
> connected directly to the MIPS core interrupt controller.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
> index 3a537635a859..5483ed7062ba 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
> @@ -21,7 +21,11 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - mscc,jaguar2-icpu-intr
> +          - mscc,luton-icpu-intr
>            - mscc,ocelot-icpu-intr
> +          - mscc,serval-icpu-intr
> +

Spurious blank line

>  
>    '#interrupt-cells':
>      const: 1
> -- 
> 2.29.2
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
