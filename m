Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1192EC2F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 19:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbhAFSIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 13:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbhAFSIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 13:08:40 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD3BC06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 10:07:59 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z12so1947928pjn.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 10:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=li/GOl/KjoXYB/kM32ILGJQY9xV9Xb+bAy3Ws88LvI0=;
        b=G4G0xD9tjCCh0tMUqSmps7tvPQGUuyIpjM2UHnaooPGnXVl/5lMqEP2h/oIPI/5DLk
         OW1i21NQosW1QV6NJKWL5hg98YJ6ls6JEZm1aNwsT7/9kTDmudiZFGCbyfStZLvVQTlT
         AFW4rGz510zkhSX77+QjOvY8z2GYCHgfbBnY4WOiLRZGTABvJ6Bxbdy8aYhxx5+grXv7
         ugWNu6w1oUhjfGQnBKueZgn86DrOWrx/r2fSEMPqDBzbdSqEv1iByBTRCGtpcyXDgWtz
         tbmc1M2cVOMXRpx7Uj+Wnp+cdwroYCNO+2CEJ4fEwNWWO6CvVJ7WRTn30uSPm1yNHFki
         1FlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=li/GOl/KjoXYB/kM32ILGJQY9xV9Xb+bAy3Ws88LvI0=;
        b=UPOn3S+R7T8CJWeEo4ydZU6BKLwvlkryO09Za7EMhVYtKFbYlsqe4g19iNbI2KuNXu
         DxWmWBgUMcnbbfXHIWT3CuU00LZP562CnznSsc1iiSJqddTjz09JqYN73slZmy5uz9wd
         8tSVWXxkUwFserDKCw67QMdlpqc3kzEFd8IQQJnN6apq1OcfJ/7ixvQj0N7IAY3hDdqT
         NHw0lKLpTAoCgYTlyZ/3QRPwNoxGPtBCeGmrsYsoSDIvjd8maHeov4mURAmJMRqedeBi
         Vwty/7yxwM7Eve2mNn06LkdGxoy55mbyfuvm6+M41AqiOlKXMspqnLb4ooRkMEyqa5WB
         I2kQ==
X-Gm-Message-State: AOAM531f7l5sBZW2SRVGi1GuIzar6LFrTVkVZnpqBMitxh6p5cmf83/A
        PxdNu68tnTxzuP5NFKLcIr+RixvEFPJ1DQ==
X-Google-Smtp-Source: ABdhPJwswpe5K1Pu3QoJal8mFFt/BLf2x1bIlEr+tYpSTIMc6GOafuNzaX//pofuFihvWTv/VSvWpg==
X-Received: by 2002:a17:902:d202:b029:da:d86b:78be with SMTP id t2-20020a170902d202b02900dad86b78bemr5307588ply.0.1609956479208;
        Wed, 06 Jan 2021 10:07:59 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id m22sm3647018pgj.46.2021.01.06.10.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 10:07:58 -0800 (PST)
Date:   Wed, 6 Jan 2021 10:07:51 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] RFC: VMX: fix for disappearing L1->L2 event
 injection on L1 migration
Message-ID: <X/X8d2XijuPxLOGG@google.com>
References: <20210106105306.450602-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106105306.450602-1-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021, Maxim Levitsky wrote:
> This is VMX version of the same issue as I reproduced on SVM.
> 
> Unlike SVM, this version has 2 pending issues to resolve.
> 
> 1. This seems to break 'vmx' kvm-unit-test in
> 'error code <-> (!URG || prot_mode) [+]' case.
> 
> The test basically tries to do nested vm entry with unrestricted guest disabled,
> real mode, and for some reason that works without patch 2 of this series and it
> doesn't cause the #GP to be injected, but with this patch the test complains
> about unexpected #GP.

An unexpected #GP for that test is very unlikely.  The various sub-tests under
vmx_controls_test() should never fully enter the guest as GUEST.RFLAGS is set to
an invalid value.  And, that specific test does VM-Enter with URG=0 and
CR0.PG/PE=0, which is also invalid.  The unit test uses test_vmx_valid_controls(),
which is a wee bit misleading, as the "early" consistency checks that cause
VM-Fail are expected to succeed, while the VM-Enter is still expected to "fail"
due to a consistency check VM-Exit.

> I suspect that this test case is broken, but this has to be investigated.
> 
> 2. L1 MTF injections are lost since kvm has no notion of them, this is TBD to
> be fixed.
> 
> This was lightly tested on my nested migration test which no VMX sadly still
> crashes and burns on an (likely) unrelated issue.
> 
> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (2):
>   KVM: VMX: create vmx_process_injected_event
>   KVM: nVMX: fix for disappearing L1->L2 event injection on L1 migration
> 
>  arch/x86/kvm/vmx/nested.c | 12 ++++----
>  arch/x86/kvm/vmx/vmx.c    | 60 ++++++++++++++++++++++++---------------
>  arch/x86/kvm/vmx/vmx.h    |  4 +++
>  3 files changed, 47 insertions(+), 29 deletions(-)
> 
> -- 
> 2.26.2
> 
> 
