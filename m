Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0182B5D40
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgKQKvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:51:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgKQKvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:51:12 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF07A22447;
        Tue, 17 Nov 2020 10:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605610272;
        bh=M9flKwRDRr9z64KmcbSgnOXXghPG2KQsLqY0zyac1Pc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hJb1EcqJN7y1+EllTk1nrvx7ql2HD2xrFheKYg8a5Qe1xK4dx+bbBZuRQE43nJsgP
         cLIg109k/Xs+axWgm62EusuYdb1mhlnsy5YoJwfluMJ9qupSxhcu4yXO2J0KinRL6h
         6YzGxnDuj0ANEfmFcJ7Quv/pVpImxgKmhNcqZMsc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1keyZp-00BIq8-MW; Tue, 17 Nov 2020 10:51:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 17 Nov 2020 10:51:09 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Zenghui Yu <yuzenghui@huawei.com>, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, wanghaibin.wang@huawei.com,
        Keqian Zhu <zhukeqian1@huawei.com>,
        kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com
Subject: Re: [PATCH 1/2] KVM: arm64: vgic: Forbid invalid userspace
 Redistributor accesses
In-Reply-To: <5ba4a98e-276b-2462-0580-fe0e007e9b38@redhat.com>
References: <20201113142801.1659-1-yuzenghui@huawei.com>
 <20201113142801.1659-2-yuzenghui@huawei.com>
 <724c43702b52aac0d3c9beb9604d1bfb@kernel.org>
 <584b7ff1-ecf2-b0ec-cea3-ccc29902f43a@huawei.com>
 <cc45285fe491aff5c28a24f94c124508@kernel.org>
 <7e58200c-814e-3598-155a-9a7e6cc24374@huawei.com>
 <c20865a267e44d1e2c0d52ce4e012263@kernel.org>
 <5ba4a98e-276b-2462-0580-fe0e007e9b38@redhat.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <6f4312dbedd6c1d8fa88dc0fc5adcb5d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, yuzenghui@huawei.com, suzuki.poulose@arm.com, linux-kernel@vger.kernel.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, wanghaibin.wang@huawei.com, zhukeqian1@huawei.com, kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-17 09:59, Auger Eric wrote:
> Hi Marc,
> 
> On 11/17/20 9:49 AM, Marc Zyngier wrote:
>> Hi Zenghui,
>> 
>> On 2020-11-16 14:57, Zenghui Yu wrote:
>>> Hi Marc,
>>> 
>>> On 2020/11/16 22:10, Marc Zyngier wrote:
>>>>> My take is that only if the "[Re]Distributor base address" is 
>>>>> specified
>>>>> in the system memory map, will the user-provided 
>>>>> kvm_device_attr.offset
>>>>> make sense. And we can then handle the access to the register which 
>>>>> is
>>>>> defined by "base address + offset".
>>>> 
>>>> I'd tend to agree, but it is just that this is a large change at 
>>>> -rc4.
>>>> I'd rather have a quick fix for 5.10, and a more invasive change for
>>>> 5.11,
>>>> spanning all the possible vgic devices.
>>> 
>>> So you prefer fixing it by "return a value that doesn't have the Last
>>> bit set" for v5.10? I'm ok with it and can send v2 for it.
>> 
>> Cool. Thanks for that.
>> 
>>> Btw, looking again at the way we handle the user-reading of 
>>> GICR_TYPER
>>> 
>>>     vgic_mmio_read_v3r_typer(vcpu, addr, len)
>>> 
>>> it seems that @addr is actually the *offset* of GICR_TYPER (0x0008) 
>>> and
>>> @addr is unlikely to be equal to last_rdist_typer, which is the *GPA* 
>>> of
>>> the last RD. Looks like the user-reading of GICR_TYPER.Last is always
>>> broken?
>> 
>> I think you are right. Somehow, we don't seem to track the index of
>> the RD in the region, so we can never compute the address of the RD
>> even if the base address is set.
>> 
>> Let's drop the reporting of Last for userspace for now, as it never
>> worked. If you post a patch addressing that quickly, I'll get it to
>> Paolo by the end of the week (there's another fix that needs merging).
>> 
>> Eric: do we have any test covering the userspace API?
> 
> So as this issue seems related to the changes made when implementing 
> the
> multiple RDIST regions, I volunteer to write those KVM selftests :-)

You're on! :D

More seriously, there is scope for fuzzing the device save/restore API,
as we find bugs every time someone change the "known good" ordering that
is implemented in QEMU.

Maybe it means getting rid of some unnecessary flexibility, as proposed
by Zenghui, if we are confident that no userspace makes use of it.
And in the future, making sure that new APIs are rigid enough to avoid 
such
bugs.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
