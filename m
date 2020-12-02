Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD33D2CBD54
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgLBMu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:50:57 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2389 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgLBMu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:50:57 -0500
Received: from dggeme706-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CmJhP5YQxz50gv;
        Wed,  2 Dec 2020 20:49:41 +0800 (CST)
Received: from [10.174.186.123] (10.174.186.123) by
 dggeme706-chm.china.huawei.com (10.1.199.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 2 Dec 2020 20:50:14 +0800
Subject: Re: [PATCH v2 0/3] Fix several bugs in KVM stage 2 translation
To:     Marc Zyngier <maz@kernel.org>
CC:     Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
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
 <74540986-6197-34bc-cd53-850472091ee3@huawei.com>
 <616980dcddd5c7e832c1068f6fa91449@kernel.org>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <b9cf36df-dc1f-5d40-0341-cfa573c9ecd9@huawei.com>
Date:   Wed, 2 Dec 2020 20:50:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <616980dcddd5c7e832c1068f6fa91449@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.186.123]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme706-chm.china.huawei.com (10.1.199.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/2 20:23, Marc Zyngier wrote:
> Hi Yanan,
>
> [...]
>
>> BTW: there are two more things below that I want to talk about.
>>
>> 1.  Recently, I have been focusing on the ARMv8.4-TTRem feature which
>> is aimed at changing block size in stage 2 mapping.
>>
>> I have a plan to implement this feature for stage 2 translation when
>> splitting a block into tables or merging tables into a block.
>>
>> This feature supports changing block size without performing
>> *break-before-make*, which might have some improvement on performance.
>>
>> What do you think about this?
>
> It would be interesting if you can demonstrate some significant
> performance improvements compared to the same workload with BBM.
>
> I'm not completely convinced this would change much, given that
> it is only when moving from a table to a block mapping that you
> can elide BBM when the support level is 1 or 2. As far as I can
> tell, this only happens in the "stop logging" case.
>
> Is that something that happens often enough to justify the added
> complexity? Having to handle TLB Conflict Abort is annoying, for
> example.

I will take more consideration about the necessity  and maybe some tests

on the performance will be made later.


Thanks,


Yanan

>
>> 2. Given that the issues we discussed before were found in practice
>> when guest state changes from dirty logging to dirty logging canceled.
>>
>> I could add a test file testing on this case to selftests/ or kvm unit
>> tests/, if it's necessary.
>
> That would be awesome, and I'd be very grateful if you did. It is the
> second time we break this exact case, and having a reliable way to
> verify it would definitely help.
>
> Thanks,
>
>         M.
