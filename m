Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935A32FE912
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbhAULls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:41:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11423 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbhAULk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:40:29 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DM0lJ6bCLzj9Kr;
        Thu, 21 Jan 2021 19:38:36 +0800 (CST)
Received: from [10.67.77.175] (10.67.77.175) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Jan 2021
 19:39:21 +0800
Subject: Re: [PATCH v2 1/3] perf vendor events: Add cache refill and DCZVA
 events
To:     Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>,
        <john.garry@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <leo.yan@linaro.org>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
 <20210121105425.2695843-2-nakamura.shun@jp.fujitsu.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <b00bf252-e31f-b0eb-d0aa-0a62bcaee22e@hisilicon.com>
Date:   Thu, 21 Jan 2021 19:39:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20210121105425.2695843-2-nakamura.shun@jp.fujitsu.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.77.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2021/1/21 18:54, Shunsuke Nakamura Ð´µÀ:
> Adds L1 data cache refill prefetch, L2 data cache refill prefetch, 
> and DCZVA instruction events.

A silly question, Does Arm define these events? I checked Arm ARM
document(DDI0487Fc) that these event numbers are reserved. Or maybe
I miss something.

Thanks,
Shaokun

> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
> ---
>  .../perf/pmu-events/arch/arm64/armv8-recommended.json  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/armv8-recommended.json b/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
> index d0a1986..ee0e67d 100644
> --- a/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
> +++ b/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
> @@ -54,6 +54,12 @@
>          "BriefDescription": "L1D cache invalidate"
>      },
>      {
> +        "PublicDescription": "This event counts L1D_CACHE_REFILL caused by software or hardware prefetch.",
> +        "EventCode": "0x49",
> +        "EventName": "L1D_CACHE_REFILL_PRF",
> +        "BriefDescription": "This event counts L1D_CACHE_REFILL caused by software or hardware prefetch."
> +    },
> +    {
>          "PublicDescription": "Attributable Level 1 data TLB refill, read",
>          "EventCode": "0x4C",
>          "EventName": "L1D_TLB_REFILL_RD",
> @@ -120,6 +126,12 @@
>          "BriefDescription": "L2D cache invalidate"
>      },
>      {
> +        "PublicDescription": "This event counts L2D_CACHE_REFILL caused by software or hardware prefetch.",
> +        "EventCode": "0x59",
> +        "EventName": "L2D_CACHE_REFILL_PRF",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL caused by software or hardware prefetch."
> +    },
> +    {
>          "PublicDescription": "Attributable Level 2 data or unified TLB refill, read",
>          "EventCode": "0x5c",
>          "EventName": "L2D_TLB_REFILL_RD",
> @@ -408,6 +420,12 @@
>          "BriefDescription": "Release consistency operation speculatively executed, Store-Release"
>     },
>     {
> +         "PublicDescription": "This event counts architecturally executed zero blocking operations due to the 'DC ZVA' instruction.",
> +         "EventCode": "0x9f",
> +         "EventName": "DCZVA_SPEC",
> +         "BriefDescription": "This event counts architecturally executed zero blocking operations due to the 'DC ZVA' instruction."
> +   },
> +   {
>          "PublicDescription": "Attributable Level 3 data or unified cache access, read",
>          "EventCode": "0xa0",
>          "EventName": "L3D_CACHE_RD",
> 
