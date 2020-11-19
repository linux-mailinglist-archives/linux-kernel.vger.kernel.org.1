Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF02B92C1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgKSMqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:46:30 -0500
Received: from foss.arm.com ([217.140.110.172]:56360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgKSMq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:46:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6039A1396;
        Thu, 19 Nov 2020 04:46:28 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFEED3F718;
        Thu, 19 Nov 2020 04:46:25 -0800 (PST)
Subject: Re: [PATCH v4 1/2] arm64: kvm: Save/restore MTE registers
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
References: <20201026155727.36685-1-steven.price@arm.com>
 <20201026155727.36685-2-steven.price@arm.com>
 <b8f2fe15e0cab5c24094915b8c000930@kernel.org>
 <98eaa539-0ae8-ce4c-8886-3040542ede80@arm.com> <X7VTsaO/7+Izqm8/@trantor>
From:   Steven Price <steven.price@arm.com>
Message-ID: <f5e9fe3a-2147-4326-5e78-5eaf88c72789@arm.com>
Date:   Thu, 19 Nov 2020 12:45:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X7VTsaO/7+Izqm8/@trantor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2020 17:02, Catalin Marinas wrote:
> On Wed, Nov 18, 2020 at 04:01:18PM +0000, Steven Price wrote:
>> On 17/11/2020 19:20, Marc Zyngier wrote:
>>> On 2020-10-26 15:57, Steven Price wrote:
>>>> diff --git a/arch/arm64/include/asm/sysreg.h
>>>> b/arch/arm64/include/asm/sysreg.h
>>>> index d52c1b3ce589..7727df0bc09d 100644
>>>> --- a/arch/arm64/include/asm/sysreg.h
>>>> +++ b/arch/arm64/include/asm/sysreg.h
>>>> @@ -565,7 +565,8 @@
>>>> ï¿½#define SCTLR_ELx_Mï¿½ï¿½ï¿½ (BIT(0))
>>>>
>>>> ï¿½#define SCTLR_ELx_FLAGSï¿½ï¿½ï¿½ (SCTLR_ELx_Mï¿½ | SCTLR_ELx_A | SCTLR_ELx_C | \
>>>> -ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB)
>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB | \
>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ SCTLR_ELx_ITFSB)
>>>>
>>>> ï¿½/* SCTLR_EL2 specific flags. */
>>>> ï¿½#define SCTLR_EL2_RES1ï¿½ï¿½ï¿½ ((BIT(4))ï¿½ | (BIT(5))ï¿½ | (BIT(11)) |
>>>> (BIT(16)) | \
>>>> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
>>>> b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
>>>> index 7a986030145f..a124ffa49ba3 100644
>>>> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
>>>> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
>>>> @@ -18,6 +18,11 @@
>>>> ï¿½static inline void __sysreg_save_common_state(struct
>>>> kvm_cpu_context *ctxt)
>>>> ï¿½{
>>>> ï¿½ï¿½ï¿½ï¿½ ctxt_sys_reg(ctxt, MDSCR_EL1)ï¿½ï¿½ï¿½ = read_sysreg(mdscr_el1);
>>>> +ï¿½ï¿½ï¿½ if (system_supports_mte()) {
>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ctxt_sys_reg(ctxt, RGSR_EL1)ï¿½ï¿½ï¿½ = read_sysreg_s(SYS_RGSR_EL1);
>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ctxt_sys_reg(ctxt, GCR_EL1)ï¿½ï¿½ï¿½ = read_sysreg_s(SYS_GCR_EL1);
>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ctxt_sys_reg(ctxt, TFSRE0_EL1)ï¿½ï¿½ï¿½ =
>>>> read_sysreg_s(SYS_TFSRE0_EL1);
>>>
>>> As far as I can tell, HCR_EL2.ATA is still clear when running a guest.
>>> So why, do we save/restore this state yet?
>>>
>>> Also, I wonder whether we should keep these in the C code. If one day
>>> we enable MTE in the kernel, we will have to move them to the assembly
>>> part, much like we do for PAuth. And I fear that "one day" is pretty
>>> soon:
>>>
>>> https://lore.kernel.org/linux-arm-kernel/cover.1605046192.git.andreyknvl@google.com/
>>
>> Good point. Although for MTE we do have the option of setting TCO in PSTATE
>> so this could remain in C if we're not bothered about the 'gap' in KASAN
>> coverage. I haven't yet got my head around how (or indeed if) that series
>> handles guests.
> 
> I think we should be fine with the currently proposed in-kernel MTE
> support. However, setting GCR_EL1 can get in the way if stack tagging is
> ever enabled (it breaks single image). The compiler uses GCR_EL1 to
> generate different colours for variables on the stack and changing it in
> the middle of a function may cause confusion. You'd have to set
> PSTATE.TCO for the whole function, either from the caller or, if the
> compiler gets smarter, some function attribute.
> 

If the compiler might start playing with TCO then this could also be an 
issue for VMMs which will (at least with the current design) need to use 
TCO to safely access guest memory. Especially if we enforce PROT_MTE 
mappings for the VMM.

Steve
