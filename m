Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D895294E66
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 16:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443422AbgJUOUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 10:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46339 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2442794AbgJUOUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 10:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603290032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JiFxSuJ2FGqYz83ATOZ2qMT+S8z5SWmFzW4lLY1qn4I=;
        b=Y5ShbfMRR4F+JuOVR58Q76N3FfXf8AaTbw54TUdV0YYLEbKP2t2hC7UuN4UMNFGDA6Giea
        9hE70AWXNNc+KqtjpgUf5c8ivNvQD1ebXfZIc3gKJ6xUfKLKd08pvdt2RTGzDWHybFC1G2
        VzMrLvptiMBncRucAdTubDL2vL1C3HQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-f_73qoPKNzuopLQLC1pmTw-1; Wed, 21 Oct 2020 10:20:30 -0400
X-MC-Unique: f_73qoPKNzuopLQLC1pmTw-1
Received: by mail-wm1-f69.google.com with SMTP id z7so1679269wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 07:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JiFxSuJ2FGqYz83ATOZ2qMT+S8z5SWmFzW4lLY1qn4I=;
        b=s74lujSy55ypFW1N58vmm6rK/FNydHz6skKWvsG4Flg8b6Q46cwQlgrf6XWbOfMi5v
         xBgw/K13Qmb3gFmOuF3pAUFiKwGL5pcRbUnBwwDkOveRSrbCqCs/w2tUc9BGbeMvkCPe
         cAqNROEm9XaJvZyHZAj3+l5+MxdjtwKAwbL+1oZqjEG0+NpuimcZd+2Ln+XcAVImEgLu
         yRpv4zc1gTKtyVGbbukTlWuZw2LOFIJADS1AOM6/rPy1/k5DdSKoh9ONDKkIXls81qkZ
         Qayfjxf2ZtiZE8e6ZZC1osAY2yXLSTdwvcRSfTjolNG95UbgFJBG3mrJOCIiSnBDpRca
         lnjA==
X-Gm-Message-State: AOAM532AGjSsJZgq+mAYEucAyw3dNTOMgOuXct+S5GHbdbSKURrilNlm
        3snhfKOm36EONz8SdD2hluqBk9a+T0c/A0lPFNRQmh5KxsS9fwohN4eheYXxn3u0AzQGwQgu1uf
        0HiHFC8d9JExWEgAoTKESMT0P
X-Received: by 2002:a1c:39c2:: with SMTP id g185mr3744028wma.28.1603290028399;
        Wed, 21 Oct 2020 07:20:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0P6KKxCCSIHUEVGmBlp11OfL8y+nHHhgBTbaJwPGQzmFILSnfAW14ustdtKbw8rG9ggymAw==
X-Received: by 2002:a1c:39c2:: with SMTP id g185mr3744006wma.28.1603290028187;
        Wed, 21 Oct 2020 07:20:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w1sm3993823wrp.95.2020.10.21.07.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 07:20:27 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] KVM: VMX: Define Hyper-V paravirt TLB flush fields iff Hyper-V is enabled
In-Reply-To: <20201020215613.8972-9-sean.j.christopherson@intel.com>
References: <20201020215613.8972-1-sean.j.christopherson@intel.com> <20201020215613.8972-9-sean.j.christopherson@intel.com>
Date:   Wed, 21 Oct 2020 16:20:26 +0200
Message-ID: <87o8kv4q51.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Ifdef away the Hyper-V specific fields in structs kvm_vmx and vcpu_vmx
> as each field has only a single reference outside of the struct itself
> that isn't already wrapped in ifdeffery (and both are initialization).
>
> vcpu_vmx.ept_pointer in particular should be wrapped as it is valid if
> and only if Hyper-v is active, i.e. non-Hyper-V code cannot rely on it
> to actually track the current EPTP (without additional code changes).
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 5 ++++-
>  arch/x86/kvm/vmx/vmx.h | 4 ++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 55d6b699d8e3..a45a90d44d24 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6933,8 +6933,9 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
>  	vmx->pi_desc.nv = POSTED_INTR_VECTOR;
>  	vmx->pi_desc.sn = 1;
>  
> +#if IS_ENABLED(CONFIG_HYPERV)
>  	vmx->ept_pointer = INVALID_PAGE;
> -
> +#endif
>  	return 0;
>  
>  free_vmcs:
> @@ -6951,7 +6952,9 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
>  
>  static int vmx_vm_init(struct kvm *kvm)
>  {
> +#if IS_ENABLED(CONFIG_HYPERV)
>  	spin_lock_init(&to_kvm_vmx(kvm)->ept_pointer_lock);
> +#endif
>  
>  	if (!ple_gap)
>  		kvm->arch.pause_in_guest = true;
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index e8d7d07b2020..1b8c08e483cd 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -276,7 +276,9 @@ struct vcpu_vmx {
>  	 */
>  	u64 msr_ia32_feature_control;
>  	u64 msr_ia32_feature_control_valid_bits;
> +#if IS_ENABLED(CONFIG_HYPERV)
>  	u64 ept_pointer;
> +#endif
>  
>  	struct pt_desc pt_desc;
>  
> @@ -295,8 +297,10 @@ struct kvm_vmx {
>  	bool ept_identity_pagetable_done;
>  	gpa_t ept_identity_map_addr;
>  
> +#if IS_ENABLED(CONFIG_HYPERV)
>  	hpa_t hv_tlb_eptp;
>  	spinlock_t ept_pointer_lock;
> +#endif
>  };
>  
>  bool nested_vmx_allowed(struct kvm_vcpu *vcpu);

Assuming this compiles without CONFIG_HYPERV,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

