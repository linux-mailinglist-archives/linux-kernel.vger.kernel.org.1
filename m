Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582602937B8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392601AbgJTJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392600AbgJTJNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603185193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOEy9aT9NtMMFJrshH7arUKD1nGqLIA4h6tvbyg+cCQ=;
        b=LCJZi89OrGNkFFIHRJT7lbuv04P3ML8t+Pe2kekJ6UiDtw25zVTe9Wnp2HJdXqTMxbcXQ+
        v+9O7rZBg/SQlEbJLiimyh3BrThehMSkK/Pj/uZdvnYowHMxJ4mYMRWtH0RAkkKC+gAZh0
        yvvUK+JEpzoh06eIeLINPyUXFwDjcB8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-C38QvdgHMOeCldvmUPxklg-1; Tue, 20 Oct 2020 05:13:12 -0400
X-MC-Unique: C38QvdgHMOeCldvmUPxklg-1
Received: by mail-wr1-f72.google.com with SMTP id q15so550847wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oOEy9aT9NtMMFJrshH7arUKD1nGqLIA4h6tvbyg+cCQ=;
        b=cqXPJ+5Xrt5Y0uWqcWbmFdMifMAbDE9sSMNBTj3Z8WK8E+X7aXwh5/SNWNCHnAMnPK
         gu35EEfukal6eyOqpXSViIazcgMC0Hi8TlJwdSgHo8qgWQr0r7xSz2od3gm1TtnQ4rPc
         WQ13dCs9KxnOvZbugXpYCTOQc0l0YbK2TAHACbBFczM+B7ySQZZSqdy9I9pHjet80c6x
         liSzdRL/XcOASr6AQuwM90TSZ7I4G6J74p61y26hs0jL6uv0khXl7qOmXgW2WYhkkbj3
         m0sii8WCwdyPmhLxfGQAZ2L5UZDO8GOVS2mjG3Yk37fhqa+htJho100kGNTG/XYqWgmD
         TOMg==
X-Gm-Message-State: AOAM533huMf1tiKDkG+/j79P8AP8rsdGS7nN55OoAeyICV8/5eBQwG7Z
        Hfsh4Fbb78ywoul49KyUdZdcCVABcRN0ePg9eLpMBKA83NQHskYuvE0gu0tPWeoLshoD4CUARsO
        SEysu1ijRHNohYBYn2YBs5EU7
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr1869321wmd.95.1603185190640;
        Tue, 20 Oct 2020 02:13:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYLeXYXKL0aEWIz3HPFIHkZmIWRXrsEo41r73AgTQ1N4YxYXVrI7Ur44rryYm+YqVyWuwqUA==
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr1869301wmd.95.1603185190434;
        Tue, 20 Oct 2020 02:13:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j7sm1942145wrn.81.2020.10.20.02.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 02:13:09 -0700 (PDT)
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
References: <20200930041659.28181-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/5] KVM: x86: Handle reserved CR4 bit interception in VMX
Message-ID: <8bf5e849-3a7d-a30a-061b-0a67a57de865@redhat.com>
Date:   Tue, 20 Oct 2020 11:13:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200930041659.28181-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 06:16, Sean Christopherson wrote:
> This series stems from Lai's RFC patches to intercept LA57 and let the
> guest own FSGSBASE[*].  Discussion and inspection revealed that KVM does
> not handle the case where LA57 is supported in hardware but not exposed to
> the guest.  This is actually true for all CR4 bits, but LA57 is currently
> the only bit that can be reserved and also owned by the guest.  I have
> a unit test for this that I'll post separately.
> 
> Intercepting LA57 was by far the easiest fix for the immedidate bug, and
> is likely the right change in the long term as there's no justification
> for letting the guest own LA57.
> 
> The middle three patches adjust VMX's CR4 guest/host mask to intercept
> reserved bits.  This required reworking CPUID updates to also refresh said
> mask at the correct time.
> 
> The last past is Lai's, which let's the guest own FSGSBASE.  This depends
> on the reserved bit handling being in place.
> 
> Ran everything through unit tests, and ran the kernel's FSGSBASE selftests
> in a VM.
> 
> [*] https://lkml.kernel.org/r/20200928083047.3349-1-jiangshanlai@gmail.com
> 
> Lai Jiangshan (2):
>   KVM: x86: Intercept LA57 to inject #GP fault when it's reserved
>   KVM: x86: Let the guest own CR4.FSGSBASE
> 
> Sean Christopherson (3):
>   KVM: x86: Invoke vendor's vcpu_after_set_cpuid() after all common
>     updates
>   KVM: x86: Move call to update_exception_bitmap() into VMX code
>   KVM: VMX: Intercept guest reserved CR4 bits to inject #GP fault
> 
>  arch/x86/kvm/cpuid.c          |  6 +++---
>  arch/x86/kvm/kvm_cache_regs.h |  2 +-
>  arch/x86/kvm/vmx/vmx.c        | 18 +++++++++++++-----
>  3 files changed, 17 insertions(+), 9 deletions(-)
> 

Queued, thanks.

Paolo

