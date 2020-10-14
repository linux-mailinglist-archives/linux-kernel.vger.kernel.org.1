Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084FB28EAFF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 04:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgJOCOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 22:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgJOCOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 22:14:38 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15341C025250
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 16:45:10 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x62so1069891oix.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 16:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPEAUTaHFJBlJ3cHsQHzTIqn4FY8RMR2DPGgZPy4y8c=;
        b=Ue0dv8jwzT024oyZojc2HQM6bIHxdp4tf22FRTm7f61/b1y6sa3xfE759o8/fRI+nQ
         rMSZk45Sf28IJBCiJT8078zrjFrwHNCCqTQ2fd4fhb0w1HGBIsmWhlzJZyRDeQ0CEAPB
         nSJYext+uAqbPerDnRuVJt9AS0O/qljmyEe0WwvOGBZoGij4Z6tLe2cBf6UVfwFD0WQW
         6qR75YCzh9RamTDh6849k25Hj/JFwmJtnRtMb8WAD/808FDq1AJGT7rPYUOyM64SH6zL
         D6fJAG/rjpG2b68Xlnh3NqQGjL+W+4cIlaN767qxXtcg1ieYfk+A411erzq47XNmkRKA
         3XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPEAUTaHFJBlJ3cHsQHzTIqn4FY8RMR2DPGgZPy4y8c=;
        b=smrvUMLoTCSFQm1vevCY/ZddjTv/NemWLnb7cfssGZ9vxFMoE1DXHkTSvMdInlcBhL
         1TepDERhECl3apszHcKG/hh1nCp4naGJqqiUX8NpeUKu+kC8RQlytGy+217nDx/mFhRT
         cJZaGpxD3F4a1bjSfLvUfyA/viOAsxhprYwqWl+2Va4d+b8FmkI39+qZAF+oq/O2/UwA
         Kl+p1hm5vgKckPJYP4+i9CKuOLlHSyYimmLQc96h0OKF0RvSKP9SGle5Vcnvd9FEdWtF
         LleCvQRIshk7OO2rxNT8aLekz7gO3tIZ1a7+DW9UxwUe71PXGcVjzaBUpRq1bT1847W0
         ysGA==
X-Gm-Message-State: AOAM531cV92vwoT5KfgoKkLDVI50gXI7/kpvgEHIKdHKe5kUrZujAurV
        NQj2v31jmbYQ2IAuZrGltqGxlvZuWc4DN9M21SrOwA==
X-Google-Smtp-Source: ABdhPJy5Y67usdoKq8vmm5eMXo1vsetEcSrMnYAJKT5By38JawcWo0nTE6uIqrbMJvd3qgHc4jUBYZY/lWYwMmarCJ0=
X-Received: by 2002:aca:f202:: with SMTP id q2mr398037oih.6.1602719109161;
 Wed, 14 Oct 2020 16:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200710154811.418214-1-mgamal@redhat.com> <20200710154811.418214-8-mgamal@redhat.com>
 <CALMp9eSbY6FjZAXt7ojQrX_SC_Lyg24dTGFZdKZK7fARGA=3hg@mail.gmail.com>
In-Reply-To: <CALMp9eSbY6FjZAXt7ojQrX_SC_Lyg24dTGFZdKZK7fARGA=3hg@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 14 Oct 2020 16:44:57 -0700
Message-ID: <CALMp9eTFzQMpsrGhN4uJxyUHMKd5=yFwxLoBy==2BTHwmv_UGQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] KVM: VMX: Add guest physical address check in EPT
 violation and misconfig
To:     Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 9:17 AM Jim Mattson <jmattson@google.com> wrote:
>
> On Fri, Jul 10, 2020 at 8:48 AM Mohammed Gamal <mgamal@redhat.com> wrote:
> >
> > Check guest physical address against it's maximum physical memory. If
> > the guest's physical address exceeds the maximum (i.e. has reserved bits
> > set), inject a guest page fault with PFERR_RSVD_MASK set.
> >
> > This has to be done both in the EPT violation and page fault paths, as
> > there are complications in both cases with respect to the computation
> > of the correct error code.
> >
> > For EPT violations, unfortunately the only possibility is to emulate,
> > because the access type in the exit qualification might refer to an
> > access to a paging structure, rather than to the access performed by
> > the program.
> >
> > Trapping page faults instead is needed in order to correct the error code,
> > but the access type can be obtained from the original error code and
> > passed to gva_to_gpa.  The corrections required in the error code are
> > subtle. For example, imagine that a PTE for a supervisor page has a reserved
> > bit set.  On a supervisor-mode access, the EPT violation path would trigger.
> > However, on a user-mode access, the processor will not notice the reserved
> > bit and not include PFERR_RSVD_MASK in the error code.
> >
> > Co-developed-by: Mohammed Gamal <mgamal@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  arch/x86/kvm/vmx/vmx.c | 24 +++++++++++++++++++++---
> >  arch/x86/kvm/vmx/vmx.h |  3 ++-
> >  2 files changed, 23 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 770b090969fb..de3f436b2d32 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -4790,9 +4790,15 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
> >
> >         if (is_page_fault(intr_info)) {
> >                 cr2 = vmx_get_exit_qual(vcpu);
> > -               /* EPT won't cause page fault directly */
> > -               WARN_ON_ONCE(!vcpu->arch.apf.host_apf_flags && enable_ept);
> > -               return kvm_handle_page_fault(vcpu, error_code, cr2, NULL, 0);
> > +               if (enable_ept && !vcpu->arch.apf.host_apf_flags) {
> > +                       /*
> > +                        * EPT will cause page fault only if we need to
> > +                        * detect illegal GPAs.
> > +                        */
> > +                       kvm_fixup_and_inject_pf_error(vcpu, cr2, error_code);
> > +                       return 1;
> > +               } else
> > +                       return kvm_handle_page_fault(vcpu, error_code, cr2, NULL, 0);
> >         }
> >
> >         ex_no = intr_info & INTR_INFO_VECTOR_MASK;
> > @@ -5308,6 +5314,18 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
> >                PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
> >
> >         vcpu->arch.exit_qualification = exit_qualification;
> > +
> > +       /*
> > +        * Check that the GPA doesn't exceed physical memory limits, as that is
> > +        * a guest page fault.  We have to emulate the instruction here, because
> > +        * if the illegal address is that of a paging structure, then
> > +        * EPT_VIOLATION_ACC_WRITE bit is set.  Alternatively, if supported we
> > +        * would also use advanced VM-exit information for EPT violations to
> > +        * reconstruct the page fault error code.
> > +        */
> > +       if (unlikely(kvm_mmu_is_illegal_gpa(vcpu, gpa)))
> > +               return kvm_emulate_instruction(vcpu, 0);
> > +
>
> Is kvm's in-kernel emulator up to the task? What if the instruction in
> question is AVX-512, or one of the myriad instructions that the
> in-kernel emulator can't handle? Ice Lake must support the advanced
> VM-exit information for EPT violations, so that would seem like a
> better choice.
>
Anyone?
