Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE9292651
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgJSLYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbgJSLYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603106641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hq4ZCvsEstWxmDC5Y+AIkMFzc4tSVhHqiOMH2psAJxk=;
        b=UMOfYq7THqj5byJbqpLfpS1uD8aaTag5OjW9Ouixpk5v4S6h1AoNspIBQXsbtTtGJemgAH
        x9sd6vd7qJAQzue+kal9knOBRBJSsuzcRjelVNcflF3OtS3QftcvhnhD/amg/Rp1krxwGp
        0JLfYuxL8gkxAlzoIrDlRdFvusBsTOY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-EInenvtDPS6UyDcz-50opQ-1; Mon, 19 Oct 2020 07:24:00 -0400
X-MC-Unique: EInenvtDPS6UyDcz-50opQ-1
Received: by mail-wr1-f72.google.com with SMTP id i6so7255268wrx.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 04:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Hq4ZCvsEstWxmDC5Y+AIkMFzc4tSVhHqiOMH2psAJxk=;
        b=abcpRzq9P18Jp3s0RhznYw0JK2px/M1KROd/GjBltS5hoImvZ3X1IK+JlkNq5RI+YB
         kGTyXAw3tLusOxax5yD/ouJFEvHG/49t3jqBaenZE2J/0PkQuWjtm6roHIsFMmga1Cfo
         J495AiBHcD1smMOjl1AaNSwKZy++esvqxP2dmaxZ06/IBv55Yi1Grp68wicd39P1cVfE
         9RztHtgL3QBwfRSpDVDan76Lql6Hqh39M26HTWylSPAqKiS9OwLBECrES+qdeuT7RL0M
         KWFyxPuoAzcJjDVFOK2/ikCFNegC6mOz2v5jhMJFacKFhaRwRIxqOBoTNuJPUmN+rxt/
         /7jQ==
X-Gm-Message-State: AOAM533FtmaVaivQnmWdpn+x45M6BUhT5cobPnNx1HxHyj1BPzT5HCGY
        wqUVXOqh9H7CIv79rYn15aoKjxoD6FgqICKM+g5JPP34s6976KI8Pl7T8T3+qxN4t+NjhbzuSFQ
        EFYtXwdS5f1RHaFziwYc3KSE7
X-Received: by 2002:a1c:b657:: with SMTP id g84mr17104836wmf.0.1603106638576;
        Mon, 19 Oct 2020 04:23:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1i/RV7VUN+OHcqUwFaEWXVn6phACO4s7j6t3VeHL2oTRq+sxihm4TZYtS5jcGTM8frt/Prw==
X-Received: by 2002:a1c:b657:: with SMTP id g84mr17104811wmf.0.1603106638345;
        Mon, 19 Oct 2020 04:23:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u202sm16230757wmu.23.2020.10.19.04.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 04:23:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     lihaiwei.kernel@gmail.com
Cc:     pbonzini@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        Haiwei Li <lihaiwei@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] KVM: Check the allocation of pv cpu mask
In-Reply-To: <20201017175436.17116-1-lihaiwei.kernel@gmail.com>
References: <20201017175436.17116-1-lihaiwei.kernel@gmail.com>
Date:   Mon, 19 Oct 2020 13:23:56 +0200
Message-ID: <87r1pu4fxv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lihaiwei.kernel@gmail.com writes:

> From: Haiwei Li <lihaiwei@tencent.com>
>
> check the allocation of per-cpu __pv_cpu_mask. Init
> 'send_IPI_mask_allbutself' only when successful and check the allocation
> of __pv_cpu_mask in 'kvm_flush_tlb_others'.
>
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
> v1 -> v2:
>  * add CONFIG_SMP for kvm_send_ipi_mask_allbutself to prevent build error
> v2 -> v3:
>  * always check the allocation of __pv_cpu_mask in kvm_flush_tlb_others
> v3 -> v4:
>  * mov kvm_setup_pv_ipi to kvm_alloc_cpumask and get rid of kvm_apic_init
>
>  arch/x86/kernel/kvm.c | 53 +++++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 42c6e0deff9e..be28203cc098 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -547,16 +547,6 @@ static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
>  	__send_ipi_mask(local_mask, vector);
>  }
>  
> -/*
> - * Set the IPI entry points
> - */
> -static void kvm_setup_pv_ipi(void)
> -{
> -	apic->send_IPI_mask = kvm_send_ipi_mask;
> -	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
> -	pr_info("setup PV IPIs\n");
> -}
> -
>  static void kvm_smp_send_call_func_ipi(const struct cpumask *mask)
>  {
>  	int cpu;
> @@ -619,6 +609,11 @@ static void kvm_flush_tlb_others(const struct cpumask *cpumask,
>  	struct kvm_steal_time *src;
>  	struct cpumask *flushmask = this_cpu_cpumask_var_ptr(__pv_cpu_mask);
>  
> +	if (unlikely(!flushmask)) {
> +		native_flush_tlb_others(cpumask, info);
> +		return;
> +	}
> +
>  	cpumask_copy(flushmask, cpumask);
>  	/*
>  	 * We have to call flush only on online vCPUs. And
> @@ -732,10 +727,6 @@ static uint32_t __init kvm_detect(void)
>  
>  static void __init kvm_apic_init(void)
>  {
> -#if defined(CONFIG_SMP)
> -	if (pv_ipi_supported())
> -		kvm_setup_pv_ipi();
> -#endif
>  }

Do we still need the now-empty function?

>  
>  static void __init kvm_init_platform(void)
> @@ -765,10 +756,18 @@ static __init int activate_jump_labels(void)
>  }
>  arch_initcall(activate_jump_labels);
>  
> +static void kvm_free_cpumask(void)
> +{
> +	unsigned int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		free_cpumask_var(per_cpu(__pv_cpu_mask, cpu));
> +}
> +
>  static __init int kvm_alloc_cpumask(void)
>  {
>  	int cpu;
> -	bool alloc = false;
> +	bool alloc = false, alloced = true;
>  
>  	if (!kvm_para_available() || nopv)
>  		return 0;
> @@ -783,10 +782,30 @@ static __init int kvm_alloc_cpumask(void)
>  
>  	if (alloc)
>  		for_each_possible_cpu(cpu) {
> -			zalloc_cpumask_var_node(per_cpu_ptr(&__pv_cpu_mask, cpu),
> -				GFP_KERNEL, cpu_to_node(cpu));
> +			if (!zalloc_cpumask_var_node(
> +				per_cpu_ptr(&__pv_cpu_mask, cpu),
> +				GFP_KERNEL, cpu_to_node(cpu))) {
> +				alloced = false;
> +				break;
> +			}
>  		}
>  
> +#if defined(CONFIG_SMP)
> +	/* Set the IPI entry points */
> +	if (pv_ipi_supported()) {

What if we define pv_ipi_supported() in !CONFIG_SMP case as 'false'?

The code we have above:

        if (pv_tlb_flush_supported())
		alloc = true;

#if defined(CONFIG_SMP)
        if (pv_ipi_supported())
		alloc = true;
#endif

      	if (alloc)
...

will transform into 'if (pv_tlb_flush_supported() ||
pv_ipi_supported())' and we'll get rid of 'alloc' variable.

Also, we can probably get rid of this new 'alloced' variable and switch
to checking if the cpumask for the last CPU in cpu_possible_mask is not
NULL.
 
> +		apic->send_IPI_mask = kvm_send_ipi_mask;
> +		if (alloced)
> +			apic->send_IPI_mask_allbutself =
> +				kvm_send_ipi_mask_allbutself;
> +		pr_info("setup PV IPIs\n");

I'd rather not set 'apic->send_IPI_mask = kvm_send_ipi_mask' in case we
failed to alloc cpumask too. It is weird that in case of an allocation
failure *some* IPIs will use the PV path and some won't. It's going to
be a nightmare to debug.

> +	}
> +#endif
> +
> +	if (!alloced) {
> +		kvm_free_cpumask();
> +		return -ENOMEM;
> +	}
> +
>  	return 0;
>  }
>  arch_initcall(kvm_alloc_cpumask);

-- 
Vitaly

