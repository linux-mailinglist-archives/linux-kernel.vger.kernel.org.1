Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6F92CD07A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbgLCHl4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Dec 2020 02:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLCHl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:41:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE928C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 23:41:15 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kkjEi-00041p-BX; Thu, 03 Dec 2020 08:41:08 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kkjEg-0000zA-GE; Thu, 03 Dec 2020 08:41:06 +0100
Message-ID: <230c34e8a973140ebb7f155f5527050408f0c438.camel@pengutronix.de>
Subject: Re: [v6,1/3] dt-binding: reset-controller: mediatek: add YAML
 schemas
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Crystal Guo <crystal.guo@mediatek.com>, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, s-anna@ti.com, seiya.wang@mediatek.com,
        stanley.chu@mediatek.com, yingjoe.chen@mediatek.com,
        fan.chen@mediatek.com, yong.liang@mediatek.com
Date:   Thu, 03 Dec 2020 08:41:06 +0100
In-Reply-To: <20200930022159.5559-2-crystal.guo@mediatek.com>
References: <20200930022159.5559-1-crystal.guo@mediatek.com>
         <20200930022159.5559-2-crystal.guo@mediatek.com>
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

Hi,

On Wed, 2020-09-30 at 10:21 +0800, Crystal Guo wrote:
> Add a YAML documentation for Mediatek, which uses ti reset-controller
> driver directly. The TI reset controller provides a common reset
> management, and is suitable for Mediatek SoCs.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>  .../bindings/reset/mediatek-syscon-reset.yaml | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml b/Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml
> new file mode 100644
> index 000000000000..7871550c3c69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/mediatek-syscon-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Reset Controller
> +
> +maintainers:
> +  - Crystal Guo <crystal.guo@mediatek.com>
> +
> +description:
> +  The bindings describe the reset-controller for Mediatek SoCs,
> +  which is based on TI reset controller. For more detail, please
> +  visit Documentation/devicetree/bindings/reset/ti-syscon-reset.txt.
> +
> +properties:
> +  compatible:
> +    const: mediatek,syscon-reset
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  mediatek,reset-bits:
> +    description: >
> +      Contains the reset control register information, please refer to
> +      Documentation/devicetree/bindings/reset/ti-syscon-reset.txt.

I would really like some input from Rob on this, in v4 he asked not to
repeat 'ti,reset-bits'.

regards
Philipp
