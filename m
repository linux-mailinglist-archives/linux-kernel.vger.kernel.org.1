Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAC73045F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391428AbhAZSHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:07:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390781AbhAZJ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611653124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=psqoQb8M1ZbviHk/oEAqOvlNRFhfySafJPPh42D8Lw4=;
        b=fS1h4iJQukzMFvwajCbSwMUzd6J81P7UhpnpQICuD9hGTYgNhLsYQN9lV5/3JYHEFwWJy5
        rnEXxckRIzV6KZZQSaQNavkGm5zjNlnmjXnre1kywTmNtGMiHtn0i471Di5mpPypPvHEPz
        GTgUB02VE5F5NJC2f2mNGq0Oo7AdZ7I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-XOU79gXwMUyzVaYCVHKVFw-1; Tue, 26 Jan 2021 04:25:22 -0500
X-MC-Unique: XOU79gXwMUyzVaYCVHKVFw-1
Received: by mail-ed1-f71.google.com with SMTP id o19so9084418edq.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=psqoQb8M1ZbviHk/oEAqOvlNRFhfySafJPPh42D8Lw4=;
        b=pYZgiiYLz1nghvnuEx00tVBkuXuAv31mckhUANABgc6LBzsuzO9ExlZkrRJmxmz6GC
         wmwzqrU4ZBFd7S5y8yUMLv4+bfKvX7iDM45wMy1KXMT5Au76LI6JlKh5rOIIbxdvSJgT
         ljBzCJ2LEIArTLLj8wK3GFh85fw5PO6Nj/mk2+1eqlDwvoDqADICvhlqft9//xx2vMds
         yKgb34AhTbKeJ90AZf+JmISeftye7HkptC36XkTJuiWzNwwNtm9U3/gjqmRNAroMKtEV
         QjfJMTIzYjWjaXSmdVIMt4w2ZeiTNEqUyonfkWJGbjc4agTOBbmvFZUOFuTackAMnHIc
         mEKQ==
X-Gm-Message-State: AOAM53366e6WP6fhYjR6ylCcc1O3Gw/aDccevOHUMivBV3GkVGx1S25y
        uxByaU0QdmbbApOlAqnulFNu1WkWQq46LxIlXVy6jk6cXy5pqQjaBjJWdhnNw4R8sdPsyvSKSlZ
        RYAj7tpUN9/dJOmQGMLaYQBity1MHaR2We7xGA1oypBw9fDmLTKL77CV8vPT7ejF2biYXA9AwY4
        JV
X-Received: by 2002:a05:6402:22db:: with SMTP id dm27mr3928115edb.379.1611653120929;
        Tue, 26 Jan 2021 01:25:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzu8Mz662tDQlLDu7zmLZYNOETmSPQR4ZpjatODnRxEFNL9lQpsbL3OLGnygCaYP90+CIh/Ew==
X-Received: by 2002:a05:6402:22db:: with SMTP id dm27mr3928090edb.379.1611653120709;
        Tue, 26 Jan 2021 01:25:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id v25sm9550672ejw.21.2021.01.26.01.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 01:25:19 -0800 (PST)
Subject: Re: [RESEND v13 01/10] KVM: x86: Move common set/get handler of
 MSR_IA32_DEBUGCTLMSR to VMX
To:     Like Xu <like.xu@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        wei.w.wang@intel.com, kan.liang@intel.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210108013704.134985-1-like.xu@linux.intel.com>
 <20210108013704.134985-2-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a77477a2-cc64-ec8d-1258-f3222b6a358a@redhat.com>
Date:   Tue, 26 Jan 2021 10:25:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108013704.134985-2-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/21 02:36, Like Xu wrote:
> SVM already has specific handlers of MSR_IA32_DEBUGCTLMSR in the
> svm_get/set_msr, so the x86 common part can be safely moved to VMX.
> 
> Add vmx_supported_debugctl() to refactor the throwing logic of #GP.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>   arch/x86/kvm/vmx/capabilities.h |  5 +++++
>   arch/x86/kvm/vmx/vmx.c          | 19 ++++++++++++++++---
>   arch/x86/kvm/x86.c              | 13 -------------
>   3 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
> index 3a1861403d73..a58cf3655351 100644
> --- a/arch/x86/kvm/vmx/capabilities.h
> +++ b/arch/x86/kvm/vmx/capabilities.h
> @@ -378,4 +378,9 @@ static inline u64 vmx_get_perf_capabilities(void)
>   	return PMU_CAP_FW_WRITES;
>   }
>   
> +static inline u64 vmx_supported_debugctl(void)
> +{
> +	return DEBUGCTLMSR_LBR | DEBUGCTLMSR_BTF;
> +}
> +
>   #endif /* __KVM_X86_VMX_CAPS_H */
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 2af05d3b0590..23b46327527e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1924,6 +1924,9 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
>   			return 1;
>   		goto find_uret_msr;
> +	case MSR_IA32_DEBUGCTLMSR:
> +		msr_info->data = 0;
> +		break;
>   	default:
>   	find_uret_msr:
>   		msr = vmx_find_uret_msr(vmx, msr_info->index);
> @@ -2002,9 +2005,19 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   						VM_EXIT_SAVE_DEBUG_CONTROLS)
>   			get_vmcs12(vcpu)->guest_ia32_debugctl = data;
>   
> -		ret = kvm_set_msr_common(vcpu, msr_info);
> -		break;
> -
> +		if (!data) {
> +			/* We support the non-activated case already */
> +			return 0;
> +		} else if (data & ~vmx_supported_debugctl()) {
> +			/*
> +			 * Values other than LBR and BTF are vendor-specific,
> +			 * thus reserved and should throw a #GP.
> +			 */
> +			return 1;
> +		}
> +		vcpu_unimpl(vcpu, "%s: MSR_IA32_DEBUGCTLMSR 0x%llx, nop\n",
> +			    __func__, data);
> +		return 0;
>   	case MSR_IA32_BNDCFGS:
>   		if (!kvm_mpx_supported() ||
>   		    (!msr_info->host_initiated &&
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0287840b93e0..c765fd72a66c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3063,18 +3063,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   			return 1;
>   		}
>   		break;
> -	case MSR_IA32_DEBUGCTLMSR:
> -		if (!data) {
> -			/* We support the non-activated case already */
> -			break;
> -		} else if (data & ~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_BTF)) {
> -			/* Values other than LBR and BTF are vendor-specific,
> -			   thus reserved and should throw a #GP */
> -			return 1;
> -		} else if (report_ignored_msrs)
> -			vcpu_unimpl(vcpu, "%s: MSR_IA32_DEBUGCTLMSR 0x%llx, nop\n",
> -				    __func__, data);
> -		break;
>   	case 0x200 ... 0x2ff:
>   		return kvm_mtrr_set_msr(vcpu, msr, data);
>   	case MSR_IA32_APICBASE:
> @@ -3347,7 +3335,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   	switch (msr_info->index) {
>   	case MSR_IA32_PLATFORM_ID:
>   	case MSR_IA32_EBL_CR_POWERON:
> -	case MSR_IA32_DEBUGCTLMSR:
>   	case MSR_IA32_LASTBRANCHFROMIP:
>   	case MSR_IA32_LASTBRANCHTOIP:
>   	case MSR_IA32_LASTINTFROMIP:
> 

Queued, thanks.

Paolo

