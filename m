Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AD22E0DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 18:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgLVRmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 12:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgLVRmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 12:42:22 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9843DC061793
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 09:41:42 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f17so8813718pge.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 09:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wl/m34cfT29L8x9YJJ07WrglAhvlzuwbzAXMtwjLDqs=;
        b=Xcs3s6dUoU49zTj42FUTN0c8Q1qmmR7Aahy0+qgkt/nzM/0dpofhm8l7+6ZNb8vW21
         ZZWzDW26Zihr1gwtLowjrQkHyMviPT9rAd2x5LyFY1WBSyMr2oyXm9m/nS7g1mXBuWo9
         MEddoMGx2hhX8qPVuay8nMtQlNaWvgZsABJVGTTrxOjajSJlVJ5BIHDJM9KsNHwgCbLB
         bd+5UF/8exzo99R+/gnN0vBm/14h4dqlwvBdoy1w+Mrsczen0C3tXFJkNtWURjmviaTz
         VOXQuRmMPCpsLfGfFVzmUPju5bGMcVwgkL9W5IOi1WQDGE17V4pWIeT+IceHWAdRQWmZ
         JIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wl/m34cfT29L8x9YJJ07WrglAhvlzuwbzAXMtwjLDqs=;
        b=kflbZgGhK3djPo0qsahS76zk/vYvW/ajSHuYALaB5A4K3n/A2xTgFuOA1VJldQk93z
         GJXnrim1z8y44n8+dUJXudEnMJdH7tWMSDnGx/QXO7PVZauxXbKAfdj9Sv4EBShjruy1
         JFFkSBV6zZyeCmmXx9aIm+8/KmvfI81Ijv78+hoq2Zk+mcQAtYRBd7xGbblUIKxyvM1D
         ckY2E/LNS591cZy0U35vAXsDCSsY3kqqNHEL+E4CDnYklcON9AXw3/DrLwAsInvHICXK
         cBqUCjp0/jcTN0fJ0B3V18zX3o5eQHMyHplCFfUfSKWEY5XhVBNaCcKkTyOvtVuODGFu
         E23g==
X-Gm-Message-State: AOAM5338EfGHQvHUwV8ikOPRWnj0pewUew2oF9o9z2GuJylIo2Ej8NN/
        dzVjvHXH7ImSpsA0dQxPl/pRgQ==
X-Google-Smtp-Source: ABdhPJzJmLsjwvtHIrr7Rf9B1stJ0eSh5IU+5JT3nqkJJ7OGOO5GHBGeHytzs1Eji1L3ZxiTm41JHA==
X-Received: by 2002:a62:1ad0:0:b029:197:e389:fb26 with SMTP id a199-20020a621ad00000b0290197e389fb26mr20811212pfa.20.1608658901964;
        Tue, 22 Dec 2020 09:41:41 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id w27sm17226426pfq.104.2020.12.22.09.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 09:41:41 -0800 (PST)
Date:   Tue, 22 Dec 2020 09:41:34 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        kvm list <kvm@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        kyung.min.park@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        "H . Peter Anvin" <hpa@zytor.com>, mgross@linux.intel.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kim.phillips@amd.com,
        wei.huang2@amd.com
Subject: Re: [PATCH 1/2] x86/cpufeatures: Add the Virtual SPEC_CTRL feature
Message-ID: <X+IvzsazR8f2LjLw@google.com>
References: <160738054169.28590.5171339079028237631.stgit@bmoger-ubuntu>
 <160738067105.28590.10158084163761735153.stgit@bmoger-ubuntu>
 <CALMp9eTk6B2832EN8EhL51m8UqmHLTfeOjdKs8TvFSSAUxGk2Q@mail.gmail.com>
 <2e929c9a-9da9-e7da-9fd4-8e0ea2163a19@amd.com>
 <CALMp9eRzYoVqr0zm60+pkJbGF+t0ry8k7y=X=R1paDhUUPSVCw@mail.gmail.com>
 <00fdc56a-5ac4-94a0-88b4-42e4cf46f083@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00fdc56a-5ac4-94a0-88b4-42e4cf46f083@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020, Babu Moger wrote:
> 
> On 12/9/20 5:11 PM, Jim Mattson wrote:
> > On Wed, Dec 9, 2020 at 2:39 PM Babu Moger <babu.moger@amd.com> wrote:
> >>
> >> On 12/7/20 5:22 PM, Jim Mattson wrote:
> >>> On Mon, Dec 7, 2020 at 2:38 PM Babu Moger <babu.moger@amd.com> wrote:
> >>>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> >>>> index dad350d42ecf..d649ac5ed7c7 100644
> >>>> --- a/arch/x86/include/asm/cpufeatures.h
> >>>> +++ b/arch/x86/include/asm/cpufeatures.h
> >>>> @@ -335,6 +335,7 @@
> >>>>  #define X86_FEATURE_AVIC               (15*32+13) /* Virtual Interrupt Controller */
> >>>>  #define X86_FEATURE_V_VMSAVE_VMLOAD    (15*32+15) /* Virtual VMSAVE VMLOAD */
> >>>>  #define X86_FEATURE_VGIF               (15*32+16) /* Virtual GIF */
> >>>> +#define X86_FEATURE_V_SPEC_CTRL                (15*32+20) /* Virtual SPEC_CTRL */
> >>>
> >>> Shouldn't this bit be reported by KVM_GET_SUPPORTED_CPUID when it's
> >>> enumerated on the host?
> >>
> >> Jim, I am not sure if this needs to be reported by
> >> KVM_GET_SUPPORTED_CPUID. I dont see V_VMSAVE_VMLOAD or VGIF being reported
> >> via KVM_GET_SUPPORTED_CPUID. Do you see the need for that?
> > 
> > Every little bit helps. No, it isn't *needed*. But then again, this
> > entire patchset isn't *needed*, is it?
> > 
> 
> Working on v2 of these patches. Saw this code comment(in
> arch/x86/kvm/cpuid.c) on about exposing SVM features to the guest.
> 
> 
>         /*
>          * Hide all SVM features by default, SVM will set the cap bits for
>          * features it emulates and/or exposes for L1.
>          */
>         kvm_cpu_cap_mask(CPUID_8000_000A_EDX, 0);
> 
> 
> Should we go ahead with the changes here?

Probably not, as the current SVM implementation aligns with the intended use of
KVM_GET_SUPPORTED_CPUID.  The current approach is to enumerate what SVM features
KVM can virtualize or emulate for a nested VM, i.e. what SVM features an L1 VMM
can use and thus can be set in a vCPU's CPUID model.  For V_SPEC_CTRL, I'm
pretty sure Jim was providing feedback for the non-nested case of reporting
host/KVM support of the feature itself.

There is the question of whether or not KVM should have an ioctl() to report
what virtualization features are supported/enabled.  AFAIK, it's not truly
required as userspace can glean the information via /proc/cpuinfo (especially
now that vmx_features exists), raw CPUID, and KVM module params.  Providing an
ioctl() would likely be a bit cleaner for userspace, but I'm guessing that ship
has already sailed for most VMMs.
