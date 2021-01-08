Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D123E2EF630
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbhAHREl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:04:41 -0500
Received: from foss.arm.com ([217.140.110.172]:54258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbhAHREl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:04:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B35E11FB;
        Fri,  8 Jan 2021 09:03:56 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034A43F70D;
        Fri,  8 Jan 2021 09:03:53 -0800 (PST)
Subject: Re: [PATCH] KVM: arm64: Compute TPIDR_EL2 ignoring MTE tag
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
References: <20210108161254.53674-1-steven.price@arm.com>
 <e49459f08d0afb30a120dfb3d6b80741@kernel.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <d26549a7-8de8-876e-0385-ebb831da4a53@arm.com>
Date:   Fri, 8 Jan 2021 17:03:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e49459f08d0afb30a120dfb3d6b80741@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2021 16:51, Marc Zyngier wrote:
> Hi Steven,
> 
> On 2021-01-08 16:12, Steven Price wrote:
>> KASAN in HW_TAGS mode will store MTE tags in the top byte of the
>> pointer. When computing the offset for TPIDR_EL2 we don't want anything
>> in the top byte, so remove the tag to ensure the computation is correct
>> no matter what the tag.
>>
>> Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>> Without this fix I can't boot a config with KASAN_HW_TAGS and KVM on an
>> MTE enabled host. I'm unsure if this should really be in
>> this_cpu_ptr_nvhe_sym().
> 
> this_cpu_ptr_nvhe_sym() should return something that is valid for
> the EL1 kernel, so I guess untagging in the helper may not be
> that useful.

Makes sense and was my suspicion.

> However, I'm more concerned by anything at requires us to follow
> pointers set up by EL1 at EL2. It looks to me that the only reason
> the whole thing works is because kern_hyp_va() *accidentally* drops
> tags before applying the EL1/EL2 offset...

In the case I'm fixing this is intended to be an offset calculation - 
it's just messed up by the presence of an MTE tag in one of the pointers.

I agree I was somewhat surprised when everything 'just worked' with this 
one change - and I think you're right it's because kern_hyp_va() 'just 
happens' to lose the tags. Of course there may be other bugs lurking - 
running MTE+KASAN on the model is slow so I didn't do much beyond boot it.

One of the 'fun' things about MTE is that you can no longer do pointer 
subtraction to calculate the offset unless the pointers are actually 
from the same allocation (and therefore have the same tag). I'm sure the 
C language experts would point out that's "always been the case" but it 
will probably break things elsewhere too.

Steve

> Or am I getting it wrong?
> 
> Thanks,
> 
>          M.

