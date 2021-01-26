Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A569303B95
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404956AbhAZL1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:27:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391162AbhAZJbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611653408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+ZpZHpOkIPnIutZEYCghjpUFXEecoOLDsLy71i5vGQ=;
        b=hR4pW+LWomkdON9SViap7LahQOgEMGyng20K4Fs+wXkh3aC9iqhRImreKN73gpfVvdA/30
        880423Pt/NL6e6lNtsDo+ZqMEY3KP8Qnoen8fo5fd9MU1k3U0El2dlJTeh9+WJG4zNtGfd
        14aKiZGy5r8Itdgvmf2EyNXwkJmL1qY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-y6F1hYppPgiDu2r3UvxGzg-1; Tue, 26 Jan 2021 04:30:07 -0500
X-MC-Unique: y6F1hYppPgiDu2r3UvxGzg-1
Received: by mail-wr1-f70.google.com with SMTP id u3so10815185wri.19
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h+ZpZHpOkIPnIutZEYCghjpUFXEecoOLDsLy71i5vGQ=;
        b=KcHspg6P0HZF1OQAB6sjwraf95P6kwA9GhKuTEPVTtSbvugspclnP0urRnSJYMx6BK
         uRnH3RcIZDef6AabjJpwX1wYYyd5e2UqsLKy5X4NzSkeMnNlMDxO5PLJHKuixpaOgOkO
         pq/rKO0oPYbIW+d8oJbjZty8HdO6eFfugY3l6nOHIqBrOlX+KZCdwWsAky03dxpUNjhw
         eLCRKu+xnRdOt7b9kv9t9HZFdb34OK/Umg/y3Ln7pjR2Pb1+/h2KlZPxwHLzM4jIqgEg
         Yg+GXEVACjWJ14OMH3RQuBgSRjQQ/jdyt0lEmg0KcR0leP1iJ9yv6u9P41F3yx7n2GCh
         3Zuw==
X-Gm-Message-State: AOAM531lbWQ8AZnoSQzCEAhKrkgtDeD99ndvuadKoP3GEKTNFjeTfdUA
        9QNqbRq536b272LIvPbw0bxnvg2BI046knPnxaLXmpxjjV5ThG/mmSzQU88EU2B+ApQ/luWtbCk
        uUSHZ5KIAYA3DFepveR9lUMyCTNfhPlpB4GkOtlvS7/uOYSp/YyahMtf/4QItw6uPxTS3H+yhwS
        nA
X-Received: by 2002:a05:6000:1142:: with SMTP id d2mr5142103wrx.307.1611653405294;
        Tue, 26 Jan 2021 01:30:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWAoc/h4SZNsmz+mkEnH2HYCgpbjliy09pP/DmoI918Oq2WzaI7/Z4F+HSwDBlb9skYXBc3w==
X-Received: by 2002:a05:6000:1142:: with SMTP id d2mr5142070wrx.307.1611653405005;
        Tue, 26 Jan 2021 01:30:05 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k131sm2540210wmb.37.2021.01.26.01.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 01:30:04 -0800 (PST)
Subject: Re: [RESEND v13 09/10] KVM: vmx/pmu: Expose LBR_FMT in the
 MSR_IA32_PERF_CAPABILITIES
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
 <20210108013704.134985-10-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ff8ca5a-32ec-ca5d-50c3-d1690e933f6d@redhat.com>
Date:   Tue, 26 Jan 2021 10:30:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108013704.134985-10-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/21 02:37, Like Xu wrote:
> Userspace could enable guest LBR feature when the exactly supported
> LBR format value is initialized to the MSR_IA32_PERF_CAPABILITIES
> and the LBR is also compatible with vPMU version and host cpu model.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>   arch/x86/kvm/vmx/capabilities.h | 9 ++++++++-
>   arch/x86/kvm/vmx/vmx.c          | 7 +++++++
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
> index 57b940c613ab..a9a7c4d1b634 100644
> --- a/arch/x86/kvm/vmx/capabilities.h
> +++ b/arch/x86/kvm/vmx/capabilities.h
> @@ -378,7 +378,14 @@ static inline u64 vmx_get_perf_capabilities(void)
>   	 * Since counters are virtualized, KVM would support full
>   	 * width counting unconditionally, even if the host lacks it.
>   	 */
> -	return PMU_CAP_FW_WRITES;
> +	u64 perf_cap = PMU_CAP_FW_WRITES;
> +
> +	if (boot_cpu_has(X86_FEATURE_PDCM))
> +		rdmsrl(MSR_IA32_PERF_CAPABILITIES, perf_cap);
> +
> +	perf_cap |= perf_cap & PMU_CAP_LBR_FMT;
> +
> +	return perf_cap;
>   }
>   
>   static inline u64 vmx_supported_debugctl(void)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ad3b079f6700..9cb5b1e4fc27 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2229,6 +2229,13 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   	case MSR_IA32_PERF_CAPABILITIES:
>   		if (data && !vcpu_to_pmu(vcpu)->version)
>   			return 1;
> +		if (data & PMU_CAP_LBR_FMT) {
> +			if ((data & PMU_CAP_LBR_FMT) !=
> +			    (vmx_get_perf_capabilities() & PMU_CAP_LBR_FMT))
> +				return 1;
> +			if (!intel_pmu_lbr_is_compatible(vcpu))
> +				return 1;
> +		}
>   		ret = kvm_set_msr_common(vcpu, msr_info);
>   		break;
>   
> 

Please move this hunk to patch 4.

Paolo

