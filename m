Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612FE2CDB90
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgLCQun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:50:43 -0500
Received: from foss.arm.com ([217.140.110.172]:45070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgLCQun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:50:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2856011D4;
        Thu,  3 Dec 2020 08:49:57 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963473F575;
        Thu,  3 Dec 2020 08:49:54 -0800 (PST)
Subject: Re: [PATCH v6 0/2] MTE support for KVM guest
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
References: <20201127152113.13099-1-steven.price@arm.com>
 <20201203160943.GG96754@C02TD0UTHF1T.local>
From:   Steven Price <steven.price@arm.com>
Message-ID: <77e65f06-563b-3b30-ab36-9670e8cc03a4@arm.com>
Date:   Thu, 3 Dec 2020 16:49:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203160943.GG96754@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2020 16:09, Mark Rutland wrote:
> On Fri, Nov 27, 2020 at 03:21:11PM +0000, Steven Price wrote:
>> It's been a week, and I think the comments on v5 made it clear that
>> enforcing PROT_MTE requirements on the VMM was probably the wrong
>> approach. So since I've got swap working correctly without that I
>> thought I'd post a v6 which hopefully addresses all the comments so far.
>>
>> This series adds support for Arm's Memory Tagging Extension (MTE) to
>> KVM, allowing KVM guests to make use of it. This builds on the existing
>> user space support already in v5.10-rc4, see [1] for an overview.
> 
>>   arch/arm64/include/asm/kvm_emulate.h       |  3 +++
>>   arch/arm64/include/asm/kvm_host.h          |  8 ++++++++
>>   arch/arm64/include/asm/pgtable.h           |  2 +-
>>   arch/arm64/include/asm/sysreg.h            |  3 ++-
>>   arch/arm64/kernel/mte.c                    | 18 +++++++++++++-----
>>   arch/arm64/kvm/arm.c                       |  9 +++++++++
>>   arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
>>   arch/arm64/kvm/mmu.c                       | 16 ++++++++++++++++
>>   arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
>>   include/uapi/linux/kvm.h                   |  1 +
>>   10 files changed, 82 insertions(+), 12 deletions(-)
> 
> I note that doesn't fixup arch/arm64/kvm/inject_fault.c, where in
> enter_exception64() we have:
> 
> | // TODO: TCO (if/when ARMv8.5-MemTag is exposed to guests)
> 
> ... and IIUC when MTE is present, TCO should be set when delivering an
> exception, so I believe that needs to be updated to set TCO.

Well spotted! As you say TCO should be set when delivering an exception, 
so we need the following:

-       // TODO: TCO (if/when ARMv8.5-MemTag is exposed to guests)
+       if (kvm_has_mte(vcpu->kvm))
+               new |= PSR_TCO_BIT;

> Given that MTE-capable HW does that unconditionally, this is going to be
> a mess for big.LITTLE. :/

I'm not sure I follow. Either all CPUs support MTE in which this isn't a 
problem, or the MTE feature just isn't exposed. We don't support a mix 
of MTE and non-MTE CPUs. There are several aspects of MTE which 
effective mean it's an all-or-nothing feature for the system.

Thanks,

Steve
