Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1F230410C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391377AbhAZO42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:56:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391040AbhAZJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611653594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PcrXNhlDKomMCLfJNYybeh+OpNdfCtsOzQcjyLVp37M=;
        b=fUkPCU/7b8+O4MZ7EXbxFGCHzkfYEKP+ua9Hs0PATVq0Mz3xnuAkl938b8HXVGsd4jWgup
        sfaSaAyKpuX4qkO72B7J3rsW52VUefmeaBT8goGcriyZu6JE1PVNiomgDtpPywO+74IbXW
        QWLiXB85yf3ApzNn07T6iZI4rAg9x0U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-GChiiOwsNMWmxCBONT9r2Q-1; Tue, 26 Jan 2021 04:33:13 -0500
X-MC-Unique: GChiiOwsNMWmxCBONT9r2Q-1
Received: by mail-ed1-f71.google.com with SMTP id ck25so9044709edb.16
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PcrXNhlDKomMCLfJNYybeh+OpNdfCtsOzQcjyLVp37M=;
        b=B9mU8+rwmx91OoFcrZDqs6BwQYoGKKd/Hlme/YZ8Ok/bYBomUx73Qskxh2qHYjxae/
         rdg5z2NCDP2y5DcVzpq+FI3LrLlsMk2yNPbv287/iotyxQxbDI9EESUxn3QI0hUoptY/
         G/PyyB4v+dweSm9jjpwAlDDkp0ze7hqbUNzELZ2K1z6fcPpi5LDr/JODt6Y+lO9+yqGI
         akScIh14M/aqYpfw0QOsPyHlPR5Hr/NNtfaQGXd1rLoqB98IwJkYtEort3JdsHa9Rcu6
         mK3riRhrvJ0KbQ7BMPpq5TKCCDi4JplpuW8O9cnPM44oTpKcNMmfTBLHIsdZw91pNqk4
         nlEw==
X-Gm-Message-State: AOAM5305j/aw2wdFGd8fFdeTDpr4tlhlaeDXc52aL5725rlqXy0rcGds
        JZeLOHJChg6lYcKnee+qTeZB1+hK2bWcqfNQ2okm4XpSjzdRSg2MiXeeTQaf0/qI8Tn04fcEx/T
        f5WziI2PY2xXSeRKp2FzDY8QYzkl82XGcplS71Wrdk/Ug+4gCERF+8whMGpb1jDD/Zex+uOEM84
        v5
X-Received: by 2002:a17:907:9710:: with SMTP id jg16mr3017575ejc.286.1611653592041;
        Tue, 26 Jan 2021 01:33:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyR/KtoRSXk3hGJDjmpgB2IHv1y+LGmFyGanS7w1DkJt6Hjfu5vnx33qOdP9bqKL93pCOatbw==
X-Received: by 2002:a17:907:9710:: with SMTP id jg16mr3017552ejc.286.1611653591863;
        Tue, 26 Jan 2021 01:33:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ke7sm9484812ejc.7.2021.01.26.01.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 01:33:11 -0800 (PST)
Subject: Re: [RESEND v13 10/10] KVM: vmx/pmu: Release guest LBR event via lazy
 release mechanism
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
 <20210108013704.134985-11-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <310d674c-44e7-7b46-064f-7cb88c456d0f@redhat.com>
Date:   Tue, 26 Jan 2021 10:33:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108013704.134985-11-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/21 02:37, Like Xu wrote:
> The vPMU uses GUEST_LBR_IN_USE_IDX (bit 58) in 'pmu->pmc_in_use' to
> indicate whether a guest LBR event is still needed by the vcpu. If the
> vcpu no longer accesses LBR related registers within a scheduling time
> slice, and the enable bit of LBR has been unset, vPMU will treat the
> guest LBR event as a bland event of a vPMC counter and release it
> as usual. Also, the pass-through state of LBR records msrs is cancelled.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>   arch/x86/kvm/pmu.c           |  7 +++++++
>   arch/x86/kvm/pmu.h           |  4 ++++
>   arch/x86/kvm/vmx/pmu_intel.c | 17 ++++++++++++++++-
>   3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 405890c723a1..e7c72eea07d4 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -463,6 +463,7 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu)
>   	struct kvm_pmc *pmc = NULL;
>   	DECLARE_BITMAP(bitmask, X86_PMC_IDX_MAX);
>   	int i;
> +	bool extra_cleanup = false;
>   
>   	pmu->need_cleanup = false;
>   
> @@ -474,8 +475,14 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu)
>   
>   		if (pmc && pmc->perf_event && !pmc_speculative_in_use(pmc))
>   			pmc_stop_counter(pmc);
> +
> +		if (i == INTEL_GUEST_LBR_INUSE)
> +			extra_cleanup = true;
>   	}
>   
> +	if (extra_cleanup && kvm_x86_ops.pmu_ops->cleanup)
> +		kvm_x86_ops.pmu_ops->cleanup(vcpu);
> +

You can call this function always, it's cleaner than hardcoding 
INTEL_GUEST_LBR_INUSE.

You can also use INTEL_PMC_IDX_FIXED_VLBR directly instead of 
INTEL_GUEST_LBR_INUSE.

Paolo

