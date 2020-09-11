Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62214266654
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgIKRZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:25:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39538 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbgIKRZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599845140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rq3sqFL6vTqtj3WUeeDyK7taU7BHDxoUtnP2+8arByI=;
        b=Tmybk7QSPiiqzSjZZsJIiJfDExgyLmwX90fgkW+kNWlTVaRPhWLRDiiMDIOwXvc5sVs09R
        Oa5YycB/NfDFVs5jdFuwRCX2jt0MynV4HG2288qb3vAXZhZZZxS8WkxnA+9gZXCV+ewklg
        uZefuWYHSu5a9vW9eX1ouRDjQJMFErI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-9b49q9DuPI-UffjuoPqj7A-1; Fri, 11 Sep 2020 13:25:36 -0400
X-MC-Unique: 9b49q9DuPI-UffjuoPqj7A-1
Received: by mail-wm1-f72.google.com with SMTP id d22so1617605wmd.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rq3sqFL6vTqtj3WUeeDyK7taU7BHDxoUtnP2+8arByI=;
        b=ZqNPXLKRbDpnxfbRLlmOPGc23YmOySEDFKXqGa/cp6NEUYCk1wGmnQOjKxxiAJtg4k
         QH9LyAabXqnYNjwXDX3VThLzHxD1U3oiqruXWluUdJ7yhFAg43xuaxGnmiYUO9pihcog
         jkpA53OmCf+C+L4HWm1DO3of+YFwOl0B+utuF/Td8yOtEn2e5MyviDxoc1xNYN7GpS8f
         ri7L8mvyxyfCT8531jAm8LpoleSClWZYAfMhoFP8/UuSCH3ZjEen/mnUx62iGl+H02wN
         +OBLj+qra9SnYs4xe+N7lYVptv2R4cCHAzOEOcjkiXAYwI4/Qz8gN+TYDUrUt/62gl/F
         EvFw==
X-Gm-Message-State: AOAM532NM0u1bsDVI/y/Quey7CaiGWp9eGxo/BT+08zJXFj9A8ThJBtH
        SyEMvIqlQNMr1RP8imeovmVXMVciRgyRbwmn+um6XmTCFeZOHIX+PBTYtZfItkUC5BABsEbnlOm
        mpW+Ro7jvwk5kFSmf8a+TMtw2
X-Received: by 2002:a1c:2e4b:: with SMTP id u72mr3249512wmu.69.1599845134542;
        Fri, 11 Sep 2020 10:25:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE3otLO4wRNpP+aV23Yy58U5CCa3uZE7eu4+twKiyBsylZXDLRLWm38SWtnPOOlZPoIflB5g==
X-Received: by 2002:a1c:2e4b:: with SMTP id u72mr3249501wmu.69.1599845134341;
        Fri, 11 Sep 2020 10:25:34 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id k84sm5399436wmf.6.2020.09.11.10.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 10:25:33 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: always allow writing '0' to MSR_KVM_ASYNC_PF_EN
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200911093147.484565-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f8e18679-dd49-f3e0-49fa-6f7cf1e1c025@redhat.com>
Date:   Fri, 11 Sep 2020 19:25:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911093147.484565-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/20 11:31, Vitaly Kuznetsov wrote:
> Even without in-kernel LAPIC we should allow writing '0' to
> MSR_KVM_ASYNC_PF_EN as we're not enabling the mechanism. In
> particular, QEMU with 'kernel-irqchip=off' fails to start
> a guest with
> 
> qemu-system-x86_64: error: failed to set MSR 0x4b564d02 to 0x0
> 
> Fixes: 9d3c447c72fb2 ("KVM: X86: Fix async pf caused null-ptr-deref")
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d39d6cf1d473..44a86f7f2397 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2730,9 +2730,6 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>  	if (data & 0x30)
>  		return 1;
>  
> -	if (!lapic_in_kernel(vcpu))
> -		return 1;
> -
>  	vcpu->arch.apf.msr_en_val = data;
>  
>  	if (!kvm_pv_async_pf_enabled(vcpu)) {
> @@ -2741,6 +2738,9 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>  		return 0;
>  	}
>  
> +	if (!lapic_in_kernel(vcpu))
> +		return 1;
> +
>  	if (kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
>  					sizeof(u64)))
>  		return 1;
> 

Queued, thanks.

Paolo

