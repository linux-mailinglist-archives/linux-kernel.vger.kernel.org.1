Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38982D9B27
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408165AbgLNPfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:35:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408153AbgLNPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607960034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+PRiDgQULRi0yq6DjpeidJviTPzLRdIf0NEV0CGlxx4=;
        b=eimEfPuAN6/wk0fmXsFN/TvUoT13iiLHF4keeYLA4tpysjsKdCibp+SGyNTMg+S1CIgVUz
        GZufTPA1eHWuegTsCYFYun0pkfVnGLqodUttI/VODDRl3ylXDyFel1YVJnLvO518X0IbU+
        GW96pUL9IN01pvoSuHO7LTvq6Z5e/2A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-7Q-qtkHXMc6OyVGhtffK8A-1; Mon, 14 Dec 2020 10:33:53 -0500
X-MC-Unique: 7Q-qtkHXMc6OyVGhtffK8A-1
Received: by mail-ed1-f72.google.com with SMTP id dc6so8417630edb.14
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 07:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+PRiDgQULRi0yq6DjpeidJviTPzLRdIf0NEV0CGlxx4=;
        b=Ea3+kZN9Ke/5sN2JfzlrOpY2wQA0lK2qv/rJS9W0vyMWxIWhoEH88pey+GpUUHm0jf
         MSnMpJC+w50kjqtDx2gEYxFS0NAiC4Ey8ELe/0tr5UM3rZ3tBTItbdjgYo5tCgKgA+VO
         9s1f/KazbvEGB9kEEXIZCVFXLGd0PvXWRjKWXNq+FmFrIFt6Eo55taohLdSBCgAhVmbn
         4zMNrtfYspedqpsb9ZPEGwFDfAtALRWhT33QYyLLZ3Tms6zHeTm/+a4QTIiX7LLmoN+B
         63go97eA9un1aK2vByl2OHeNNq8Bx1B7W8xrsy6+Ru1dIs1wZp1Y4S1yB1BtH3Kz4Sio
         mnDw==
X-Gm-Message-State: AOAM532ngUhzG7Ep5KfylR2cdUICRCd3OHvnQxi0rG3LlCXlggzWvrI1
        IkD9TG2gKb1juKBza/n1mDzuuy/h2T6xGIkKcj0GEWKAdVW30kzwpw9zoyLQpvOVYVJNQ5ltveJ
        2t6cdbzAawYp1NsiMly6EfIQF
X-Received: by 2002:a17:906:ce3c:: with SMTP id sd28mr22787445ejb.485.1607960029278;
        Mon, 14 Dec 2020 07:33:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1XRhfOIcU3cutCLJJY4tOucC1Mb7zMFBkGD99zp+c++arxGGFE8VDh5rRqdlANcQAaDZwlA==
X-Received: by 2002:a17:906:ce3c:: with SMTP id sd28mr22786860ejb.485.1607960021472;
        Mon, 14 Dec 2020 07:33:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j5sm15718173edl.42.2020.12.14.07.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 07:33:39 -0800 (PST)
To:     Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1607620209.git.thomas.lendacky@amd.com>
 <eb73a31713e8ddc324b61c4d4425f27cbf5eae50.1607620209.git.thomas.lendacky@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 07/34] KVM: SVM: Add required changes to support
 intercepts under SEV-ES
Message-ID: <68d996e8-8f08-559c-c626-53f1daaff187@redhat.com>
Date:   Mon, 14 Dec 2020 16:33:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <eb73a31713e8ddc324b61c4d4425f27cbf5eae50.1607620209.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 18:09, Tom Lendacky wrote:
> @@ -2797,7 +2838,27 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>   
>   static int wrmsr_interception(struct vcpu_svm *svm)
>   {
> -	return kvm_emulate_wrmsr(&svm->vcpu);
> +	u32 ecx;
> +	u64 data;
> +
> +	if (!sev_es_guest(svm->vcpu.kvm))
> +		return kvm_emulate_wrmsr(&svm->vcpu);
> +
> +	ecx = kvm_rcx_read(&svm->vcpu);
> +	data = kvm_read_edx_eax(&svm->vcpu);
> +	if (kvm_set_msr(&svm->vcpu, ecx, data)) {
> +		trace_kvm_msr_write_ex(ecx, data);
> +		ghcb_set_sw_exit_info_1(svm->ghcb, 1);
> +		ghcb_set_sw_exit_info_2(svm->ghcb,
> +					X86_TRAP_GP |
> +					SVM_EVTINJ_TYPE_EXEPT |
> +					SVM_EVTINJ_VALID);
> +		return 1;
> +	}
> +
> +	trace_kvm_msr_write(ecx, data);
> +
> +	return kvm_skip_emulated_instruction(&svm->vcpu);
>   }
>   
>   static int msr_interception(struct vcpu_svm *svm)

This code duplication is ugly, and does not work with userspace MSR 
filters too.

But we can instead trap the completion of the MSR read/write to use 
ghcb_set_sw_exit_info_1 instead of kvm_inject_gp, with a callback like

static int svm_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
{
         if (!sev_es_guest(svm->vcpu.kvm) || !err)
                 return kvm_complete_insn_gp(&svm->vcpu, err);

         ghcb_set_sw_exit_info_1(svm->ghcb, 1);
         ghcb_set_sw_exit_info_2(svm->ghcb,
                                 X86_TRAP_GP |
                                 SVM_EVTINJ_TYPE_EXEPT |
                                 SVM_EVTINJ_VALID);
         return 1;
}


...
	.complete_emulated_msr = svm_complete_emulated_msr,

> @@ -2827,7 +2888,14 @@ static int interrupt_window_interception(struct vcpu_svm *svm)
>   static int pause_interception(struct vcpu_svm *svm)
>   {
>   	struct kvm_vcpu *vcpu = &svm->vcpu;
> -	bool in_kernel = (svm_get_cpl(vcpu) == 0);
> +	bool in_kernel;
> +
> +	/*
> +	 * CPL is not made available for an SEV-ES guest, so just set in_kernel
> +	 * to true.
> +	 */
> +	in_kernel = (sev_es_guest(svm->vcpu.kvm)) ? true
> +						  : (svm_get_cpl(vcpu) == 0);
>   
>   	if (!kvm_pause_in_guest(vcpu->kvm))
>   		grow_ple_window(vcpu);

See below.

> @@ -3273,6 +3351,13 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
>   	struct vcpu_svm *svm = to_svm(vcpu);
>   	struct vmcb *vmcb = svm->vmcb;
>   
> +	/*
> +	 * SEV-ES guests to not expose RFLAGS. Use the VMCB interrupt mask
> +	 * bit to determine the state of the IF flag.
> +	 */
> +	if (sev_es_guest(svm->vcpu.kvm))
> +		return !(vmcb->control.int_state & SVM_GUEST_INTERRUPT_MASK);

This seems wrong, you have to take into account 
SVM_INTERRUPT_SHADOW_MASK as well.  Also, even though GIF is not really 
used by SEV-ES guests, I think it's nicer to put this check afterwards.

That is:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4372e45c8f06..2dd9c9698480 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3247,7 +3247,14 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
  	if (!gif_set(svm))
  		return true;

-	if (is_guest_mode(vcpu)) {
+	if (sev_es_guest(svm->vcpu.kvm)) {
+		/*
+		 * SEV-ES guests to not expose RFLAGS. Use the VMCB interrupt mask
+		 * bit to determine the state of the IF flag.
+		 */
+		if (!(vmcb->control.int_state & SVM_GUEST_INTERRUPT_MASK))
+			return true;
+	} else if (is_guest_mode(vcpu)) {
  		/* As long as interrupts are being delivered...  */
  		if ((svm->nested.ctl.int_ctl & V_INTR_MASKING_MASK)
  		    ? !(svm->nested.hsave->save.rflags & X86_EFLAGS_IF)



>   	if (!gif_set(svm))
>   		return true;
>   
> @@ -3458,6 +3543,12 @@ static void svm_complete_interrupts(struct vcpu_svm *svm)
>   		svm->vcpu.arch.nmi_injected = true;
>   		break;
>   	case SVM_EXITINTINFO_TYPE_EXEPT:
> +		/*
> +		 * Never re-inject a #VC exception.
> +		 */
> +		if (vector == X86_TRAP_VC)
> +			break;
> +
>   		/*
>   		 * In case of software exceptions, do not reinject the vector,
>   		 * but re-execute the instruction instead. Rewind RIP first
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a3fdc16cfd6f..b6809a2851d2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4018,7 +4018,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>   {
>   	int idx;
>   
> -	if (vcpu->preempted)
> +	if (vcpu->preempted && !vcpu->arch.guest_state_protected)
>   		vcpu->arch.preempted_in_kernel = !kvm_x86_ops.get_cpl(vcpu);

This has to be true, otherwise no directed yield will be done at all:

	if (READ_ONCE(vcpu->preempted) && yield_to_kernel_mode &&
	    !kvm_arch_vcpu_in_kernel(vcpu))
		continue;

Or more easily, just use in_kernel == false in pause_interception, like

+	/*
+	 * CPL is not made available for an SEV-ES guest, therefore
+	 * vcpu->arch.preempted_in_kernel can never be true.  Just
+	 * set in_kernel to false as well.
+	 */
+	in_kernel = !sev_es_guest(svm->vcpu.kvm) && svm_get_cpl(vcpu) == 0;

>   
>   	/*
> @@ -8161,7 +8161,9 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
>   {
>   	struct kvm_run *kvm_run = vcpu->run;
>   
> -	kvm_run->if_flag = (kvm_get_rflags(vcpu) & X86_EFLAGS_IF) != 0;
> +	kvm_run->if_flag = (vcpu->arch.guest_state_protected)
> +		? kvm_arch_interrupt_allowed(vcpu)
> +		: (kvm_get_rflags(vcpu) & X86_EFLAGS_IF) != 0;

Here indeed you only want the interrupt allowed bit, not the interrupt 
window.  But we can just be bold and always set it to true.

- for userspace irqchip, kvm_run->ready_for_interrupt_injection is set 
just below and it will always be false if kvm_arch_interrupt_allowed is 
false

- for in-kernel APIC, if_flag is documented to be invalid (though it 
actually is valid).  For split irqchip, they can just use 
kvm_run->ready_for_interrupt_injection; for entirely in-kernel interrupt 
handling, userspace does not need if_flag at all.

Paolo

>   	kvm_run->flags = is_smm(vcpu) ? KVM_RUN_X86_SMM : 0;
>   	kvm_run->cr8 = kvm_get_cr8(vcpu);
>   	kvm_run->apic_base = kvm_get_apic_base(vcpu);
> 


