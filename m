Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E354D28A6D6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 12:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgJKKED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 06:04:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59974 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgJKKED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 06:04:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6314C1F4420C
Subject: Re: [PATCH v3] dt-bindings: power: rockchip: Convert to json-schema
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dianders@chromium.org,
        heiko@sntech.de, Collabora Kernel ML <kernel@collabora.com>,
        Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200921092951.945382-1-enric.balletbo@collabora.com>
 <20201007151159.GA221754@bogus>
 <0abb7d69-e522-4281-bcb7-a5d3f9372a48@collabora.com>
Message-ID: <13e60748-6c65-43bc-cf34-b3a40091f6e3@collabora.com>
Date:   Sun, 11 Oct 2020 12:03:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0abb7d69-e522-4281-bcb7-a5d3f9372a48@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/20 11:56, Enric Balletbo i Serra wrote:
> Hi Rob,
> 
> Many thanks for your comments, some questions below.
> 
> On 7/10/20 17:11, Rob Herring wrote:
>> On Mon, Sep 21, 2020 at 11:29:51AM +0200, Enric Balletbo i Serra wrote:
>>> Convert the soc/rockchip/power_domain.txt binding document to json-schema
>>> and move to the power bindings directory.
>>>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>
>>> Changes in v3:
>>> - Fixed tab errors found by bot
>>>
>>> Changes in v2:
>>> - Fixed a warning that says that 'syscon' should not be used alone.
>>> - Use patternProperties to define a new level for power-domains.
>>> - Add const values for power-domain-cells, address-cells, etc.
>>>
>>>  .../power/rockchip,power-controller.yaml      | 207 ++++++++++++++++++
>>>  .../bindings/soc/rockchip/power_domain.txt    | 136 ------------
>>>  2 files changed, 207 insertions(+), 136 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>>> new file mode 100644
>>> index 000000000000..b23ea37e2a08
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>>> @@ -0,0 +1,207 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Rockchip Power Domains
>>> +
>>> +maintainers:
>>> +  - Caesar Wang <wxt@rock-chips.com>
>>> +  - Heiko Stuebner <heiko@sntech.de>
>>> +
>>> +description: |
>>> +  Rockchip processors include support for multiple power domains which can be
>>> +  powered up/down by software based on different application scenes to save power.
>>> +
>>> +  Power domains contained within power-controller node are generic power domain
>>> +  providers documented in Documentation/devicetree/bindings/power/power-domain.yaml.
>>> +
>>> +  IP cores belonging to a power domain should contain a 'power-domains'
>>> +  property that is a phandle for the power domain node representing the domain.
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    const: power-controller
>>> +
>>> +  compatible:
>>> +    enum:
>>> +      - rockchip,px30-power-controller
>>> +      - rockchip,rk3036-power-controller
>>> +      - rockchip,rk3066-power-controller
>>> +      - rockchip,rk3128-power-controller
>>> +      - rockchip,rk3188-power-controller
>>> +      - rockchip,rk3228-power-controller
>>> +      - rockchip,rk3288-power-controller
>>> +      - rockchip,rk3328-power-controller
>>> +      - rockchip,rk3366-power-controller
>>> +      - rockchip,rk3368-power-controller
>>> +      - rockchip,rk3399-power-controller
>>> +
>>> +  '#power-domain-cells':
>>> +    const: 1
>>> +
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 0
>>> +
>>> +patternProperties:
>>> +  "^power-domain@[0-9]+$":
>>
>> unit-addresses are hex.
>>
> 
> As explained in the description of 'reg' is more a power domain index than a
> hexadecimal address. Same as done in
> Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> 
> Use hex pattern will give a lot of errors, i.e 'pd_edp@25' and many others will
> not match the regexes '^power-domain@[0-9a-f]+$'
> 
> Is the hex notation a must here? In that case, I assume I should change all the
> power/rk3*power.h includes to use that notation.
> 

Oops, forget about this part, not enough caffeine this morning, I was confused,
sorry.

[snip]
