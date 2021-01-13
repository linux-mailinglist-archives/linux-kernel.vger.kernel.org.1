Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8986C2F53CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbhAMUCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbhAMUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:02:08 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A48EC061575;
        Wed, 13 Jan 2021 12:01:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E89E71F44C55
Subject: Re: [PATCH 1/3] dt-bindings: power: Add domain regulator supply
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20210107104915.2888408-1-hsinyi@chromium.org>
 <20210107104915.2888408-2-hsinyi@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <4824b486-79e7-a382-0168-8cf51e20f7c7@collabora.com>
Date:   Wed, 13 Jan 2021 21:01:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107104915.2888408-2-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for the patch.

On 7/1/21 11:49, Hsin-Yi Wang wrote:
> Some power domains (eg. mfg) needs to turn on power supply before power
> on.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  .../bindings/power/mediatek,power-controller.yaml        | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index d14cb9bac8497..e529586af5a12 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -82,6 +82,9 @@ patternProperties:
>            be specified by order, adding first the BASIC clocks followed by the
>            SUSBSYS clocks.
>  
> +      domain-supply:
> +        description: domain regulator supply.
> +
>        mediatek,infracfg:
>          $ref: /schemas/types.yaml#/definitions/phandle
>          description: phandle to the device containing the INFRACFG register range.
> @@ -130,6 +133,9 @@ patternProperties:
>                be specified by order, adding first the BASIC clocks followed by the
>                SUSBSYS clocks.
>  
> +          domain-supply:
> +            description: domain regulator supply.
> +
>            mediatek,infracfg:
>              $ref: /schemas/types.yaml#/definitions/phandle
>              description: phandle to the device containing the INFRACFG register range.
> @@ -178,6 +184,9 @@ patternProperties:
>                    be specified by order, adding first the BASIC clocks followed by the
>                    SUSBSYS clocks.
>  
> +              domain-supply:
> +                description: domain regulator supply.
> +
>                mediatek,infracfg:
>                  $ref: /schemas/types.yaml#/definitions/phandle
>                  description: phandle to the device containing the INFRACFG register range.
> 
