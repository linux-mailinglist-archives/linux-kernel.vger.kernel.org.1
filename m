Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F83296117
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901071AbgJVOpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2901062AbgJVOpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603377899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MMaUMBupo+aMZow4IDwl1t08XFtpsf1GwqJ0/qCgZAo=;
        b=Td0672p7zqPwWSDSRfJEkVFsxAGqVrLi+2c3pSOpmclJhnF0iBnTpgG1wi7rY0U2V95grI
        oDi68eltcxkemI430RlT962ITaU8jRmv7jDexghaRcmFTHW2Yiudc/hVa79r80Upbl7MOc
        oRjx7W8+W9aEmpuMx7V9jG8/asUNkDU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-E6CbuAFlN72ated3sKJx-g-1; Thu, 22 Oct 2020 10:44:56 -0400
X-MC-Unique: E6CbuAFlN72ated3sKJx-g-1
Received: by mail-wm1-f70.google.com with SMTP id f26so366803wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MMaUMBupo+aMZow4IDwl1t08XFtpsf1GwqJ0/qCgZAo=;
        b=SOoAqYAhwNk9gsMDQjL6i/lqFhFrGodpHXOAlIlwsAl292e+4t9VQlwBvzjzElFIm7
         15Pzb09bA/qJwoijkwdhsWpfv5cGxl6Whx7vVzxam0R5b055QCcYwj9j2PYr/Egwn6tc
         SNgxg4yjeSpGnKGZTCwLGMo3Onoh+R4IMN7P9OFfVoSkijymSJJUAf5EnB+umkmernAY
         HqEr3mV4/FhVTdFI9qHbF4MwkLtLpIOvAuGwv8LzwkxS2p6b+IgtFTy+dlK2DMkCQIBX
         MjkgDxHosOSPaXxaY2a6m7BXopWqCQdyeIHN4U2CNs1SjZzUAvIqfY+jGO2mLHKWs9dU
         LVCQ==
X-Gm-Message-State: AOAM532WD7hOkwn3aoCpLiWikBNkXbMwnSGq+gf0gAHSCiidjM5np0V+
        4AVdMLEpKWKB+b0F+dZ/rjFQmQemMhsKCXBopnQKODkV9d1IhOLstFq/y553mcdU3KsmzVsMTHg
        EEiZY8QefYRt/roiVDLwLEg1N
X-Received: by 2002:a5d:6341:: with SMTP id b1mr3025885wrw.373.1603377895530;
        Thu, 22 Oct 2020 07:44:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyy6/ULc2Qhz/lkjYdnyHz1JbZVqrBgfAegGJEfIA9/WIOjOlNUiHYm8Jolf3SALmV2NNabnA==
X-Received: by 2002:a5d:6341:: with SMTP id b1mr3025872wrw.373.1603377895365;
        Thu, 22 Oct 2020 07:44:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n62sm4120086wmb.10.2020.10.22.07.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 07:44:54 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Expose KVM_HINTS_REALTIME in
 KVM_GET_SUPPORTED_CPUID
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1603330475-7063-1-git-send-email-wanpengli@tencent.com>
 <cfd9d16f-6ddf-60d5-f73d-bb49ccd4055f@redhat.com>
 <6ad94df6-9ecd-e364-296a-34ba41e938b1@intel.com>
 <31b189e0-503f-157d-7af0-329744ed5369@redhat.com>
 <18e7a0c6-faff-8c4c-0830-a0bc02627a36@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a5d0ccd-f6a7-2afe-2480-991ff7e079b4@redhat.com>
Date:   Thu, 22 Oct 2020 16:44:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <18e7a0c6-faff-8c4c-0830-a0bc02627a36@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/20 16:28, Xiaoyao Li wrote:
> On 10/22/2020 10:06 PM, Paolo Bonzini wrote:
>> On 22/10/20 15:31, Xiaoyao Li wrote:
>>>>
>>>> It's common for userspace to copy all supported CPUID bits to
>>>> KVM_SET_CPUID2, I don't think this is the right behavior for
>>>> KVM_HINTS_REALTIME.
>>>
>>> It reminds of X86_FEATURE_WAITPKG, which is added to supported CPUID
>>> recently as a fix but QEMU exposes it to guest only when "-overcommit
>>> cpu-pm"
>>
>> WAITPKG is not included in KVM_GET_SUPPORTED_CPUID either.  QEMU detects
>> it through the MSR_IA32_UMWAIT register.
> 
> Doesn't 0abcc8f65cc2 ("KVM: VMX: enable X86_FEATURE_WAITPKG in KVM
> capabilities") add WAITPKG to KVM_GET_SUPPORTED_CPUID?

You're right, I shouldn't have checked only cpuid.c. :)

Still I think WAITPKG is different, because it's only for userspace and
it's always possible for userspace to do "for(;;)" and burn CPU.
KVM_HINTS_REALTIME is more similar to MONITOR, which is not set.

Paolo

