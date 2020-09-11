Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F894267650
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 01:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgIKXDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 19:03:17 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42045 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgIKXC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 19:02:59 -0400
Received: by mail-il1-f196.google.com with SMTP id t13so10436578ile.9;
        Fri, 11 Sep 2020 16:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DRAR9Vlf/Eil1JIquqfcd9+7QFJ7fXC9J6FLqU5faTg=;
        b=U1DZONBfqC5wKyNEsyi0+/VOW/r96YVUwJwXsojhcs9brDzJMMmZuq3QLkXBHFVcd2
         VkG6Up9vn5UiG6xqv5k9kqaHbdYe7R8liQr0TH7L2MnHdcTeu+CN8Gw3YP6UKTdQYwvj
         TJETsGkgEgxe3sUuPYgjRRuMbYvJ1A93biw1ge4cZVCz8/W3yLGxT1TM77nZVHcaD+DT
         wp/EcrTXAElcLHowcf9pD5NzVDRqod1sIka7Pdjh3eMZ+8XbxOcbO/sHgAifzU+ppv6d
         t9FdFlS/YfWtkHstT4lg3M4djWX2KS+5+NTNVsS02kzPhW1j2lWl4tR15lsZggPSuwi4
         B/lg==
X-Gm-Message-State: AOAM5333AuXD4gedIrUHzO965Q8XYQcfQas8i35PO066M9wL/uyTeXbX
        itChWqvOgaJ1SdKmNC9zlw==
X-Google-Smtp-Source: ABdhPJyiOCSzRWKdX5VB5WxlES/eiFs1eKFXLi556PfER0yColMIC/T3LiuLIivE3sbFCb2pkr64Tw==
X-Received: by 2002:a92:d0c4:: with SMTP id y4mr3511853ila.298.1599865377542;
        Fri, 11 Sep 2020 16:02:57 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id q23sm1864341iob.19.2020.09.11.16.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 16:02:56 -0700 (PDT)
Received: (nullmailer pid 2983166 invoked by uid 1000);
        Fri, 11 Sep 2020 23:02:55 -0000
Date:   Fri, 11 Sep 2020 17:02:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 01/12] dt-bindings: power: Add bindings for the Mediatek
 SCPSYS power domains controller
Message-ID: <20200911230255.GA2972120@bogus>
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <20200910172826.3074357-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910172826.3074357-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 07:28:15PM +0200, Enric Balletbo i Serra wrote:
> The System Control Processor System (SCPSYS) has several power management
> related tasks in the system. Add the bindings to define the power
> domains for the SCPSYS power controller.
> 
> Co-developed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Dear Rob,
> 
> I am awasre that this binding is not ready, but I prefered to send because I'm
> kind of blocked. Compiling this binding triggers the following error:
> 
>     mediatek,power-controller.example.dt.yaml: syscon@10006000: mfg_async@7:
>     '#address-cells', '#size-cells', 'mfg_2d@8'
>     do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> This happens when a definition of a power-domain (parent) contains
> another power-domain (child), like the example. I am not sure how to
> specify this in the yaml and deal with this, so any clue is welcome.

You just have to keep nesting schemas all the way down. Define a 
grandchild node under the child node and then all of its properties.

> 
> Thanks,
>   Enric
> 
>  .../power/mediatek,power-controller.yaml      | 171 ++++++++++++++++++
>  1 file changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> new file mode 100644
> index 000000000000..8be9244ad160
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -0,0 +1,171 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Power Domains Controller
> +
> +maintainers:
> +  - Weiyi Lu <weiyi.lu@mediatek.com>
> +  - Matthias Brugger <mbrugger@suse.com>
> +
> +description: |
> +  Mediatek processors include support for multiple power domains which can be
> +  powered up/down by software based on different application scenes to save power.
> +
> +  IP cores belonging to a power domain should contain a 'power-domains'
> +  property that is a phandle for SCPSYS node representing the domain.
> +
> +properties:
> +  $nodename:
> +    pattern: "^syscon@[0-9a-f]+$"
> +
> +  compatible:
> +    items:
> +      - enum:
> +        - mediatek,mt8173-power-controller
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^.*@[0-9]$":

Node names should be generic:

power-domain@

> +    type: object
> +    description: |
> +      Represents the power domains within the power controller node as documented
> +      in Documentation/devicetree/bindings/power/power-domain.yaml.
> +
> +    properties:
> +      reg:
> +        description: |
> +          Power domain index. Valid values are defined in:
> +              "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
> +        maxItems: 1
> +
> +      '#power-domain-cells':
> +        description:
> +          Documented by the generic PM Domain bindings in
> +          Documentation/devicetree/bindings/power/power-domain.yaml.

No need to redefine a common property. This should define valid values 
for it.

> +
> +      clocks:
> +        description: |
> +          A number of phandles to clocks that need to be enabled during domain
> +          power-up sequencing.

No need to redefine 'clocks'. You need to define how many, what each one 
is, and the order.

> +
> +      clock-names:
> +        description: |
> +          List of names of clocks, in order to match the power-up sequencing
> +          for each power domain we need to group the clocks by name. BASIC
> +          clocks need to be enabled before enabling the corresponding power
> +          domain, and should not have a '-' in their name (i.e mm, mfg, venc).
> +          SUSBYS clocks need to be enabled before releasing the bus protection,
> +          and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
> +
> +          In order to follow properly the power-up sequencing, the clocks must
> +          be specified by order, adding first the BASIC clocks followed by the
> +          SUSBSYS clocks.

You need to define the names.

> +
> +      mediatek,infracfg:
> +        $ref: /schemas/types.yaml#definitions/phandle
> +        description: phandle to the device containing the INFRACFG register range.
> +
> +      mediatek,smi:
> +        $ref: /schemas/types.yaml#definitions/phandle
> +        description: phandle to the device containing the SMI register range.
> +
> +    required:
> +      - reg
> +      - '#power-domain-cells'
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +    #include <dt-bindings/power/mt8173-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        scpsys: syscon@10006000 {
> +            compatible = "mediatek,mt8173-power-controller", "syscon";
> +            reg = <0 0x10006000 0 0x1000>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            /* power domains of the SoC */
> +            vdec@MT8173_POWER_DOMAIN_VDEC {
> +                reg = <MT8173_POWER_DOMAIN_VDEC>;
> +                clocks = <&topckgen CLK_TOP_MM_SEL>;
> +                clock-names = "mm";
> +                #power-domain-cells = <0>;
> +            };
> +
> +            venc@MT8173_POWER_DOMAIN_VENC {
> +                reg = <MT8173_POWER_DOMAIN_VENC>;
> +                clocks = <&topckgen CLK_TOP_MM_SEL>,
> +                         <&topckgen CLK_TOP_VENC_SEL>;
> +                clock-names = "mm", "venc";
> +                #power-domain-cells = <0>;
> +            };
> +            isp@MT8173_POWER_DOMAIN_ISP {
> +                reg = <MT8173_POWER_DOMAIN_ISP>;
> +                clocks = <&topckgen CLK_TOP_MM_SEL>;
> +                clock-names = "mm";
> +                #power-domain-cells = <0>;
> +            };
> +            mm@MT8173_POWER_DOMAIN_MM {
> +                reg = <MT8173_POWER_DOMAIN_MM>;
> +                clocks = <&topckgen CLK_TOP_MM_SEL>;
> +                clock-names = "mm";
> +                #power-domain-cells = <0>;
> +                mediatek,infracfg = <&infracfg>;
> +            };
> +            venc_lt@MT8173_POWER_DOMAIN_VENC_LT {
> +                reg = <MT8173_POWER_DOMAIN_VENC_LT>;
> +                clocks = <&topckgen CLK_TOP_MM_SEL>,
> +                         <&topckgen CLK_TOP_VENC_LT_SEL>;
> +                clock-names = "mm", "venclt";
> +                #power-domain-cells = <0>;
> +            };
> +            audio@MT8173_POWER_DOMAIN_AUDIO {
> +                reg = <MT8173_POWER_DOMAIN_AUDIO>;
> +                #power-domain-cells = <0>;
> +            };
> +            usb@MT8173_POWER_DOMAIN_USB {
> +                reg = <MT8173_POWER_DOMAIN_USB>;
> +                #power-domain-cells = <0>;
> +            };
> +            mfg_async@MT8173_POWER_DOMAIN_MFG_ASYNC {
> +                reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
> +                clocks = <&clk26m>;
> +                clock-names = "mfg";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                #power-domain-cells = <1>;
> +
> +                mfg_2d@MT8173_POWER_DOMAIN_MFG_2D {
> +                    reg = <MT8173_POWER_DOMAIN_MFG_2D>;
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                    #power-domain-cells = <1>;
> +
> +                    mfg@MT8173_POWER_DOMAIN_MFG {
> +                        reg = <MT8173_POWER_DOMAIN_MFG>;
> +                        #power-domain-cells = <0>;
> +                        mediatek,infracfg = <&infracfg>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.28.0
> 
