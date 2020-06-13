Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2431F7FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 02:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFMAEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 20:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgFMAEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 20:04:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBEDC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 17:04:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j198so10002294wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VfDm+kOR3bMur7weyo96z2X7xwYG9trcHyU7UQvlWck=;
        b=vaNnyxycjd5kVmPsqB+l7TbfUaSdnI8iMMldqNk2u7cGUDel5AZ3kJ2Hm7vGrTybcW
         IMRl7EUWDhkYW3ikUGr87wAlRoKSX38/r+P9KryW2iX35lr69kVMZW8StAduHSgZUAz1
         kw0b5t9JCiOmk06Y4VRQmWsA7KvB/Eto8SCiz8mT7JG8gY//VuL+p+OTZWw6vwBBUq68
         qBpVCQGe9/1ieQZ7cjrE396XLirr189vRwgY1Lgp0NNOVSNkYvK6mhCscnS6C01QnSuK
         zbX/yuuGwjR2Xo+D3WtjxbnwiyVgblZfM8nOPJU88akEh5UqeK4IKb40xRNArVJLLsD1
         KltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VfDm+kOR3bMur7weyo96z2X7xwYG9trcHyU7UQvlWck=;
        b=MwhLjhqRfgEzKeVkvoUFVjw7q6S+ByHK478jUfWvrqvjUEpBzQOLMpfXpdgOm0lcCy
         li/9UilqAIjgiSDu0q3kpPRQVjL6AhPrzu4QLB+Z95XU8YOKv/yExNigcdCMMt1zwNKo
         xPfdPpqEBxuEazYdLKeGdzLDqB/FUwAAbvTxQad6rYc9gnfmCbZCnxICt32MtJSHLzgd
         UU5cqzwmJSkGve8+J1Ejt4A08LwGqpH1iC78GRghX6gWpc6LU68ftPQidS2CUw3Babeb
         IBP3CPS4NGwRrALHy73WQa4/1qiujpOZSdtvt3+OX44qZts7Py/47PdABLaQ0R2i8860
         e29A==
X-Gm-Message-State: AOAM53130/H79b/pKfuSXsUgdwthJoMnSJBB/NKvvEV3PAvcjv8mFvx4
        A5rfZw6a7duHrynV//fTZmeOp+KDoc/1D7vsjkMgIg==
X-Google-Smtp-Source: ABdhPJwCvyBB1gdgVqXaOyNEdN2d9vbWc0h3WyQyHySECyQktUK6pC75Gg1d763D8eulWBamCVfziZiK02AbXcR8d/4=
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr1372084wml.48.1592006669955;
 Fri, 12 Jun 2020 17:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <159191202523.31436.11959784252237488867.stgit@bmoger-ubuntu>
 <159191213022.31436.11150808867377936241.stgit@bmoger-ubuntu>
 <CALMp9eSC-wwP50gtprpakKjPYeZ5LdDSFS6i__csVCJwUKmqjA@mail.gmail.com>
 <d0b09992-eb87-651a-3b97-0787e07cc46d@amd.com> <CALMp9eRZQXgJvt3MGreq47ApM5ObTU7YFQV_GcY5N+jozGK1Uw@mail.gmail.com>
 <d0c38022-2d82-aacc-4829-02c557edddc0@amd.com>
In-Reply-To: <d0c38022-2d82-aacc-4829-02c557edddc0@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 12 Jun 2020 17:04:18 -0700
Message-ID: <CALMp9eSn36W=YK5XtaVATJis-J--udGK4ZOESDhYyT0zJ4YZ9A@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM:SVM: Enable INVPCID feature on AMD
To:     Babu Moger <babu.moger@amd.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 2:47 PM Babu Moger <babu.moger@amd.com> wrote:
>
>
>
> On 6/12/20 3:10 PM, Jim Mattson wrote:
> > On Fri, Jun 12, 2020 at 12:35 PM Babu Moger <babu.moger@amd.com> wrote:
> >>
> >>
> >>
> >>> -----Original Message-----
> >>> From: Jim Mattson <jmattson@google.com>
> >>> Sent: Thursday, June 11, 2020 6:51 PM
> >>> To: Moger, Babu <Babu.Moger@amd.com>
> >>> Cc: Wanpeng Li <wanpengli@tencent.com>; Joerg Roedel <joro@8bytes.org=
>;
> >>> the arch/x86 maintainers <x86@kernel.org>; Sean Christopherson
> >>> <sean.j.christopherson@intel.com>; Ingo Molnar <mingo@redhat.com>;
> >>> Borislav Petkov <bp@alien8.de>; H . Peter Anvin <hpa@zytor.com>; Paol=
o
> >>> Bonzini <pbonzini@redhat.com>; Vitaly Kuznetsov <vkuznets@redhat.com>=
;
> >>> Thomas Gleixner <tglx@linutronix.de>; LKML <linux-kernel@vger.kernel.=
org>;
> >>> kvm list <kvm@vger.kernel.org>
> >>> Subject: Re: [PATCH 3/3] KVM:SVM: Enable INVPCID feature on AMD
> >>>
> >>> On Thu, Jun 11, 2020 at 2:48 PM Babu Moger <babu.moger@amd.com> wrote=
:
> >>>>
> >>>> The following intercept is added for INVPCID instruction:
> >>>> Code    Name            Cause
> >>>> A2h     VMEXIT_INVPCID  INVPCID instruction
> >>>>
> >>>> The following bit is added to the VMCB layout control area
> >>>> to control intercept of INVPCID:
> >>>> Byte Offset     Bit(s)    Function
> >>>> 14h             2         intercept INVPCID
> >>>>
> >>>> For the guests with nested page table (NPT) support, the INVPCID
> >>>> feature works as running it natively. KVM does not need to do any
> >>>> special handling in this case.
> >>>>
> >>>> Interceptions are required in the following cases.
> >>>> 1. If the guest tries to disable the feature when the underlying
> >>>> hardware supports it. In this case hypervisor needs to report #UD.
> >>>
> >>> Per the AMD documentation, attempts to use INVPCID at CPL>0 will
> >>> result in a #GP, regardless of the intercept bit. If the guest CPUID
> >>> doesn't enumerate the feature, shouldn't the instruction raise #UD
> >>> regardless of CPL? This seems to imply that we should intercept #GP
> >>> and decode the instruction to see if we should synthesize #UD instead=
.
> >>
> >> Purpose here is to report UD when the guest CPUID doesn't enumerate th=
e
> >> INVPCID feature When Bare-metal supports it. It seems to work fine for
> >> that purpose. You are right. The #GP for CPL>0 takes precedence over
> >> interception. No. I am not planning to intercept GP.
> >
> > WIthout intercepting #GP, you fail to achieve your stated purpose.
>
> I think I have misunderstood this part. I was not inteding to change the
> #GP behaviour. I will remove this part. My intension of these series is t=
o
> handle invpcid in shadow page mode. I have verified that part. Hope I did
> not miss anything else.

You don't really have to intercept INVPCID when tdp is in use, right?
There are certainly plenty of operations for which kvm does not
properly raise #UD when they aren't enumerated in the guest CPUID.

> >> I will change the text. How about this?
> >>
> >> Interceptions are required in the following cases.
> >> 1. If the guest CPUID doesn't enumerate the INVPCID feature when the
> >> underlying hardware supports it,  hypervisor needs to report UD. Howev=
er,
> >> #GP for CPL>0 takes precedence over interception.
> >
> > This text is not internally consistent. In one sentence, you say that
> > "hypervisor needs to report #UD." In the next sentence, you are
> > essentially saying that the hypervisor doesn't need to report #UD.
> > Which is it?
> >
> >>>> 2. When the guest is running with shadow page table enabled, in
> >>>> this case the hypervisor needs to handle the tlbflush based on the
> >>>> type of invpcid instruction type.
> >>>>
> >>>> AMD documentation for INVPCID feature is available at "AMD64
> >>>> Architecture Programmer=E2=80=99s Manual Volume 2: System Programmin=
g,
> >>>> Pub. 24593 Rev. 3.34(or later)"
> >>>>
> >>>> The documentation can be obtained at the links below:
> >>>> Link:
> >>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw=
ww.a
> >>> md.com%2Fsystem%2Ffiles%2FTechDocs%2F24593.pdf&amp;data=3D02%7C01%7
> >>> Cbabu.moger%40amd.com%7C36861b25f6d143e3b38e08d80e624472%7C3dd8
> >>> 961fe4884e608e11a82d994e183d%7C0%7C0%7C637275163374103811&amp;s
> >>> data=3DE%2Fdb6T%2BdO4nrtUoqhKidF6XyorsWrphj6O4WwNZpmYA%3D&amp;res
> >>> erved=3D0
> >>>> Link:
> >>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fb=
ugzilla.
> >>> kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=3D02%7C01%7Cbabu.m
> >>> oger%40amd.com%7C36861b25f6d143e3b38e08d80e624472%7C3dd8961fe488
> >>> 4e608e11a82d994e183d%7C0%7C0%7C637275163374103811&amp;sdata=3Db81
> >>> 9W%2FhKS93%2BAp3QvcsR0BwTQpUVUFMbIaNaisgWHRY%3D&amp;reserved=3D
> >>> 0
> >>>>
> >>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >>>> ---
> >>>>  arch/x86/include/asm/svm.h      |    4 ++++
> >>>>  arch/x86/include/uapi/asm/svm.h |    2 ++
> >>>>  arch/x86/kvm/svm/svm.c          |   42
> >>> +++++++++++++++++++++++++++++++++++++++
> >>>>  3 files changed, 48 insertions(+)
> >>>>
> >>>> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> >>>> index 62649fba8908..6488094f67fa 100644
> >>>> --- a/arch/x86/include/asm/svm.h
> >>>> +++ b/arch/x86/include/asm/svm.h
> >>>> @@ -55,6 +55,10 @@ enum {
> >>>>         INTERCEPT_RDPRU,
> >>>>  };
> >>>>
> >>>> +/* Extended Intercept bits */
> >>>> +enum {
> >>>> +       INTERCEPT_INVPCID =3D 2,
> >>>> +};
> >>>>
> >>>>  struct __attribute__ ((__packed__)) vmcb_control_area {
> >>>>         u32 intercept_cr;
> >>>> diff --git a/arch/x86/include/uapi/asm/svm.h
> >>> b/arch/x86/include/uapi/asm/svm.h
> >>>> index 2e8a30f06c74..522d42dfc28c 100644
> >>>> --- a/arch/x86/include/uapi/asm/svm.h
> >>>> +++ b/arch/x86/include/uapi/asm/svm.h
> >>>> @@ -76,6 +76,7 @@
> >>>>  #define SVM_EXIT_MWAIT_COND    0x08c
> >>>>  #define SVM_EXIT_XSETBV        0x08d
> >>>>  #define SVM_EXIT_RDPRU         0x08e
> >>>> +#define SVM_EXIT_INVPCID       0x0a2
> >>>>  #define SVM_EXIT_NPF           0x400
> >>>>  #define SVM_EXIT_AVIC_INCOMPLETE_IPI           0x401
> >>>>  #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS     0x402
> >>>> @@ -171,6 +172,7 @@
> >>>>         { SVM_EXIT_MONITOR,     "monitor" }, \
> >>>>         { SVM_EXIT_MWAIT,       "mwait" }, \
> >>>>         { SVM_EXIT_XSETBV,      "xsetbv" }, \
> >>>> +       { SVM_EXIT_INVPCID,     "invpcid" }, \
> >>>>         { SVM_EXIT_NPF,         "npf" }, \
> >>>>         { SVM_EXIT_AVIC_INCOMPLETE_IPI,         "avic_incomplete_ipi=
" }, \
> >>>>         { SVM_EXIT_AVIC_UNACCELERATED_ACCESS,
> >>> "avic_unaccelerated_access" }, \
> >>>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> >>>> index 285e5e1ff518..82d974338f68 100644
> >>>> --- a/arch/x86/kvm/svm/svm.c
> >>>> +++ b/arch/x86/kvm/svm/svm.c
> >>>> @@ -813,6 +813,11 @@ static __init void svm_set_cpu_caps(void)
> >>>>         if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
> >>>>             boot_cpu_has(X86_FEATURE_AMD_SSBD))
> >>>>                 kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
> >>>> +
> >>>> +       /* Enable INVPCID if both PCID and INVPCID enabled */
> >>>> +       if (boot_cpu_has(X86_FEATURE_PCID) &&
> >>>> +           boot_cpu_has(X86_FEATURE_INVPCID))
> >>>> +               kvm_cpu_cap_set(X86_FEATURE_INVPCID);
> >>>>  }
> >>>>
> >>>>  static __init int svm_hardware_setup(void)
> >>>> @@ -1099,6 +1104,17 @@ static void init_vmcb(struct vcpu_svm *svm)
> >>>>                 clr_intercept(svm, INTERCEPT_PAUSE);
> >>>>         }
> >>>>
> >>>> +       /*
> >>>> +        * Intercept INVPCID instruction only if shadow page table i=
s
> >>>> +        * enabled. Interception is not required with nested page ta=
ble.
> >>>> +        */
> >>>> +       if (boot_cpu_has(X86_FEATURE_INVPCID)) {
> >>>> +               if (!npt_enabled)
> >>>> +                       set_extended_intercept(svm, INTERCEPT_INVPCI=
D);
> >>>> +               else
> >>>> +                       clr_extended_intercept(svm, INTERCEPT_INVPCI=
D);
> >>>> +       }
> >>>> +
> >>>>         if (kvm_vcpu_apicv_active(&svm->vcpu))
> >>>>                 avic_init_vmcb(svm);
> >>>>
> >>>> @@ -2715,6 +2731,23 @@ static int mwait_interception(struct vcpu_svm
> >>> *svm)
> >>>>         return nop_interception(svm);
> >>>>  }
> >>>>
> >>>> +static int invpcid_interception(struct vcpu_svm *svm)
> >>>> +{
> >>>> +       struct kvm_vcpu *vcpu =3D &svm->vcpu;
> >>>> +       unsigned long type;
> >>>> +       gva_t gva;
> >>>> +
> >>>> +       /*
> >>>> +        * For an INVPCID intercept:
> >>>> +        * EXITINFO1 provides the linear address of the memory opera=
nd.
> >>>> +        * EXITINFO2 provides the contents of the register operand.
> >>>> +        */
> >>>> +       type =3D svm->vmcb->control.exit_info_2;
> >>>> +       gva =3D svm->vmcb->control.exit_info_1;
> >>>> +
> >>>> +       return kvm_handle_invpcid_types(vcpu,  gva, type);
> >>>> +}
> >>>> +
> >>>>  static int (*const svm_exit_handlers[])(struct vcpu_svm *svm) =3D {
> >>>>         [SVM_EXIT_READ_CR0]                     =3D cr_interception,
> >>>>         [SVM_EXIT_READ_CR3]                     =3D cr_interception,
> >>>> @@ -2777,6 +2810,7 @@ static int (*const svm_exit_handlers[])(struct
> >>> vcpu_svm *svm) =3D {
> >>>>         [SVM_EXIT_MWAIT]                        =3D mwait_intercepti=
on,
> >>>>         [SVM_EXIT_XSETBV]                       =3D xsetbv_intercept=
ion,
> >>>>         [SVM_EXIT_RDPRU]                        =3D rdpru_intercepti=
on,
> >>>> +       [SVM_EXIT_INVPCID]                      =3D invpcid_intercep=
tion,
> >>>>         [SVM_EXIT_NPF]                          =3D npf_interception=
,
> >>>>         [SVM_EXIT_RSM]                          =3D rsm_interception=
,
> >>>>         [SVM_EXIT_AVIC_INCOMPLETE_IPI]          =3D
> >>> avic_incomplete_ipi_interception,
> >>>> @@ -3562,6 +3596,14 @@ static void svm_cpuid_update(struct kvm_vcpu
> >>> *vcpu)
> >>>>         svm->nrips_enabled =3D kvm_cpu_cap_has(X86_FEATURE_NRIPS) &&
> >>>>                              guest_cpuid_has(&svm->vcpu, X86_FEATURE=
_NRIPS);
> >>>>
> >>>> +       /*
> >>>> +        * Intercept INVPCID instruction if the baremetal has the su=
pport
> >>>> +        * but the guest doesn't claim the feature.
> >>>> +        */
> >>>> +       if (boot_cpu_has(X86_FEATURE_INVPCID) &&
> >>>> +           !guest_cpuid_has(vcpu, X86_FEATURE_INVPCID))
> >>>> +               set_extended_intercept(svm, INTERCEPT_INVPCID);
> >>>> +
> >>>
> >>> What if INVPCID is enabled in the guest CPUID later? Shouldn't we the=
n
> >>> clear this intercept bit?
> >>
> >> I assume the feature enable comes in the same code path as this. I can=
 add
> >> "if else" check here if that is what you are suggesting.
> >
> > Yes, that's what I'm suggesting.
> >
> >>>
> >>>>         if (!kvm_vcpu_apicv_active(vcpu))
> >>>>                 return;
> >>>>
> >>>>
