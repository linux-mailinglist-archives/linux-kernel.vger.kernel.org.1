Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1832628A677
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgJKJB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 05:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJKJB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 05:01:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87982C0613CE;
        Sun, 11 Oct 2020 02:01:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 47C461F44213
Subject: Re: [PATCH v3] dt-bindings: power: rockchip: Convert to json-schema
To:     Rob Herring <robh@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Caesar Wang <wxt@rock-chips.com>
References: <20200921092951.945382-1-enric.balletbo@collabora.com>
 <20201007151159.GA221754@bogus>
 <CAFqH_531fkh_gZbOMuzhsRj-72NeWsPyxWoFQh9bAF3CZwTfNw@mail.gmail.com>
 <CAL_JsqL7ej3o_qzb7r+Nmdp=YkuYciqRYYcFo4Z21OGOvkn-3A@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2623f12e-aca6-59ea-5f5e-0cd61a229004@collabora.com>
Date:   Sun, 11 Oct 2020 11:01:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL7ej3o_qzb7r+Nmdp=YkuYciqRYYcFo4Z21OGOvkn-3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 8/10/20 21:47, Rob Herring wrote:
> On Wed, Oct 7, 2020 at 3:57 PM Enric Balletbo Serra <eballetbo@gmail.com> wrote:
>>
>> Hi Rob,
>>
>> Missatge de Rob Herring <robh@kernel.org> del dia dc., 7 d’oct. 2020 a
>> les 17:12:
>>>
>>> On Mon, Sep 21, 2020 at 11:29:51AM +0200, Enric Balletbo i Serra wrote:
>>>> Convert the soc/rockchip/power_domain.txt binding document to json-schema
>>>> and move to the power bindings directory.
>>>>
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> ---
>>>>
>>>> Changes in v3:
>>>> - Fixed tab errors found by bot
>>>>
>>>> Changes in v2:
>>>> - Fixed a warning that says that 'syscon' should not be used alone.
>>>> - Use patternProperties to define a new level for power-domains.
>>>> - Add const values for power-domain-cells, address-cells, etc.
>>>>
>>>>  .../power/rockchip,power-controller.yaml      | 207 ++++++++++++++++++
>>>>  .../bindings/soc/rockchip/power_domain.txt    | 136 ------------
>>>>  2 files changed, 207 insertions(+), 136 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>>>>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>>>> new file mode 100644
>>>> index 000000000000..b23ea37e2a08
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>>>> @@ -0,0 +1,207 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Rockchip Power Domains
>>>> +
>>>> +maintainers:
>>>> +  - Caesar Wang <wxt@rock-chips.com>
>>>> +  - Heiko Stuebner <heiko@sntech.de>
>>>> +
>>>> +description: |
>>>> +  Rockchip processors include support for multiple power domains which can be
>>>> +  powered up/down by software based on different application scenes to save power.
>>>> +
>>>> +  Power domains contained within power-controller node are generic power domain
>>>> +  providers documented in Documentation/devicetree/bindings/power/power-domain.yaml.
>>>> +
>>>> +  IP cores belonging to a power domain should contain a 'power-domains'
>>>> +  property that is a phandle for the power domain node representing the domain.
>>>> +
>>>> +properties:
>>>> +  $nodename:
>>>> +    const: power-controller
>>>> +
>>>> +  compatible:
>>>> +    enum:
>>>> +      - rockchip,px30-power-controller
>>>> +      - rockchip,rk3036-power-controller
>>>> +      - rockchip,rk3066-power-controller
>>>> +      - rockchip,rk3128-power-controller
>>>> +      - rockchip,rk3188-power-controller
>>>> +      - rockchip,rk3228-power-controller
>>>> +      - rockchip,rk3288-power-controller
>>>> +      - rockchip,rk3328-power-controller
>>>> +      - rockchip,rk3366-power-controller
>>>> +      - rockchip,rk3368-power-controller
>>>> +      - rockchip,rk3399-power-controller
>>>> +
>>>> +  '#power-domain-cells':
>>>> +    const: 1
>>>> +
>>>> +  '#address-cells':
>>>> +    const: 1
>>>> +
>>>> +  '#size-cells':
>>>> +    const: 0
>>>> +
>>>> +patternProperties:
>>>> +  "^power-domain@[0-9]+$":
>>>
>>> unit-addresses are hex.
>>>
>>>> +    type: object
>>>> +    description: |
>>>> +      Represents the power domains within the power controller node as documented
>>>> +      in Documentation/devicetree/bindings/power/power-domain.yaml.
>>>> +
>>>> +    properties:
>>>> +
>>>> +      '#power-domain-cells':
>>>> +        description:
>>>> +            Must be 0 for nodes representing a single PM domain and 1 for nodes
>>>> +            providing multiple PM domains.
>>>> +
>>>> +      '#address-cells':
>>>> +        const: 1
>>>> +
>>>> +      '#size-cells':
>>>> +        const: 0
>>>> +
>>>> +      reg:
>>>> +        description: |
>>>> +          Power domain index. Valid values are defined in:
>>>> +          "include/dt-bindings/power/px30-power.h" - for PX30 type power domain.
>>>> +          "include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
>>>> +          "include/dt-bindings/power/rk3066-power.h" - for RK3066 type power domain.
>>>> +          "include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
>>>> +          "include/dt-bindings/power/rk3188-power.h" - for RK3188 type power domain.
>>>> +          "include/dt-bindings/power/rk3228-power.h" - for RK3228 type power domain.
>>>> +          "include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
>>>> +          "include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
>>>> +          "include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
>>>> +          "include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
>>>> +          "include/dt-bindings/power/rk3399-power.h" - for RK3399 type power domain.
>>>> +        maxItems: 1
>>>
>>> Range of values?
>>>
>>>> +
>>>> +      clocks:
>>>> +        description: |
>>>> +          A number of phandles to clocks that need to be enabled while power domain
>>>> +          switches state.
>>>
>>> Can you at least put a range of how many clocks?
>>>
>>>> +
>>>> +      pm_qos:
>>>> +        description: |
>>>> +          A number of phandles to qos blocks which need to be saved and restored
>>>> +          while power domain switches state.
>>>
>>> And here.
>>>
>>>> +
>>>> +    required:
>>>> +      - reg
>>>
>>>        additionalProperties: false
>>>
>>> Which in turn means the nested power domains will throw an error, so you
>>> can do:
>>>
>>>        patternProperties:
>>>          "^power-domain@[0-9a-f]+$":
>>>            $ref: '#/patternProperties/^power-domain@[0-9a-f]+$'
>>>
>>
>> When I tried this I got the following error:
>>
>> rockchip,power-controller.yaml:
>> patternProperties:^power-domain@[0-9a-f]+$:patternProperties:^power-domain@[0-9a-f]+$:$ref:
>> '#/patternProperties/^power-domain@[0-9a-f]+$' is not a
>> 'uri-reference'
>>
>> Not sure if is my environment or I am still doing something silly, can
>> you confirm that this works for you? It doesn't seem to be any binding
>> doing this actually.
> 
> I think the regex would have to be escaped to be a valid URI:
> 
> $ref: '%23/patternProperties/%5Epower-domain@%5B0-9a-f%5D+%24'
> 
> That's not the most readable nor am I sure it would get translated
> back to the right path, so it's probably going to be best to just
> define the child nodes even if duplicated.
> 

Ok, I'll define the child node then. Thank you for your support.

Cheers,
  Enric

> Rob
> 
