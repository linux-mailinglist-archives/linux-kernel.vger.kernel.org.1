Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4446D26CAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgIPUOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgIPUN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:13:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AF2C061354
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 13:13:13 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lo4so12705574ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTCEXV2u4+i9HL2MMnq/glN2ilMyxl52NR06ee0GgqI=;
        b=s7OvZ4k0X7Pw/YnFXPKn5Ssxyktso0XlkEWg8Ij8fpLQLTsn54sqNK2C19JaPgH3YT
         Q6wO5+CpziRHkRIR30K7Fm8GwZ6iYHI+T6Acw4WahChKZ/t7rSDaFJc9Txc3wBm+WIsE
         gf7L45v47+T6MmK+JdJPaVaykD7W/oAl3ornmLk4a2d+MUBp37OFzc+FuXyQ1T8rHxVB
         uQUoLkdr1VYohRqnGs7BNUX0dhjNdjcRIA+07PzaKxA/LjFD2UUpcl2tkqCfwRaPKs2/
         ETUN51b1wV9G2k/ROZlQN3xYXCTrdWJr1uZbFG3PmdICKdnMMdhiPphRVdY8OLGDp5M/
         dMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTCEXV2u4+i9HL2MMnq/glN2ilMyxl52NR06ee0GgqI=;
        b=b+2IZ9LOE0Xsrj72XcZCTWLRNTgcKK2RSK+Stui8/0Uyx1uopai35MNNJMgd/+CBRm
         NXiDNYo6GD4bnnrarQhyUX/p+kGpuDgCLGY9vsMLu16A0XNxTS4jHpnYeFGYpRArruoJ
         rqfEI2n16N2Nw/Gry9ESDunslu838sByrNFgQoVNuRWTR0oVDxmOMHBiJipiQH4j3IHR
         4v6LY3uaXTlBDkWCbDFacR748h28ePhwEWYiCbKo3iwhLI6ljlcZFCkpcso2kxR8hwVh
         sT2OSQ96mNbFoEIP+BBM0/hmXkWTaOsKb8taK1hvGfih2+pUkinczjparOQU8DfK5Mlg
         oD+w==
X-Gm-Message-State: AOAM533fSmBH/zAB7ztTEHgi57OlKYaxE8Kkjv1/r8gnr48jfd4DowYX
        hhiGApGeTLS+KtmN/uNtnvhQS/J5hSy89el9i/22aA==
X-Google-Smtp-Source: ABdhPJzdmjE+SQI5hqYGTUQLcnf/xhorcpJlukLBjVePzZop6EZ+nDYP/c+zStkGc1zzXydi3cvMrPidltQPbtiLAtw=
X-Received: by 2002:a17:906:4d97:: with SMTP id s23mr28200879eju.157.1600287191923;
 Wed, 16 Sep 2020 13:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200902125935.20646-1-graf@amazon.com> <20200902125935.20646-6-graf@amazon.com>
 <CAAAPnDH2D6fANhZzy3fAL2XKO4ROrvbOoqPme2Ww6q5XcVJfog@mail.gmail.com> <c90a705d-8768-efd1-e744-b56cd6ab3c0f@amazon.com>
In-Reply-To: <c90a705d-8768-efd1-e744-b56cd6ab3c0f@amazon.com>
From:   Aaron Lewis <aaronlewis@google.com>
Date:   Wed, 16 Sep 2020 13:13:00 -0700
Message-ID: <CAAAPnDEoQhtXuiqHwUtrsL7codcToAVwaR=+qVczZrz6RCWe0A@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] KVM: x86: VMX: Prevent MSR passthrough when MSR
 access is denied
To:     Alexander Graf <graf@amazon.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        KarimAllah Raslan <karahmed@amazon.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kvm list <kvm@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >> +
> >>   /*
> >>    * These 2 parameters are used to config the controls for Pause-Loop Exiting:
> >>    * ple_gap:    upper bound on the amount of time between two successive
> >> @@ -622,6 +642,41 @@ static inline bool report_flexpriority(void)
> >>          return flexpriority_enabled;
> >>   }
> >
> > One thing that seems to be missing is removing MSRs from the
> > permission bitmap or resetting the permission bitmap to its original
> > state before adding changes on top of it.  This would be needed on
> > subsequent calls to kvm_vm_ioctl_set_msr_filter().  When that happens
> > the original changes made by KVM_REQ_MSR_FILTER_CHANGED need to be
> > backed out before applying the new set.
>
> I'm not sure I follow. Subsequent calls to set_msr_filter() will invoke
> the "please reset the whole MSR passthrough bitmap to a consistent
> state" which will then reapply the in-kvm desired state through the
> bitmap and filter state on top on each of those.
>

Yes, you're correct.  I discovered this after the fact by adding a
test to the selftest I wrote for the deny list system which I revamped
to work for your filter system.  It proved the permission bitmaps are
in fact set as expected on subsequent calls.  You can disregard this
comment.

As a side note, I'm happy to share the test if you'd like. I also used
it to uncover an issue in the first commit of this series.
