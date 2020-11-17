Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF372B5C26
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgKQJra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:47:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgKQJra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605606448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bu5x+H+Bnz2zQiGdHqKojzUdpKyg3Vir6SAo3F4rtgE=;
        b=ObMKGO1TI9Pq+s4uQCKkK5XvYNPqmcpu1xJhhm7K6+78W4tlPxv5HIWe4UhRk24HksVQPI
        2U4dvqSiBKyWuCWCct4+bCiGMbBylppHqHyPRIxw8FIUaHqSd7QDHy2iPd5V03gcETDoxN
        kqtHaVC5SBikYn4gutHvZjuPueUfsSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-s2NKkLE0PFC24vsg_YzNkw-1; Tue, 17 Nov 2020 04:47:26 -0500
X-MC-Unique: s2NKkLE0PFC24vsg_YzNkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89190A0CD9;
        Tue, 17 Nov 2020 09:47:17 +0000 (UTC)
Received: from [10.36.113.230] (ovpn-113-230.ams2.redhat.com [10.36.113.230])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A764660C04;
        Tue, 17 Nov 2020 09:47:14 +0000 (UTC)
Subject: Re: [PATCH 1/2] KVM: arm64: vgic: Forbid invalid userspace
 Redistributor accesses
To:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        wanghaibin.wang@huawei.com, Keqian Zhu <zhukeqian1@huawei.com>
References: <20201113142801.1659-1-yuzenghui@huawei.com>
 <20201113142801.1659-2-yuzenghui@huawei.com>
 <724c43702b52aac0d3c9beb9604d1bfb@kernel.org>
 <584b7ff1-ecf2-b0ec-cea3-ccc29902f43a@huawei.com>
 <cc45285fe491aff5c28a24f94c124508@kernel.org>
 <7e58200c-814e-3598-155a-9a7e6cc24374@huawei.com>
 <c20865a267e44d1e2c0d52ce4e012263@kernel.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <ea719c25-911e-345a-61fa-648d2f01ab4a@redhat.com>
Date:   Tue, 17 Nov 2020 10:47:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c20865a267e44d1e2c0d52ce4e012263@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

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
No, there are no KVM selftests for that yet.

Thanks

Eric

> 
> Thanks,
> 
>         M.

