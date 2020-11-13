Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEE02B1942
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgKMKnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:43:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2100 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgKMKnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:43:20 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CXZl22YsHz67KSS;
        Fri, 13 Nov 2020 18:41:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 13 Nov 2020 11:43:16 +0100
Received: from [10.47.88.104] (10.47.88.104) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 13 Nov
 2020 10:43:16 +0000
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: Improve cmdq lock efficiency
From:   John Garry <john.garry@huawei.com>
To:     Will Deacon <will@kernel.org>
CC:     <robin.murphy@arm.com>, <joro@8bytes.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <maz@kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <1598018062-175608-1-git-send-email-john.garry@huawei.com>
 <20200921134324.GK2139@willie-the-truck>
 <b13d0858-e164-4670-a5c6-ab84e81724b7@huawei.com>
Message-ID: <ca5a0f5f-91fb-4c11-f158-44e16343cdb2@huawei.com>
Date:   Fri, 13 Nov 2020 10:43:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <b13d0858-e164-4670-a5c6-ab84e81724b7@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.88.104]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2020 14:58, John Garry wrote:
> On 21/09/2020 14:43, Will Deacon wrote:
>> On Fri, Aug 21, 2020 at 09:54:20PM +0800, John Garry wrote:
>>> As mentioned in [0], the CPU may consume many cycles processing
>>> arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() 
>>> loop to
>>> get space on the queue takes a lot of time once we start getting many
>>> CPUs contending - from experiment, for 64 CPUs contending the cmdq,
>>> success rate is ~ 1 in 12, which is poor, but not totally awful.
>>>
>>> This series removes that cmpxchg() and replaces with an atomic_add,
>>> same as how the actual cmdq deals with maintaining the prod pointer.
>>  > I'm still not a fan of this.
> 
> :(
> 
>> Could you try to adapt the hacks I sent before,
>> please? I know they weren't quite right (I have no hardware to test 
>> on), but
>> the basic idea is to fall back to a spinlock if the cmpxchg() fails. The
>> queueing in the spinlock implementation should avoid the contention.
> 
> OK, so if you're asking me to try this again, then I can do that, and 
> see what it gives us.
> 

JFYI, to prove that this is not a problem which affects only our HW, I 
managed to test an arm64 platform from another vendor. Generally I see 
the same issue, and this patchset actually helps that platform even more.

		CPUs	Before	After	% Increase
Huawei D06	8	282K	302K	7%
Other			379K	420K	11%

Huawei D06	16	115K	193K	68K
Other			102K	291K	185K

Huawei D06	32	36K	80K	122%
Other			41K	156K	280%

Huawei D06	64	11K	30K	172%
Other			6K	47K	683%

I tested with something like [1], so unit is map+unmaps per cpu per 
second - higher is better.

My D06 is memory poor, so would expect higher results otherwise (with 
more memory). Indeed, my D05 has memory on all nodes and performs better.

Anyway, I see that the implementation here is not perfect, and I could 
not get suggested approach to improve performance significantly. So back 
to the drawing board...

Thanks,
John

[1] 
https://lore.kernel.org/linux-iommu/20201102080646.2180-1-song.bao.hua@hisilicon.com/

