Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F147275E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIWRZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726413AbgIWRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600881934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6tnByusYeU+TVxG5Re3j+mmtEuKFnOyGqlIj3o5A10=;
        b=JZ9JbVtDZRjJSeKGPDY6aMReoQEsV7R+nCfEhZ7WEqSJO71bQDjOJJDzqxfDrPItMwujRg
        FQwO5T9p5o9b0AF7Xqc30YSeaULeXdqqK+FnVFNVvYEQNQDpxUf1ZnjlQW9qWlzGnwJlDZ
        uh8OQbvzoo45XQxEcKWRffyfCuOCvOw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-bP_ovPh6N6-3QEwrC_v-Lg-1; Wed, 23 Sep 2020 13:25:32 -0400
X-MC-Unique: bP_ovPh6N6-3QEwrC_v-Lg-1
Received: by mail-wm1-f71.google.com with SMTP id s24so189684wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q6tnByusYeU+TVxG5Re3j+mmtEuKFnOyGqlIj3o5A10=;
        b=jDfEYpfQqBHl/l/2xIBEsH9dO8i7bGO3oywO6KF9uFDvo6yahkcfqH8LsBPSGz0ezg
         pZxBT3MXb9A24BekYvZXbGFgvJjoWg+fZPtGt31QDelRlDl/wjheQJlOf5pqBrJ91yPd
         YmS++PO45Mg1MXWiDKyLXedMBH2jqvKZbj51quRfwKAYXQ0LpfOlgBaKjR6ACRbagr3w
         MsuyyMdo1rxAThMYqrHlnU75IYKgV3vkn7y6BzWl871cOO5k+iwiclLdYruItiruE+iC
         fvNVmAiUu1T+dUJJTd/bY0JhB9+63H83Rs+CrvYEdNqMmGNs27E4wNhh5++yJa8BRUGn
         htFA==
X-Gm-Message-State: AOAM533FdXhuOIn4lt0T9hJW4v5TCKlvL0HeKf7ik57shneYjp1jEp3A
        nhQjtXLw1I8+4Y5VbRKEsfT6frneBw3LLN01iLEhKkJlC/RaF7uQLGPovsNgaMwD8RaeL1+Mtsk
        HwL2SjiSU/A8vIGLIb0Q1iHM4
X-Received: by 2002:a1c:2e08:: with SMTP id u8mr659678wmu.156.1600881930818;
        Wed, 23 Sep 2020 10:25:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIIw+44nwPJJJ//1KslPu6gF+MH4SLCC4Xd9t8DFAYnRxG6RDZ+KUfqRMuH7NdGDhmkiJ4Rw==
X-Received: by 2002:a1c:2e08:: with SMTP id u8mr659651wmu.156.1600881930529;
        Wed, 23 Sep 2020 10:25:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9? ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
        by smtp.gmail.com with ESMTPSA id p1sm10824020wma.0.2020.09.23.10.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 10:25:29 -0700 (PDT)
Subject: Re: [PATCH 2/4] KVM: VMX: Unconditionally clear CPUID.INVPCID if
 !CPUID.PCID
To:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200923165048.20486-1-sean.j.christopherson@intel.com>
 <20200923165048.20486-3-sean.j.christopherson@intel.com>
 <CALMp9eTPG14Mwd_NcMf-f86U5GyfcOAVHk=ugydyJj0PybiRMA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <010a907b-d838-532d-7869-7342c3aca1c8@redhat.com>
Date:   Wed, 23 Sep 2020 19:25:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eTPG14Mwd_NcMf-f86U5GyfcOAVHk=ugydyJj0PybiRMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20 19:15, Jim Mattson wrote:
> On Wed, Sep 23, 2020 at 9:51 AM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
>>
>> If PCID is not exposed to the guest, clear INVPCID in the guest's CPUID
>> even if the VMCS INVPCID enable is not supported.  This will allow
>> consolidating the secondary execution control adjustment code without
>> having to special case INVPCID.
>>
>> Technically, this fixes a bug where !CPUID.PCID && CPUID.INVCPID would
>> result in unexpected guest behavior (#UD instead of #GP/#PF), but KVM
>> doesn't support exposing INVPCID if it's not supported in the VMCS, i.e.
>> such a config is broken/bogus no matter what.
>>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> ---
>>  arch/x86/kvm/vmx/vmx.c | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index cfed29329e4f..57e48c5a1e91 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -4149,16 +4149,22 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
>>                 }
>>         }
>>
>> +       /*
>> +        * Expose INVPCID if and only if PCID is also exposed to the guest.
>> +        * INVPCID takes a #UD when it's disabled in the VMCS, but a #GP or #PF
>> +        * if CR4.PCIDE=0.  Enumerating CPUID.INVPCID=1 would lead to incorrect
>> +        * behavior from the guest perspective (it would expect #GP or #PF).
>> +        */
>> +       if (!guest_cpuid_has(vcpu, X86_FEATURE_PCID))
>> +               guest_cpuid_clear(vcpu, X86_FEATURE_INVPCID);
>> +
> 
> I thought the general rule for userspace provided CPUID bits was that
> kvm only made any adjustments necessary to prevent bad things from
> happening at the host level. Proper guest semantics are entirely the
> responsibility of userspace. Or did I misunderstand?
> 

Yes, that's generally the idea.  INVPCID has always been a bit special
due to the secondary execution control being of the "enable" kind; this
led the original author to try and disable the instruction (which is by
itself something we do not always do, and sometimes cannot always do).

So I agree that Sean's patch is of marginal utility by itself; however
it lets him use the new macros in patch 4 and it is a good idea to
separate the small functional change into its own commit.

Paolo

