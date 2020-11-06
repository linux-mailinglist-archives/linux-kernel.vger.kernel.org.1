Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EF92A970D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 14:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgKFNhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 08:37:05 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2064 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgKFNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 08:37:04 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CSLx93FMhz67Grv;
        Fri,  6 Nov 2020 21:35:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 6 Nov 2020 14:37:02 +0100
Received: from [10.47.7.5] (10.47.7.5) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 6 Nov 2020
 13:37:01 +0000
Subject: Re: [PATCH v2 0/4] perf drivers: Add sysfs identifier file
To:     <Frank.li@nxp.com>, <will@kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <zhangshaokun@hisilicon.com>,
        <qiangqing.zhang@nxp.com>
CC:     <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <acme@kernel.org>,
        <jolsa@redhat.com>, <irogers@google.com>
References: <1602149181-237415-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6b6b96d0-19c7-8be7-5742-ed01b5b891cc@huawei.com>
Date:   Fri, 6 Nov 2020 13:36:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1602149181-237415-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.7.5]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2020 10:26, John Garry wrote:

Hi Will, Mark,

Can you have a look at this series please?

You were cc'ed on the v5 rebase of the userspace part which I sent out a 
little while ago.

Cheers,
John

> To allow perf tool to identify a specific implementation of a PMU for
> event alias matching and metric support, expose a per-PMU identifier file.
> 
> There is no standard format for the identifier string. It just should be
> unique per HW implementation.
> 
> Typical methods to retrieve the information for the identifier string
> can include:
> - Hardcoding in the driver, matched via DT bindings compat string,
>    ACPI HID, or similar
> - Directly from DT bindings property
> - Read from some HW identification register
> 
> In this series, for the SMMUv3 PMU and HiSi uncore drivers, a HW ID
> register is read for the identifier. For the imx8 ddr driver, the
> identifier is hardcoded, matched via DT compat string.
> 
> Joakim Zhang (2):
>    bindings/perf/imx-ddr: update compatible string
>    perf/imx_ddr: Add system PMU identifier for userspace
> 
> John Garry (2):
>    drivers/perf: hisi: Add identifier sysfs file
>    perf/smmuv3: Support sysfs identifier file
> 
>   .../devicetree/bindings/perf/fsl-imx-ddr.txt  |  3 ++
>   drivers/perf/arm_smmuv3_pmu.c                 | 39 ++++++++++++++++
>   drivers/perf/fsl_imx8_ddr_perf.c              | 45 +++++++++++++++++--
>   drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 16 +++++++
>   drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 16 +++++++
>   drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 16 +++++++
>   drivers/perf/hisilicon/hisi_uncore_pmu.c      | 10 +++++
>   drivers/perf/hisilicon/hisi_uncore_pmu.h      |  7 +++
>   8 files changed, 149 insertions(+), 3 deletions(-)
> 

