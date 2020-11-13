Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFA02B182F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 10:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKMJYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 04:24:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2099 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 04:24:52 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CXY174SvFz67LCL;
        Fri, 13 Nov 2020 17:23:23 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 13 Nov 2020 10:24:50 +0100
Received: from [10.47.88.104] (10.47.88.104) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 13 Nov
 2020 09:24:49 +0000
Subject: Re: [PATCH RFC v5 01/13] perf jevents: Add support for an extra
 directory level
To:     kajoljain <kjain@linux.ibm.com>, <acme@kernel.org>,
        <will@kernel.org>, <mark.rutland@arm.com>, <jolsa@redhat.com>,
        <irogers@google.com>, <leo.yan@linaro.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <qiangqing.zhang@nxp.com>,
        <zhangshaokun@hisilicon.com>, <linux-imx@nxp.com>
References: <1604666153-4187-1-git-send-email-john.garry@huawei.com>
 <1604666153-4187-2-git-send-email-john.garry@huawei.com>
 <61c23ae8-73d4-4616-38f5-f81dafbf5851@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3ca35e0f-e5e6-8616-0435-0f8e553df1f9@huawei.com>
Date:   Fri, 13 Nov 2020 09:24:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <61c23ae8-73d4-4616-38f5-f81dafbf5851@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.104]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2020 08:48, kajoljain wrote:
> 
> On 11/6/20 6:05 PM, John Garry wrote:
>> Currently only upto a level 2 directory is supported, in form
>> vendor/platform.
> Hi John,
>      Just want to check in case of sub directories,
> Will it be good add on/feasible to be able to include events of particular sub-directory for a
> platform? Otherwise with this patch in the end all event will be part of
> same pmu_event structure. So what is the purpose of sub directories? Let me know if I am missing something.

Hi Kajol Jain,

So currently we support both of the following structure:
arch/platform
arch/vendor/platform/

arch/vendor/platform/ is for an arch like arm, where the arch provider 
may not be the vendor.

I want to go one step further, to support also:
arch/vendor/platform/cpu
arch/vendor/platform/sys

Here we have separate folders for cpu and sys events. CPU events in 
"cpu" folder are added to pmu_events_map[], as before. And events in 
"sys" folder are added from patch 2/13 to new table pmu_sys_events_table[].

I hope it's clearer now.

Thanks,
John

> 
> Thanks,
> Kajol Jain
>> Add support for a further level, to support vendor/platform
>> sub-directories in future.

