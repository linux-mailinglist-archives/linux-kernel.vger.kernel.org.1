Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C48E2B5C67
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgKQJ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:59:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbgKQJ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605607176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mOqkemx80iqAEbsvZPEHgtzkP43+VniYkthIUbTgE4=;
        b=jUPyGd/h/Yjs7Ang6PQCCDLLUksFeJqpDaTdh8U5+SASUpaA/GRF5eUq02rIGs67isbGuj
        MdROD4rYVPFzjJFv50J53Mab4PoUeSNQbAmiy/mY9XIiQZBj0OhD7gViX9o9AV8sMTlgCD
        OKOVCx3Zk0p9iZ3MSIauVvNewsi6WoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-_3BCSZ60ORWuvma_yhqS-Q-1; Tue, 17 Nov 2020 04:59:34 -0500
X-MC-Unique: _3BCSZ60ORWuvma_yhqS-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5EA91899422;
        Tue, 17 Nov 2020 09:59:32 +0000 (UTC)
Received: from [10.36.113.230] (ovpn-113-230.ams2.redhat.com [10.36.113.230])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5A335D9CC;
        Tue, 17 Nov 2020 09:59:29 +0000 (UTC)
Subject: Re: [PATCH 1/2] KVM: arm64: vgic: Forbid invalid userspace
 Redistributor accesses
To:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Cc:     suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        wanghaibin.wang@huawei.com, Keqian Zhu <zhukeqian1@huawei.com>,
        kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com
References: <20201113142801.1659-1-yuzenghui@huawei.com>
 <20201113142801.1659-2-yuzenghui@huawei.com>
 <724c43702b52aac0d3c9beb9604d1bfb@kernel.org>
 <584b7ff1-ecf2-b0ec-cea3-ccc29902f43a@huawei.com>
 <cc45285fe491aff5c28a24f94c124508@kernel.org>
 <7e58200c-814e-3598-155a-9a7e6cc24374@huawei.com>
 <c20865a267e44d1e2c0d52ce4e012263@kernel.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <5ba4a98e-276b-2462-0580-fe0e007e9b38@redhat.com>
Date:   Tue, 17 Nov 2020 10:59:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c20865a267e44d1e2c0d52ce4e012263@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 11/17/20 9:49 AM, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On 2020-11-16 14:57, Zenghui Yu wrote:
>> Hi Marc,
>>
>> On 2020/11/16 22:10, Marc Zyngier wrote:
>>>> My take is that only if the "[Re]Distributor base address" is specified
>>>> in the system memory map, will the user-provided kvm_device_attr.offset
>>>> make sense. And we can then handle the access to the register which is
>>>> defined by "base address + offset".
>>>
>>> I'd tend to agree, but it is just that this is a large change at -rc4.
>>> I'd rather have a quick fix for 5.10, and a more invasive change for
>>> 5.11,
>>> spanning all the possible vgic devices.
>>
>> So you prefer fixing it by "return a value that doesn't have the Last
>> bit set" for v5.10? I'm ok with it and can send v2 for it.
> 
> Cool. Thanks for that.
> 
>> Btw, looking again at the way we handle the user-reading of GICR_TYPER
>>
>>     vgic_mmio_read_v3r_typer(vcpu, addr, len)
>>
>> it seems that @addr is actually the *offset* of GICR_TYPER (0x0008) and
>> @addr is unlikely to be equal to last_rdist_typer, which is the *GPA* of
>> the last RD. Looks like the user-reading of GICR_TYPER.Last is always
>> broken?
> 
> I think you are right. Somehow, we don't seem to track the index of
> the RD in the region, so we can never compute the address of the RD
> even if the base address is set.
> 
> Let's drop the reporting of Last for userspace for now, as it never
> worked. If you post a patch addressing that quickly, I'll get it to
> Paolo by the end of the week (there's another fix that needs merging).
> 
> Eric: do we have any test covering the userspace API?

So as this issue seems related to the changes made when implementing the
multiple RDIST regions, I volunteer to write those KVM selftests :-)

Thanks

Eric

> 
> Thanks,
> 
>         M.

