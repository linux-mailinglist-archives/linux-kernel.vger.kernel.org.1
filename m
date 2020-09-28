Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E60427AD79
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgI1MFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:05:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50624 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbgI1MFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:05:47 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 261F75B7C094076B8000;
        Mon, 28 Sep 2020 20:05:45 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 20:05:38 +0800
Subject: Re: [PATCH v3 03/21] dt-bindings: arm: hisilicon: convert Hisilicon
 board/soc bindings to json-schema
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200927062129.4573-1-thunder.leizhen@huawei.com>
 <20200927062129.4573-4-thunder.leizhen@huawei.com>
CC:     Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5F71D192.8070105@hisilicon.com>
Date:   Mon, 28 Sep 2020 20:05:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20200927062129.4573-4-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen Lei,

Thanks!

On 2020/9/27 14:21, Zhen Lei wrote:
> Convert Hisilicon SoC bindings to DT schema format using json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../bindings/arm/hisilicon/hisilicon.txt           | 57 ----------------
>  .../bindings/arm/hisilicon/hisilicon.yaml          | 77 ++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> deleted file mode 100644
> index f7e52476f5f2f3c..000000000000000
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -Hisilicon Platforms Device Tree Bindings
> -----------------------------------------------------
> -Hi3660 SoC
> -Required root node properties:
> -	- compatible = "hisilicon,hi3660";
> -
> -HiKey960 Board
> -Required root node properties:
> -	- compatible = "hisilicon,hi3660-hikey960", "hisilicon,hi3660";
> -
> -Hi3670 SoC
> -Required root node properties:
> -	- compatible = "hisilicon,hi3670";
> -
> -HiKey970 Board
> -Required root node properties:
> -	- compatible = "hisilicon,hi3670-hikey970", "hisilicon,hi3670";
> -
> -Hi3798cv200 SoC
> -Required root node properties:
> -	- compatible = "hisilicon,hi3798cv200";
> -
> -Hi3798cv200 Poplar Board
> -Required root node properties:
> -	- compatible = "hisilicon,hi3798cv200-poplar", "hisilicon,hi3798cv200";
> -
> -Hi4511 Board
> -Required root node properties:
> -	- compatible = "hisilicon,hi3620-hi4511";
> -
> -Hi6220 SoC
> -Required root node properties:
> -	- compatible = "hisilicon,hi6220";
> -
> -HiKey Board
> -Required root node properties:
> -	- compatible = "hisilicon,hi6220-hikey", "hisilicon,hi6220";
> -
> -HiP01 ca9x2 Board
> -Required root node properties:
> -	- compatible = "hisilicon,hip01-ca9x2";
> -
> -HiP04 D01 Board
> -Required root node properties:
> -	- compatible = "hisilicon,hip04-d01";
> -
> -HiP05 D02 Board
> -Required root node properties:
> -	- compatible = "hisilicon,hip05-d02";
> -
> -HiP06 D03 Board
> -Required root node properties:
> -	- compatible = "hisilicon,hip06-d03";
> -
> -HiP07 D05 Board
> -Required root node properties:
> -	- compatible = "hisilicon,hip07-d05";
> \ No newline at end of file
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
> new file mode 100644
> index 000000000000000..362decf3b85c6fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/hisilicon/hisilicon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Wei Xu <xuwei5@hisilicon.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +
> +  compatible:
> +    oneOf:
> +      - description: Hi3660 SoC
> +        items:
> +          - const: hisilicon,hi3660
> +
> +      - description: HiKey960 Board
> +        items:
> +          - const: hisilicon,hi3660-hikey960
> +          - const: hisilicon,hi3660

How about to use the boards with SoC to reduce some duplication like following?

         - description: Boards with the Hisilicon hi3660 SoC
           items:
             - enum:
                 - hisilicon,hi3660-hikey960
             - const: hisilicon,hi3660

And in this case, there is no need to remove the "hisilicon,hip01" as the first patch.

Best Regards,
Wei

> +
> +      - description: Hi3670 SoC
> +        items:
> +          - const: hisilicon,hi3670
> +
> +      - description: HiKey970 Board
> +        items:
> +          - const: hisilicon,hi3670-hikey970
> +          - const: hisilicon,hi3670
> +
> +      - description: Hi3798cv200 SoC
> +        items:
> +          - const: hisilicon,hi3798cv200
> +
> +      - description: Hi3798cv200 Poplar Board
> +        items:
> +          - const: hisilicon,hi3798cv200-poplar
> +          - const: hisilicon,hi3798cv200
> +
> +      - description: Hi4511 Board
> +        items:
> +          - const: hisilicon,hi3620-hi4511
> +
> +      - description: Hi6220 SoC
> +        items:
> +          - const: hisilicon,hi6220
> +
> +      - description: HiKey Board
> +        items:
> +          - const: hisilicon,hi6220-hikey
> +          - const: hisilicon,hi6220
> +
> +      - description: HiP01 ca9x2 Board
> +        items:
> +          - const: hisilicon,hip01-ca9x2
> +
> +      - description: HiP04 D01 Board
> +        items:
> +          - const: hisilicon,hip04-d01
> +
> +      - description: HiP05 D02 Board
> +        items:
> +          - const: hisilicon,hip05-d02
> +
> +      - description: HiP06 D03 Board
> +        items:
> +          - const: hisilicon,hip06-d03
> +
> +      - description: HiP07 D05 Board
> +        items:
> +          - const: hisilicon,hip07-d05
> +...
> 	
