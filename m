Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107141FEE7F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 11:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgFRJUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 05:20:10 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2324 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728995AbgFRJUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:20:09 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id F2C18BCA44432416FAA3;
        Thu, 18 Jun 2020 10:20:07 +0100 (IST)
Received: from [127.0.0.1] (10.210.165.247) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Thu, 18 Jun
 2020 10:20:07 +0100
Subject: Re: [PATCH] drivers/perf: hisi: Add identifier sysfs file
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <qiangqing.zhang@nxp.com>,
        <jolsa@redhat.com>, <linuxarm@huawei.com>
References: <1592399111-134786-1-git-send-email-john.garry@huawei.com>
 <089b4276-a247-5d39-4227-32629d3ee888@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <086e0fd0-590b-8a95-5ac9-9d585e8a3342@huawei.com>
Date:   Thu, 18 Jun 2020 10:18:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <089b4276-a247-5d39-4227-32629d3ee888@hisilicon.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.165.247]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2020 02:40, Shaokun Zhang wrote:
>> }
>>   
>> +	hha_pmu->identifier = readl(hha_pmu->base + HHA_VERSION);
> Since we are now refactoring the PMU framework, the PMU version offset
> is always the same except DDRC PMU and other uncore PMU modules will
> also use this, how about we do it as the common code:
> 
> #define HISI_PMU_VERSION_REG   0x1CF0
> int hisi_uncore_pmu_version(struct hisi_pmu *hisi_pmu)
> {
>         return readl(hisi_pmu->base + HISI_PMU_VERSION_REG);
> }
> EXPORT_SYMBOL_GPL(hisi_uncore_pmu_version);

Hi Shaokun,

Some points to make:

- It's hardly worth having a separate function to do this 1-line readl() 
call, especially since it not even generic (DDRC is different)

- We would have to export it (or put in a common header file with static 
inline keywords) - less exports are good

- with factoring out common code, it's good to reduce total code - this 
change would increase it, AFAICS

- This is HW specific. The driver is currently layered such that all HW 
specific stuff is in the HW driver (like hisi_uncore_ddrc_pmu.c), and 
not library code (hisi_uncore_pmu.c). I don't see why you want to mix 
that, like you're proposing in the framework revision you proposed 
internally.

Thanks,
John

> 
> hha_pmu->identifier = hisi_uncore_pmu_version(hha_pmu);
> we can remove the duplicated PMU version register definition in each module.
> 
> Thanks,
> Shaokun
> 
>> +
>>   	return 0;
>>   }
>>   
>> @@ -320,10 +323,23 @@ static const struct attribute_group hisi_hha_pmu_cpumask_attr_group = {
>>   	.attrs = hisi_hha_pmu_cpumask_attrs,
>>   };

