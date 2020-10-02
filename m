Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD352816C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbgJBPia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:38:30 -0400
Received: from foss.arm.com ([217.140.110.172]:39382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387938AbgJBPiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:38:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C8A51396;
        Fri,  2 Oct 2020 08:38:20 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EB183F73B;
        Fri,  2 Oct 2020 08:38:16 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] MTE support for KVM guest
To:     Andrew Jones <drjones@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Haibo Xu <Haibo.Xu@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        qemu-devel@nongnu.org, Dave Martin <Dave.Martin@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20200925093607.3051-1-steven.price@arm.com>
 <20201002143640.uzsz3nhr45payhlb@kamzik.brq.redhat.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <b653bbc8-1ebc-7c1a-9653-5441ca1be4b2@arm.com>
Date:   Fri, 2 Oct 2020 16:38:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002143640.uzsz3nhr45payhlb@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2020 15:36, Andrew Jones wrote:
> On Fri, Sep 25, 2020 at 10:36:05AM +0100, Steven Price wrote:
>> Version 3 of adding MTE support for KVM guests. See the previous (v2)
>> posting for background:
>>
>>   https://lore.kernel.org/r/20200904160018.29481-1-steven.price%40arm.com
>>
>> These patches add support to KVM to enable MTE within a guest. They are
>> based on Catalin's v9 MTE user-space support series[1] (currently in
>> next).
>>
>> Changes since v2:
>>
>>   * MTE is no longer a VCPU feature, instead it is a VM cap.
>>
>>   * Being a VM cap means easier probing (check for KVM_CAP_ARM_MTE).
>>
>>   * The cap must be set before any VCPUs are created, preventing any
>>     shenanigans where MTE is enabled for the guest after memory accesses
>>     have been performed.
>>
>> [1] https://lore.kernel.org/r/20200904103029.32083-1-catalin.marinas@arm.com
>>
>> Steven Price (2):
>>    arm64: kvm: Save/restore MTE registers
>>    arm64: kvm: Introduce MTE VCPU feature
>>
>>   arch/arm64/include/asm/kvm_emulate.h       |  3 +++
>>   arch/arm64/include/asm/kvm_host.h          |  7 +++++++
>>   arch/arm64/include/asm/sysreg.h            |  3 ++-
>>   arch/arm64/kvm/arm.c                       |  9 +++++++++
>>   arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
>>   arch/arm64/kvm/mmu.c                       | 15 +++++++++++++++
>>   arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
>>   include/uapi/linux/kvm.h                   |  1 +
>>   8 files changed, 66 insertions(+), 6 deletions(-)
>>
>> -- 
>> 2.20.1
>>
>>
> 
> Hi Steven,
> 
> These patches look fine to me, but I'd prefer we have a working
> implementation in QEMU before we get too excited about the KVM
> bits. kvmtool isn't sufficient since it doesn't support migration
> (at least afaik). In the past we've implemented features in KVM
> that look fine, but then issues have been discovered when trying
> to enable them from QEMU, where we also support migration. This
> feature looks like there's risk of issues with the userspace side.
> Although these two patches would probably stay the same, even if
> userspace requires more support.

I agree kvmtool isn't a great test because it doesn't support migration. 
The support in this series is just the basic support for MTE in a guest 
and we'd need to wait for the QEMU implementation before deciding 
whether we need any extra support (e.g. kernel interfaces for 
reading/writing tags as discussed before).

However, I don't think there's much danger of the support in this series 
changing - so extra support can be added when/if it's needed, but I 
don't think we need to block these series on that - QEMU can just probe 
for whatever additional support it needs before enabling MTE in a guest. 
I plan to rebase/repost after -rc1 when the user space support has been 
merged.

Steve
