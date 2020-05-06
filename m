Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1749D1C7BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 22:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgEFU7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 16:59:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58080 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgEFU7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:59:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5B3EB2A2524
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v14 01/11] dt-bindings: mediatek: Add property to mt8183
 smi-common
To:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        Fan Chen <fan.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>
References: <1588752963-19934-1-git-send-email-weiyi.lu@mediatek.com>
 <1588752963-19934-2-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <7165ec9f-03ca-3020-2c34-246465094c46@collabora.com>
Date:   Wed, 6 May 2020 22:59:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588752963-19934-2-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi,

Thank you for your patch. Don't forget to cc <devicetree@vger.kernel.org>,
otherwise this patch could be silently ignored.

On 6/5/20 10:15, Weiyi Lu wrote:
> For scpsys driver using regmap based syscon driver API.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  .../devicetree/bindings/memory-controllers/mediatek,smi-common.txt      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> index b478ade..01744ec 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> @@ -20,7 +20,7 @@ Required properties:
>  	"mediatek,mt2712-smi-common"
>  	"mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
>  	"mediatek,mt8173-smi-common"
> -	"mediatek,mt8183-smi-common"
> +	"mediatek,mt8183-smi-common", "syscon"
>  - reg : the register and size of the SMI block.
>  - power-domains : a phandle to the power domain of this local arbiter.
>  - clocks : Must contain an entry for each entry in clock-names.
> 
