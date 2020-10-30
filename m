Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743322A0489
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJ3Lnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJ3Lnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:43:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F3DC0613CF;
        Fri, 30 Oct 2020 04:43:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id F132C1F45EBC
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add MT8167 power domains
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <mbrugger@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201027131122.374046-1-fparent@baylibre.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c00a5ba1-154d-66ab-2ac7-c504e2e87b3e@collabora.com>
Date:   Fri, 30 Oct 2020 12:43:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027131122.374046-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

Thank you for the patch and base it on [0]

On 27/10/20 14:11, Fabien Parent wrote:
> Add power domains dt-bindings for MT8167.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> 
> This patch depends on the SCPSYS PM domains driver [0].
> 
> v2:
> 	* Implement on top of new SCPSYS PM domains driver [0]
> 
> [0] https://patchwork.kernel.org/project/linux-mediatek/list/?series=370737
> 
>  .../power/mediatek,power-controller.yaml       |  2 ++
>  include/dt-bindings/power/mt8167-power.h       | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8167-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 0318ffb1133c..73e5452c3a5d 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -23,6 +23,7 @@ properties:
>  
>    compatible:
>      enum:
> +      - mediatek,mt8167-power-controller
>        - mediatek,mt8173-power-controller
>        - mediatek,mt8183-power-controller
>        - mediatek,mt8192-power-controller
> @@ -59,6 +60,7 @@ patternProperties:
>        reg:
>          description: |
>            Power domain index. Valid values are defined in:
> +              "include/dt-bindings/power/mt8167-power.h" - for MT8167 type power domain.
>                "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
>                "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
>                "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
> diff --git a/include/dt-bindings/power/mt8167-power.h b/include/dt-bindings/power/mt8167-power.h
> new file mode 100644
> index 000000000000..7e3babfc2eef
> --- /dev/null
> +++ b/include/dt-bindings/power/mt8167-power.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MT8167_POWER_H
> +#define _DT_BINDINGS_POWER_MT8167_POWER_H
> +
> +#define MT8167_POWER_DOMAIN_MM		0
> +#define MT8167_POWER_DOMAIN_DISP	0

Is that correct? Both domains have the same index?

> +#define MT8167_POWER_DOMAIN_VDEC	1
> +#define MT8167_POWER_DOMAIN_ISP		2
> +#define MT8167_POWER_DOMAIN_CONN	3
> +#define MT8167_POWER_DOMAIN_MFG_ASYNC	4
> +#define MT8167_POWER_DOMAIN_MFG_2D	5
> +#define MT8167_POWER_DOMAIN_MFG		6
> +
> +#endif /* _DT_BINDINGS_POWER_MT8167_POWER_H */
> 
