Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9C8205296
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 14:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbgFWMfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 08:35:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732553AbgFWMfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:35:21 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E6C9CBDEAA656743EC89;
        Tue, 23 Jun 2020 20:35:17 +0800 (CST)
Received: from [127.0.0.1] (10.67.76.251) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 23 Jun 2020
 20:35:11 +0800
Subject: Re: [PATCH] drivers/perf: hisi: Add identifier sysfs file
To:     John Garry <john.garry@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <qiangqing.zhang@nxp.com>,
        <jolsa@redhat.com>, <linuxarm@huawei.com>
References: <1592399111-134786-1-git-send-email-john.garry@huawei.com>
 <089b4276-a247-5d39-4227-32629d3ee888@hisilicon.com>
 <086e0fd0-590b-8a95-5ac9-9d585e8a3342@huawei.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <ae89e842-8bec-91f6-e758-a269c596ed5e@hisilicon.com>
Date:   Tue, 23 Jun 2020 20:35:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <086e0fd0-590b-8a95-5ac9-9d585e8a3342@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.76.251]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thanks your further explaination and I'm ok on it, so for this patch:

Acked-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Thanks,
Shaokun

在 2020/6/18 17:18, John Garry 写道:
> On 18/06/2020 02:40, Shaokun Zhang wrote:
>>> }
>>>   +    hha_pmu->identifier = readl(hha_pmu->base + HHA_VERSION);
>> Since we are now refactoring the PMU framework, the PMU version offset
>> is always the same except DDRC PMU and other uncore PMU modules will
>> also use this, how about we do it as the common code:
>>
>> #define HISI_PMU_VERSION_REG   0x1CF0
>> int hisi_uncore_pmu_version(struct hisi_pmu *hisi_pmu)
>> {
>>         return readl(hisi_pmu->base + HISI_PMU_VERSION_REG);
>> }
>> EXPORT_SYMBOL_GPL(hisi_uncore_pmu_version);
> 
> Hi Shaokun,
> 
> Some points to make:
> 
> - It's hardly worth having a separate function to do this 1-line readl()
> call, especially since it not even generic (DDRC is different)
> 
> - We would have to export it (or put in a common header file with static
> inline keywords) - less exports are good
> 
> - with factoring out common code, it's good to reduce total code - this
> change would increase it, AFAICS
> 
> - This is HW specific. The driver is currently layered such that all HW
> specific stuff is in the HW driver (like hisi_uncore_ddrc_pmu.c), and
> not library code (hisi_uncore_pmu.c). I don't see why you want to mix
> that, like you're proposing in the framework revision you proposed
> internally.
> 
> Thanks,
> John
> 
>>
>> hha_pmu->identifier = hisi_uncore_pmu_version(hha_pmu);
>> we can remove the duplicated PMU version register definition in each
>> module.
>>
>> Thanks,
>> Shaokun
>>
>>> +
>>>       return 0;
>>>   }
>>>   @@ -320,10 +323,23 @@ static const struct attribute_group
>>> hisi_hha_pmu_cpumask_attr_group = {
>>>       .attrs = hisi_hha_pmu_cpumask_attrs,
>>>   };
> 
> 
> .

