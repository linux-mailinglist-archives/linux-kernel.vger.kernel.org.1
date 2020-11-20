Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4442BAB83
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgKTNrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:47:46 -0500
Received: from smtp1.axis.com ([195.60.68.17]:58855 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgKTNrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=axis.com; l=3001; q=dns/txt; s=axis-central1;
  t=1605880064; x=1637416064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q4FFmjkhGxwPiHWpq/qUaLz9tnZojoP8KxE7GRpyXWI=;
  b=BoiNbqp/E053Sbf5qwh+UvtfrhK86jDKWZlquLw2H9W6a6A3DS3olGvu
   9F7rrEIQ18Eb+6JQV0p0PVpf7cQW0FVrryFisBgkP6PqCl2KHh1tSmug6
   pAPcomKZRNAFjR7K2tE1hPzKs2pZmARkrcDEqbSzTcjDWICR/uJmZWngh
   rnBx8Rlh0hyamS7G17zHyiUb6yC91O6nRI7txQmnQhCShKH8Fgfwx79eL
   cBdI54kL6Fo6AT/WSYazyxAfynxICiG/NHoIf/hGymKg3HtI2OOinpRpJ
   7OAnydkudeEVOElXGkDv+vL6v6dUxS/uZ6ZyCAGvUWg66UOMi9+Z9KibL
   A==;
IronPort-SDR: oNha+Y6qa1g25DQREhZ50z/FIA5QY+f+S5QNcdHPxu9eiRh8JcvPAFid0ARns+H2wwDe8X/L8H
 jmzuFHbB9ddpsOUcFWNbVI1vxpL8gaV1iuqW5WKS6Z+LK7RPClf9h7upyh4IdiN5r+pLzKi3TO
 6QEHLbUuiUhFfoSgn67nxMBAoEy/Wz7suNVZtLM8i6LcrEzl6nxCwGloukSSCvuuHvCm6IbD3z
 qHZIBKt4qkyQI7vIVi7i/JqXyhKh5IEyXcT4FFJQoq9rF4mYnL05Tv7JWApu3qHrtgXzXA8POa
 qxw=
X-IronPort-AV: E=Sophos;i="5.78,356,1599516000"; 
   d="scan'208";a="15269818"
Date:   Fri, 20 Nov 2020 14:47:42 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Adam Ward <adam.ward@diasemi.com>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/9] regulator: Update DA9121 dt-bindings
Message-ID: <20201120134742.y7bocaok3gcahbxt@axis.com>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
 <a5a57b416a47c044797d9b669c7e021acd69abae.1605868780.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a5a57b416a47c044797d9b669c7e021acd69abae.1605868780.git.Adam.Ward.opensource@diasemi.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:14:50PM +0100, Adam Ward wrote:
> Update bindings for the Dialog Semiconductor DA9121 voltage regulator to add device variants.
> 
> Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
> ---
>  .../devicetree/bindings/regulator/dlg,da9121.yaml  | 177 +++++++++++++++++++--
>  MAINTAINERS                                        |   2 +
>  .../dt-bindings/regulator/dlg,da9121-regulator.h   |  22 +++
>  3 files changed, 185 insertions(+), 16 deletions(-)
>  create mode 100644 include/dt-bindings/regulator/dlg,da9121-regulator.h
> 
> diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> index cde0d82..1bd177d 100644
> --- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> +++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> @@ -8,40 +8,185 @@ title: Dialog Semiconductor DA9121 voltage regulator
>  
>  maintainers:
>    - Vincent Whitchurch <vincent.whitchurch@axis.com>
> +  - Adam Ward <adam.ward@disasemi.com>

I'm quite happy to have myself removed from the list instead.  You are
in a much better position to maintain the bindings for these chips.

> -  buck1:
> -    description:
> -      Initial data for the Buck1 regulator.
> -    $ref: "regulator.yaml#"
> +  interrupt-parent:
> +    maxItems: 1
> +    description: Specifies the reference to the interrupt controller.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: IRQ line information.
> +
> +  dlg,irq-polling-delay-passive:
> +    maxItems: 1
> +    description: |
> +      Specify the polling period, measured in milliseconds, between interrupt status
> +      update checks. Range 1000-10000 ms.
> +
> +  regulators:
>      type: object
> +    $ref: regulator.yaml#
> +    description: |
> +      This node defines the settings for the BUCK. The content of the
> +      sub-node is defined by the standard binding for regulators; see regulator.yaml.
> +      The DA9121 regulator is bound using their names listed below
> +      buck1 - BUCK1
> +      buck2 - BUCK2       //DA9122, DA9220, DA9131, DA9132 only

This move to a sub-node means that older devicetrees won't work. I
assume that's fine since the driver is only in linux-next at the moment,
but perhaps it's worth mentioning this in the commit message?

> +
> +    patternProperties:
> +      "^buck([0-1])$":
> +        type: object
> +        $ref: regulator.yaml#
> +
> +    properties:
> +      regulator-mode:
> +        maxItems: 1
> +        description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
> +
> +      regulator-initial-mode:
> +        maxItems: 1
> +        description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
>  
> -unevaluatedProperties: false

I think my s/unevaluatedProperties/additionalProperties/ fix is already
in linux-next, so this looks like it needs rebasing.
