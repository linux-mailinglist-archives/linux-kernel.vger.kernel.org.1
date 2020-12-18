Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CFF2DE09F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 10:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733123AbgLRJyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 04:54:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732918AbgLRJyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 04:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608285176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6RVjVRHhsYe3XpQF++UQyD52VVp++/9RVJAksaPzvc=;
        b=cJWfOBwyfBGyi1ZenZGORibCz3TJDy73GxYh5hv/CO+IBuL1Em6fc+reOO6+neqQvTFGVf
        RspL4Id7Bn59eiZDH7aYmrNHayRIeRD3+YzrAGcTb59J3XSdtUJsyaqWd1cRgrWM1MoXeb
        CHUX7wcpkKgzQkfwKxEBMxgF+iWOzv8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-tcgtBUsbMyGqu1VDtXL5Sg-1; Fri, 18 Dec 2020 04:52:53 -0500
X-MC-Unique: tcgtBUsbMyGqu1VDtXL5Sg-1
Received: by mail-ed1-f71.google.com with SMTP id i15so882682edx.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 01:52:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a6RVjVRHhsYe3XpQF++UQyD52VVp++/9RVJAksaPzvc=;
        b=LoIV9x5q4WX/F7CBF2AGW02w50St2fdcK5CfNVo52iHA5Itk8kCGKApM54aTj1q6gK
         c1wEx7UWtw9qZW1baeFudA4xvvyvbWuy5z50CsUI0ZQ4Z4kkREhzTK0hV+akcTNC8mW1
         P2VxwBQNin5ucS7O/MPqnCefOsak7IsLtbzqVW7Vwz3I3KZdkCe3p2AtaYVSDhNTbuGj
         KkYoOi25iC7Hp1JhwTTkb8JxdwJYFHb11CBgvjengr5Dt6IbHWQmlL4B4VXsyUiH+jcC
         TR+iQtKkYvHSzZ8kpCMWXJBT8dyxJPS4JTlWcSvqScAbRcPByNKlZV1sc+0KRjb9+Ol8
         cLzQ==
X-Gm-Message-State: AOAM532pBkorSl25rWbdZIZf7gF3HkvqWj1Qc33cbNNZ9MsL79kRRqZ4
        0tQ0L8oARDuIJuKWDYuvqBbDhF6AIZVh3HISudk6l2ecx3N2vdGqs1KLSAWXUfoz5El8Hv8hUSQ
        mTkmx4ZFMwil4eU65czUqGjPu
X-Received: by 2002:aa7:d6d8:: with SMTP id x24mr3557817edr.105.1608285172505;
        Fri, 18 Dec 2020 01:52:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlZQ2u1rTTQO4tt2JaV5Gy2f85VZgPGr2AdtSj/z6V5lxDmjH3TPGB4b3Y2vRE2VvAqjoSGQ==
X-Received: by 2002:aa7:d6d8:: with SMTP id x24mr3557786edr.105.1608285172028;
        Fri, 18 Dec 2020 01:52:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p22sm5269290ejx.59.2020.12.18.01.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 01:52:51 -0800 (PST)
Subject: Re: [PATCH] KVM/nVMX: Use __vmx_vcpu_run in
 nested_vmx_check_vmentry_hw
To:     Uros Bizjak <ubizjak@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
References: <20201217184451.201311-1-ubizjak@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <90780f46-dd6d-2ce9-0018-1daff515d918@redhat.com>
Date:   Fri, 18 Dec 2020 10:52:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201217184451.201311-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/20 19:44, Uros Bizjak wrote:
> Replace inline assembly in nested_vmx_check_vmentry_hw
> with a call to __vmx_vcpu_run.  The function is not
> performance critical, so (double) GPR save/restore
> in __vmx_vcpu_run can be tolerated, as far as performance
> effects are concerned.
> 
> v2: Mark vmx_vmenter SYM_FUNC_START_LOCAL.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Reviewed-and-tested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>   arch/x86/kvm/vmx/nested.c  | 32 +++-----------------------------
>   arch/x86/kvm/vmx/vmenter.S |  2 +-
>   arch/x86/kvm/vmx/vmx.c     |  2 --
>   arch/x86/kvm/vmx/vmx.h     |  1 +
>   4 files changed, 5 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 89af692deb7e..6ab62bf277c4 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -12,6 +12,7 @@
>   #include "nested.h"
>   #include "pmu.h"
>   #include "trace.h"
> +#include "vmx.h"
>   #include "x86.h"
>   
>   static bool __read_mostly enable_shadow_vmcs = 1;
> @@ -3056,35 +3057,8 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
>   		vmx->loaded_vmcs->host_state.cr4 = cr4;
>   	}
>   
> -	asm(
> -		"sub $%c[wordsize], %%" _ASM_SP "\n\t" /* temporarily adjust RSP for CALL */
> -		"cmp %%" _ASM_SP ", %c[host_state_rsp](%[loaded_vmcs]) \n\t"
> -		"je 1f \n\t"
> -		__ex("vmwrite %%" _ASM_SP ", %[HOST_RSP]") "\n\t"
> -		"mov %%" _ASM_SP ", %c[host_state_rsp](%[loaded_vmcs]) \n\t"
> -		"1: \n\t"
> -		"add $%c[wordsize], %%" _ASM_SP "\n\t" /* un-adjust RSP */
> -
> -		/* Check if vmlaunch or vmresume is needed */
> -		"cmpb $0, %c[launched](%[loaded_vmcs])\n\t"
> -
> -		/*
> -		 * VMLAUNCH and VMRESUME clear RFLAGS.{CF,ZF} on VM-Exit, set
> -		 * RFLAGS.CF on VM-Fail Invalid and set RFLAGS.ZF on VM-Fail
> -		 * Valid.  vmx_vmenter() directly "returns" RFLAGS, and so the
> -		 * results of VM-Enter is captured via CC_{SET,OUT} to vm_fail.
> -		 */
> -		"call vmx_vmenter\n\t"
> -
> -		CC_SET(be)
> -	      : ASM_CALL_CONSTRAINT, CC_OUT(be) (vm_fail)
> -	      :	[HOST_RSP]"r"((unsigned long)HOST_RSP),
> -		[loaded_vmcs]"r"(vmx->loaded_vmcs),
> -		[launched]"i"(offsetof(struct loaded_vmcs, launched)),
> -		[host_state_rsp]"i"(offsetof(struct loaded_vmcs, host_state.rsp)),
> -		[wordsize]"i"(sizeof(ulong))
> -	      : "memory"
> -	);
> +	vm_fail = __vmx_vcpu_run(vmx, (unsigned long *)&vcpu->arch.regs,
> +				 vmx->loaded_vmcs->launched);
>   
>   	if (vmx->msr_autoload.host.nr)
>   		vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.host.nr);
> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index 90ad7a6246e3..14abe1e37359 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -44,7 +44,7 @@
>    * they VM-Fail, whereas a successful VM-Enter + VM-Exit will jump
>    * to vmx_vmexit.
>    */
> -SYM_FUNC_START(vmx_vmenter)
> +SYM_FUNC_START_LOCAL(vmx_vmenter)
>   	/* EFLAGS.ZF is set if VMCS.LAUNCHED == 0 */
>   	je 2f
>   
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 47b8357b9751..72b496c54bc9 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6593,8 +6593,6 @@ static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
>   	}
>   }
>   
> -bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned long *regs, bool launched);
> -
>   static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>   					struct vcpu_vmx *vmx)
>   {
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index f6f66e5c6510..32db3b033e9b 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -339,6 +339,7 @@ void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
>   struct vmx_uret_msr *vmx_find_uret_msr(struct vcpu_vmx *vmx, u32 msr);
>   void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu);
>   void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp);
> +bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned long *regs, bool launched);
>   int vmx_find_loadstore_msr_slot(struct vmx_msrs *m, u32 msr);
>   void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu);
>   
> 

Queued, thanks.

Paolo

