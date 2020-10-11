Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEB628A6BF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 11:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbgJKJ4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 05:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgJKJ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 05:56:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87EC0613CE;
        Sun, 11 Oct 2020 02:56:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 90CF91F4420C
Subject: Re: [PATCH v3] dt-bindings: power: rockchip: Convert to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dianders@chromium.org,
        heiko@sntech.de, Collabora Kernel ML <kernel@collabora.com>,
        Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200921092951.945382-1-enric.balletbo@collabora.com>
 <20201007151159.GA221754@bogus>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <0abb7d69-e522-4281-bcb7-a5d3f9372a48@collabora.com>
Date:   Sun, 11 Oct 2020 11:56:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201007151159.GA221754@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Many thanks for your comments, some questions below.

On 7/10/20 17:11, Rob Herring wrote:
> On Mon, Sep 21, 2020 at 11:29:51AM +0200, Enric Balletbo i Serra wrote:
>> Convert the soc/rockchip/power_domain.txt binding document to json-schema
>> and move to the power bindings directory.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v3:
>> - Fixed tab errors found by bot
>>
>> Changes in v2:
>> - Fixed a warning that says that 'syscon' should not be used alone.
>> - Use patternProperties to define a new level for power-domains.
>> - Add const values for power-domain-cells, address-cells, etc.
>>
>>  .../power/rockchip,power-controller.yaml      | 207 ++++++++++++++++++
>>  .../bindings/soc/rockchip/power_domain.txt    | 136 ------------
>>  2 files changed, 207 insertions(+), 136 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>> new file mode 100644
>> index 000000000000..b23ea37e2a08
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>> @@ -0,0 +1,207 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip Power Domains
>> +
>> +maintainers:
>> +  - Caesar Wang <wxt@rock-chips.com>
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +description: |
>> +  Rockchip processors include support for multiple power domains which can be
>> +  powered up/down by software based on different application scenes to save power.
>> +
>> +  Power domains contained within power-controller node are generic power domain
>> +  providers documented in Documentation/devicetree/bindings/power/power-domain.yaml.
>> +
>> +  IP cores belonging to a power domain should contain a 'power-domains'
>> +  property that is a phandle for the power domain node representing the domain.
>> +
>> +properties:
>> +  $nodename:
>> +    const: power-controller
>> +
>> +  compatible:
>> +    enum:
>> +      - rockchip,px30-power-controller
>> +      - rockchip,rk3036-power-controller
>> +      - rockchip,rk3066-power-controller
>> +      - rockchip,rk3128-power-controller
>> +      - rockchip,rk3188-power-controller
>> +      - rockchip,rk3228-power-controller
>> +      - rockchip,rk3288-power-controller
>> +      - rockchip,rk3328-power-controller
>> +      - rockchip,rk3366-power-controller
>> +      - rockchip,rk3368-power-controller
>> +      - rockchip,rk3399-power-controller
>> +
>> +  '#power-domain-cells':
>> +    const: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +patternProperties:
>> +  "^power-domain@[0-9]+$":
> 
> unit-addresses are hex.
> 

As explained in the description of 'reg' is more a power domain index than a
hexadecimal address. Same as done in
Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml

Use hex pattern will give a lot of errors, i.e 'pd_edp@25' and many others will
not match the regexes '^power-domain@[0-9a-f]+$'

Is the hex notation a must here? In that case, I assume I should change all the
power/rk3*power.h includes to use that notation.

>> +    type: object
>> +    description: |
>> +      Represents the power domains within the power controller node as documented
>> +      in Documentation/devicetree/bindings/power/power-domain.yaml.
>> +
>> +    properties:
>> +
>> +      '#power-domain-cells':
>> +        description:
>> +            Must be 0 for nodes representing a single PM domain and 1 for nodes
>> +            providing multiple PM domains.
>> +
>> +      '#address-cells':
>> +        const: 1
>> +
>> +      '#size-cells':
>> +        const: 0
>> +
>> +      reg:
>> +        description: |
>> +          Power domain index. Valid values are defined in:
>> +          "include/dt-bindings/power/px30-power.h" - for PX30 type power domain.
>> +          "include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
>> +          "include/dt-bindings/power/rk3066-power.h" - for RK3066 type power domain.
>> +          "include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
>> +          "include/dt-bindings/power/rk3188-power.h" - for RK3188 type power domain.
>> +          "include/dt-bindings/power/rk3228-power.h" - for RK3228 type power domain.
>> +          "include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
>> +          "include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
>> +          "include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
>> +          "include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
>> +          "include/dt-bindings/power/rk3399-power.h" - for RK3399 type power domain.
>> +        maxItems: 1
> 
> Range of values?
> 
>> +
>> +      clocks:
>> +        description: |
>> +          A number of phandles to clocks that need to be enabled while power domain
>> +          switches state.
> 
> Can you at least put a range of how many clocks?
> 

minItems could be 0, but from the datasheet, I am not sure if I am able to
define a maxItems, I think I can do two things, or define a maxItems based on
current definitions (with the risk that if a new SoC is supported we should
change that number) or use a finger in the air "safe" value. Should any of these
solutions be acceptable for you?


>> +
>> +      pm_qos:
>> +        description: |
>> +          A number of phandles to qos blocks which need to be saved and restored
>> +          while power domain switches state.
> 
> And here.
> 

The same as clocks here.

>> +
>> +    required:
>> +      - reg
> 
>        additionalProperties: false
> 
> Which in turn means the nested power domains will throw an error, so you 
> can do:
> 
>        patternProperties:
> 	 "^power-domain@[0-9a-f]+$":
>            $ref: '#/patternProperties/^power-domain@[0-9a-f]+$'
> 
>> +
>> +required:
>> +  - compatible
>> +  - '#power-domain-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/rk3399-cru.h>
>> +    #include <dt-bindings/power/rk3399-power.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        qos_hdcp: qos@ffa90000 {
>> +            compatible = "rockchip,rk3399-qos","syscon";
> 
> space                                             ^
> 
>> +            reg = <0x0 0xffa90000 0x0 0x20>;
>> +        };
>> +
>> +        qos_iep: qos@ffa98000 {
>> +            compatible = "rk3399-qos","syscon";
>> +            reg = <0x0 0xffa98000 0x0 0x20>;
>> +        };
>> +
>> +        qos_rga_r: qos@ffab0000 {
>> +            compatible = "rk3399-qos","syscon";
>> +            reg = <0x0 0xffab0000 0x0 0x20>;
>> +        };
>> +
>> +        qos_rga_w: qos@ffab0080 {
>> +            compatible = "rk3399-qos","syscon";
>> +            reg = <0x0 0xffab0080 0x0 0x20>;
>> +        };
>> +
>> +        qos_video_m0: qos@ffab8000 {
>> +            compatible = "rk3399-qos","syscon";
>> +            reg = <0x0 0xffab8000 0x0 0x20>;
>> +        };
>> +
>> +        qos_video_m1_r: qos@ffac0000 {
>> +            compatible = "rk3399-qos","syscon";
>> +            reg = <0x0 0xffac0000 0x0 0x20>;
>> +        };
>> +
>> +        qos_video_m1_w: qos@ffac0080 {
>> +            compatible = "rk3399-qos","syscon";
>> +            reg = <0x0 0xffac0080 0x0 0x20>;
>> +        };
>> +
>> +        power-management@ff310000 {
>> +            compatible = "rockchip,rk3399-pmu", "syscon", "simple-mfd";
>> +            reg = <0x0 0xff310000 0x0 0x1000>;
>> +
>> +            power-controller {
>> +                compatible = "rockchip,rk3399-power-controller";
>> +                #power-domain-cells = <1>;
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                /* These power domains are grouped by VD_CENTER */
>> +                power-domain@RK3399_PD_IEP {
>> +                    reg = <RK3399_PD_IEP>;
>> +                    clocks = <&cru ACLK_IEP>,
>> +                             <&cru HCLK_IEP>;
>> +                    pm_qos = <&qos_iep>;
>> +                    #power-domain-cells = <0>;
>> +                };
>> +                power-domain@RK3399_PD_RGA {
>> +                    reg = <RK3399_PD_RGA>;
>> +                    clocks = <&cru ACLK_RGA>,
>> +                             <&cru HCLK_RGA>;
>> +                    pm_qos = <&qos_rga_r>,
>> +                             <&qos_rga_w>;
>> +                    #power-domain-cells = <0>;
>> +                };
>> +                power-domain@RK3399_PD_VCODEC {
>> +                    reg = <RK3399_PD_VCODEC>;
>> +                    clocks = <&cru ACLK_VCODEC>,
>> +                             <&cru HCLK_VCODEC>;
>> +                    pm_qos = <&qos_video_m0>;
>> +                    #power-domain-cells = <0>;
>> +                };
>> +                power-domain@RK3399_PD_VDU {
>> +                    reg = <RK3399_PD_VDU>;
>> +                    clocks = <&cru ACLK_VDU>,
>> +                             <&cru HCLK_VDU>;
>> +                    pm_qos = <&qos_video_m1_r>,
>> +                             <&qos_video_m1_w>;
>> +                    #power-domain-cells = <0>;
>> +                };
>> +                power-domain@RK3399_PD_VIO {
>> +                    reg = <RK3399_PD_VIO>;
>> +                    #power-domain-cells = <1>;
>> +                    #address-cells = <1>;
>> +                    #size-cells = <0>;
>> +
>> +                    power-domain@RK3399_PD_HDCP {
>> +                        reg = <RK3399_PD_HDCP>;
>> +                        clocks = <&cru ACLK_HDCP>,
>> +                                 <&cru HCLK_HDCP>,
>> +                                 <&cru PCLK_HDCP>;
>> +                        pm_qos = <&qos_hdcp>;
>> +                        #power-domain-cells = <0>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
