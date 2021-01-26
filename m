Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DEF30418E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406128AbhAZPHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:07:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406112AbhAZPGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611673528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xs14Pz1Mq5FTHwPzuFvyU/rHvTdWdEjaMGXPw3VcyzI=;
        b=fhG3+E2auH56bXTf0tWNx8b5Lnkq4ob+fx51ba/sOwHkUiMiW719/kiElyhFiGbNvsKcOI
        1GhCUeQaThAMOAEiRrgQvisYR750NLK/WZgm15ZdTuHpn3+L/DSJgy8MjgjsqWLpQpMMmv
        j3S9X1KKuHsUgxSEDFA1FlCDCVPKNbA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-P0tOjGF7OEi0A45IbIgi-w-1; Tue, 26 Jan 2021 10:05:26 -0500
X-MC-Unique: P0tOjGF7OEi0A45IbIgi-w-1
Received: by mail-oi1-f199.google.com with SMTP id r82so6254562oie.18
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xs14Pz1Mq5FTHwPzuFvyU/rHvTdWdEjaMGXPw3VcyzI=;
        b=n5zgJ9OuO/bJLqnhsbtbMclh7ge2tWB1upPr5FNoMPe/LL3Lo/yQVXEs68YDYZp+O0
         gjaYntfI4cZmS22CZQonDiScnq8NK3wOhlRRHCaZZTKP9n1FyEQeRDDBHNmeK1Fa3lOR
         W4DkRjXpfMX8eZQmK7A3I7LO6ExaSKHvzvaReOv0/7YGn4Ugl1+8wBKHI9uLjox1p9jU
         0aWebucprva0rlpJvSBZb0rUQtsFCec8yvYU3DR/b0wjfI06pk2Vsx7MXO+2uykCoVi4
         ysqExQC3xnAU8CpiWfD92oae5M2p9twvlXoCWB6kVKFMEUFXnha4SOmqhw4Pln8+d6hD
         DehQ==
X-Gm-Message-State: AOAM530wX3dr1Rzed4siLsitBI8ILWUtU9aRRAugqGTT+fqOP2t1OuDV
        rxvXyv0MBBVdu6bFDYzXdErVGhZJrPCznyVxoGeDu8dBgbXbCZ2NQ4K3zQCqCaHXnjcVjzkUDt6
        2eI/a0pc2YUymNKfFYv3Hrtl5
X-Received: by 2002:a05:6808:a09:: with SMTP id n9mr75650oij.26.1611673525916;
        Tue, 26 Jan 2021 07:05:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyamxSOGkosVTZAPozfdk59s0vMHPoPqsvHNSyOUyLqzfFV2cKUPpAWmmkZ2dYRfOBx0JV2Og==
X-Received: by 2002:a05:6808:a09:: with SMTP id n9mr75621oij.26.1611673525705;
        Tue, 26 Jan 2021 07:05:25 -0800 (PST)
Received: from [192.168.1.38] (cpe-70-113-46-183.austin.res.rr.com. [70.113.46.183])
        by smtp.gmail.com with ESMTPSA id f6sm691379ote.28.2021.01.26.07.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 07:05:24 -0800 (PST)
From:   Wei Huang <wehuang@redhat.com>
X-Google-Original-From: Wei Huang <wei.huang2@amd.com>
Subject: Re: [PATCH v3 0/4] Handle #GP for SVM execution instructions
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        mlevitsk@redhat.com, seanjc@google.com, joro@8bytes.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        jmattson@google.com, wanpengli@tencent.com, bsd@redhat.com,
        dgilbert@redhat.com, luto@amacapital.net
References: <20210126081831.570253-1-wei.huang2@amd.com>
 <3349e153-83ae-3c55-ee88-2036b2ce38d8@redhat.com>
Message-ID: <4b72ebd1-ace8-f03c-2e53-1c4ece0b17d8@amd.com>
Date:   Tue, 26 Jan 2021 09:05:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3349e153-83ae-3c55-ee88-2036b2ce38d8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/21 5:39 AM, Paolo Bonzini wrote:
> On 26/01/21 09:18, Wei Huang wrote:
>> While running SVM related instructions (VMRUN/VMSAVE/VMLOAD), some AMD
>> CPUs check EAX against reserved memory regions (e.g. SMM memory on host)
>> before checking VMCB's instruction intercept. If EAX falls into such
>> memory areas, #GP is triggered before #VMEXIT. This causes unexpected #GP
>> under nested virtualization. To solve this problem, this patchset makes
>> KVM trap #GP and emulate these SVM instuctions accordingly.
>>
>> Also newer AMD CPUs will change this behavior by triggering #VMEXIT
>> before #GP. This change is indicated by CPUID_0x8000000A_EDX[28]. Under
>> this circumstance, #GP interception is not required. This patchset 
>> supports
>> the new feature.
>>
>> This patchset has been verified with vmrun_errata_test and 
>> vmware_backdoor
>> tests of kvm_unit_test on the following configs. Also it was verified 
>> that
>> vmware_backdoor can be turned on under nested on nested.
>>    * Current CPU: nested, nested on nested
>>    * New CPU with X86_FEATURE_SVME_ADDR_CHK: nested, nested on nested
>>
>> v2->v3:
>>    * Change the decode function name to x86_decode_emulated_instruction()
>>    * Add a new variable, svm_gp_erratum_intercept, to control 
>> interception
>>    * Turn on VM's X86_FEATURE_SVME_ADDR_CHK feature in svm_set_cpu_caps()
>>    * Fix instruction emulation for vmware_backdoor under nested-on-nested
>>    * Minor comment fixes
>>
>> v1->v2:
>>    * Factor out instruction decode for sharing
>>    * Re-org gp_interception() handling for both #GP and vmware_backdoor
>>    * Use kvm_cpu_cap for X86_FEATURE_SVME_ADDR_CHK feature support
>>    * Add nested on nested support
>>
>> Thanks,
>> -Wei
>>
>> Wei Huang (4):
>>    KVM: x86: Factor out x86 instruction emulation with decoding
>>    KVM: SVM: Add emulation support for #GP triggered by SVM instructions
>>    KVM: SVM: Add support for SVM instruction address check change
>>    KVM: SVM: Support #GP handling for the case of nested on nested
>>
>>   arch/x86/include/asm/cpufeatures.h |   1 +
>>   arch/x86/kvm/svm/svm.c             | 128 +++++++++++++++++++++++++----
>>   arch/x86/kvm/x86.c                 |  62 ++++++++------
>>   arch/x86/kvm/x86.h                 |   2 +
>>   4 files changed, 152 insertions(+), 41 deletions(-)
>>
> 
> Queued, thanks.

Thanks. BTW because we use kvm_cpu_cap_set() in svm_set_cpu_caps(). This 
will be reflected into the CPUID received by QEMU. QEMU needs a one-line 
patch to declare the new feature. I will send it out this morning.

-Wei

> 
> Paolo
> 

