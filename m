Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807E72B4476
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgKPNKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:10:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7938 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbgKPNKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:10:06 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CZTv61v1dzhbp6;
        Mon, 16 Nov 2020 21:09:54 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 21:09:53 +0800
Subject: Re: [PATCH 1/2] KVM: arm64: vgic: Forbid invalid userspace
 Redistributor accesses
To:     Marc Zyngier <maz@kernel.org>
CC:     <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <eric.auger@redhat.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <wanghaibin.wang@huawei.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
References: <20201113142801.1659-1-yuzenghui@huawei.com>
 <20201113142801.1659-2-yuzenghui@huawei.com>
 <724c43702b52aac0d3c9beb9604d1bfb@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <584b7ff1-ecf2-b0ec-cea3-ccc29902f43a@huawei.com>
Date:   Mon, 16 Nov 2020 21:09:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <724c43702b52aac0d3c9beb9604d1bfb@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/11/16 1:04, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On 2020-11-13 14:28, Zenghui Yu wrote:
>> It's expected that users will access registers in the redistributor *if*
>> the RD has been initialized properly. Unfortunately userspace can be 
>> bogus
>> enough to access registers before setting the RD base address, and KVM
>> implicitly allows it (we handle the access anyway, regardless of whether
>> the base address is set).
>>
>> Bad thing happens when we're handling the user read of GICR_TYPER. We end
>> up with an oops when deferencing the unset rdreg...
>>
>>     gpa_t last_rdist_typer = rdreg->base + GICR_TYPER +
>>             (rdreg->free_index - 1) * KVM_VGIC_V3_REDIST_SIZE;
>>
>> Fix this issue by informing userspace what had gone wrong (-ENXIO).
> 
> I'm worried about the "implicit" aspect of the access that this patch
> now forbids.
> 
> The problem is that the existing documentation doesn't cover this case, > and -ENXIO's "Getting or setting this register is not yet supported"
> is way too vague.

Indeed. How about changing to

     -ENXIO  Getting or setting this register is not yet supported
             or VGIC not properly configured (e.g., [Re]Distributor base
             address is unknown)

> There is a precedent with the ITS, but that's 
> undocumented
> as well. Also, how about v2? If that's the wasy we are going to fix this,
> we also nned to beef up the documentation.

Sure, I plan to do so and hope it won't break the existing userspace.

> Of course, the other horrible way to address the issue is to return a value
> that doesn't have the Last bit set, since we can't synthetise it. It 
> doesn't
> change the userspace API, and I can even find some (admittedly  twisted)
> logic to it (since there is no base address, there is no last RD...).

I'm fine with it. But I'm afraid that there might be other issues due to
the "unexpected" accesses since I haven't tested with all registers from
userspace.

My take is that only if the "[Re]Distributor base address" is specified
in the system memory map, will the user-provided kvm_device_attr.offset
make sense. And we can then handle the access to the register which is
defined by "base address + offset".


Thanks,
Zenghui
