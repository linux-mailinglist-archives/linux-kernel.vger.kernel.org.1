Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590EF27FCC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 12:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgJAKEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 06:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725938AbgJAKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601546659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=56/dU84kpZDmYsVBBSbcPE0h+GJYdVwP6FX71jWM3s8=;
        b=f1cq/DbtNjBX9piU8V4yU2dbZkPLEhelaqoIbAwP2Gzjg4u9dB9jms1mwWnGv6ClP+Nyi4
        4AHU3Ll9gqcgK5nSvb4MT1+US9N+HXmgSkjmMBKNxF0F8hjUF1CoDaS/gUl669JlMEslrZ
        kN6sELFXDpL29GKLyBsX+zpSzvehM2o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-5P-CnpVkNCWiZiGinj-zCw-1; Thu, 01 Oct 2020 06:04:18 -0400
X-MC-Unique: 5P-CnpVkNCWiZiGinj-zCw-1
Received: by mail-ej1-f71.google.com with SMTP id gt18so2022099ejb.16
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 03:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=56/dU84kpZDmYsVBBSbcPE0h+GJYdVwP6FX71jWM3s8=;
        b=Lde6BqQMukh5vo6SuxiO/THKI5Rrsb5bHURoUvgAHYkJ9rV1I7Gxf/+UpGciYAmY/G
         ZmxbDrt4WnqbrV6b5gcJH155irI3rBTPoZ7mdRVTMk5AOqpdSvvsF0n1oK0hyLQ8Pi9y
         LGgYjIYq7+gJ9NS85ktrKIBXhLkMXcffXDfw5xSgIiiEjkvGGE19NthiaRXa+oloTbM5
         EoG0uzg7JTSZlYDyXCWIbG6VosFZssj6ZRe/pBtAV3DiBmUTXfi1NUUji9OtPtSzZhuy
         5jvdd+KzwSIKYmUHRQ0n4zqS2ZCQ37hpwIVq0wQIJY72Kaaf/Ck3PuJaVW3u7Z2+JByM
         Ny6Q==
X-Gm-Message-State: AOAM532x+f5G94/i0/z/jqobCi+4KrO/UdQYYeGpRXqtQqTzirGLSrr2
        bG22Dm3RstF0QARObKBtFyUfklPU8R8AbquR81q35o0LuqqU0LMVpDlZ4xc1Xh6k1nRm0+a9eSL
        DzNiqIM6ot/K9pfH/q7EaFYk9
X-Received: by 2002:a17:906:2e83:: with SMTP id o3mr7472724eji.47.1601546656585;
        Thu, 01 Oct 2020 03:04:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHTIc3ovp4n5Hxm1K2Q2q2sAxv80q40xpzWmOqWX9HyQWyCCmO1bQ6l6Tx0yntM0jsg1Efww==
X-Received: by 2002:a17:906:2e83:: with SMTP id o3mr7472694eji.47.1601546656308;
        Thu, 01 Oct 2020 03:04:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id y24sm3646585eds.35.2020.10.01.03.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 03:04:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Wei Huang <whuang2@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] KVM: x86: allocate vcpu->arch.cpuid_entries dynamically
In-Reply-To: <20200918024117.GC14678@sjchrist-ice>
References: <20200915154306.724953-1-vkuznets@redhat.com> <20200915154306.724953-2-vkuznets@redhat.com> <20200918024117.GC14678@sjchrist-ice>
Date:   Thu, 01 Oct 2020 12:04:14 +0200
Message-ID: <87imbu9s9t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Tue, Sep 15, 2020 at 05:43:05PM +0200, Vitaly Kuznetsov wrote:
>> The current limit for guest CPUID leaves (KVM_MAX_CPUID_ENTRIES, 80)
>> is reported to be insufficient but before we bump it let's switch to
>> allocating vcpu->arch.cpuid_entries dynamically. Currenly,
>
>                                                    Currently,
>
>> 'struct kvm_cpuid_entry2' is 40 bytes so vcpu->arch.cpuid_entries is
>> 3200 bytes which accounts for 1/4 of the whole 'struct kvm_vcpu_arch'
>> but having it pre-allocated (for all vCPUs which we also pre-allocate)
>> gives us no benefits.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>
> ...
>
>> @@ -241,18 +253,31 @@ int kvm_vcpu_ioctl_set_cpuid2(struct kvm_vcpu *vcpu,
>>  			      struct kvm_cpuid2 *cpuid,
>>  			      struct kvm_cpuid_entry2 __user *entries)
>>  {
>> +	struct kvm_cpuid_entry2 *cpuid_entries2 = NULL;
>>  	int r;
>>  
>>  	r = -E2BIG;
>>  	if (cpuid->nent > KVM_MAX_CPUID_ENTRIES)
>>  		goto out;
>>  	r = -EFAULT;
>> -	if (copy_from_user(&vcpu->arch.cpuid_entries, entries,
>> -			   cpuid->nent * sizeof(struct kvm_cpuid_entry2)))
>> -		goto out;
>> +
>> +	if (cpuid->nent) {
>> +		cpuid_entries2 = vmemdup_user(entries,
>> +					      array_size(sizeof(cpuid_entries2[0]),
>> +							 cpuid->nent));
>
> Any objection to using something super short like "e2" instead of cpuid_entries2
> so that this can squeeze on a single line, or at least be a little more sane?
>
>> +		if (IS_ERR(cpuid_entries2)) {
>> +			r = PTR_ERR(cpuid_entries2);
>> +			goto out;
>
> Don't suppose you'd want to opportunistically kill off these gotos?
>
>> +		}
>> +	}
>> +	kvfree(vcpu->arch.cpuid_entries);
>
> This is a bit odd.  The previous vcpu->arch.cpuid_entries is preserved on
> allocation failure, but not on kvm_check_cpuid() failure.  Being destructive
> on the "check" failure was always a bit odd, but it really stands out now.
>
> Given that kvm_check_cpuid() now only does an actual check and not a big
> pile of updates, what if we refactored the guts of kvm_find_cpuid_entry()
> into yet another helper so that kvm_check_cpuid() could check the input
> before crushing vcpu->arch.cpuid_entries?
>
> 	if (cpuid->nent) {
> 		e2 = vmemdup_user(entries, array_size(sizeof(e2[0]), cpuid->nent));
> 		if (IS_ERR(e2))
> 			return PTR_ERR(e2);
>
> 		r = kvm_check_cpuid(e2, cpuid->nent);
> 		if (r)
> 			return r;
> 	}
>
> 	vcpu->arch.cpuid_entries = e2;
> 	vcpu->arch.cpuid_nent = cpuid->nent;
> 	return 0;
>

(I somehow missed this and forgot about the whole thing).

Makes sense to me, will do in v1.

Overall, it seems nobody is against the general idea so I'll prepeare
v1.

Thanks!

>> +	vcpu->arch.cpuid_entries = cpuid_entries2;
>>  	vcpu->arch.cpuid_nent = cpuid->nent;
>> +
>>  	r = kvm_check_cpuid(vcpu);
>>  	if (r) {
>> +		kvfree(vcpu->arch.cpuid_entries);
>> +		vcpu->arch.cpuid_entries = NULL;
>>  		vcpu->arch.cpuid_nent = 0;
>>  		goto out;
>>  	}
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 1994602a0851..42259a6ec1d8 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -9610,6 +9610,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>>  	kvm_mmu_destroy(vcpu);
>>  	srcu_read_unlock(&vcpu->kvm->srcu, idx);
>>  	free_page((unsigned long)vcpu->arch.pio_data);
>> +	kvfree(vcpu->arch.cpuid_entries);
>>  	if (!lapic_in_kernel(vcpu))
>>  		static_key_slow_dec(&kvm_no_apic_vcpu);
>>  }
>> -- 
>> 2.25.4
>> 
>

-- 
Vitaly

