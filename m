Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5442DAAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgLOKZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:25:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727378AbgLOKZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608027836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1GIdHGO3VDUt7FjZGS2sawfNSbB/YdQ7Ov2GGs7wu1Q=;
        b=W2Ef109mrhDK+CN0g6S1jMfQMcPApLjS33pkcJtHJ8yuxfCXuicPUkgBB6cLf/qZtDBudQ
        +xWGvWdbl2zyAVL7fjakTTF9SBUXd8+6mseW+NaefnQqfE2CFZyWDLQf1gpQDl6RhXXsKP
        jCQkc0r93GdfYgNC1ZbAvowkJfqrnVM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548--w9RYDCQMmuIWBG07oca6w-1; Tue, 15 Dec 2020 05:23:55 -0500
X-MC-Unique: -w9RYDCQMmuIWBG07oca6w-1
Received: by mail-ed1-f71.google.com with SMTP id z20so9702256edl.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1GIdHGO3VDUt7FjZGS2sawfNSbB/YdQ7Ov2GGs7wu1Q=;
        b=fULE3kiDLRZFkhoW8ebEO+82apDlMAbLesMnQ/7nkPPz5Lg/DJcQNZ3xw0iLOvdBJF
         o/99tS1RqPMBZiDm9mg5wnZg/di/7hTJismG/xOldH+N0aaHQOu4g3pI2mqp7DjaWsQw
         hEwyoKvJILFz5cVQEzaiuXBxRTC0lRsXLulgchGl0CXvD9kpx7M/PjloYsRJoks7IbnN
         gpgym89QhEDTzXJfe7hrI8OOGRxUSWetp0ym1iEyIi0CK9etdC1VixTnOesaWfL5RQPt
         E4tQoWpEqT1T+qD50BsvDZmzgXExGRMq55qpRFPj1nURf34jXOsvl6+0YkaGOlDsrB0G
         l2bw==
X-Gm-Message-State: AOAM533O8QZQksoxczQmEceCM+lH4pLSIvb9bfFLXMQmR90D8Xmk3zNB
        zlYAc0jSJ7l6SEKNL5B3pYbESiXC/B36ul7Z7Jq4XGLZifnH9jeaJ4XNH+DYj36dAJ0K9OowZxA
        Hj+PlWW76ljhnt6hv9RN/0E8f
X-Received: by 2002:a50:9354:: with SMTP id n20mr29398135eda.231.1608027833513;
        Tue, 15 Dec 2020 02:23:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1c6r8g0j8NSpDIKdTq6bNjySPfZpzsD+RZRAPpqqrKRVkAJsMtO0GWz1rDgtoVga3KcnJbA==
X-Received: by 2002:a50:9354:: with SMTP id n20mr29398104eda.231.1608027832902;
        Tue, 15 Dec 2020 02:23:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id oq27sm1037911ejb.108.2020.12.15.02.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 02:23:51 -0800 (PST)
Subject: Re: [PATCH 3/3] KVM: x86: introduce complete_emulated_msr callback
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Alexander Graf <graf@amazon.com>
References: <20201214183250.1034541-1-pbonzini@redhat.com>
 <20201214183250.1034541-4-pbonzini@redhat.com>
 <da346203-7465-dcc8-9ed3-7e92aa136e62@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b16db2f-cf95-b433-73fc-ad6ccb2740ae@redhat.com>
Date:   Tue, 15 Dec 2020 11:23:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <da346203-7465-dcc8-9ed3-7e92aa136e62@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/20 21:55, Tom Lendacky wrote:
> On 12/14/20 12:32 PM, Paolo Bonzini wrote:
>> This will be used by SEV-ES to inject MSR failure via the GHCB.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> (Changed Sean's email on this reply, but missed the others...)

Thanks for the review, I pushed to kvm/queue now.

Paolo

>> ---
>>   arch/x86/include/asm/kvm_host.h | 1 +
>>   arch/x86/kvm/svm/svm.c          | 1 +
>>   arch/x86/kvm/vmx/vmx.c          | 1 +
>>   arch/x86/kvm/x86.c              | 8 ++++----
>>   4 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 8cf6b0493d49..18aa15e6fadd 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -1285,6 +1285,7 @@ struct kvm_x86_ops {
>>   
>>   	void (*migrate_timers)(struct kvm_vcpu *vcpu);
>>   	void (*msr_filter_changed)(struct kvm_vcpu *vcpu);
>> +	int (*complete_emulated_msr)(struct kvm_vcpu *vcpu, int err);
>>   };
>>   
>>   struct kvm_x86_nested_ops {
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 801e0a641258..4067d511be08 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -4306,6 +4306,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
>>   	.apic_init_signal_blocked = svm_apic_init_signal_blocked,
>>   
>>   	.msr_filter_changed = svm_msr_filter_changed,
>> +	.complete_emulated_msr = kvm_complete_insn_gp,
>>   };
>>   
>>   static struct kvm_x86_init_ops svm_init_ops __initdata = {
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 849be2a9f260..55fa51c0cd9d 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -7701,6 +7701,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
>>   	.migrate_timers = vmx_migrate_timers,
>>   
>>   	.msr_filter_changed = vmx_msr_filter_changed,
>> +	.complete_emulated_msr = kvm_complete_insn_gp,
>>   	.cpu_dirty_log_size = vmx_cpu_dirty_log_size,
>>   };
>>   
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 2f1bc52e70c0..6c4482b97c91 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -1642,12 +1642,12 @@ static int complete_emulated_rdmsr(struct kvm_vcpu *vcpu)
>>   		kvm_rdx_write(vcpu, vcpu->run->msr.data >> 32);
>>   	}
>>   
>> -	return kvm_complete_insn_gp(vcpu, err);
>> +	return kvm_x86_ops.complete_emulated_msr(vcpu, err);
>>   }
>>   
>>   static int complete_emulated_wrmsr(struct kvm_vcpu *vcpu)
>>   {
>> -	return kvm_complete_insn_gp(vcpu, vcpu->run->msr.error);
>> +	return kvm_x86_ops.complete_emulated_msr(vcpu, vcpu->run->msr.error);
>>   }
>>   
>>   static u64 kvm_msr_reason(int r)
>> @@ -1720,7 +1720,7 @@ int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
>>   		trace_kvm_msr_read_ex(ecx);
>>   	}
>>   
>> -	return kvm_complete_insn_gp(vcpu, r);
>> +	return kvm_x86_ops.complete_emulated_msr(vcpu, r);
>>   }
>>   EXPORT_SYMBOL_GPL(kvm_emulate_rdmsr);
>>   
>> @@ -1747,7 +1747,7 @@ int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
>>   	else
>>   		trace_kvm_msr_write_ex(ecx, data);
>>   
>> -	return kvm_complete_insn_gp(vcpu, r);
>> +	return kvm_x86_ops.complete_emulated_msr(vcpu, r);
>>   }
>>   EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr);
>>   
>>
> 

