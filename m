Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB12B013C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKLIcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:32:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgKLIcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605169965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=up1lOrEugzLW07KRiPo8mFDChEY+WGuuuWj0cewxi6M=;
        b=RbjbV8Sjv2WqzR/iTz5xm2vO9WfJ6rIeYHIcXzNuj8Uld77GVnD96NhaWyl/uwlftp1cZv
        egqWWj/+CUg+P5PvaZFGbS6TfDPRM1af/Lp6YYXyGVJZ7/My5taBOoNYmTtel5Gaw5P/Di
        vsvzMS2PIhU5INwDncYivTh6sSMTLtg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-yOAe-C5eMiiEdt41LzpNxA-1; Thu, 12 Nov 2020 03:32:42 -0500
X-MC-Unique: yOAe-C5eMiiEdt41LzpNxA-1
Received: by mail-wr1-f72.google.com with SMTP id f4so1605503wru.21
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 00:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=up1lOrEugzLW07KRiPo8mFDChEY+WGuuuWj0cewxi6M=;
        b=X/wX9qutYfC+pl+qwVAwob1ZwIVlkjIOBSlGKkx7R++SrTL/L6D2Fu52vmpFnLOzXq
         FaFfi9rNB/1kh8aya3y/BvXAJ8luWB6cqCcYQj+3FjPbiumDnQQB15CHV0VTauvCcrT9
         iEdkzRSlErfM7ocsNpesp1QKMVynsGGtiTSaSuTophieC7vwHCdQ1UuzOKbB47aJOPz2
         bURCc2OmQV7Og5WU7pO1orclq9D811VuJ3Fnzpc7BuciyS55MVvu4OInGCXhffZNQh2i
         QKu9oQNDfouQKXaOw3ymyZTrCD0JaRanO7nSQgZGJcgrKNw9M2HhS0aGelZvpfv+5aRB
         D2Uw==
X-Gm-Message-State: AOAM531nfSOuop3+ENG7z+K1NGxUF2rjoXkaSGI95BP8AOGMlL/iPyUj
        NlGNQkL+T1Ob1QXuNzNZKykW3MK0VFiCzBekrSB/rPvfW8RypHk3Ytt4CP32ww9IOSMOfBGKioe
        7S+YOhkQ1QQUAdUa7uUQ4JVO8
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr8351251wmj.109.1605169961516;
        Thu, 12 Nov 2020 00:32:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzWU8fZ9HRoVIS5lwVjtIkmc2UzdjOOXNZfQk70jewC7qS3zZSD9YvBvQ7DGMOuoPTMNDM2g==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr8351219wmj.109.1605169961257;
        Thu, 12 Nov 2020 00:32:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id k1sm1937588wrp.23.2020.11.12.00.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 00:32:40 -0800 (PST)
To:     Babu Moger <babu.moger@amd.com>
Cc:     junaids@google.com, wanpengli@tencent.com, kvm@vger.kernel.org,
        joro@8bytes.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, tglx@linutronix.de, vkuznets@redhat.com,
        jmattson@google.com
References: <160514082171.31583.9995411273370528911.stgit@bmoger-ubuntu>
 <160514090654.31583.12433653224184517852.stgit@bmoger-ubuntu>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] KVM:SVM: Mask SEV encryption bit from CR3 reserved
 bits
Message-ID: <09c5a083-a841-7d0e-f315-1d480e929957@redhat.com>
Date:   Thu, 12 Nov 2020 09:32:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <160514090654.31583.12433653224184517852.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/20 01:28, Babu Moger wrote:
> Add support to the mask_cr3_rsvd_bits() callback to mask the
> encryption bit from the CR3 value when SEV is enabled.
> 
> Additionally, cache the encryption mask for quick access during
> the check.
> 
> Fixes: a780a3ea628268b2 ("KVM: X86: Fix reserved bits check for MOV to CR3")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   arch/x86/kvm/svm/svm.c |   11 ++++++++++-
>   arch/x86/kvm/svm/svm.h |    3 +++
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index a491a47d7f5c..c2b1e52810c6 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3741,6 +3741,7 @@ static u64 svm_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
>   static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>   {
>   	struct vcpu_svm *svm = to_svm(vcpu);
> +	struct kvm_cpuid_entry2 *best;
>   
>   	vcpu->arch.xsaves_enabled = guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
>   				    boot_cpu_has(X86_FEATURE_XSAVE) &&
> @@ -3771,6 +3772,12 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>   	if (nested && guest_cpuid_has(vcpu, X86_FEATURE_SVM))
>   		kvm_request_apicv_update(vcpu->kvm, false,
>   					 APICV_INHIBIT_REASON_NESTED);
> +
> +	best = kvm_find_cpuid_entry(vcpu, 0x8000001F, 0);
> +	if (best)
> +		svm->sev_enc_mask = ~(1UL << (best->ebx & 0x3f));
> +	else
> +		svm->sev_enc_mask = ~0UL;
>   }
>   
>   static bool svm_has_wbinvd_exit(void)
> @@ -4072,7 +4079,9 @@ static void enable_smi_window(struct kvm_vcpu *vcpu)
>   
>   static unsigned long svm_mask_cr3_rsvd_bits(struct kvm_vcpu *vcpu, unsigned long cr3)
>   {
> -	return cr3;
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +
> +	return sev_guest(vcpu->kvm) ? (cr3 & svm->sev_enc_mask) : cr3;
>   }
>   
>   static bool svm_can_emulate_instruction(struct kvm_vcpu *vcpu, void *insn, int insn_len)
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 1d853fe4c778..57a36645a0e4 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -152,6 +152,9 @@ struct vcpu_svm {
>   	u64 *avic_physical_id_cache;
>   	bool avic_is_running;
>   
> +	/* SEV Memory encryption mask */
> +	unsigned long sev_enc_mask;
> +
>   	/*
>   	 * Per-vcpu list of struct amd_svm_iommu_ir:
>   	 * This is used mainly to store interrupt remapping information used
> 

Instead of adding a new callback, you can add a field to struct 
kvm_vcpu_arch:

  	if (is_long_mode(vcpu) &&
-	    (cr3 & rsvd_bits(cpuid_maxphyaddr(vcpu), 63)))
+	    (cr3 & vcpu->arch.cr3_lm_rsvd_bits))

Set it in kvm_vcpu_after_set_cpuid, and clear the memory encryption bit 
in kvm_x86_ops.vcpu_after_set_cpuid.

Paolo

