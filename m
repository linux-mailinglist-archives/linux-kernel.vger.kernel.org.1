Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749122B8BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgKSGaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgKSGaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:30:18 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9E2246A5;
        Thu, 19 Nov 2020 06:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605767417;
        bh=pbjxqJYxs2h8BKkAMHOF56IVNV1ESX5tvFquYGytkEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aEYl0IHIOk31cTSJJ33KRpfnbntJx8l+QTGsS9jUfrpNznR4Iczlq3e5cNKxzS5tV
         IkfMntJXEeyQYfmRzuo05byZ5O4au3MNXgBiT6fqDh8voZF+vaBf/hrU4O+/Pp/IZk
         2DDA04kWGoTrijPouW4YvNqf/9AYqRsx/conNW3o=
Date:   Thu, 19 Nov 2020 12:00:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: phy: bcm-ns-usb3-phy: convert to yaml
Message-ID: <20201119063012.GF50232@vkoul-mobl>
References: <20201116074650.16070-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201116074650.16070-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-20, 08:46, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Change syntax from txt to yaml
> 2. Drop "Driver for" from the title
> 3. Drop "reg = <0x0>;" from example (noticed by dt_binding_check)
> 4. Specify license

You missed Ccing Rob

> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> I think this should go through linux-phy tree. Kishon, Vinod, can you
> take this patch?
> 
> This patch generates a false positive checkpatch.pl warning [0].
> Please ignore:
> WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

That is okay, it is a warning ;-)

> 
> [0] https://lkml.org/lkml/2020/2/18/1084
> ---
>  .../bindings/phy/bcm-ns-usb3-phy.txt          | 34 ----------
>  .../bindings/phy/bcm-ns-usb3-phy.yaml         | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt b/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
> deleted file mode 100644
> index 32f057260351..000000000000
> --- a/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -Driver for Broadcom Northstar USB 3.0 PHY
> -
> -Required properties:
> -
> -- compatible: one of: "brcm,ns-ax-usb3-phy", "brcm,ns-bx-usb3-phy".
> -- reg: address of MDIO bus device
> -- usb3-dmp-syscon: phandle to syscon with DMP (Device Management Plugin)
> -		   registers
> -- #phy-cells: must be 0
> -
> -Initialization of USB 3.0 PHY depends on Northstar version. There are currently
> -three known series: Ax, Bx and Cx.
> -Known A0: BCM4707 rev 0
> -Known B0: BCM4707 rev 4, BCM53573 rev 2
> -Known B1: BCM4707 rev 6
> -Known C0: BCM47094 rev 0
> -
> -Example:
> -	mdio: mdio@0 {
> -		reg = <0x0>;
> -		#size-cells = <1>;
> -		#address-cells = <0>;
> -
> -		usb3-phy@10 {
> -			compatible = "brcm,ns-ax-usb3-phy";
> -			reg = <0x10>;
> -			usb3-dmp-syscon = <&usb3_dmp>;
> -			#phy-cells = <0>;
> -		};
> -	};
> -
> -	usb3_dmp: syscon@18105000 {
> -		reg = <0x18105000 0x1000>;
> -	};
> diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml
> new file mode 100644
> index 000000000000..7fd419db45d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/bcm-ns-usb3-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Northstar USB 3.0 PHY
> +
> +description: |
> +  Initialization of USB 3.0 PHY depends on Northstar version. There are currently
> +  three known series: Ax, Bx and Cx.
> +  Known A0: BCM4707 rev 0
> +  Known B0: BCM4707 rev 4, BCM53573 rev 2
> +  Known B1: BCM4707 rev 6
> +  Known C0: BCM47094 rev 0
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,ns-ax-usb3-phy
> +      - brcm,ns-bx-usb3-phy
> +
> +  reg:
> +    description: address of MDIO bus device
> +    maxItems: 1
> +
> +  usb3-dmp-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the DMP (Device Management Plugin) syscon
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - usb3-dmp-syscon
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        usb3-phy@10 {
> +            compatible = "brcm,ns-ax-usb3-phy";
> +            reg = <0x10>;
> +            usb3-dmp-syscon = <&usb3_dmp>;
> +            #phy-cells = <0>;
> +        };
> +    };
> +
> +    usb3_dmp: syscon@18105000 {
> +        reg = <0x18105000 0x1000>;
> +    };
> -- 
> 2.27.0

-- 
~Vinod
