Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35CA267834
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 08:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgILGV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 02:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbgILGVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 02:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599891710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DoRfe+catPHrHtF6PXn2NHblX5adVVfE1OCD3cfXEoA=;
        b=ZwZtkH+sOCdJ2UhlzILR7ssE0Y9rDjbBBi9V1Uqp7/qOr6F0Kml5XpNoybbl7nUu2dDMSQ
        Jnpc8UgjOeZmTM7Kmgv2kvOwSbMU8JrtqbH6EVHd7l8OKjrSn/v1KJoYDYRPxDkknrxgLt
        jykrigib+O3qUuZrAHuaJ/7pFZG1NBI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-Ml1XqN9ON5KS6OL479I4PQ-1; Sat, 12 Sep 2020 02:21:46 -0400
X-MC-Unique: Ml1XqN9ON5KS6OL479I4PQ-1
Received: by mail-wr1-f70.google.com with SMTP id f18so4068497wrv.19
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 23:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DoRfe+catPHrHtF6PXn2NHblX5adVVfE1OCD3cfXEoA=;
        b=TSMhdI10IGlyXVm5uEyeJCpwv+cRWlS0LSDOFgb1HFF5XcCNSXQsrk9O4SBOHn9W8y
         hy8VlTXRjjAUtgyZ/ngV1eypm7M4RIACpas7P7dvddwzc2QIuGrBtOCcP2Uv/x8vxhjX
         MS3td713N4X/uYrKUVtfECwPvKF3doP6+ZEaChPYiPdNmRxWxFEvpKNg32GvtTUorNDR
         J0hf8OlOxZcjb4HgLjA+Ze7exTAc0FvsyFSUVrMsgb1u5TwgiaEeqkI0EQK/ArPczjRZ
         uoRtLoFgIMWPBj8YbKXS1YANGvVVI2Tnj5hEtFGTSAJ3R+4jetfV+VmC+vyoowTqqKpr
         d/2g==
X-Gm-Message-State: AOAM530yT7G6Qlk91B7MdN/Lwgo3OFAxhaQHApx9NXaNg/FA2OWoaBPc
        dsWR4OmuU1rKG/jEhbfJfu/CdTUTfVy5aH8NlfJsArun3L0NPFaAVTL9vbDNNBpF5wd1I/o/whr
        mD4a/1s5bSHF5QJbpN8GkgncL
X-Received: by 2002:adf:ec82:: with SMTP id z2mr5363113wrn.214.1599891704831;
        Fri, 11 Sep 2020 23:21:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOUxPWoc1KgfE5qSdceI4D2L/RmrE5drDfLuFzxyq0DwKRyHh5UTj02585OrvX2QJviXZorg==
X-Received: by 2002:adf:ec82:: with SMTP id z2mr5363096wrn.214.1599891704635;
        Fri, 11 Sep 2020 23:21:44 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id v9sm8452118wru.37.2020.09.11.23.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 23:21:44 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: LAPIC: Fix updating DFR missing apic map
 recalculation
To:     Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1597827327-25055-1-git-send-email-wanpengli@tencent.com>
 <CANRm+Cx=6zc=KTw5XwMQTdOG3m67MCcmthRuFR-VTnOTB06kow@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <35b993bf-24d5-5cab-4a93-9ed76b0a3215@redhat.com>
Date:   Sat, 12 Sep 2020 08:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CANRm+Cx=6zc=KTw5XwMQTdOG3m67MCcmthRuFR-VTnOTB06kow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/20 10:41, Wanpeng Li wrote:
> Any Reviewed-by for these two patches? :)
> On Wed, 19 Aug 2020 at 16:55, Wanpeng Li <kernellwp@gmail.com> wrote:
>>
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> There is missing apic map recalculation after updating DFR, if it is
>> INIT RESET, in x2apic mode, local apic is software enabled before.
>> This patch fix it by introducing the function kvm_apic_set_dfr() to
>> be called in INIT RESET handling path.
>>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>>  arch/x86/kvm/lapic.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>> index 5ccbee7..248095a 100644
>> --- a/arch/x86/kvm/lapic.c
>> +++ b/arch/x86/kvm/lapic.c
>> @@ -310,6 +310,12 @@ static inline void kvm_apic_set_ldr(struct kvm_lapic *apic, u32 id)
>>         atomic_set_release(&apic->vcpu->kvm->arch.apic_map_dirty, DIRTY);
>>  }
>>
>> +static inline void kvm_apic_set_dfr(struct kvm_lapic *apic, u32 val)
>> +{
>> +       kvm_lapic_set_reg(apic, APIC_DFR, val);
>> +       atomic_set_release(&apic->vcpu->kvm->arch.apic_map_dirty, DIRTY);
>> +}
>> +
>>  static inline u32 kvm_apic_calc_x2apic_ldr(u32 id)
>>  {
>>         return ((id >> 4) << 16) | (1 << (id & 0xf));
>> @@ -1984,10 +1990,9 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
>>                 break;
>>
>>         case APIC_DFR:
>> -               if (!apic_x2apic_mode(apic)) {
>> -                       kvm_lapic_set_reg(apic, APIC_DFR, val | 0x0FFFFFFF);
>> -                       atomic_set_release(&apic->vcpu->kvm->arch.apic_map_dirty, DIRTY);
>> -               } else
>> +               if (!apic_x2apic_mode(apic))
>> +                       kvm_apic_set_dfr(apic, val | 0x0FFFFFFF);
>> +               else
>>                         ret = 1;
>>                 break;
>>
>> @@ -2303,7 +2308,7 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
>>                              SET_APIC_DELIVERY_MODE(0, APIC_MODE_EXTINT));
>>         apic_manage_nmi_watchdog(apic, kvm_lapic_get_reg(apic, APIC_LVT0));
>>
>> -       kvm_lapic_set_reg(apic, APIC_DFR, 0xffffffffU);
>> +       kvm_apic_set_dfr(apic, 0xffffffffU);
>>         apic_set_spiv(apic, 0xff);
>>         kvm_lapic_set_reg(apic, APIC_TASKPRI, 0);
>>         if (!apic_x2apic_mode(apic))
>> --
>> 2.7.4
>>
> 

Queued, thanks.

Paolo

