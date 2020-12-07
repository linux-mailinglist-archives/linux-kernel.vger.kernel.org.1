Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AC22D123E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgLGNh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:37:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9390 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgLGNh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:37:28 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CqPTp1812z79wc;
        Mon,  7 Dec 2020 21:36:14 +0800 (CST)
Received: from [10.174.187.37] (10.174.187.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 21:36:35 +0800
Subject: Re: [PATCH] iommu: Up front sanity check in the arm_lpae_map
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <20201205082957.12544-1-zhukeqian1@huawei.com>
 <b85e98c8-0117-49c5-97ad-896ff88f7b88@arm.com>
 <20201207120527.GA4474@willie-the-truck>
 <2b0ec25b-0fa4-65ca-7c1b-109ce766197f@huawei.com>
 <9a6f31d7-3471-c045-368b-42ece5a2d34d@arm.com>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <maz@kernel.org>, <jiangkunkun@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        <iommu@lists.linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        "James Morse" <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <wanghaibin.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   zhukeqian <zhukeqian1@huawei.com>
Message-ID: <2191c045-449e-e7cb-a267-5bd356dab58e@huawei.com>
Date:   Mon, 7 Dec 2020 21:36:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <9a6f31d7-3471-c045-368b-42ece5a2d34d@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2020/12/7 20:46, Robin Murphy wrote:
> On 2020-12-07 12:15, zhukeqian wrote:
>> Hi,
>>
>> On 2020/12/7 20:05, Will Deacon wrote:
>>> On Mon, Dec 07, 2020 at 12:01:09PM +0000, Robin Murphy wrote:
>>>> On 2020-12-05 08:29, Keqian Zhu wrote:
>>>>> ... then we have more chance to detect wrong code logic.
>>>>
>>>> I don't follow that justification - it's still the same check with the same
>>>> outcome, so how does moving it have any effect on the chance to detect
>>>> errors?
>>
>>>>
>>>> AFAICS the only difference it would make is to make some errors *less*
>>>> obvious - if a sufficiently broken caller passes an empty prot value
>>>> alongside an invalid size or already-mapped address, this will now quietly
>>>> hide the warnings from the more serious condition(s).
>>>>
>>>> Yes, it will bail out a bit faster in the specific case where the prot value
>>>> is the only thing wrong, but since when do we optimise for fundamentally
>>>> incorrect API usage?
>>>
>>> I thought it was the other way round -- doesn't this patch move the "empty
>>> prot" check later, so we have a chance to check the size and addresses
>>> first?
>>
>> Yes, this is my original idea.
>> For that we treat iommu_prot with no permission as success at early start, defer
>> this early return can expose hidden errors.
> 
> ...oh dear, my apologies. I've just had a week off and apparently in that time I lost the ability to read :(
> 
> I was somehow convinced that the existing check happened at the point where we go to install the PTE, and this patch was moving it earlier. Looking at the whole code in context now I see I got it completely backwards. Sorry for being an idiot.
> 
I see :-) I should make a more descriptive commit message.

> I guess that only goes to show that a more descriptive commit message would definitely be a good thing :)
> 
I have adapted Will's suggestion and sent v2, please check whether it is OK to you?

Cheers,
Keqian

[...]
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
> .
> 
