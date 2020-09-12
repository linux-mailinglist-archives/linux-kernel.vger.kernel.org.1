Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADEA267846
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 08:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgILGq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 02:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725813AbgILGqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 02:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599893181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFfBOM91iLP1SjI0vZrul8BPW6RVcNXYqE3XcKBqSQA=;
        b=Tjc/rZwr/ezAPC0jdyBKJuUf+xTkNr2nxlYRlXNvleEHmbTBwkiOFY5HZXEhDn/l7QKLBa
        QC6pTT375ija8EKcPkFjyNx7j81qEKnDZlAl7JV3nhQDwjNM18tcVnFdlvtJL5bsclzoCs
        d8/8C5jBve8MCU9raYEulkVFJompxEA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-TKZAky5VNUO6HNYIrfdpmQ-1; Sat, 12 Sep 2020 02:46:19 -0400
X-MC-Unique: TKZAky5VNUO6HNYIrfdpmQ-1
Received: by mail-wm1-f72.google.com with SMTP id l26so2311639wmg.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 23:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TFfBOM91iLP1SjI0vZrul8BPW6RVcNXYqE3XcKBqSQA=;
        b=IGi7I93n65zFviSdCdRmB7O9cmU1FEAN1F9rK6XlSiLQlxWVw62DICO7MEgLUWsejI
         ON6UXU6o9dgIYAp/mU3V6idXRMAoLB7dH4TDOTs1IeDlM5Se1FSOB/aS8GCwhnkc5gn1
         YkYtgj4QUNzCjfkXMZSG2Tz5a4JE8bMKse6pgibHrgBpux2rRvSX7B1jZWXx7QCGIhqh
         A8hR5yHYEJR/qkVU9LeYTYPFYP91A0LnTrIVfHRNv325Q3cp2z8/qq7hlo/2hK8+9PE7
         BGcyU07qATiHgx2J92WD1JyToMKuin+Qin8+GJVleg0pNBBZMFwotemnNxz4/ExAXFGl
         foVA==
X-Gm-Message-State: AOAM531TzmiNIsme0GVWikMb/iHaIrf0SdGWxcPQJ7k6YrEBdtapAYNI
        3d4uC0RuIUk7HNED0jw3kLZTpk7eb0H5s6Q8AKlSzSG5VWjk63NPSD2xVr4SFhvXZvkaQ5XK717
        ahYhiCT3JXnJAkmkzrPv9IZll
X-Received: by 2002:adf:84c3:: with SMTP id 61mr5375726wrg.131.1599893178160;
        Fri, 11 Sep 2020 23:46:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytNHdaGj7CH2JrSIfFxD6Mr0PL45XbVa+e8uovi64GV/yFY9bz3q4vtw91Ojua76ATT2UcUw==
X-Received: by 2002:adf:84c3:: with SMTP id 61mr5375704wrg.131.1599893177896;
        Fri, 11 Sep 2020 23:46:17 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id p16sm8681576wro.71.2020.09.11.23.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 23:46:17 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] KVM: LAPIC: Narrow down the kick target vCPU
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1599731444-3525-1-git-send-email-wanpengli@tencent.com>
 <1599731444-3525-6-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9281f28a-e2bd-a79c-fc94-4999f4c6307a@redhat.com>
Date:   Sat, 12 Sep 2020 08:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1599731444-3525-6-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/20 11:50, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> The kick after setting KVM_REQ_PENDING_TIMER is used to handle the timer
> fires on a different pCPU which vCPU is running on, this kick is expensive
> since memory barrier, rcu, preemption disable/enable operations. We don't
> need this kick when injecting already-expired timer, we also should call
> out the VMX preemption timer case, which also passes from_timer_fn=false
> but doesn't need a kick because kvm_lapic_expired_hv_timer() is called
> from the target vCPU.
> 
> Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 4 +++-
>  arch/x86/kvm/x86.c   | 6 ------
>  arch/x86/kvm/x86.h   | 1 -
>  3 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index e446bdf..3b32d3b 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1642,7 +1642,9 @@ static void apic_timer_expired(struct kvm_lapic *apic, bool from_timer_fn)
>  	}
>  
>  	atomic_inc(&apic->lapic_timer.pending);
> -	kvm_set_pending_timer(vcpu);
> +	kvm_make_request(KVM_REQ_PENDING_TIMER, vcpu);
> +	if (from_timer_fn)
> +		kvm_vcpu_kick(vcpu);
>  }

This only matters for !APICv, but it's nice anyway.

Paolo

>  static void start_sw_tscdeadline(struct kvm_lapic *apic)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d39d6cf..dcf4494 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1774,12 +1774,6 @@ static s64 get_kvmclock_base_ns(void)
>  }
>  #endif
>  
> -void kvm_set_pending_timer(struct kvm_vcpu *vcpu)
> -{
> -	kvm_make_request(KVM_REQ_PENDING_TIMER, vcpu);
> -	kvm_vcpu_kick(vcpu);
> -}
> -
>  static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock)
>  {
>  	int version;
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 995ab69..ea20b8b 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -246,7 +246,6 @@ static inline bool kvm_vcpu_latch_init(struct kvm_vcpu *vcpu)
>  	return is_smm(vcpu) || kvm_x86_ops.apic_init_signal_blocked(vcpu);
>  }
>  
> -void kvm_set_pending_timer(struct kvm_vcpu *vcpu);
>  void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip);
>  
>  void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr);
> 

