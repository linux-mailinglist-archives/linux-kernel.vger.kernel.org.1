Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577EE2B4593
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgKPOKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbgKPOKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:10:37 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C559222B9;
        Mon, 16 Nov 2020 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605535837;
        bh=ce9j1AGGlbt/dA39/NSUVN8ivIA3K66bI5W3yfnRygo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MxzRGCoWZdy+IUxEK/B3YqzKL9YwdvEloQ4NV94H/28zFEl8StOb8eqKkaY1CBO6v
         NdkWbaJXg1tYuz+cQAj3nPFl9IBzbX/6xl8Gai6j6b4MWiRfjjMSy44MBvlx8A/U0y
         0OoThWvSEmzVrfOplnI5zr1uz2lyPMoEqxVIaQ/w=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kefDH-00B1sD-2K; Mon, 16 Nov 2020 14:10:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 16 Nov 2020 14:10:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eric.auger@redhat.com,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, wanghaibin.wang@huawei.com,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH 1/2] KVM: arm64: vgic: Forbid invalid userspace
 Redistributor accesses
In-Reply-To: <584b7ff1-ecf2-b0ec-cea3-ccc29902f43a@huawei.com>
References: <20201113142801.1659-1-yuzenghui@huawei.com>
 <20201113142801.1659-2-yuzenghui@huawei.com>
 <724c43702b52aac0d3c9beb9604d1bfb@kernel.org>
 <584b7ff1-ecf2-b0ec-cea3-ccc29902f43a@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <cc45285fe491aff5c28a24f94c124508@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, wanghaibin.wang@huawei.com, zhukeqian1@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-16 13:09, Zenghui Yu wrote:
> Hi Marc,
> 
> On 2020/11/16 1:04, Marc Zyngier wrote:
>> Hi Zenghui,
>> 
>> On 2020-11-13 14:28, Zenghui Yu wrote:
>>> It's expected that users will access registers in the redistributor 
>>> *if*
>>> the RD has been initialized properly. Unfortunately userspace can be 
>>> bogus
>>> enough to access registers before setting the RD base address, and 
>>> KVM
>>> implicitly allows it (we handle the access anyway, regardless of 
>>> whether
>>> the base address is set).
>>> 
>>> Bad thing happens when we're handling the user read of GICR_TYPER. We 
>>> end
>>> up with an oops when deferencing the unset rdreg...
>>> 
>>>     gpa_t last_rdist_typer = rdreg->base + GICR_TYPER +
>>>             (rdreg->free_index - 1) * KVM_VGIC_V3_REDIST_SIZE;
>>> 
>>> Fix this issue by informing userspace what had gone wrong (-ENXIO).
>> 
>> I'm worried about the "implicit" aspect of the access that this patch
>> now forbids.
>> 
>> The problem is that the existing documentation doesn't cover this 
>> case, > and -ENXIO's "Getting or setting this register is not yet 
>> supported"
>> is way too vague.
> 
> Indeed. How about changing to
> 
>     -ENXIO  Getting or setting this register is not yet supported
>             or VGIC not properly configured (e.g., [Re]Distributor base
>             address is unknown)

Looks OK to me.

> 
>> There is a precedent with the ITS, but that's undocumented
>> as well. Also, how about v2? If that's the wasy we are going to fix 
>> this,
>> we also nned to beef up the documentation.
> 
> Sure, I plan to do so and hope it won't break the existing userspace.

Well, at this stage we can only hope.

> 
>> Of course, the other horrible way to address the issue is to return a 
>> value
>> that doesn't have the Last bit set, since we can't synthetise it. It 
>> doesn't
>> change the userspace API, and I can even find some (admittedly  
>> twisted)
>> logic to it (since there is no base address, there is no last RD...).
> 
> I'm fine with it. But I'm afraid that there might be other issues due 
> to
> the "unexpected" accesses since I haven't tested with all registers 
> from
> userspace.

I have had a look at the weekend, and couldn't see any other other GICR
register that would suffer from rdreg being NULL. I haven't looked at
GICD, but I don't anticipate anything bad on that front.

> My take is that only if the "[Re]Distributor base address" is specified
> in the system memory map, will the user-provided kvm_device_attr.offset
> make sense. And we can then handle the access to the register which is
> defined by "base address + offset".

I'd tend to agree, but it is just that this is a large change at -rc4.
I'd rather have a quick fix for 5.10, and a more invasive change for 
5.11,
spanning all the possible vgic devices.

         M.
-- 
Jazz is not dead. It just smells funny...
