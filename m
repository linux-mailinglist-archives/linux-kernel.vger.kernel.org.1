Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B5A2D1E24
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgLGXLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:11:38 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:45030 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLGXLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:11:38 -0500
Received: by mail-oo1-f68.google.com with SMTP id i13so3609821oou.11;
        Mon, 07 Dec 2020 15:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dfskF783ia3OMw4OOOrEJp2Y2XtFdH1x7H9M26RfBPo=;
        b=o5V0QWSQUAFJwtldj90D+M7MreQ+yEeY8x6ctX8g+Ur0XtAZTA3/uatYIdonxLXv2J
         U/2c+3AidwfqWJfZWs9ghtAFiGJK1tVgLp1OYniUX76jyVTAUQ1lglgw43O6OjCl6V71
         cxD2sYOIBn0EIRhmYAf3AV+obsNAUvvcT+YTYclCyQoQoTvEge7UE/RMlHBnbG3NuWvM
         dvgNFVZz4kKG/pw4pnngL1WMfBziiNitASX0b29nVQM65cnNFjsSrkyPPrbT53fjzra+
         a/dUchV6F3vESFmk9lSbdMUicvpWQUBQtPGrf6ClcrFtcHhLNcYh4hSeNsqsc4+z2Jte
         lItg==
X-Gm-Message-State: AOAM530gxAf8ah/wwjiNPf4gYUkzOwq5c7nFUcq8PRiYgzwp32tuRlDg
        GzdzrYFr0QxrzfvolsDDOg==
X-Google-Smtp-Source: ABdhPJy3SHc3uf9CAtctVkktZ0wF0cHaP6H6KTIyGar9W/HK75hIYztUzZg+9WfTtm3MZ5haFQNiLw==
X-Received: by 2002:a4a:a785:: with SMTP id l5mr14519981oom.83.1607382656883;
        Mon, 07 Dec 2020 15:10:56 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k3sm1677318oor.19.2020.12.07.15.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 15:10:55 -0800 (PST)
Received: (nullmailer pid 1024898 invoked by uid 1000);
        Mon, 07 Dec 2020 23:10:55 -0000
Date:   Mon, 7 Dec 2020 17:10:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: reset: convert Hisilicon reset
 controller bindings to json-schema
Message-ID: <20201207231055.GA1021342@robh.at.kernel.org>
References: <20201204014236.1158-1-thunder.leizhen@huawei.com>
 <20201204014236.1158-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204014236.1158-4-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 09:42:36AM +0800, Zhen Lei wrote:
> Convert the Hisilicon reset controller binding to DT schema format using
> json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../bindings/reset/hisilicon,hi3660-reset.txt      | 44 -------------
>  .../bindings/reset/hisilicon,hi3660-reset.yaml     | 77 ++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
> deleted file mode 100644
> index aefd26710f9e87d..000000000000000
> --- a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -Hisilicon System Reset Controller
> -======================================
> -
> -Please also refer to reset.txt in this directory for common reset
> -controller binding usage.
> -
> -The reset controller registers are part of the system-ctl block on
> -hi3660 and hi3670 SoCs.
> -
> -Required properties:
> -- compatible: should be one of the following:
> -		 "hisilicon,hi3660-reset" for HI3660
> -		 "hisilicon,hi3670-reset", "hisilicon,hi3660-reset" for HI3670
> -- hisilicon,rst-syscon: phandle of the reset's syscon.
> -- #reset-cells : Specifies the number of cells needed to encode a
> -  reset source.  The type shall be a <u32> and the value shall be 2.
> -
> -	 Cell #1 : offset of the reset assert control
> -	           register from the syscon register base
> -		   offset + 4: deassert control register
> -		   offset + 8: status control register
> -	 Cell #2 : bit position of the reset in the reset control register
> -
> -Example:
> -	iomcu: iomcu@ffd7e000 {
> -		compatible = "hisilicon,hi3660-iomcu", "syscon";
> -		reg = <0x0 0xffd7e000 0x0 0x1000>;
> -	};
> -
> -	iomcu_rst: iomcu_rst_controller {
> -		compatible = "hisilicon,hi3660-reset";
> -		hisilicon,rst-syscon = <&iomcu>;
> -		#reset-cells = <2>;
> -	};
> -
> -Specifying reset lines connected to IP modules
> -==============================================
> -example:
> -
> -        i2c0: i2c@..... {
> -                ...
> -		resets = <&iomcu_rst 0x20 3>; /* offset: 0x20; bit: 3 */
> -                ...
> -        };
> diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
> new file mode 100644
> index 000000000000000..9bf40952e5b7d28
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/hisilicon,hi3660-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon System Reset Controller
> +
> +maintainers:
> +  - Wei Xu <xuwei5@hisilicon.com>
> +
> +description: |
> +  Please also refer to reset.txt in this directory for common reset
> +  controller binding usage.
> +  The reset controller registers are part of the system-ctl block on
> +  hi3660 and hi3670 SoCs.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: hisilicon,hi3660-reset
> +      - items:
> +          - const: hisilicon,hi3670-reset
> +          - const: hisilicon,hi3660-reset
> +
> +  hisilicon,rst-syscon:
> +    description: phandle of the reset's syscon.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  '#reset-cells':
> +    description: |
> +      Specifies the number of cells needed to encode a reset source.
> +      Cell #1 : offset of the reset assert control register from the syscon
> +                register base
> +                offset + 4: deassert control register
> +                offset + 8: status control register
> +      Cell #2 : bit position of the reset in the reset control register
> +    const: 2
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/hi3660-clock.h>
> +
> +    iomcu: iomcu@ffd7e000 {
> +        compatible = "hisilicon,hi3660-iomcu", "syscon";
> +        reg = <0xffd7e000 0x1000>;
> +    };
> +
> +    iomcu_rst: iomcu_rst_controller {
> +        compatible = "hisilicon,hi3660-reset";
> +        hisilicon,rst-syscon = <&iomcu>;

Really, if you are going to break things, this node should be a child of 
iomcu instead and you don't need this property (just get the parent). Or 
just add '#reset-cells' to iomcu.

> +        #reset-cells = <2>;
> +    };
> +
> +    /* Specifying reset lines connected to IP modules */
> +    i2c@ffd71000 {
> +        compatible = "snps,designware-i2c";
> +        reg = <0xffd71000 0x1000>;
> +        interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        clock-frequency = <400000>;
> +        clocks = <&crg_ctrl HI3660_CLK_GATE_I2C0>;
> +        resets = <&iomcu_rst 0x20 3>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
> +        status = "disabled";
> +    };
> +...
> -- 
> 1.8.3
> 
> 
