Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528642F8356
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbhAOSKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbhAOSKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:10:42 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98EEC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:10:01 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 15so6506921pgx.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A8HU57lnNGXivwjmV5hD7UIXYBjhrtMp5tMlgZSsho0=;
        b=YgjCZxlUX8zIn6UUzJNeBbd/T6EBt4wgcjHLo6RzW50hLGTjG6rqz5Uq0SOCDcWT96
         Co6Z1YZE5sY8El66WZy7CsA45bBR31DpKk5qD9dDCyEMvaCbZWhXIZkHMqYGA/wcVdTm
         LwvWdURhcQYsNLp2TvpmD7fcKV+sMH1s/r0h3iI43hcSSIJDPQM+yie14SpuDeWUv1v+
         Q2sJK5/rfaEiyEgI0XQ4Lb13GCGT3VY0oxSZMmqN/vgZXot9ySDK2KT+Y8Nsh/ERd5JX
         g4QLmw2/TecEKSHYhFR3Ui/gpX+R1/stZlzDf52p46JLvyUuSkEM//RwrIxPq364c6Jo
         fFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A8HU57lnNGXivwjmV5hD7UIXYBjhrtMp5tMlgZSsho0=;
        b=M+oKNrcKU98yh2BxRdiHHoMimHuULZaB/PMViTV6WAV19xnetj+lclaW8CV4Lb/xif
         c6BGYKFfnBlHZx6nGJ6NNmy03eapCrAwXV5JrhM4leea0gX8+UrwUoo43KqjYMozLbbF
         KQgS6DFcUqGyYTYPjyiqrtoLSqqDZmF5bfDBnlcxlRTXrsiW1ffRWDgcbId0CmqGPAWS
         /ApPtR9hxSOy2U3NbeZXGLogCtJriSvZYiF0SQ0T2zif6D8WDBeMg6r2/HWpGo5WMehG
         ExX9Sn9DyXeYQsQat9tXFzZZfZPY4P0irhOs1oWBVvoFDpkaFKALNADP1ZX4b1iDkxud
         iPQw==
X-Gm-Message-State: AOAM532eKwwvPc3kad7D8IPyyw+rN3wlqCSmk59PDpQGuTD2XRsOqS+/
        a7zG1CASgXM6Q6TJZrlRtPUvDA==
X-Google-Smtp-Source: ABdhPJwPv/lvnonyIREFYeM8j+JUI2wrlGzj8IloDhV+QBYpX2nG/g0QM/KmYtg+wSyPkEnfC4YvNg==
X-Received: by 2002:a62:d14f:0:b029:1ae:72f9:254c with SMTP id t15-20020a62d14f0000b02901ae72f9254cmr13740607pfl.38.1610734201153;
        Fri, 15 Jan 2021 10:10:01 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id x23sm10738953pge.47.2021.01.15.10.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:10:00 -0800 (PST)
Date:   Fri, 15 Jan 2021 10:09:53 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/3] x86/KVM/VMX: Introduce and use try_cmpxchg64()
Message-ID: <YAHaceikAK+xYxUg@google.com>
References: <20201215182805.53913-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215182805.53913-1-ubizjak@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020, Uros Bizjak wrote:
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
>   asm-generic/atomic: Add try_cmpxchg64() instrumentation
>   locking/atomic/x86: Introduce arch_try_cmpxchg64()
>   KVM/VMX: Use try_cmpxchg64() in posted_intr.c

For anyone else trying to apply this, it depends on v5.11-rc1 (commit
29f006fdefe6, "asm-generic/atomic: Add try_cmpxchg() fallbacks"), which hasn't
yet been merged into Paolo's tree.

>  arch/x86/include/asm/cmpxchg_32.h         | 62 +++++++++++++++++++----
>  arch/x86/include/asm/cmpxchg_64.h         |  6 +++
>  arch/x86/kvm/vmx/posted_intr.c            |  9 ++--
>  include/asm-generic/atomic-instrumented.h | 46 ++++++++++++++++-
>  scripts/atomic/gen-atomic-instrumented.sh |  2 +-
>  5 files changed, 108 insertions(+), 17 deletions(-)
> 
> -- 
> 2.26.2
> 
