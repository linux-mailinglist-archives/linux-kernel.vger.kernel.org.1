Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180D02D4E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 00:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbgLIXMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 18:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbgLIXMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:12:08 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11864C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 15:11:28 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id d189so3603026oig.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 15:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+U3WjMnftlSlkbn1Lbx+pgtBqPon9rmgvApLkBmiaaU=;
        b=ZWRFbiIbiezKISQP/eI7Cq3y9gmx6t6oJWTTlMpQD15u5m2o/QFoxFmpLh9k4mqNzu
         ACPQPNpMUd/nqmRQ3TdFRqSPCU5s44U9sGLQbg/Y3djE4/Wm5lRzmn+hHabAGe6BZdhJ
         yMicJ+WXSuB3awEB3u80zaOa7prnO3VIfXSmRTzL87riDWtX+Sj/d5qP3fI12Ki6/yAJ
         9a58/fG7NC4lagk6mLfjXmllyYi9g34nD0/l+Avd68fE6wQHrTiYXfriHyCYLub9GwAu
         eZ77KnTF4g5txSAZgCV2sqxd+q28DLxAz5tqoE+VwTj9deTQgVBozfQ5ThNTGPWKmORB
         Pdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+U3WjMnftlSlkbn1Lbx+pgtBqPon9rmgvApLkBmiaaU=;
        b=LR42+oMoQe9HSupIgvH8gnuwUbN4YGIrXrqXLqQTQwpP3eXnP0iUqRkiwcwzFMOw54
         nXIgTimKRsI3qVOXbtpeShKNFVTTbZeqNlAOrxB+UhjKlaakEluPCZx/FZkb8IxZkhJK
         Wj/VOqbUh9qL2dkna/0UQZ6dbeVSjB61D+BhhZby+RoV5DzGKOmCqhnK+tE49SG/yCCz
         CnbCxH/Z6ffKuzR5AgTV81+8ZPNvI27fE41M1I2bLhVhgL/3EVGwp9i1wuYB5ureomG/
         iDGUsaOhpIxgA94O8k9jN6qvkhk9kblo7Sz+21lfBnbCrv1xPZsZbuCdzDwPKs3+Z/Gi
         z1NA==
X-Gm-Message-State: AOAM533cOK3SnBnPAMX+fdKeB3CkiFbxogipC5cXxxO8V5J+/k7Ol0W0
        QLMM20xhXzx6QC6sIrLo6uEEkauT1CSnb41C9QGdhg==
X-Google-Smtp-Source: ABdhPJzwwEXYRzMbbJ2qBJM0N85TZRUKGCspwNVHhcEAthwq6icK1CUeTPl4tTDURhuaU6UeUsJI4ytf/zoohfh2QUU=
X-Received: by 2002:aca:d06:: with SMTP id 6mr3655233oin.13.1607555487103;
 Wed, 09 Dec 2020 15:11:27 -0800 (PST)
MIME-Version: 1.0
References: <160738054169.28590.5171339079028237631.stgit@bmoger-ubuntu>
 <160738067105.28590.10158084163761735153.stgit@bmoger-ubuntu>
 <CALMp9eTk6B2832EN8EhL51m8UqmHLTfeOjdKs8TvFSSAUxGk2Q@mail.gmail.com> <2e929c9a-9da9-e7da-9fd4-8e0ea2163a19@amd.com>
In-Reply-To: <2e929c9a-9da9-e7da-9fd4-8e0ea2163a19@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 9 Dec 2020 15:11:15 -0800
Message-ID: <CALMp9eRzYoVqr0zm60+pkJbGF+t0ry8k7y=X=R1paDhUUPSVCw@mail.gmail.com>
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

On Wed, Dec 9, 2020 at 2:39 PM Babu Moger <babu.moger@amd.com> wrote:
>
>
>
> On 12/7/20 5:22 PM, Jim Mattson wrote:
> > On Mon, Dec 7, 2020 at 2:38 PM Babu Moger <babu.moger@amd.com> wrote:
> >>
> >> Newer AMD processors have a feature to virtualize the use of the SPEC_CTRL
> >> MSR. This feature is identified via CPUID 0x8000000A_EDX[20]. When present,
> >> the SPEC_CTRL MSR is automatically virtualized and no longer requires
> >> hypervisor intervention.
> >>
> >> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >> ---
> >>  arch/x86/include/asm/cpufeatures.h |    1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> >> index dad350d42ecf..d649ac5ed7c7 100644
> >> --- a/arch/x86/include/asm/cpufeatures.h
> >> +++ b/arch/x86/include/asm/cpufeatures.h
> >> @@ -335,6 +335,7 @@
> >>  #define X86_FEATURE_AVIC               (15*32+13) /* Virtual Interrupt Controller */
> >>  #define X86_FEATURE_V_VMSAVE_VMLOAD    (15*32+15) /* Virtual VMSAVE VMLOAD */
> >>  #define X86_FEATURE_VGIF               (15*32+16) /* Virtual GIF */
> >> +#define X86_FEATURE_V_SPEC_CTRL                (15*32+20) /* Virtual SPEC_CTRL */
> >
> > Shouldn't this bit be reported by KVM_GET_SUPPORTED_CPUID when it's
> > enumerated on the host?
>
> Jim, I am not sure if this needs to be reported by
> KVM_GET_SUPPORTED_CPUID. I dont see V_VMSAVE_VMLOAD or VGIF being reported
> via KVM_GET_SUPPORTED_CPUID. Do you see the need for that?

Every little bit helps. No, it isn't *needed*. But then again, this
entire patchset isn't *needed*, is it?
