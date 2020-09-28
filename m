Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F9B27AB21
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgI1Jsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:48:30 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2923 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbgI1Js3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:48:29 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 81FBC5EA687BE95948BF;
        Mon, 28 Sep 2020 10:48:28 +0100 (IST)
Received: from localhost (10.52.126.2) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 28 Sep
 2020 10:48:28 +0100
Date:   Mon, 28 Sep 2020 10:46:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
CC:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Libin <huawei.libin@huawei.com>
Subject: Re: [PATCH v3 10/21] dt-bindings: arm: hisilicon: convert
 hisilicon, pcie-sas-subctrl bindings to json-schema
Message-ID: <20200928104646.000073ce@Huawei.com>
In-Reply-To: <20200927062129.4573-11-thunder.leizhen@huawei.com>
References: <20200927062129.4573-1-thunder.leizhen@huawei.com>
        <20200927062129.4573-11-thunder.leizhen@huawei.com>
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

On Sun, 27 Sep 2020 14:21:18 +0800
Zhen Lei <thunder.leizhen@huawei.com> wrote:

> Convert the Hisilicon HiP05/HiP06 PCIe-SAS subsystem controller binding
> to DT schema format using json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

One small thing inline to fix.

Jonathan

> ---
>  .../controller/hisilicon,pcie-sas-subctrl.txt      | 15 ---------
>  .../controller/hisilicon,pcie-sas-subctrl.yaml     | 37 ++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
> deleted file mode 100644
> index 43efdaf408f6fe1..000000000000000
> --- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -Hisilicon HiP05/HiP06 PCIe-SAS sub system controller
> -
> -Required properties:
> -- compatible : "hisilicon,pcie-sas-subctrl", "syscon";
> -- reg : Register address and size
> -
> -The PCIe-SAS sub system controller is shared by PCIe and SAS controllers in
> -HiP05 or HiP06 Soc to implement some basic configurations.
> -
> -Example:
> -	/* for HiP05 PCIe-SAS sub system */
> -	pcie_sas: system_controller@b0000000 {
> -		compatible = "hisilicon,pcie-sas-subctrl", "syscon";
> -		reg = <0xb0000000 0x10000>;
> -	};
> \ No newline at end of file
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml
> new file mode 100644
> index 000000000000000..8d1341022de587d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon HiP05/HiP06 PCIe-SAS subsystem controller
> +
> +maintainers:
> +  - Wei Xu <xuwei5@hisilicon.com>
> +
> +description: |
> +  The PCIe-SAS sub system controller is shared by PCIe and SAS controllers in
> +  HiP05 or HiP06 Soc to implement some basic configurations.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: hisilicon,pcie-sas-subctrl
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
> +    /* for HiP05 PCIe-SAS sub system */
> +    pcie_sas: system_controller@b0000000 {
> +        compatible = "hisilicon,pcie-sas-subctrl", "syscon";
> +        reg = <0xb0000000 0x10000>;
> +    };
> +...
> \ No newline at end of file

Trivial, but fix that by adding one.

Jonathan


