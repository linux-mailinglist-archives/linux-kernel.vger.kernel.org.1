Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57042861DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgJGPMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:12:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41721 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgJGPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:12:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id q136so1608907oic.8;
        Wed, 07 Oct 2020 08:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EWNhakFdr+Af9mXVcjVojegyJELDAdY6frBEcDPGyxU=;
        b=rPgy62fssGRIBCp3fztdl7mi1crnUdoa1jIssThK0OxqTIktvZoD5FmFtxmEME5Dwz
         FiTaq8LOqFQqQgb+gGdBsd5HrUe4wlb8sEawiIICQPgjrdHtReq3qMCZafavMHSJ29pl
         E+UVXQ9iTrPwobGrIsDIdO/74+uV8TIdD3cLjFbemjB/3qGOztZgUzozWNvyztaQikDH
         YnX9PXxBV/gAXmorHn09T+MWAwJQdRk5ClcJkE1YaZlrsPkTtYxgtuZsuyCvXESYqCXt
         qm7DsSQt9Gt7HqIgpKrtoieQrnfYG3T9ufdEBhowaOqmHjt8K0FXdL1Ts6EJBSX6OYWs
         010A==
X-Gm-Message-State: AOAM530HBhH415Py0d/slonVuuV+KCvRi1XfQUuWQqzfq1JJ/h37p/wp
        dupvY6CcRu5K/ypD5pUPqA==
X-Google-Smtp-Source: ABdhPJy8zFQuU7BA4DG6IGmdYxtGW+BiMCGOjN+e2y4EDjuN4sX3E0CEhnbI1WsT2xPArBQABn1tHg==
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr2065065oif.118.1602083521386;
        Wed, 07 Oct 2020 08:12:01 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o2sm2081304oia.42.2020.10.07.08.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 08:12:00 -0700 (PDT)
Received: (nullmailer pid 234333 invoked by uid 1000);
        Wed, 07 Oct 2020 15:11:59 -0000
Date:   Wed, 7 Oct 2020 10:11:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, dianders@chromium.org,
        heiko@sntech.de, Collabora Kernel ML <kernel@collabora.com>,
        Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] dt-bindings: power: rockchip: Convert to json-schema
Message-ID: <20201007151159.GA221754@bogus>
References: <20200921092951.945382-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921092951.945382-1-enric.balletbo@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:29:51AM +0200, Enric Balletbo i Serra wrote:
> Convert the soc/rockchip/power_domain.txt binding document to json-schema
> and move to the power bindings directory.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3:
> - Fixed tab errors found by bot
> 
> Changes in v2:
> - Fixed a warning that says that 'syscon' should not be used alone.
> - Use patternProperties to define a new level for power-domains.
> - Add const values for power-domain-cells, address-cells, etc.
> 
>  .../power/rockchip,power-controller.yaml      | 207 ++++++++++++++++++
>  .../bindings/soc/rockchip/power_domain.txt    | 136 ------------
>  2 files changed, 207 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> new file mode 100644
> index 000000000000..b23ea37e2a08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> @@ -0,0 +1,207 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Power Domains
> +
> +maintainers:
> +  - Caesar Wang <wxt@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |
> +  Rockchip processors include support for multiple power domains which can be
> +  powered up/down by software based on different application scenes to save power.
> +
> +  Power domains contained within power-controller node are generic power domain
> +  providers documented in Documentation/devicetree/bindings/power/power-domain.yaml.
> +
> +  IP cores belonging to a power domain should contain a 'power-domains'
> +  property that is a phandle for the power domain node representing the domain.
> +
> +properties:
> +  $nodename:
> +    const: power-controller
> +
> +  compatible:
> +    enum:
> +      - rockchip,px30-power-controller
> +      - rockchip,rk3036-power-controller
> +      - rockchip,rk3066-power-controller
> +      - rockchip,rk3128-power-controller
> +      - rockchip,rk3188-power-controller
> +      - rockchip,rk3228-power-controller
> +      - rockchip,rk3288-power-controller
> +      - rockchip,rk3328-power-controller
> +      - rockchip,rk3366-power-controller
> +      - rockchip,rk3368-power-controller
> +      - rockchip,rk3399-power-controller
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^power-domain@[0-9]+$":

unit-addresses are hex.

> +    type: object
> +    description: |
> +      Represents the power domains within the power controller node as documented
> +      in Documentation/devicetree/bindings/power/power-domain.yaml.
> +
> +    properties:
> +
> +      '#power-domain-cells':
> +        description:
> +            Must be 0 for nodes representing a single PM domain and 1 for nodes
> +            providing multiple PM domains.
> +
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +      reg:
> +        description: |
> +          Power domain index. Valid values are defined in:
> +          "include/dt-bindings/power/px30-power.h" - for PX30 type power domain.
> +          "include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
> +          "include/dt-bindings/power/rk3066-power.h" - for RK3066 type power domain.
> +          "include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
> +          "include/dt-bindings/power/rk3188-power.h" - for RK3188 type power domain.
> +          "include/dt-bindings/power/rk3228-power.h" - for RK3228 type power domain.
> +          "include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
> +          "include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
> +          "include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
> +          "include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
> +          "include/dt-bindings/power/rk3399-power.h" - for RK3399 type power domain.
> +        maxItems: 1

Range of values?

> +
> +      clocks:
> +        description: |
> +          A number of phandles to clocks that need to be enabled while power domain
> +          switches state.

Can you at least put a range of how many clocks?

> +
> +      pm_qos:
> +        description: |
> +          A number of phandles to qos blocks which need to be saved and restored
> +          while power domain switches state.

And here.

> +
> +    required:
> +      - reg

       additionalProperties: false

Which in turn means the nested power domains will throw an error, so you 
can do:

       patternProperties:
	 "^power-domain@[0-9a-f]+$":
           $ref: '#/patternProperties/^power-domain@[0-9a-f]+$'

> +
> +required:
> +  - compatible
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/power/rk3399-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        qos_hdcp: qos@ffa90000 {
> +            compatible = "rockchip,rk3399-qos","syscon";

space                                             ^

> +            reg = <0x0 0xffa90000 0x0 0x20>;
> +        };
> +
> +        qos_iep: qos@ffa98000 {
> +            compatible = "rk3399-qos","syscon";
> +            reg = <0x0 0xffa98000 0x0 0x20>;
> +        };
> +
> +        qos_rga_r: qos@ffab0000 {
> +            compatible = "rk3399-qos","syscon";
> +            reg = <0x0 0xffab0000 0x0 0x20>;
> +        };
> +
> +        qos_rga_w: qos@ffab0080 {
> +            compatible = "rk3399-qos","syscon";
> +            reg = <0x0 0xffab0080 0x0 0x20>;
> +        };
> +
> +        qos_video_m0: qos@ffab8000 {
> +            compatible = "rk3399-qos","syscon";
> +            reg = <0x0 0xffab8000 0x0 0x20>;
> +        };
> +
> +        qos_video_m1_r: qos@ffac0000 {
> +            compatible = "rk3399-qos","syscon";
> +            reg = <0x0 0xffac0000 0x0 0x20>;
> +        };
> +
> +        qos_video_m1_w: qos@ffac0080 {
> +            compatible = "rk3399-qos","syscon";
> +            reg = <0x0 0xffac0080 0x0 0x20>;
> +        };
> +
> +        power-management@ff310000 {
> +            compatible = "rockchip,rk3399-pmu", "syscon", "simple-mfd";
> +            reg = <0x0 0xff310000 0x0 0x1000>;
> +
> +            power-controller {
> +                compatible = "rockchip,rk3399-power-controller";
> +                #power-domain-cells = <1>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                /* These power domains are grouped by VD_CENTER */
> +                power-domain@RK3399_PD_IEP {
> +                    reg = <RK3399_PD_IEP>;
> +                    clocks = <&cru ACLK_IEP>,
> +                             <&cru HCLK_IEP>;
> +                    pm_qos = <&qos_iep>;
> +                    #power-domain-cells = <0>;
> +                };
> +                power-domain@RK3399_PD_RGA {
> +                    reg = <RK3399_PD_RGA>;
> +                    clocks = <&cru ACLK_RGA>,
> +                             <&cru HCLK_RGA>;
> +                    pm_qos = <&qos_rga_r>,
> +                             <&qos_rga_w>;
> +                    #power-domain-cells = <0>;
> +                };
> +                power-domain@RK3399_PD_VCODEC {
> +                    reg = <RK3399_PD_VCODEC>;
> +                    clocks = <&cru ACLK_VCODEC>,
> +                             <&cru HCLK_VCODEC>;
> +                    pm_qos = <&qos_video_m0>;
> +                    #power-domain-cells = <0>;
> +                };
> +                power-domain@RK3399_PD_VDU {
> +                    reg = <RK3399_PD_VDU>;
> +                    clocks = <&cru ACLK_VDU>,
> +                             <&cru HCLK_VDU>;
> +                    pm_qos = <&qos_video_m1_r>,
> +                             <&qos_video_m1_w>;
> +                    #power-domain-cells = <0>;
> +                };
> +                power-domain@RK3399_PD_VIO {
> +                    reg = <RK3399_PD_VIO>;
> +                    #power-domain-cells = <1>;
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    power-domain@RK3399_PD_HDCP {
> +                        reg = <RK3399_PD_HDCP>;
> +                        clocks = <&cru ACLK_HDCP>,
> +                                 <&cru HCLK_HDCP>,
> +                                 <&cru PCLK_HDCP>;
> +                        pm_qos = <&qos_hdcp>;
> +                        #power-domain-cells = <0>;
> +                    };
> +                };
> +            };
> +        };
> +    };
