Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42822B8162
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKRQBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:01:25 -0500
Received: from foss.arm.com ([217.140.110.172]:58150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgKRQBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:01:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF7011396;
        Wed, 18 Nov 2020 08:01:21 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 201683F719;
        Wed, 18 Nov 2020 08:01:19 -0800 (PST)
Subject: Re: [PATCH v4 1/2] arm64: kvm: Save/restore MTE registers
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
From:   Steven Price <steven.price@arm.com>
Message-ID: <98eaa539-0ae8-ce4c-8886-3040542ede80@arm.com>
Date:   Wed, 18 Nov 2020 16:01:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b8f2fe15e0cab5c24094915b8c000930@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2020 19:20, Marc Zyngier wrote:
> Hi Steven,

Hi Marc

> These patches unfortunately don't apply to -rc4 anymore, as we repainted
> quite a bit while working on fixes. I'd be grateful if you could rebase 
> them.

No problem - the changes look relatively minor.

> 
> A few other things though:
> 
> On 2020-10-26 15:57, Steven Price wrote:
>> Define the new system registers that MTE introduces and context switch
>> them. The MTE feature is still hidden from the ID register as it isn't
>> supported in a VM yet.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>> ---
>>  arch/arm64/include/asm/kvm_host.h          |  4 ++++
>>  arch/arm64/include/asm/sysreg.h            |  3 ++-
>>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
>>  arch/arm64/kvm/sys_regs.c                  | 14 ++++++++++----
>>  4 files changed, 30 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h
>> b/arch/arm64/include/asm/kvm_host.h
>> index 0aecbab6a7fb..95ab7345dcc8 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -134,6 +134,8 @@ enum vcpu_sysreg {
>>      SCTLR_EL1,    /* System Control Register */
>>      ACTLR_EL1,    /* Auxiliary Control Register */
>>      CPACR_EL1,    /* Coprocessor Access Control */
>> +    RGSR_EL1,    /* Random Allocation Tag Seed Register */
>> +    GCR_EL1,    /* Tag Control Register */
>>      ZCR_EL1,    /* SVE Control */
>>      TTBR0_EL1,    /* Translation Table Base Register 0 */
>>      TTBR1_EL1,    /* Translation Table Base Register 1 */
>> @@ -150,6 +152,8 @@ enum vcpu_sysreg {
>>      TPIDR_EL1,    /* Thread ID, Privileged */
>>      AMAIR_EL1,    /* Aux Memory Attribute Indirection Register */
>>      CNTKCTL_EL1,    /* Timer Control Register (EL1) */
>> +    TFSRE0_EL1,    /* Tag Fault Status Register (EL0) */
>> +    TFSR_EL1,    /* Tag Fault Stauts Register (EL1) */
>>      PAR_EL1,    /* Physical Address Register */
>>      MDSCR_EL1,    /* Monitor Debug System Control Register */
>>      MDCCINT_EL1,    /* Monitor Debug Comms Channel Interrupt Enable 
>> Reg */
>> diff --git a/arch/arm64/include/asm/sysreg.h 
>> b/arch/arm64/include/asm/sysreg.h
>> index d52c1b3ce589..7727df0bc09d 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -565,7 +565,8 @@
>>  #define SCTLR_ELx_M    (BIT(0))
>>
>>  #define SCTLR_ELx_FLAGS    (SCTLR_ELx_M  | SCTLR_ELx_A | SCTLR_ELx_C | \
>> -             SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB)
>> +             SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB | \
>> +             SCTLR_ELx_ITFSB)
>>
>>  /* SCTLR_EL2 specific flags. */
>>  #define SCTLR_EL2_RES1    ((BIT(4))  | (BIT(5))  | (BIT(11)) | 
>> (BIT(16)) | \
>> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
>> b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
>> index 7a986030145f..a124ffa49ba3 100644
>> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
>> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
>> @@ -18,6 +18,11 @@
>>  static inline void __sysreg_save_common_state(struct kvm_cpu_context 
>> *ctxt)
>>  {
>>      ctxt_sys_reg(ctxt, MDSCR_EL1)    = read_sysreg(mdscr_el1);
>> +    if (system_supports_mte()) {
>> +        ctxt_sys_reg(ctxt, RGSR_EL1)    = read_sysreg_s(SYS_RGSR_EL1);
>> +        ctxt_sys_reg(ctxt, GCR_EL1)    = read_sysreg_s(SYS_GCR_EL1);
>> +        ctxt_sys_reg(ctxt, TFSRE0_EL1)    = 
>> read_sysreg_s(SYS_TFSRE0_EL1);
> 
> As far as I can tell, HCR_EL2.ATA is still clear when running a guest.
> So why, do we save/restore this state yet?

At this stage it is indeed not necessary. Clearly it's needed after the 
second patch because ATA is enabled for the guest. This is just an 
artifact of doing this as two patches. The first patch adds all the 
save/restoring logic the second the machinery for enabling ATA safely. 
If you've got any suggestions about how to better split it (or indeed if 
you'd prefer the patches squashed) let me know. The only alternative I 
can think of is three patches: the 'mte_enabled' machinery (but without 
a way of enabling it), this patch, followed by a way of turning 
mte_enabled on. But that doesn't seem an improvement to anything other 
than my patch count ;)

> 
> Also, I wonder whether we should keep these in the C code. If one day
> we enable MTE in the kernel, we will have to move them to the assembly
> part, much like we do for PAuth. And I fear that "one day" is pretty
> soon:
> 
> https://lore.kernel.org/linux-arm-kernel/cover.1605046192.git.andreyknvl@google.com/ 

Good point. Although for MTE we do have the option of setting TCO in 
PSTATE so this could remain in C if we're not bothered about the 'gap' 
in KASAN coverage. I haven't yet got my head around how (or indeed if) 
that series handles guests.

> 
> 
> 
>> +    }
>>  }
>>
>>  static inline void __sysreg_save_user_state(struct kvm_cpu_context 
>> *ctxt)
>> @@ -45,6 +50,8 @@ static inline void __sysreg_save_el1_state(struct
>> kvm_cpu_context *ctxt)
>>      ctxt_sys_reg(ctxt, CNTKCTL_EL1)    = read_sysreg_el1(SYS_CNTKCTL);
>>      ctxt_sys_reg(ctxt, PAR_EL1)    = read_sysreg(par_el1);
>>      ctxt_sys_reg(ctxt, TPIDR_EL1)    = read_sysreg(tpidr_el1);
>> +    if (system_supports_mte())
>> +        ctxt_sys_reg(ctxt, TFSR_EL1) = read_sysreg_el1(SYS_TFSR);
>>
>>      ctxt_sys_reg(ctxt, SP_EL1)    = read_sysreg(sp_el1);
>>      ctxt_sys_reg(ctxt, ELR_EL1)    = read_sysreg_el1(SYS_ELR);
>> @@ -63,6 +70,11 @@ static inline void
>> __sysreg_save_el2_return_state(struct kvm_cpu_context *ctxt)
>>  static inline void __sysreg_restore_common_state(struct 
>> kvm_cpu_context *ctxt)
>>  {
>>      write_sysreg(ctxt_sys_reg(ctxt, MDSCR_EL1),  mdscr_el1);
>> +    if (system_supports_mte()) {
>> +        write_sysreg_s(ctxt_sys_reg(ctxt, RGSR_EL1), SYS_RGSR_EL1);
>> +        write_sysreg_s(ctxt_sys_reg(ctxt, GCR_EL1), SYS_GCR_EL1);
>> +        write_sysreg_s(ctxt_sys_reg(ctxt, TFSRE0_EL1), SYS_TFSRE0_EL1);
>> +    }
>>  }
>>
>>  static inline void __sysreg_restore_user_state(struct kvm_cpu_context 
>> *ctxt)
>> @@ -106,6 +118,8 @@ static inline void
>> __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
>>      write_sysreg_el1(ctxt_sys_reg(ctxt, CNTKCTL_EL1), SYS_CNTKCTL);
>>      write_sysreg(ctxt_sys_reg(ctxt, PAR_EL1),    par_el1);
>>      write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL1),    tpidr_el1);
>> +    if (system_supports_mte())
>> +        write_sysreg_el1(ctxt_sys_reg(ctxt, TFSR_EL1), SYS_TFSR);
>>
>>      if (!has_vhe() &&
>>          cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT) &&
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index d9117bc56237..430e36e1a13d 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1391,6 +1391,12 @@ static bool access_mte_regs(struct kvm_vcpu
>> *vcpu, struct sys_reg_params *p,
>>      return false;
>>  }
>>
>> +static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
>> +                   const struct sys_reg_desc *rd)
>> +{
>> +    return REG_HIDDEN_USER | REG_HIDDEN_GUEST;
> 
> The handling of visibility has changed somehow since 01fe5ace92dd.

Thanks for the pointer!

Steve

>> +}
>> +
>>  /* sys_reg_desc initialiser for known cpufeature ID registers */
>>  #define ID_SANITISED(name) {            \
>>      SYS_DESC(SYS_##name),            \
>> @@ -1557,8 +1563,8 @@ static const struct sys_reg_desc sys_reg_descs[] 
>> = {
>>      { SYS_DESC(SYS_ACTLR_EL1), access_actlr, reset_actlr, ACTLR_EL1 },
>>      { SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
>>
>> -    { SYS_DESC(SYS_RGSR_EL1), access_mte_regs },
>> -    { SYS_DESC(SYS_GCR_EL1), access_mte_regs },
>> +    { SYS_DESC(SYS_RGSR_EL1), access_mte_regs, reset_unknown, RGSR_EL1,
>> .visibility = mte_visibility },
>> +    { SYS_DESC(SYS_GCR_EL1), access_mte_regs, reset_unknown, GCR_EL1,
>> .visibility = mte_visibility },
>>
>>      { SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility =
>> sve_visibility },
>>      { SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, 
>> TTBR0_EL1 },
>> @@ -1584,8 +1590,8 @@ static const struct sys_reg_desc sys_reg_descs[] 
>> = {
>>      { SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
>>      { SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
>>
>> -    { SYS_DESC(SYS_TFSR_EL1), access_mte_regs },
>> -    { SYS_DESC(SYS_TFSRE0_EL1), access_mte_regs },
>> +    { SYS_DESC(SYS_TFSR_EL1), access_mte_regs, reset_unknown, TFSR_EL1,
>> .visibility = mte_visibility },
>> +    { SYS_DESC(SYS_TFSRE0_EL1), access_mte_regs, reset_unknown,
>> TFSRE0_EL1, .visibility = mte_visibility },
>>
>>      { SYS_DESC(SYS_FAR_EL1), access_vm_reg, reset_unknown, FAR_EL1 },
>>      { SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },
> 
> Thanks,
> 
>          M.

