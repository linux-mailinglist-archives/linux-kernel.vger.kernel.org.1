Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A8D2B0304
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKLKrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:47:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbgKLKrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605178066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U58Dp7HKlOCi3zzkY5UzLsmwDbmNrCN0rpjOwlFDyTs=;
        b=EaX41muKH74zD3Sx9kJVQceErNV3UBDcVDejQT+SUAQwBIVBRfEXJwBpjY5fqN70xKgvg8
        kNRkjFA0VaSajh/hKOQ6ZXG/O5hNOgT3VEAMmsG8E5hVodvh0FT8T5COAjHEyOeFv0SGbc
        Js1fszUbIytCWCpi4RIDMJuHeB9/vEs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-mPmlLEAoPqyF9U5PFPPOPw-1; Thu, 12 Nov 2020 05:47:44 -0500
X-MC-Unique: mPmlLEAoPqyF9U5PFPPOPw-1
Received: by mail-wm1-f72.google.com with SMTP id y187so1993542wmy.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=U58Dp7HKlOCi3zzkY5UzLsmwDbmNrCN0rpjOwlFDyTs=;
        b=hdutzJwMobBiC4RnyMSR2qKQR9h9QDa0rwMO3pWN1/1RBsroCn2K7fRb16ybzXg1q4
         gjLQ+KKgxnw/EL8GchVIHxCcorWFUPmW/JUmafI+++VWGGhuAwzA8Era6zjUjM4gXdc+
         czGCXYlDoZ41BfrE7Iqk29M7TfMIPpElImeHSaQCzFi/5rbZSbz5biU/VAEo/9AgH4Xc
         YpPpjBgG45GXBYI8PSuILXuye5Ij0u/OluoRStZLcbf59h5sD0n7+xj1XrGtzdr0P8L3
         nzwUVw4slfoMD1cCZW6EvbuAo7jDcPtnTwL5Ge8GwvqMnEToUpYFYf4eFCZXDRgOUTtQ
         W2xg==
X-Gm-Message-State: AOAM532p87mLckP7Gs4BNi2Kf+L2iABge5C8yEEpx5Kh9/rlERLslXeY
        CPdXTY0CvtP2LlWK/hBUqHKAeSmgHvpY9nmQY7dutz8/nIO9ZkczbEx3wUWkTLZAb3x+w6Qh7Q7
        66lfjzvwpsNFD35IzxxqA+P+v3EilVdsIcnZOQXkSdIk/y/YYYLm+xcO5z1HPSle1pNhhlGo9/6
        Ul
X-Received: by 2002:a7b:c748:: with SMTP id w8mr9045678wmk.32.1605178063348;
        Thu, 12 Nov 2020 02:47:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGNECVrJaiU2hs4X3p6/OjOnbtXa1jH1DkI4ndBft2jyK4PGa2j96dI91jWN/T3OfkZc7pNQ==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr9045655wmk.32.1605178063127;
        Thu, 12 Nov 2020 02:47:43 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id y11sm5623866wmj.36.2020.11.12.02.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:47:42 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/11] KVM: VMX: Do Hyper-V TLB flush iff vCPU's EPTP
 hasn't been flushed
In-Reply-To: <20201027212346.23409-6-sean.j.christopherson@intel.com>
References: <20201027212346.23409-1-sean.j.christopherson@intel.com>
 <20201027212346.23409-6-sean.j.christopherson@intel.com>
Date:   Thu, 12 Nov 2020 11:47:41 +0100
Message-ID: <878sb6zwaa.fsf@vitty.brq.redhat.com>
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
>  arch/x86/kvm/vmx/vmx.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f5e9e2f61e10..17b228c4ba19 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -505,33 +505,26 @@ static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
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
> -				kvm_vmx->hv_tlb_eptp = INVALID_PAGE;
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
> +		if (kvm_vmx->ept_pointers_match == EPT_POINTERS_MISMATCH)
> +			kvm_vmx->hv_tlb_eptp = INVALID_PAGE;
>  	} else if (VALID_PAGE(kvm_vmx->hv_tlb_eptp)) {
>  		ret = hv_remote_flush_eptp(kvm_vmx->hv_tlb_eptp, range);
>  	}

It seems this patch makes EPT_POINTERS_MISMATCH an alias for
EPT_POINTERS_CHECK but this all is gone in the next patch, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

