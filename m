Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7054427AB33
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgI1Jwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:52:33 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2924 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726513AbgI1Jwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:52:33 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id F15ECFFB7E0B9848BF89;
        Mon, 28 Sep 2020 10:52:31 +0100 (IST)
Received: from localhost (10.52.126.2) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 28 Sep
 2020 10:52:31 +0100
Date:   Mon, 28 Sep 2020 10:50:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
CC:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Libin <huawei.libin@huawei.com>
Subject: Re: [PATCH v3 20/21] dt-bindings: arm: hisilicon: convert
 hisilicon, hi6220-sramctrl bindings to json-schema
Message-ID: <20200928105050.0000395f@Huawei.com>
In-Reply-To: <20200927062129.4573-21-thunder.leizhen@huawei.com>
References: <20200927062129.4573-1-thunder.leizhen@huawei.com>
        <20200927062129.4573-21-thunder.leizhen@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.2]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Sep 2020 14:21:28 +0800
Zhen Lei <thunder.leizhen@huawei.com> wrote:

> Convert the Hisilicon Hi6220 SRAM controller binding to DT schema format
> using json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../hi3620/hisilicon,hi6220-sramctrl.txt           | 16 ---------
>  .../hi3620/hisilicon,hi6220-sramctrl.yaml          | 38 ++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.txt
> deleted file mode 100644
> index 963a2cb13a249d9..000000000000000
> --- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -Hisilicon Hi6220 SRAM controller
> -
> -Required properties:
> -- compatible : "hisilicon,hi6220-sramctrl", "syscon"
> -- reg : Register address and size
> -
> -Hisilicon's SoCs use sram for multiple purpose; on Hi6220 there have several
> -SRAM banks for power management, modem, security, etc. Further, use "syscon"
> -managing the common sram which can be shared by multiple modules.
> -
> -Example:
> -	/*for Hi6220*/
> -	sram: sram@fff80000 {
> -		compatible = "hisilicon,hi6220-sramctrl", "syscon";
> -		reg = <0x0 0xfff80000 0x0 0x12000>;
> -	};
> \ No newline at end of file
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.yaml
> new file mode 100644
> index 000000000000000..f66d414a7a48071
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon Hi6220 SRAM controller
> +
> +maintainers:
> +  - Wei Xu <xuwei5@hisilicon.com>
> +
> +description: |
> +  Hisilicon's SoCs use sram for multiple purpose; on Hi6220 there have several

SRAM for consistency

> +  SRAM banks for power management, modem, security, etc. Further, use "syscon"
> +  managing the common sram which can be shared by multiple modules.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: hisilicon,hi6220-sramctrl
> +      - const: syscon
> +
> +  reg:
> +    description: Register address and size
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    /* for Hi6220 */
> +    sram: sram@fff80000 {
> +        compatible = "hisilicon,hi6220-sramctrl", "syscon";
> +        reg = <0xfff80000 0x12000>;
> +    };
> +...
> \ No newline at end of file

As per other files that have this, please add one.



