Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB7A2B1AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgKMMEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:04:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbgKMLgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605267378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KS2gzxwe2L87PtFz5vQ1RhEQgR8wNZBK0sfzPULcu7o=;
        b=Nz2iO3lMeGSwRDlhKPLBQaJf4pWtw1rvV45nbwMT8NTnW/jPDJMutrxP5zLIJsxePgGC/+
        lqEK9YGZkw+lD92QNhg7S4OhJF5qkHvKXXmJTM+rT2+y7pmoPc+rXQXDAnsOvOvWXqOEgI
        RUyjFr/y8b3A486Wzvlvj2/cnKn7XFY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-rOae7TjUP2GHhXWTeaU_pg-1; Fri, 13 Nov 2020 06:36:16 -0500
X-MC-Unique: rOae7TjUP2GHhXWTeaU_pg-1
Received: by mail-wm1-f71.google.com with SMTP id y26so3064469wmj.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KS2gzxwe2L87PtFz5vQ1RhEQgR8wNZBK0sfzPULcu7o=;
        b=IFG4W9K1D3LKGj9Ld80uNhfYql56FKExVnoaqrouYkttpH9i2s0EPtv9ddVjXTx9AS
         xxjfaDClIki05ArfypfBAm1zRiqs9BEPTxRktgBnDVO6kuoE0shXMSsI3wjJRgTMtHOb
         OtCQZRwfF8GTDVwVQAfgIpkhhJGk0U649/WvW0J7sD621gYCXwokts6Hz1UisL0CTuO6
         Y4gmJj6QGbh3XR+ThNu8b2HTiDbNzPNbCSkCas0nc2kooikqMyGlUo4MsFNGD7aD8iPI
         2KQy5EEGmkiirkBQKz6+gCzYsAQvJn7A2i02GQRJ4uOIN+ZZD9xftQIApC/RZQ2JFLzA
         6MGg==
X-Gm-Message-State: AOAM530HSXXQIR59Uzv5VQej3KWLrlrOOLYieE2td2HSWivmMh7KGYws
        QHYb3AD1pV6HXznDETAcxLZGBw92Wm2B3vAuMfNlwbC91X+gaqDvnEtKyrgHT4hQd90YdkkHwsI
        X06dXq1rzCY2npgfMufjOdVMM
X-Received: by 2002:adf:d188:: with SMTP id v8mr2843718wrc.167.1605267375675;
        Fri, 13 Nov 2020 03:36:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCm0Ta3PICoFUYN57ryHX4hbOc9tjQT5NoiiL6jlhQd5K67/cBAJCbuSadSBT4N599467vIw==
X-Received: by 2002:adf:d188:: with SMTP id v8mr2843695wrc.167.1605267375442;
        Fri, 13 Nov 2020 03:36:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b14sm10981498wrx.35.2020.11.13.03.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:36:14 -0800 (PST)
Subject: Re: [PATCH 0/6] KVM: x86: KVM_SET_SREGS.CR4 bug fixes and cleanup
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stas Sergeev <stsp@users.sourceforge.net>
References: <20201007014417.29276-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <287166fd-0db1-ace1-3abe-96c5600fd30b@redhat.com>
Date:   Fri, 13 Nov 2020 12:36:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201007014417.29276-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/20 03:44, Sean Christopherson wrote:
> Two bug fixes to handle KVM_SET_SREGS without a preceding KVM_SET_CPUID2.
> 
> The overarching issue is that kvm_x86_ops.set_cr4() can fail, but its
> invocation from __set_sregs(), a.k.a. KVM_SET_SREGS, ignores the result.
> Fix the issue by moving all validity checks out of .set_cr4() in one way
> or another.
> 
> I intentionally omitted a Cc to stable.  The first bug fix in particular
> may break stable trees as it simply removes a check, and I don't know that
> stable trees have the generic CR4 reserved bit check that is needed to
> prevent the guest from setting VMXE when nVMX is not allowed.
> 
> Sean Christopherson (6):
>    KVM: VMX: Drop guest CPUID check for VMXE in vmx_set_cr4()
>    KVM: VMX: Drop explicit 'nested' check from vmx_set_cr4()
>    KVM: SVM: Drop VMXE check from svm_set_cr4()
>    KVM: x86: Move vendor CR4 validity check to dedicated kvm_x86_ops hook
>    KVM: x86: Return bool instead of int for CR4 and SREGS validity checks
>    KVM: selftests: Verify supported CR4 bits can be set before
>      KVM_SET_CPUID2
> 
>   arch/x86/include/asm/kvm_host.h               |  3 +-
>   arch/x86/kvm/svm/nested.c                     |  2 +-
>   arch/x86/kvm/svm/svm.c                        | 12 ++-
>   arch/x86/kvm/svm/svm.h                        |  2 +-
>   arch/x86/kvm/vmx/nested.c                     |  2 +-
>   arch/x86/kvm/vmx/vmx.c                        | 35 +++----
>   arch/x86/kvm/vmx/vmx.h                        |  2 +-
>   arch/x86/kvm/x86.c                            | 28 +++---
>   arch/x86/kvm/x86.h                            |  2 +-
>   .../selftests/kvm/include/x86_64/processor.h  | 17 ++++
>   .../selftests/kvm/include/x86_64/vmx.h        |  4 -
>   .../selftests/kvm/x86_64/set_sregs_test.c     | 92 ++++++++++++++++++-
>   12 files changed, 153 insertions(+), 48 deletions(-)
> 

Queued, thanks.

Paolo

