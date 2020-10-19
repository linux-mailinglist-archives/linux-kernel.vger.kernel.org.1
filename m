Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7586292AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgJSP7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730335AbgJSP7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603123175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOEy9aT9NtMMFJrshH7arUKD1nGqLIA4h6tvbyg+cCQ=;
        b=Nj+YtCioiH7Z/NJMfxduw341ouVe337TLvlRQJx/rNSZPkr/D0EAOMraM85aNccMlW3esn
        zIKKckcQtXXyry3lKuZHtq23I9e4hBzc0QUiMMMfaaZLnhsgCyb2oHHSIOZw70qkF6JMyd
        webMFxu3EYi4gzvVsnLUfpjc055JdEA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-YQuLrWkiMcWGd6IOv5JRlw-1; Mon, 19 Oct 2020 11:59:33 -0400
X-MC-Unique: YQuLrWkiMcWGd6IOv5JRlw-1
Received: by mail-wm1-f69.google.com with SMTP id c204so67wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oOEy9aT9NtMMFJrshH7arUKD1nGqLIA4h6tvbyg+cCQ=;
        b=ZUKzibQV/Qa1OyiYMDMlMqOSxS9qn9U/brU0vNKC4RiZoDfsUGDxs2BjfsCYzAh5XN
         DpuFlXX5jgC3LvzN3Oj1AezCHg8l7TT8JuzNFu9c09iolHqHMIL1JLVy9AdXH6Eud9ZR
         y8m4RLDsMTQ0ZMT1fWW1ToHCnHOyJrHyIz3Owph8CrP18cK9HkFLZJjWR5Mgb1nr9Utm
         9ejTNIeoY3On01REaphkimCA4W+0iqgY0+32lR7w3yaGeS4KEKCxk4i1jFad26b3MisJ
         LETGjbqgR69Ky3NtzUaJL02FSRfD+m3NMVCDwt0PYELE2z7Calc2NB5sdaGqcL3uHM8U
         XTDQ==
X-Gm-Message-State: AOAM533CiEjNiFj7nAAwoaRUITUPw0ahRiIzu7iuzI9IxWtGuZNbxoYG
        UK7zAmCDQk09WthuHpKGFi+APVqREZRmQnMgV617secWojdu4TjWrhYjjnLoULcXbN6aV7F3DVm
        eMq4NpetGp47lDnEdYZSoGqol
X-Received: by 2002:adf:a455:: with SMTP id e21mr286562wra.158.1603123171543;
        Mon, 19 Oct 2020 08:59:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEGOfQUJy5OxMjIop2OyfD2MyEgGIseNWdmiEzUvFGnE9jJvyiXxLsD4/rUhivbOaFwu1s2w==
X-Received: by 2002:adf:a455:: with SMTP id e21mr286529wra.158.1603123171196;
        Mon, 19 Oct 2020 08:59:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o129sm11143wmb.25.2020.10.19.08.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 08:59:30 -0700 (PDT)
Subject: Re: [PATCH 0/5] KVM: x86: Handle reserved CR4 bit interception in VMX
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
Message-ID: <361d91aa-6900-12f3-d5bb-654ab4f9879f@redhat.com>
Date:   Mon, 19 Oct 2020 17:59:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200930041659.28181-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

