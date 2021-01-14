Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA582F5DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbhANJkQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Jan 2021 04:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbhANJkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:40:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC74BC061786
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:39:31 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kzz6B-00043Z-JS; Thu, 14 Jan 2021 10:39:23 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kzz6B-0003ko-6U; Thu, 14 Jan 2021 10:39:23 +0100
Message-ID: <80d4d9b16628847c59a7f94a7c002d8ce859b0ca.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: reset: microchip sparx5 reset driver
 bindings
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Steen Hegelund <steen.hegelund@microchip.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Date:   Thu, 14 Jan 2021 10:39:23 +0100
In-Reply-To: <20210113201915.2734205-2-steen.hegelund@microchip.com>
References: <20210113201915.2734205-1-steen.hegelund@microchip.com>
         <20210113201915.2734205-2-steen.hegelund@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steen,

On Wed, 2021-01-13 at 21:19 +0100, Steen Hegelund wrote:
> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> ---
>  .../bindings/reset/microchip,rst.yaml         | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> new file mode 100644
> index 000000000000..b5526753e85d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/reset/microchip,rst.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Microchip Sparx5 Switch Reset Controller
> +
> +maintainers:
> +  - Steen Hegelund <steen.hegelund@microchip.com>
> +  - Lars Povlsen <lars.povlsen@microchip.com>
> +
> +description: |
> +  The Microchip Sparx5 Switch provides reset control and implements the following
> +  functions
> +    - One Time Switch Core Reset (Soft Reset)
> +
> +properties:
> +  $nodename:
> +    pattern: "^reset-controller@[0-9a-f]+$"
> +
> +  compatible:
> +    const: microchip,sparx5-switch-reset
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  syscons:
> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    description: Array of syscons used to access reset registers
> +    minItems: 2

The order seems to be important in the driver, so this should specify
which is the CPU syscon and which is the GCB syscon. I'm not sure if it
would be better to have two separately named syscon properties with a
single phandle each.

regards
Philipp
