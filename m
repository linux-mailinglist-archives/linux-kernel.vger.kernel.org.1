Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5592FA8D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436855AbhARSaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:30:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393684AbhARS1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610994373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z5tNgVARNvQCB0SJouIAYqEN8m6OYsaWxW5vbk1y2k0=;
        b=EH2vK0Fbaf7bWnYR919g8PTvBpqEzrZbaCIkE5RQuwp/H7nrnKVNj8SnPw9IWrZeIFO50o
        J+qrMZl5WJqjb2csBF7qiz9GEkum274+mXgliTgwVaA6iCq5Kp3Y7BcTG/BMyG3y2/5EbP
        kcTRG+vxumZSSb5i/rukRddzLlKvrqw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-uxSYyb2ZNWuTZxYOhtQwOw-1; Mon, 18 Jan 2021 13:26:12 -0500
X-MC-Unique: uxSYyb2ZNWuTZxYOhtQwOw-1
Received: by mail-wr1-f70.google.com with SMTP id r11so8697677wrs.23
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z5tNgVARNvQCB0SJouIAYqEN8m6OYsaWxW5vbk1y2k0=;
        b=nV1t21WElj6NFM3Ey6sy3hFAjvvVgKDESq5p3Q5f8ripZm3S2oyEvwlBdm1z3oJLEu
         A/zeFAKI7pQd6kpvgVWwNgJvyI/JGHs6NWFeD2Cgyhs01o+T+bRp6l3nTz5CM26hVuF2
         u5JbShK1XFlLqnUHMn1tRmAmGb6jwWF+2rB+LdKGHUr7gBLLpHI1C9JULDjHAJd2l6/Y
         Y+vGtCS0D3/I+QnCdA8WPDIhNcW+8Xbuhqx2zpd8rfRF9d3MGFny7VCtwrFh14CZzY9d
         RilZzbTUT9najyIHyeMG5TGhS0MpSGGWHQS0DmyPAn4aL/dB1pUWmmSuG2ERj4gNsecR
         yltw==
X-Gm-Message-State: AOAM5329xg9xNJ2llkX+XFi+g7AMoxX0WSWhbVoJq1sED8IM4gLRgYGn
        xU4BUpotK3cGv62wP2iHTJSHXlz9rM3Ag04UmLP0L7iWVoH7rBrROOpfWkfX7eqDR+xOFOdkFl7
        Q1+v//9lLsmfe4mwxkmtP01gV
X-Received: by 2002:adf:fccb:: with SMTP id f11mr746715wrs.3.1610994371126;
        Mon, 18 Jan 2021 10:26:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+GkRlOpn8qdAgG+r1ePLj7djM6dNvjijlBFLTRGUtIq1pAUqz9pcNXC44g/iM+5qMvdIrDA==
X-Received: by 2002:adf:fccb:: with SMTP id f11mr746695wrs.3.1610994370933;
        Mon, 18 Jan 2021 10:26:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c6sm34500990wrh.7.2021.01.18.10.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:26:10 -0800 (PST)
Subject: Re: [PATCH 0/3] x86/KVM/VMX: Introduce and use try_cmpxchg64()
To:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20201215182805.53913-1-ubizjak@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05bc4cc2-1c1b-ebb8-39e3-9eaef7f0df4f@redhat.com>
Date:   Mon, 18 Jan 2021 19:26:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201215182805.53913-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/20 19:28, Uros Bizjak wrote:
> This patch series introduces try_cmpxchg64() atomic locking function.
> 
> try_cmpxchg64() provides the same interface for 64 bit and 32 bit targets,
> emits CMPXCHGQ for 64 bit targets and CMPXCHG8B for 32 bit targets,
> and provides appropriate fallbacks when CMPXCHG8B is unavailable.
> 
> try_cmpxchg64() reuses flags from CMPXCHGQ/CMPXCHG8B instructions and
> avoids unneeded CMP for 64 bit targets or XOR/XOR/OR sequence for
> 32 bit targets.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> 
> Uros Bizjak (3):
>    asm-generic/atomic: Add try_cmpxchg64() instrumentation
>    locking/atomic/x86: Introduce arch_try_cmpxchg64()
>    KVM/VMX: Use try_cmpxchg64() in posted_intr.c
> 
>   arch/x86/include/asm/cmpxchg_32.h         | 62 +++++++++++++++++++----
>   arch/x86/include/asm/cmpxchg_64.h         |  6 +++
>   arch/x86/kvm/vmx/posted_intr.c            |  9 ++--
>   include/asm-generic/atomic-instrumented.h | 46 ++++++++++++++++-
>   scripts/atomic/gen-atomic-instrumented.sh |  2 +-
>   5 files changed, 108 insertions(+), 17 deletions(-)
> 

Queued, thanks.

Paolo

