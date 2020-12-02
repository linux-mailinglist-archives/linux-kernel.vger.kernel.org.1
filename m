Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA022CBC38
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgLBMA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:00:58 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2388 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLBMA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:00:57 -0500
Received: from dggeme717-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CmHZg5wvfz50gV;
        Wed,  2 Dec 2020 19:59:39 +0800 (CST)
Received: from [10.174.186.123] (10.174.186.123) by
 dggeme717-chm.china.huawei.com (10.1.199.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 2 Dec 2020 20:00:12 +0800
Subject: Re: [PATCH v2 0/3] Fix several bugs in KVM stage 2 translation
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Quentin Perret <qperret@google.com>,
        <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <zhukeqian1@huawei.com>, <yuzenghui@huawei.com>,
        <jiangkunkun@huawei.com>, <wangjingyi11@huawei.com>,
        <lushenming@huawei.com>
References: <20201201201034.116760-1-wangyanan55@huawei.com>
 <20201201205948.GA28178@willie-the-truck>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <74540986-6197-34bc-cd53-850472091ee3@huawei.com>
Date:   Wed, 2 Dec 2020 20:00:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201201205948.GA28178@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.186.123]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggeme717-chm.china.huawei.com (10.1.199.113)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Marc,
On 2020/12/2 4:59, Will Deacon wrote:
> On Wed, Dec 02, 2020 at 04:10:31AM +0800, Yanan Wang wrote:
>> When installing a new pte entry or updating an old valid entry in stage 2
>> translation, we use get_page()/put_page() to record page_count of the page-table
>> pages. PATCH 1/3 aims to fix incorrect use of get_page()/put_page() in stage 2,
>> which might make page-table pages unable to be freed when unmapping a range.
>>
>> When dirty logging of a guest with hugepages is finished, we should merge tables
>> back into a block entry if adjustment of huge mapping is found necessary.
>> In addition to installing the block entry, we should not only free the non-huge
>> page-table pages but also invalidate all the TLB entries of non-huge mappings for
>> the block. PATCH 2/3 adds enough TLBI when merging tables into a block entry.
>>
>> The rewrite of page-table code and fault handling add two different handlers
>> for "just relaxing permissions" and "map by stage2 page-table walk", that's
>> good improvement. Yet, in function user_mem_abort(), conditions where we choose
>> the above two fault handlers are not strictly distinguished. This will causes
>> guest errors such as infinite-loop (soft lockup will occur in result), because of
>> calling the inappropriate fault handler. So, a solution that can strictly
>> distinguish conditions is introduced in PATCH 3/3.
> For the series:
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Thanks for reporting these, helping me to understand the issues and then
> spinning a v2 so promptly.
>
> Will
> .

Thanks for the help and suggestions.

BTW: there are two more things below that I want to talk about.

1.  Recently, I have been focusing on the ARMv8.4-TTRem feature which is 
aimed at changing block size in stage 2 mapping.

I have a plan to implement this feature for stage 2 translation when 
splitting a block into tables or merging tables into a block.

This feature supports changing block size without performing 
*break-before-make*, which might have some improvement on performance.

What do you think about this?


2. Given that the issues we discussed before were found in practice when 
guest state changes from dirty logging to dirty logging canceled.

I could add a test file testing on this case to selftests/ or kvm unit 
tests/, if it's necessary.


Yanan

