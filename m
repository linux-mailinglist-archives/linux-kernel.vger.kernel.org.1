Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AF92D02BB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgLFK1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:27:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgLFK1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607250378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJIrgW7mTTQlynTZ3aiM64Xrj0jHXvCpxGNmSuVEGWU=;
        b=VLwei7WevRFKGkD+XqpjVcf06yLXbIqoEG+hrN9XQZOc2/+O58W2DKrDnpelAKKFheT6o7
        mI07dJdjeSy3JhJrhUudiEaiN2aNwp6KUmzpHDr/HYpv5LAgTHT2ngd+MLYLEC8nEibyNp
        iL4p5tlTh0TiDvTWBEsBtnPruF2CoVY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-DxTI93s4MVWvw036RxLdAQ-1; Sun, 06 Dec 2020 05:26:16 -0500
X-MC-Unique: DxTI93s4MVWvw036RxLdAQ-1
Received: by mail-wm1-f69.google.com with SMTP id a130so7892959wmf.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 02:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJIrgW7mTTQlynTZ3aiM64Xrj0jHXvCpxGNmSuVEGWU=;
        b=YtqXQRcul3m+5GQvn2XRIe3Egoui+iTfxsg4CKmBqlUlpnJoxaUTyKM0tbY4cNLBYg
         dMNYzRbKq6Y1TyAMS8u3iS8BWJBaM0GsTYqo9N77s6eQi1x3/zpGazB/tzrfNtMfti1R
         qMmY1JWd7F4TuI9Tp3gz5BCgc6mPOjilvBXCmbjZeonHPPuAa+wDBcdA6fzMhz0Nzcr2
         xpxOgLUEJAYgPZCvZLWLRIXXDQ3xZWTc31CJeYUTXFQEB3SWBI0flBEhNqgHUePS1ewt
         gmy93mizglioSpbh92xhO80RtIFM8/6hyxSJcNxcf/y9ZhZmo0YDhoSBh6zf5VqxiYpc
         /1lw==
X-Gm-Message-State: AOAM532rlBCIivzvp2LbsEKoBazIE7vfaT6a8i3eEEW3Y9mXuX7EMY9V
        k9uaWCLVXVxZ9yAsOyW91GWmvuWK/foKJX6vNeaRo1MS3yshldpJRSwd+tDOtREYK+ppW6BakZ5
        B3QCBjamu7U4KgwODQa74S3UH
X-Received: by 2002:a5d:6286:: with SMTP id k6mr14267423wru.309.1607250374960;
        Sun, 06 Dec 2020 02:26:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxN9YTHpXeqXCURubyG2sxhTny8kew+tOlq2lzqgOXEB4Z7EVdYqQvKiESiowPEO42nHm7aBg==
X-Received: by 2002:a5d:6286:: with SMTP id k6mr14267403wru.309.1607250374789;
        Sun, 06 Dec 2020 02:26:14 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id o74sm10679578wme.36.2020.12.06.02.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:26:14 -0800 (PST)
Subject: Re: [PATCH v2 1/9] KVM: x86: Add AMD SEV specific Hypercall3
To:     Sean Christopherson <seanjc@google.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        joro@8bytes.org, bp@suse.de, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, brijesh.singh@amd.com,
        dovmurik@linux.vnet.ibm.com, tobin@ibm.com, jejb@linux.ibm.com,
        frankeh@us.ibm.com, dgilbert@redhat.com
References: <cover.1606782580.git.ashish.kalra@amd.com>
 <b6bc54ed6c8ae4444f3acf1ed4386010783ad386.1606782580.git.ashish.kalra@amd.com>
 <X8gyhCsEMf8QU9H/@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d63529ce-d613-9f83-6cfc-012a8b333e38@redhat.com>
Date:   Sun, 6 Dec 2020 11:26:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X8gyhCsEMf8QU9H/@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/20 01:34, Sean Christopherson wrote:
> On Tue, Dec 01, 2020, Ashish Kalra wrote:
>> From: Brijesh Singh <brijesh.singh@amd.com>
>>
>> KVM hypercall framework relies on alternative framework to patch the
>> VMCALL -> VMMCALL on AMD platform. If a hypercall is made before
>> apply_alternative() is called then it defaults to VMCALL. The approach
>> works fine on non SEV guest. A VMCALL would causes #UD, and hypervisor
>> will be able to decode the instruction and do the right things. But
>> when SEV is active, guest memory is encrypted with guest key and
>> hypervisor will not be able to decode the instruction bytes.
>>
>> Add SEV specific hypercall3, it unconditionally uses VMMCALL. The hypercall
>> will be used by the SEV guest to notify encrypted pages to the hypervisor.
> 
> What if we invert KVM_HYPERCALL and X86_FEATURE_VMMCALL to default to VMMCALL
> and opt into VMCALL?  It's a synthetic feature flag either way, and I don't
> think there are any existing KVM hypercalls that happen before alternatives are
> patched, i.e. it'll be a nop for sane kernel builds.
> 
> I'm also skeptical that a KVM specific hypercall is the right approach for the
> encryption behavior, but I'll take that up in the patches later in the series.

Do you think that it's the guest that should "donate" memory for the 
bitmap instead?

Paolo

> 
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: x86@kernel.org
>> Cc: kvm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Reviewed-by: Steve Rutherford <srutherford@google.com>
>> Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>   arch/x86/include/asm/kvm_para.h | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
>> index 338119852512..bc1b11d057fc 100644
>> --- a/arch/x86/include/asm/kvm_para.h
>> +++ b/arch/x86/include/asm/kvm_para.h
>> @@ -85,6 +85,18 @@ static inline long kvm_hypercall4(unsigned int nr, unsigned long p1,
>>   	return ret;
>>   }
>>   
>> +static inline long kvm_sev_hypercall3(unsigned int nr, unsigned long p1,
>> +				      unsigned long p2, unsigned long p3)
>> +{
>> +	long ret;
>> +
>> +	asm volatile("vmmcall"
>> +		     : "=a"(ret)
>> +		     : "a"(nr), "b"(p1), "c"(p2), "d"(p3)
>> +		     : "memory");
>> +	return ret;
>> +}
>> +
>>   #ifdef CONFIG_KVM_GUEST
>>   bool kvm_para_available(void);
>>   unsigned int kvm_arch_para_features(void);
>> -- 
>> 2.17.1
>>
> 

