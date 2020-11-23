Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C097F2C08C4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbgKWM7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 07:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388057AbgKWM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:57:33 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E201C061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:57:28 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id c80so19557111oib.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=exUXNPUBqsurzs6TF2YvQJu6wWbhf9lKT2IejTuCk6o=;
        b=I3OXYWhBSA+1mdoW0bKXVxLM3nK8o5rwHvWB5g9l7IGc+bV7qkL5+PU4hJ7b7NgL8z
         FXYI1z+65RYwIeIpZTVYS7zvkmm8FodW0mkraqyTAQcvv1C6iR1dTMAlpQi9gviXsaSE
         e/DtN+e5rUzphZT3+t1qAQx0pPq6QFj6Y5tH5Hdqqy8kTsJdyCnGszJY+13sD6iGoh07
         csHrxamprkhWDVgMDeYd6WO98tGoRH41ytiWYFy6xeBkP0bAKCKPLQkytzU591ldRU+5
         OXzeDkclqy+vcfGx6u3gaoLqNfgrmqKzKM2iJgvdZ5FBg/nm2nUts7VflWy4gL7iJqNO
         RCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=exUXNPUBqsurzs6TF2YvQJu6wWbhf9lKT2IejTuCk6o=;
        b=T/HuApD2I2vT7K8vYu4iyiCBi+s9rjWOXa3+wchgxWyAKE4nAU45l+fVlmzz3uDUE+
         Qr824L4LKz++itfb63cULWCu/QZO2cn1DUmdWjWX02KiyIkoXeaIaUlj4Tr0qViYJ7a+
         TNpjg66FNgn7AeWQdAwvLSH7lhv+vsahODA7hAvNtZD/rP6DpwuRa6uU8780ifpOd6Vj
         8cNMDF9Exr+pHNwyo+rVUkZx9jwbcqrg7UfaWiBjYs5SDAPlzakO++U40xKBEQJT2OpL
         JuadDqLUWIJ0SEUkJWiPGOnnAifQF0mJYA6AnvY5m07schFG4ZRSjnB3kgxuIOkZcCmC
         5Z4Q==
X-Gm-Message-State: AOAM532o8hnrT7MCmUCXwD3kszZKSFrzKYs5kqMf3lqOTwyHR4ylen6y
        g9UsSDDY55A4XD83S9D14tut0w==
X-Google-Smtp-Source: ABdhPJwzwpfeNQT89sLH3jtamJqzFPHhAkP5CxC0/IL/uG66e6CxjBbYWKqGxu2eQLKFnmXRE/oXZQ==
X-Received: by 2002:aca:6548:: with SMTP id j8mr15090532oiw.109.1606136247152;
        Mon, 23 Nov 2020 04:57:27 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:acac:b2ef:c7d:fd8a])
        by smtp.gmail.com with ESMTPSA id j73sm6677293otj.37.2020.11.23.04.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 04:57:26 -0800 (PST)
Date:   Mon, 23 Nov 2020 12:57:23 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com
Subject: Re: [RFC PATCH 09/27] KVM: arm64: Allow using kvm_nvhe_sym() in hyp
 code
Message-ID: <20201123125723.4mnodg3tnal4q4v2@google.com>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-10-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117181607.1761516-10-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:15:49PM +0000, 'Quentin Perret' via kernel-team wrote:
> In order to allow the usage of code shared by the host and the hyp in
> static inline library function, allow the usage of kvm_nvhe_sym() at el2
> by defaulting to the raw symbol name.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/hyp_image.h | 4 ++++
>  arch/arm64/include/asm/kvm_asm.h   | 4 ++--
>  arch/arm64/kvm/arm.c               | 2 +-
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
> index daa1a1da539e..8b807b646b8f 100644
> --- a/arch/arm64/include/asm/hyp_image.h
> +++ b/arch/arm64/include/asm/hyp_image.h
> @@ -7,11 +7,15 @@
>  #ifndef __ARM64_HYP_IMAGE_H__
>  #define __ARM64_HYP_IMAGE_H__
>  
> +#ifndef __KVM_NVHE_HYPERVISOR__
>  /*
>   * KVM nVHE code has its own symbol namespace prefixed with __kvm_nvhe_,
>   * to separate it from the kernel proper.
>   */
>  #define kvm_nvhe_sym(sym)	__kvm_nvhe_##sym
> +#else
> +#define kvm_nvhe_sym(sym)	sym
> +#endif
>  
>  #ifdef LINKER_SCRIPT
>  
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 1a86581e581e..e4934f5e4234 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -173,11 +173,11 @@ struct kvm_s2_mmu;
>  DECLARE_KVM_NVHE_SYM(__kvm_hyp_init);
>  DECLARE_KVM_NVHE_SYM(__kvm_hyp_host_vector);
>  DECLARE_KVM_HYP_SYM(__kvm_hyp_vector);
> -DECLARE_KVM_NVHE_SYM(__kvm_hyp_psci_cpu_entry);
>  #define __kvm_hyp_init			CHOOSE_NVHE_SYM(__kvm_hyp_init)
>  #define __kvm_hyp_host_vector		CHOOSE_NVHE_SYM(__kvm_hyp_host_vector)
>  #define __kvm_hyp_vector		CHOOSE_HYP_SYM(__kvm_hyp_vector)
> -#define __kvm_hyp_psci_cpu_entry	CHOOSE_NVHE_SYM(__kvm_hyp_psci_cpu_entry)
> +
> +void kvm_nvhe_sym(__kvm_hyp_psci_cpu_entry)(void);
>  
>  extern unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
>  DECLARE_KVM_NVHE_SYM(__per_cpu_start);
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 882eb383bd75..391cf6753a13 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1369,7 +1369,7 @@ static void cpu_prepare_hyp_mode(int cpu)
>  
>  	params->vector_hyp_va = kern_hyp_va((unsigned long)kvm_ksym_ref(__kvm_hyp_host_vector));
>  	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
> -	params->entry_hyp_va = kern_hyp_va((unsigned long)kvm_ksym_ref(__kvm_hyp_psci_cpu_entry));
> +	params->entry_hyp_va = kern_hyp_va((unsigned long)kvm_ksym_ref_nvhe(__kvm_hyp_psci_cpu_entry));

Why is this change needed?

>  	params->pgd_pa = kvm_mmu_get_httbr();
>  
>  	/*
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
