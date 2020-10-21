Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA53294C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411780AbgJUMXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406859AbgJUMXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603282998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WiRz+kFKIrNEgTelCpve6u1W10g3WBtsjsLl9b2ekkI=;
        b=Q/S27Q9onqAyQ+ctufye3tg8iDHTtfRbW4Ud0RiAHNkumvNtsZviHZArl1ThN97JZ19EqV
        xQORPsXp/p65fzrp+8zzhFin2Jn9U6hoqIzVOlfIlb4Se/g0OcP1VDCnykesiuD7dPdhpq
        qULtsb/HR+mblcra/kfMlHXCmaAyvA8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-dyYwuXQ0PYiSIfN6tdZqHA-1; Wed, 21 Oct 2020 08:23:16 -0400
X-MC-Unique: dyYwuXQ0PYiSIfN6tdZqHA-1
Received: by mail-wm1-f69.google.com with SMTP id f26so1279149wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WiRz+kFKIrNEgTelCpve6u1W10g3WBtsjsLl9b2ekkI=;
        b=crUOEGZ4pfZubo6hEIGSxrEhoUDSVHzrFgPkqArAWCcqHv1f7slLUZogx4R2HyqVff
         2ZrR/0ANhHID84ZL+xzbBVsn9FZSMwx0HBFhX6EJIqxSeoYnLPMb/E0aEIIHv95uj9lU
         UsiBHpMRJXOom6ba4HGWLkz6upmPadN5OH1Ea3UYoPfEZzKQEzKLrjrjxQaSQnciEf8w
         Ud1sR85yuS1eflrzCe1sl6lTSS1lsCaR9xxGPYDTA2D/LNO6I5e1r+aOeKBSk/BFWLcy
         5TflT1AEL8wq8ApZ0C7pFF+Q/+MZRmZ/544jNC1me5j6pgjTt9Fpz4PVgQyzr8mrpg+u
         jQPw==
X-Gm-Message-State: AOAM5316RT/Q/dvJ2oxHk0WML0KrdUV8Eb0ObkSRBibF1jSl9CqFQbxX
        HszDtMKLbGPmrn9MjvEs5CPhmjjpfo9MpZvOhcOgTdanPanizXR7StLxNbmcX/U8kdWGUhFalaK
        HISF0E7In4KTJ+cHwfnVFUP6k
X-Received: by 2002:a5d:6551:: with SMTP id z17mr4525008wrv.266.1603282995109;
        Wed, 21 Oct 2020 05:23:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtwSLm6YZu+DcgrnZ/h86D1ViOpkbDmwdo17WdmpNLiHxArp0j2/UErpXqPjrdxUTG7Scd+A==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr4524981wrv.266.1603282994778;
        Wed, 21 Oct 2020 05:23:14 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t12sm3636565wrm.25.2020.10.21.05.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 05:23:14 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] KVM: VMX: Do Hyper-V TLB flush iff vCPU's EPTP hasn't been flushed
In-Reply-To: <20201020215613.8972-5-sean.j.christopherson@intel.com>
References: <20201020215613.8972-1-sean.j.christopherson@intel.com> <20201020215613.8972-5-sean.j.christopherson@intel.com>
Date:   Wed, 21 Oct 2020 14:23:13 +0200
Message-ID: <87zh4f4vke.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Combine the for-loops for Hyper-V TLB EPTP checking and flushing, and in
> doing so skip flushes for vCPUs whose EPTP matches the target EPTP.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index bba6d91f1fe1..52cb9eec1db3 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -502,31 +502,23 @@ static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
>  
>  	spin_lock(&kvm_vmx->ept_pointer_lock);
>  
> -	if (kvm_vmx->ept_pointers_match == EPT_POINTERS_CHECK) {
> +	if (kvm_vmx->ept_pointers_match != EPT_POINTERS_MATCH) {
>  		kvm_vmx->ept_pointers_match = EPT_POINTERS_MATCH;
>  		kvm_vmx->hv_tlb_eptp = INVALID_PAGE;
>  
>  		kvm_for_each_vcpu(i, vcpu, kvm) {
>  			tmp_eptp = to_vmx(vcpu)->ept_pointer;
> -			if (!VALID_PAGE(tmp_eptp))
> +			if (!VALID_PAGE(tmp_eptp) ||
> +			    tmp_eptp == kvm_vmx->hv_tlb_eptp)
>  				continue;
>  
> -			if (!VALID_PAGE(kvm_vmx->hv_tlb_eptp)) {
> +			if (!VALID_PAGE(kvm_vmx->hv_tlb_eptp))
>  				kvm_vmx->hv_tlb_eptp = tmp_eptp;
> -			} else if (kvm_vmx->hv_tlb_eptp != tmp_eptp) {
> +			else
>  				kvm_vmx->ept_pointers_match
>  					= EPT_POINTERS_MISMATCH;
> -				break;
> -			}
> -		}
> -	}
>  
> -	if (kvm_vmx->ept_pointers_match != EPT_POINTERS_MATCH) {
> -		kvm_for_each_vcpu(i, vcpu, kvm) {
> -			/* If ept_pointer is invalid pointer, bypass flush request. */
> -			if (VALID_PAGE(to_vmx(vcpu)->ept_pointer))
> -				ret |= hv_remote_flush_eptp(to_vmx(vcpu)->ept_pointer,
> -							    range);
> +			ret |= hv_remote_flush_eptp(tmp_eptp, range);
>  		}
>  	} else if (VALID_PAGE(kvm_vmx->hv_tlb_eptp)) {
>  		ret = hv_remote_flush_eptp(kvm_vmx->hv_tlb_eptp, range);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

I have an unrelated question though. Does it make sense to call
hv_remote_flush_eptp() in case all EPTPs matches with ept_pointer_lock
spinlock held? Like if we had a match by the time of the call, does it
make a difference if the situation will change before or right after we
do the hypercall?

-- 
Vitaly

