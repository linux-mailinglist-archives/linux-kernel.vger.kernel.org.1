Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDFA2B4679
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgKPO5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:57:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8094 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbgKPO5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:57:34 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZXGy5byCzLlrL;
        Mon, 16 Nov 2020 22:57:14 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 22:57:26 +0800
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
 <584b7ff1-ecf2-b0ec-cea3-ccc29902f43a@huawei.com>
 <cc45285fe491aff5c28a24f94c124508@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7e58200c-814e-3598-155a-9a7e6cc24374@huawei.com>
Date:   Mon, 16 Nov 2020 22:57:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cc45285fe491aff5c28a24f94c124508@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/11/16 22:10, Marc Zyngier wrote:
>> My take is that only if the "[Re]Distributor base address" is specified
>> in the system memory map, will the user-provided kvm_device_attr.offset
>> make sense. And we can then handle the access to the register which is
>> defined by "base address + offset".
> 
> I'd tend to agree, but it is just that this is a large change at -rc4.
> I'd rather have a quick fix for 5.10, and a more invasive change for 5.11,
> spanning all the possible vgic devices.

So you prefer fixing it by "return a value that doesn't have the Last
bit set" for v5.10? I'm ok with it and can send v2 for it.

Btw, looking again at the way we handle the user-reading of GICR_TYPER

	vgic_mmio_read_v3r_typer(vcpu, addr, len)

it seems that @addr is actually the *offset* of GICR_TYPER (0x0008) and
@addr is unlikely to be equal to last_rdist_typer, which is the *GPA* of
the last RD. Looks like the user-reading of GICR_TYPER.Last is always
broken?


Thanks,
Zenghui
