Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C252791F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgIYUUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726844AbgIYUSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:18:12 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601065091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OIVZsjCbRDX/aepPaR0Uwnnx59y20L2Av4pvbF4EM40=;
        b=TYMtXA5qeKcAGCvXRXJTRpTPCEFVcaNUEEI1JlvxvNeraaROiIdIhzbeQ1MxK35bedigNM
        p+QEb5lw9qzC8AsWlmt4BPSWRRQ3sl+RSL2SJZv01hOg+Oin6LLKa9NifzpdiDmiO5ZPms
        fJUUChSo3XCb4aeIWSOB1QKFVU2UqL0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-PoHy3J-9OJ-2Mx3SiVd2Xg-1; Fri, 25 Sep 2020 15:50:05 -0400
X-MC-Unique: PoHy3J-9OJ-2Mx3SiVd2Xg-1
Received: by mail-wr1-f69.google.com with SMTP id f18so1469902wrv.19
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OIVZsjCbRDX/aepPaR0Uwnnx59y20L2Av4pvbF4EM40=;
        b=kMo/aLDaWdXzEYBeuY/3LP5w1DmoEejTTPA6NI+oJAb3iYr5zg47ohkPWjlkxoH2N8
         vKOEUjUxQxAnQn1haNRMOGfG5LVETAyXgUI7VZibzp1E8z0SyzassbPONv1yYqriEY/j
         KrSHxa2gQQ01ieOxuibzZyNfNk/M28tt1UnWaiViFXLc4zpFWqx6cRJEQY0t87ftIPdA
         LdpVrHR8GRZRCtjQnFn/crgkTImfcYXKa8ZyFwz9T72XnOLNW5lRko4l9XGMcsfz6gc4
         7NI/nM4SFciLAcpkIpK+yIW+JgargFzU/7fB881iFSjJ50b0f0KLQtaiGVw6b3zCeF6G
         gOLQ==
X-Gm-Message-State: AOAM533GJqL5R8yNTuqISDEKsP0nAKBvtRXUp7cJf3sxozgCxarrydyq
        Hqx7Y5UmapMPablApUBM+BELLd370GNPO/pWLVi7gAERLwz3lzj8VIfJJxN4ZIs2HP7vT+LrU3C
        RJ6CNB76fo04m+rIEkjtNKF3W
X-Received: by 2002:adf:e407:: with SMTP id g7mr6102467wrm.349.1601063404437;
        Fri, 25 Sep 2020 12:50:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2BKPdK568rDKnVy0f3oYUrL5JAXlwiTjQ7YwfwmKIieoyeOCAVT75UmfZAbM9RySzYJX0EA==
X-Received: by 2002:adf:e407:: with SMTP id g7mr6102444wrm.349.1601063404156;
        Fri, 25 Sep 2020 12:50:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id u186sm75789wmu.34.2020.09.25.12.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 12:50:03 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] KVM: VMX: Clean up RTIT MAXPHYADDR usage
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200924194250.19137-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f694762-6b8c-be1b-c0f0-5f7897866b66@redhat.com>
Date:   Fri, 25 Sep 2020 21:50:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924194250.19137-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/20 21:42, Sean Christopherson wrote:
> Stop using cpuid_query_maxphyaddr() for a random RTIT MSR check, unexport
> said function to discourage future use, and do additional related cleanup.
> 
> Paolo, feel free to reorder/squash these as you see fit.  Five patches
> feels more than a bit gratuitous, but every time I tried to squash things
> I ended up with changelogs that ran on and on...
> 
> v2:
>   - Rebased to kvm/queue, commit e1ba1a15af73 ("KVM: SVM: Enable INVPCID
>     feature on AMD").
> 
> Sean Christopherson (5):
>   KVM: VMX: Use precomputed MAXPHYADDR for RTIT base MSR check
>   KVM: x86: Unexport cpuid_query_maxphyaddr()
>   KVM: VMX: Replace MSR_IA32_RTIT_OUTPUT_BASE_MASK with helper function
>   KVM: x86: Move illegal GPA helper out of the MMU code
>   KVM: VMX: Use "illegal GPA" helper for PT/RTIT output base check
> 
>  arch/x86/kvm/cpuid.c   |  1 -
>  arch/x86/kvm/cpuid.h   |  5 +++++
>  arch/x86/kvm/mmu.h     |  5 -----
>  arch/x86/kvm/mmu/mmu.c |  2 +-
>  arch/x86/kvm/vmx/vmx.c | 13 ++++++++-----
>  5 files changed, 14 insertions(+), 12 deletions(-)
> 

Queued, thanks.

Paolo

