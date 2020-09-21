Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AC9272683
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgIUOBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:01:04 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2906 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726688AbgIUOBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:01:02 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id C85C03125A0D1D39BC16;
        Mon, 21 Sep 2020 15:01:00 +0100 (IST)
Received: from [127.0.0.1] (10.210.166.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 21 Sep
 2020 15:01:00 +0100
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: Improve cmdq lock efficiency
To:     Will Deacon <will@kernel.org>
CC:     <robin.murphy@arm.com>, <joro@8bytes.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <maz@kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <1598018062-175608-1-git-send-email-john.garry@huawei.com>
 <20200921134324.GK2139@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b13d0858-e164-4670-a5c6-ab84e81724b7@huawei.com>
Date:   Mon, 21 Sep 2020 14:58:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200921134324.GK2139@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.166.25]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2020 14:43, Will Deacon wrote:
> On Fri, Aug 21, 2020 at 09:54:20PM +0800, John Garry wrote:
>> As mentioned in [0], the CPU may consume many cycles processing
>> arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() loop to
>> get space on the queue takes a lot of time once we start getting many
>> CPUs contending - from experiment, for 64 CPUs contending the cmdq,
>> success rate is ~ 1 in 12, which is poor, but not totally awful.
>>
>> This series removes that cmpxchg() and replaces with an atomic_add,
>> same as how the actual cmdq deals with maintaining the prod pointer.
>  > I'm still not a fan of this.

:(

> Could you try to adapt the hacks I sent before,
> please? I know they weren't quite right (I have no hardware to test on), but
> the basic idea is to fall back to a spinlock if the cmpxchg() fails. The
> queueing in the spinlock implementation should avoid the contention.

OK, so if you're asking me to try this again, then I can do that, and 
see what it gives us.

John

