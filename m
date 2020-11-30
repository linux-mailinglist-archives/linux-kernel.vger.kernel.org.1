Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3812C8C77
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbgK3SRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:17:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729564AbgK3SRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606760144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FiyoWyuNSHuyDR9hIsFud/925yPSvN+8hf0ndeRVCIQ=;
        b=DbVQp2GfXl9isM+8+MTy5vDrvh5+HVIdei2ERQSBYjMczC96q8Vc7PMHx04rjRbjLYbsaD
        d+bInLNM+XzzEreAbSfYc9cnp2TMvhS7u/BGdTzbAUsMVXQ9ByawzlmodTGYpvKlXaUNjM
        OWLGLm+tUcqKgQ7vbtMtI8p7rKj8YgE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-G0NcUv0kPR6cu5SZsRfsIw-1; Mon, 30 Nov 2020 13:15:42 -0500
X-MC-Unique: G0NcUv0kPR6cu5SZsRfsIw-1
Received: by mail-ed1-f69.google.com with SMTP id b13so7218054edy.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FiyoWyuNSHuyDR9hIsFud/925yPSvN+8hf0ndeRVCIQ=;
        b=DpZzg1AM1oBn4POvZBXKqn9EEeb8da2RDUC4oBhFOSoQwR24JJBvtjJAXmqQK14ECP
         mPAQtoTt6Wrt/oDCtzGLGUvP+XniwnRnysB7KqrvnwapybDTwwDR+8UcK+0+aqppdTei
         VawufQzKFEZ+XA0aOkTRiwWhMFvlN562WD/FTCeHjN0wtUDka/jTDFf04cybXZtRHi5q
         m5BxFHo0h5gjfMasja2UQTM7LVZcuYhexZQZceYyMFxkSOshBvJVsf2rNJ/Tzpgd2ULc
         TkgxJ3D6T3WORdTLcZs7u3513+3lEGiA1F0AS6zE8FsTCFafDC6jegsZ0XAJZkXUjLBE
         X00Q==
X-Gm-Message-State: AOAM533C6ANWefN5VdNHu4T2qqIIXj9Sdys4QgW1Oxk6yDMsSBE93qPM
        FLclwsqcfYJD8tlwUicllyMN5qk+qLrOquE+ktKx1YF1+CypEy93yGGaqApwNTSwCTMxGnlWhUi
        C3gg+oK48G9Z53Bsp0xdSw4SH
X-Received: by 2002:a05:6402:312b:: with SMTP id dd11mr7119206edb.308.1606760137327;
        Mon, 30 Nov 2020 10:15:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzb6sVeMXU3dxEPsQZSrjgkDPkhPZNeXztr8mJq/HGL0Rusiv8nEhQip0Ml0X4YrW7lewwimA==
X-Received: by 2002:a05:6402:312b:: with SMTP id dd11mr7118999edb.308.1606760135721;
        Mon, 30 Nov 2020 10:15:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r9sm1351828ejd.38.2020.11.30.10.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:15:34 -0800 (PST)
Subject: Re: [RFC PATCH 22/35] KVM: SVM: Add support for CR0 write traps for
 an SEV-ES guest
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1600114548.git.thomas.lendacky@amd.com>
 <68f885b63b18e5c72eae92c9c681296083c0ccd8.1600114548.git.thomas.lendacky@amd.com>
 <20200914221353.GJ7192@sjchrist-ice>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <08c28615-e16e-fe5d-4f04-24ec39387c7d@redhat.com>
Date:   Mon, 30 Nov 2020 19:15:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20200914221353.GJ7192@sjchrist-ice>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/20 00:13, Sean Christopherson wrote:
>> +static void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0,
>> +			     unsigned long cr0)
> What about using __kvm_set_cr*() instead of kvm_post_set_cr*()?  That would
> show that __kvm_set_cr*() is a subordinate of kvm_set_cr*(), and from the
> SVM side would provide the hint that the code is skipping the front end of
> kvm_set_cr*().

No, kvm_post_set_cr0 is exactly the right name because it doesn't set 
any state.  __kvm_set_cr0 tells me that it is a (rarely used) way to set 
CR0, which this function isn't.

Sorry Tom for not catching this earlier.

Paolo

>> +{
>> +	unsigned long update_bits = X86_CR0_PG | X86_CR0_WP;
>> +
>> +	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
>> +		kvm_clear_async_pf_completion_queue(vcpu);
>> +		kvm_async_pf_hash_reset(vcpu);
>> +	}
>> +
>> +	if ((cr0 ^ old_cr0) & update_bits)
>> +		kvm_mmu_reset_context(vcpu);
>> +
>> +	if (((cr0 ^ old_cr0) & X86_CR0_CD) &&
>> +	    kvm_arch_has_noncoherent_dma(vcpu->kvm) &&
>> +	    !kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_CD_NW_CLEARED))
>> +		kvm_zap_gfn_range(vcpu->kvm, 0, ~0ULL);
>> +}
>> +
>>   int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
>>   {
>>   	unsigned long old_cr0 = kvm_read_cr0(vcpu);
>>   	unsigned long pdptr_bits = X86_CR0_CD | X86_CR0_NW | X86_CR0_PG;
>> -	unsigned long update_bits = X86_CR0_PG | X86_CR0_WP;
>>   
>>   	cr0 |= X86_CR0_ET;
>>   
>> @@ -842,22 +860,23 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
>>   
>>   	kvm_x86_ops.set_cr0(vcpu, cr0);
>>   
>> -	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
>> -		kvm_clear_async_pf_completion_queue(vcpu);
>> -		kvm_async_pf_hash_reset(vcpu);
>> -	}
>> +	kvm_post_set_cr0(vcpu, old_cr0, cr0);

