Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F79A220AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 13:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgGOLFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 07:05:25 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2482 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728385AbgGOLFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:05:24 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 20E62B0F8FE8CB1CFE7A;
        Wed, 15 Jul 2020 12:05:22 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.38) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 15 Jul
 2020 12:05:21 +0100
Subject: Re: [PATCH V1 RESEND 2/3] bindings/perf/imx-ddr: update compatible
 string
To:     Joakim Zhang <qiangqing.zhang@nxp.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <shawnguo@kernel.org>
CC:     <linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-3-qiangqing.zhang@nxp.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1f530ea9-c294-64ec-fd10-54129e0b4845@huawei.com>
Date:   Wed, 15 Jul 2020 12:03:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200512073115.14177-3-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.38]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2020 08:31, Joakim Zhang wrote:
> Update compatible string according to driver change.`
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>   Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> index 7822a806ea0a..b27a1d4fec78 100644
> --- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> @@ -4,7 +4,9 @@ Required properties:
>   

Hi Joakim,

>   - compatible: should be one of:
>   	"fsl,imx8-ddr-pmu"
> -	"fsl,imx8m-ddr-pmu"
> +	"fsl,imx8mq-ddr-pmu"
> +	"fsl,imx8mm-ddr-pmu"

I noticed that some of the compat strings being added are used in imx 
dtsi files today:

john@localhost:~/linux> git grep "fsl,imx8mm-ddr-pmu"
arch/arm64/boot/dts/freescale/imx8mm.dtsi:  compatible = 
"fsl,imx8mm-ddr-pmu", "fsl,imx8m-ddr-pmu";

Any specific reason why they are not described in the dt bindings already?

I don't follow dt so much anymore, so don't know the policies.

> +	"fsl,imx8mn-ddr-pmu"

Thanks,
John

