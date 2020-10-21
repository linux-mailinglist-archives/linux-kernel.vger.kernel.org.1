Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1885A294C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442154AbgJUMAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2442135AbgJUMAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603281610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FEqXz7G12+BmHZNYqLH7P68s5dXdeke9n26KkMvS1JY=;
        b=DsRT9vRI8+PLZV5r+AEWLFi/z9nVUc/ZqOOofVY86b50YMEeqRcZ6XDzjIBz9BpLPjxK57
        0xaX4uD9QlOSF1rOj8Hm/l4GLceYugvyrdMvmpCEEEMmDjHgTbSsygPVj0VGrGalarichK
        0OB0f6vBvKxFWmBsOIhms+uYqtz+TNE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-xtALwNQAPjiwQ1iXIgdKsA-1; Wed, 21 Oct 2020 08:00:08 -0400
X-MC-Unique: xtALwNQAPjiwQ1iXIgdKsA-1
Received: by mail-wm1-f72.google.com with SMTP id 13so1310802wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FEqXz7G12+BmHZNYqLH7P68s5dXdeke9n26KkMvS1JY=;
        b=Pvkcr449S7hiI6EcsTcXRmcrLiYRhTEn+yst1VjpQ4RA0fAbs/ATejJzMeM9S52lBm
         LjUxSG9qbVhNYECwOx8I+fT/DEXflUzAhx/0CGxFaq6sV6TX0Brb5euAmaxuQNsOo22y
         nfi7WfTIrZihQgH+Sg8Sn+85LoRr9tjmbv12QdGtnsuo0ypcOIErB5HZRnyVDGiZggIL
         SgAdAu7Yzzvc1LRVlVQfvYw7nJYO1qkaSyaE0xo4paAKYB6iWacl/Hygz6I2jG2Mlqvx
         ZIYKePVyIx3eWyOGU7zA8Qx0/hVdLvb4CtYM1pON3sfcFuikjBjpQhaamVv+rxSJfOqY
         8vUA==
X-Gm-Message-State: AOAM5301IBJRHci6P4i0b/Wkzq1abPzALlFZdilggHkKKvzVVbwWYRX9
        vtR9pbUX4ppYtuCOA++YxBCUXKyt5MveJPcB5hSqSJsgxjGZs3DgnrTTu0dRrcNiy9jCPUbqvEi
        tKYIF6FMurKVYPeMcuStVH1lw
X-Received: by 2002:a1c:f30d:: with SMTP id q13mr3126695wmq.36.1603281606856;
        Wed, 21 Oct 2020 05:00:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHhHdy2ZltzmZpn86eWLCHMlwJ/xFHhZ81m7k3oEdPSWZPH4DPgsohX7uVZ9pypeXKMWfgUg==
X-Received: by 2002:a1c:f30d:: with SMTP id q13mr3126664wmq.36.1603281606572;
        Wed, 21 Oct 2020 05:00:06 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d30sm3601490wrc.19.2020.10.21.05.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 05:00:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] KVM: VMX: Stash kvm_vmx in a local variable for Hyper-V paravirt TLB flush
In-Reply-To: <20201020215613.8972-3-sean.j.christopherson@intel.com>
References: <20201020215613.8972-1-sean.j.christopherson@intel.com> <20201020215613.8972-3-sean.j.christopherson@intel.com>
Date:   Wed, 21 Oct 2020 14:00:04 +0200
Message-ID: <875z736b7f.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Capture kvm_vmx in a local variable instead of polluting
> hv_remote_flush_tlb_with_range() with to_kvm_vmx(kvm).
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 6d53bcc4a1a9..6d41c99c70c4 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -516,26 +516,27 @@ static inline int hv_remote_flush_eptp(u64 eptp, struct kvm_tlb_range *range)
>  static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
>  		struct kvm_tlb_range *range)
>  {
> +	struct kvm_vmx *kvm_vmx = to_kvm_vmx(kvm);
>  	struct kvm_vcpu *vcpu;
>  	int ret = 0, i;
>  
> -	spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
> +	spin_lock(&kvm_vmx->ept_pointer_lock);
>  
> -	if (to_kvm_vmx(kvm)->ept_pointers_match == EPT_POINTERS_CHECK)
> +	if (kvm_vmx->ept_pointers_match == EPT_POINTERS_CHECK)
>  		check_ept_pointer_match(kvm);
>  
> -	if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
> +	if (kvm_vmx->ept_pointers_match != EPT_POINTERS_MATCH) {
>  		kvm_for_each_vcpu(i, vcpu, kvm) {
>  			/* If ept_pointer is invalid pointer, bypass flush request. */
>  			if (VALID_PAGE(to_vmx(vcpu)->ept_pointer))
>  				ret |= hv_remote_flush_eptp(to_vmx(vcpu)->ept_pointer,
>  							    range);
>  		}
> -	} else if (VALID_PAGE(to_kvm_vmx(kvm)->hv_tlb_eptp)) {
> -		ret = hv_remote_flush_eptp(to_kvm_vmx(kvm)->hv_tlb_eptp, range);
> +	} else if (VALID_PAGE(kvm_vmx->hv_tlb_eptp)) {
> +		ret = hv_remote_flush_eptp(kvm_vmx->hv_tlb_eptp, range);
>  	}
>  
> -	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
> +	spin_unlock(&kvm_vmx->ept_pointer_lock);
>  	return ret;
>  }
>  static int hv_remote_flush_tlb(struct kvm *kvm)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

