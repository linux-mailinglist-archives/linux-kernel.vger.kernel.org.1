Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D0275909
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIWNpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:45:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40410 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726636AbgIWNpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600868716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QG/XpftCpbOncz4MqVk/ddxYXgT+Lw6rTWS+CEJwsqw=;
        b=ReEgkbugASa+6SobL6eqkznxF5lT2rg/URIBOqcw5Ufy3qCvjs4mdsfdfumBeLLohupLhi
        eKiEH/rFnmofpYhz3XrDAW7KQNDnBQ4d5Au2l9bp+K9pBLtzDdWvkWUQvOWuF3ZSS9FZ8G
        iE9nqw0ZV8VPt0SiV3rcNKuZ4YFn88M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-KqIyla3VMuqmTLn_sF1zYw-1; Wed, 23 Sep 2020 09:45:13 -0400
X-MC-Unique: KqIyla3VMuqmTLn_sF1zYw-1
Received: by mail-wr1-f69.google.com with SMTP id a12so8847659wrg.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 06:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QG/XpftCpbOncz4MqVk/ddxYXgT+Lw6rTWS+CEJwsqw=;
        b=q7tLBEdQgwPk2nGFOAjdACR4/SnkRPvesM+g/HMyIOfgxAB/iX74FP9mWX02G2XYrv
         MAJPxk3wWQ3Hmw/17TvU53K1T+HEJX+WrCqBJtCb3v7RXT+xTdbWgtfVy7NcalCKfOxY
         vv5DZOQ2JylOyZBwugd6SHE/F3zHb4Zm3qumqK+b1Dan5vFR7jTY24HFRl0WThIlunT+
         9fGo9HL0rQURbpjuiu/lqc5DyrNudekcDJkK2wQfxyM75TjhiWzJLhQqNeaYBSPR7xwP
         bPIMdMmSJZOcdJ8BS0u3hzU5x4/X/WAk2fhutAXquzX17qDsEoaC7LHe9Ng7hzUewW+2
         bVRw==
X-Gm-Message-State: AOAM533XJ9PjnXkduip/rWP5DBobCBauu8PMGTREgH82xS8wZUXFewAf
        eRIkNQnW2bZPcDpf7dNh8X+uXbOUzZsYkvDRH7hqtdx5Tm4ruLzWUAgixAP4RwAmZ68oL1N8tDw
        QKI0d55RS7DKhDBsb8mlFyCon
X-Received: by 2002:a5d:4f12:: with SMTP id c18mr894640wru.33.1600868712235;
        Wed, 23 Sep 2020 06:45:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb3cleun1Mcb1EtEe3QbBYzLOy6zExpHXgfTHp4hlVL/wCgtWG6/xhTdTSb3C3JjWrxKZ/Hw==
X-Received: by 2002:a5d:4f12:: with SMTP id c18mr894615wru.33.1600868711914;
        Wed, 23 Sep 2020 06:45:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9? ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
        by smtp.gmail.com with ESMTPSA id 97sm32423184wrm.15.2020.09.23.06.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 06:45:10 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: VMX: Make smaller physical guest address space
 support user-configurable
To:     Mohammed Gamal <mgamal@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org
References: <20200903141122.72908-1-mgamal@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c7ce8ff-a212-a974-3829-c45eb5335651@redhat.com>
Date:   Wed, 23 Sep 2020 15:45:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903141122.72908-1-mgamal@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/20 16:11, Mohammed Gamal wrote:
> This patch exposes allow_smaller_maxphyaddr to the user as a module parameter.
> 
> Since smaller physical address spaces are only supported on VMX, the parameter
> is only exposed in the kvm_intel module.
> Modifications to VMX page fault and EPT violation handling will depend on whether
> that parameter is enabled.
> 
> Also disable support by default, and let the user decide if they want to enable
> it.
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 15 ++++++---------
>  arch/x86/kvm/vmx/vmx.h |  3 +++
>  arch/x86/kvm/x86.c     |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 819c185adf09..dc778c7b5a06 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -129,6 +129,9 @@ static bool __read_mostly enable_preemption_timer = 1;
>  module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
>  #endif
>  
> +extern bool __read_mostly allow_smaller_maxphyaddr;
> +module_param(allow_smaller_maxphyaddr, bool, S_IRUGO | S_IWUSR);
> +
>  #define KVM_VM_CR0_ALWAYS_OFF (X86_CR0_NW | X86_CR0_CD)
>  #define KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST X86_CR0_NE
>  #define KVM_VM_CR0_ALWAYS_ON				\
> @@ -4798,7 +4801,8 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>  
>  	if (is_page_fault(intr_info)) {
>  		cr2 = vmx_get_exit_qual(vcpu);
> -		if (enable_ept && !vcpu->arch.apf.host_apf_flags) {
> +		if (enable_ept && !vcpu->arch.apf.host_apf_flags
> +			&& allow_smaller_maxphyaddr) {
>  			/*
>  			 * EPT will cause page fault only if we need to
>  			 * detect illegal GPAs.
> @@ -5331,7 +5335,7 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
>  	 * would also use advanced VM-exit information for EPT violations to
>  	 * reconstruct the page fault error code.
>  	 */
> -	if (unlikely(kvm_mmu_is_illegal_gpa(vcpu, gpa)))
> +	if (unlikely(kvm_mmu_is_illegal_gpa(vcpu, gpa)) && allow_smaller_maxphyaddr)
>  		return kvm_emulate_instruction(vcpu, 0);
>  
>  	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
> @@ -8303,13 +8307,6 @@ static int __init vmx_init(void)
>  #endif
>  	vmx_check_vmcs12_offsets();
>  
> -	/*
> -	 * Intel processors don't have problems with
> -	 * GUEST_MAXPHYADDR < HOST_MAXPHYADDR so enable
> -	 * it for VMX by default
> -	 */
> -	allow_smaller_maxphyaddr = true;
> -
>  	return 0;
>  }
>  module_init(vmx_init);
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 26175a4759fa..b859435efa2e 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -551,6 +551,9 @@ static inline bool vmx_has_waitpkg(struct vcpu_vmx *vmx)
>  
>  static inline bool vmx_need_pf_intercept(struct kvm_vcpu *vcpu)
>  {
> +	if (!allow_smaller_maxphyaddr)
> +		return false;
> +
>  	return !enable_ept || cpuid_maxphyaddr(vcpu) < boot_cpu_data.x86_phys_bits;

This needs to return true if !enable_ept.

	if (!enable_ept)
		return true;

	return allow_smaller_maxphyaddr &&
		 cpuid_maxphyaddr(vcpu) < boot_cpu_data.x86_phys_bits;

Fixed and queued, thanks.

Paolo

>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d39d6cf1d473..982f1d73a884 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -188,7 +188,7 @@ static struct kvm_shared_msrs __percpu *shared_msrs;
>  u64 __read_mostly host_efer;
>  EXPORT_SYMBOL_GPL(host_efer);
>  
> -bool __read_mostly allow_smaller_maxphyaddr;
> +bool __read_mostly allow_smaller_maxphyaddr = 0;
>  EXPORT_SYMBOL_GPL(allow_smaller_maxphyaddr);
>  
>  static u64 __read_mostly host_xss;
> 

