Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0BA2688C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgINJtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:49:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35026 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgINJtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:49:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 10169298604
Subject: Re: [PATCH 01/12] dt-bindings: power: Add bindings for the Mediatek
 SCPSYS power domains controller
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <20200910172826.3074357-2-enric.balletbo@collabora.com>
 <20200911230255.GA2972120@bogus>
 <7a1c89b6-f483-5d57-f154-b80b72964077@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <afa8d779-1965-f01c-3cd2-f57ebb3f7b60@collabora.com>
Date:   Mon, 14 Sep 2020 11:49:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7a1c89b6-f483-5d57-f154-b80b72964077@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/9/20 10:59, Matthias Brugger wrote:
> 
> 
> On 12/09/2020 01:02, Rob Herring wrote:
>> On Thu, Sep 10, 2020 at 07:28:15PM +0200, Enric Balletbo i Serra wrote:
>>> The System Control Processor System (SCPSYS) has several power management
>>> related tasks in the system. Add the bindings to define the power
>>> domains for the SCPSYS power controller.
>>>
>>> Co-developed-by: Matthias Brugger <mbrugger@suse.com>
>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>> Dear Rob,
>>>
>>> I am awasre that this binding is not ready, but I prefered to send because I'm
>>> kind of blocked. Compiling this binding triggers the following error:
>>>
>>>      mediatek,power-controller.example.dt.yaml: syscon@10006000: mfg_async@7:
>>>      '#address-cells', '#size-cells', 'mfg_2d@8'
>>>      do not match any of the regexes: 'pinctrl-[0-9]+'
>>>
>>> This happens when a definition of a power-domain (parent) contains
>>> another power-domain (child), like the example. I am not sure how to
>>> specify this in the yaml and deal with this, so any clue is welcome.
>>
>> You just have to keep nesting schemas all the way down. Define a
>> grandchild node under the child node and then all of its properties.
>>
>>>
>>> Thanks,
>>>    Enric
>>>
>>>   .../power/mediatek,power-controller.yaml      | 171 ++++++++++++++++++
>>>   1 file changed, 171 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>>> b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>>> new file mode 100644
>>> index 000000000000..8be9244ad160
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>>> @@ -0,0 +1,171 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Mediatek Power Domains Controller
>>> +
>>> +maintainers:
>>> +  - Weiyi Lu <weiyi.lu@mediatek.com>
>>> +  - Matthias Brugger <mbrugger@suse.com>
>>> +
>>> +description: |
>>> +  Mediatek processors include support for multiple power domains which can be
>>> +  powered up/down by software based on different application scenes to save
>>> power.
>>> +
>>> +  IP cores belonging to a power domain should contain a 'power-domains'
>>> +  property that is a phandle for SCPSYS node representing the domain.
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^syscon@[0-9a-f]+$"
>>> +
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +        - mediatek,mt8173-power-controller
>>> +      - const: syscon
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +patternProperties:
>>> +  "^.*@[0-9]$":
>>
>> Node names should be generic:
>>
>> power-domain@
>>
> 
> Enric correct me if I'm wrong, if we want to see the power domains in debugfs,
> they are listed by their name. If all are called power-domain then the listing
> is pretty much useless.
> 

cc'ing Dafna who might be interested in this discussion.

Yes, It'd be difficult to clearly identify which domain is without looking at
the DT. Now we have

# ls /sys/kernel/debug/pm_genpd
audio  mfg     mfg_async  pm_genpd_summary  vdec  venc_lt
isp    mfg_2d  mm         usb


Actually, I see two "problems" on using a generic name. The first one is that
debugfs uses that name and doesn't allow duplicate names, so we will get a bunch
of errors like this:

debugfs: Directory 'power-domain' with parent 'pm_gendpd' already present!
debugfs: Directory 'power-domain' with parent 'pm_gendpd' already present!
debugfs: Directory 'power-domain' with parent 'pm_gendpd' already present!
...

And we will lost the debug information. However, that's not probably a DT
problem as maybe debugfs should create different names in the form
power-domain@0, power-domain@1, etc.

The second one is what Matthias said, the name exported to the debugfs is
useless. Again, maybe is not a DT problem and the debugfs infra should handle
this cases in a better way, but that's not the case right now.


>>> +    type: object
>>> +    description: |
>>> +      Represents the power domains within the power controller node as
>>> documented
>>> +      in Documentation/devicetree/bindings/power/power-domain.yaml.
>>> +
>>> +    properties:
>>> +      reg:
>>> +        description: |
>>> +          Power domain index. Valid values are defined in:
>>> +              "include/dt-bindings/power/mt8173-power.h" - for MT8173 type
>>> power domain.
>>> +        maxItems: 1
>>> +
>>> +      '#power-domain-cells':
>>> +        description:
>>> +          Documented by the generic PM Domain bindings in
>>> +          Documentation/devicetree/bindings/power/power-domain.yaml.
>>
>> No need to redefine a common property. This should define valid values
>> for it.
>>
>>> +
>>> +      clocks:
>>> +        description: |
>>> +          A number of phandles to clocks that need to be enabled during domain
>>> +          power-up sequencing.
>>
>> No need to redefine 'clocks'. You need to define how many, what each one
>> is, and the order.
>>
> 
> Do you mean we have to define each clock for each power domain of each SoC?
> 
>>> +
>>> +      clock-names:
>>> +        description: |
>>> +          List of names of clocks, in order to match the power-up sequencing
>>> +          for each power domain we need to group the clocks by name. BASIC
>>> +          clocks need to be enabled before enabling the corresponding power
>>> +          domain, and should not have a '-' in their name (i.e mm, mfg, venc).
>>> +          SUSBYS clocks need to be enabled before releasing the bus protection,
>>> +          and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
>>> +
>>> +          In order to follow properly the power-up sequencing, the clocks must
>>> +          be specified by order, adding first the BASIC clocks followed by the
>>> +          SUSBSYS clocks.
>>
>> You need to define the names.
>>
>>> +
>>> +      mediatek,infracfg:
>>> +        $ref: /schemas/types.yaml#definitions/phandle
>>> +        description: phandle to the device containing the INFRACFG register
>>> range.
>>> +
>>> +      mediatek,smi:
>>> +        $ref: /schemas/types.yaml#definitions/phandle
>>> +        description: phandle to the device containing the SMI register range.
>>> +
>>> +    required:
>>> +      - reg
>>> +      - '#power-domain-cells'
>>> +
>>> +    additionalProperties: false
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/mt8173-clk.h>
>>> +    #include <dt-bindings/power/mt8173-power.h>
>>> +
>>> +    soc {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +
>>> +        scpsys: syscon@10006000 {
>>> +            compatible = "mediatek,mt8173-power-controller", "syscon";
> 
> The power domain controller is just one funcionality the SCPSYS block can
> provide. I think it should be child of the SCPSYS.
> 
> Regards,
> Matthias
> 
