Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DB12D1E47
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgLGXW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgLGXW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:22:59 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34510C061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 15:22:13 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id h18so10242669otq.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 15:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ecLFgA6ZVCXrlWighsImjDrXnRjbX/ebIaxkalo6/1w=;
        b=m9uza9hGO/gEO45Mlbe5J+I8EvvJeJHIkmRVRSp5NbFk4RQSlSp828okY3HqNFwRmC
         lg6oDYOANzhyajOmaeldvAnga3DuDtJf72t/6jMyIERuC0EYCg8QpUGyahruhT7Eebn5
         uE1Uj1QZ+pH7wjFxnjU69zipvFLf+HflQkjR/PKvWLN33evvvHJ/vCCxzmD+Y77OipEb
         A1Uhzily9tuqOO3xODNqNWkiUSO41F/P6jx+hXJeavMGrPBJeJod9kgVEuUv3rsRrP1Y
         wHCG+XFGYgqDZO0zLbMuJkvx2DI2QisX3UvkfvrKiqwKu2FyPFb/OIs4nwYF8gRZXlGm
         AtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecLFgA6ZVCXrlWighsImjDrXnRjbX/ebIaxkalo6/1w=;
        b=QTyjck2JrBw4QmOJM+FoWTPn6GKbbxCNa/9NYzIkRuHb1flNkb6xEzsdjX/NlIGEGc
         vrYsXwG1TDLdUP0cvowSlcJa1madYIV36Xyi3/4E36rPFTQ3NR0n3DUA3qc3Hv2C9x3b
         wInZKLExNVHZRUNF8+L4zLqsZF2nqttEbi7OeQMF3XBjQ8RD2Y1MPFYjd9SflqoGPYY+
         O+TIGy2lS3/SQmW7bYSsgn7Ophao2Wqd/Xo7penMTG3mQ7n4UPc/l9TNfP8+bHvGFLq2
         ocNUFZw8dYBt2M3zPUgf4LpZbgjBU+fyAENy4IwmHvoGAC+rIMiK7EVt2RI+0poDgOqk
         l3zw==
X-Gm-Message-State: AOAM530Bi1CsFkow41FgpP/6bgqFuV1NMzGd30K2elE1d1G1m5ESOjWk
        4E1VSlJn+BRpVxZwzGncZv1xVgJk6j582DdIbCCKOA==
X-Google-Smtp-Source: ABdhPJx72Bm1nE0g6cD2iqMrP2OAG4RUggDRs+kLGI/Mzm3KLvKIiWvl0+zmUu779zCvhLp7KCnx2Hj9ArckxZjwkJM=
X-Received: by 2002:a9d:d01:: with SMTP id 1mr14480096oti.295.1607383332277;
 Mon, 07 Dec 2020 15:22:12 -0800 (PST)
MIME-Version: 1.0
References: <160738054169.28590.5171339079028237631.stgit@bmoger-ubuntu> <160738067105.28590.10158084163761735153.stgit@bmoger-ubuntu>
In-Reply-To: <160738067105.28590.10158084163761735153.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 7 Dec 2020 15:22:00 -0800
Message-ID: <CALMp9eTk6B2832EN8EhL51m8UqmHLTfeOjdKs8TvFSSAUxGk2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/cpufeatures: Add the Virtual SPEC_CTRL feature
To:     Babu Moger <babu.moger@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        kvm list <kvm@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kyung.min.park@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        "H . Peter Anvin" <hpa@zytor.com>, mgross@linux.intel.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kim.phillips@amd.com,
        wei.huang2@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 2:38 PM Babu Moger <babu.moger@amd.com> wrote:
>
> Newer AMD processors have a feature to virtualize the use of the SPEC_CTRL
> MSR. This feature is identified via CPUID 0x8000000A_EDX[20]. When present,
> the SPEC_CTRL MSR is automatically virtualized and no longer requires
> hypervisor intervention.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index dad350d42ecf..d649ac5ed7c7 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -335,6 +335,7 @@
>  #define X86_FEATURE_AVIC               (15*32+13) /* Virtual Interrupt Controller */
>  #define X86_FEATURE_V_VMSAVE_VMLOAD    (15*32+15) /* Virtual VMSAVE VMLOAD */
>  #define X86_FEATURE_VGIF               (15*32+16) /* Virtual GIF */
> +#define X86_FEATURE_V_SPEC_CTRL                (15*32+20) /* Virtual SPEC_CTRL */

Shouldn't this bit be reported by KVM_GET_SUPPORTED_CPUID when it's
enumerated on the host?

>  /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
>  #define X86_FEATURE_AVX512VBMI         (16*32+ 1) /* AVX512 Vector Bit Manipulation instructions*/
>
