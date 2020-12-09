Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092FE2D4296
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbgLINCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731953AbgLINCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:02:36 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16056C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:01:50 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id e25so1593339wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JFqrvjW5ggq0+/xnT81gTlAuUmvGAZyqBQrhOvLhybw=;
        b=irNzgcIs/IhlG7j8FZF1Yv9WPdN0pMZxqPBTBeyPmK0rN9pW3V9W2o+UdnVxXcF7Wy
         SnL0VE737jZMGGQdewC8LyxdVVX9V8YXIwPAaaWPIQwNgIMsj7pBh8XJ9SMZhGhf6HJU
         Dzi1RuML9lEOUmJOvWuadpvkhytCcnmmCBD6vSgLJUT7X96tQ5iNOzqkD2qjzuu7TKdl
         zh/fSWDjkA0YbObX1sKXaOS2fScPAsow6oCpniA+yMs6Kb+Ivx2/Z50wB4g2qOkLfHGU
         2tqnUlKn6u8P/kzWqdDPDSnkAgl3ryy79X1lqslCwG5MwNU9ZaaQnm7+lxUQTUi7hGLr
         aXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JFqrvjW5ggq0+/xnT81gTlAuUmvGAZyqBQrhOvLhybw=;
        b=mCwTy5mnW1XbYXIX+nQ0axOIl29r+cJcVBRFFq34L82SwDq+iPa7KaI+rrX/ja1O9i
         +nRnFrZpOHXIaLVKgbR+FPitucd+Q+/QxmY0oiQmbpFBhW7zmAUoeT4kChTD1m3E6PPL
         26ad+YN6WKZZ+FHHguBNrmJdbS6gfEJFlooI5k8h3+lSsO0jZlJSXcw16SNyiGHdH6y4
         Q5hLVQGXm+i5rHni405oKRYc2iBFBBVySq/mnuYGsNibXJVgZPYL5IJqEEjjqiLN0mqX
         ugd+f3kjAPJRO6+nv7nnnAAszWlSf1OFKnpbOGGMesUc0WjzEeCfdghMsZ7vp9WuvqaT
         Lt9A==
X-Gm-Message-State: AOAM531PDIAjmtRyKTUNlSVLS9PQ1aD+T9Xe0ZGDj86azsAZ0fLbZadm
        VXYOBAt1FeIY0XFrRNwiTqPULg==
X-Google-Smtp-Source: ABdhPJzbr/oYf7go/KboT2H2FsrRWwB06zZx6/cY2dxrHx2MtzHR88WTcnuzuKEME4w0vvBdeL4NAA==
X-Received: by 2002:a1c:287:: with SMTP id 129mr2706564wmc.133.1607518908666;
        Wed, 09 Dec 2020 05:01:48 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:9d1b:d0eb:db43:6cd2])
        by smtp.gmail.com with ESMTPSA id b7sm3474204wrv.47.2020.12.09.05.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:01:46 -0800 (PST)
Date:   Wed, 9 Dec 2020 13:01:45 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [RFC PATCH 5/6] kvm: arm64: Fix constant-pool users in hyp
Message-ID: <20201209130145.lh27im2wqjpho5b6@google.com>
References: <20201119162543.78001-1-dbrazdil@google.com>
 <20201119162543.78001-6-dbrazdil@google.com>
 <CAMj1kXG_2MZu=JFqOPioGi-K3AtQHYvJyxkCR-HWBuagz=MoXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG_2MZu=JFqOPioGi-K3AtQHYvJyxkCR-HWBuagz=MoXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, relized I never replied to this...

On Tue, Nov 24, 2020 at 03:08:20PM +0100, Ard Biesheuvel wrote:
> On Thu, 19 Nov 2020 at 17:26, David Brazdil <dbrazdil@google.com> wrote:
> >
> > Hyp code used to use absolute addressing via a constant pool to obtain
> > the kernel VA of 3 symbols - panic, __hyp_panic_string and
> > __kvm_handle_stub_hvc. This used to work because the kernel would
> > relocate the addresses in the constant pool to kernel VA at boot and hyp
> > would simply load them from there.
> >
> > Now that relocations are fixed up to point to hyp VAs, this does not
> > work any longer. Rework the helpers to convert hyp VA to kernel VA / PA
> > as needed.
> >
> 
> Ok, so the reason for the problem is that the literal exists inside
> the HYP text, and all literals are fixed up using the HYP mapping,
> even if they don't point to something that is mapped at HYP. Would it
> make sense to simply disregard literals that point outside of the HYP
> VA mapping?

That would be possible - I'm about to post a v1 with build-time generation of
these relocs and kernel symbols are easily recognizable as they're undefined
in that ELF object. But I do worry that that would confuse people a lot.
And if somebody referenced a kernel symbol in C (maybe not a use case, but...)
they would get different results depending on which addressing mode the
compiler picked.

> 
> > Signed-off-by: David Brazdil <dbrazdil@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_mmu.h | 29 +++++++++++++++++++----------
> >  arch/arm64/kvm/hyp/nvhe/host.S   | 29 +++++++++++++++--------------
> >  2 files changed, 34 insertions(+), 24 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> > index 8cb8974ec9cc..0676ff2105bb 100644
> > --- a/arch/arm64/include/asm/kvm_mmu.h
> > +++ b/arch/arm64/include/asm/kvm_mmu.h
> > @@ -72,9 +72,14 @@ alternative_cb kvm_update_va_mask
> >  alternative_cb_end
> >  .endm
> >
> > +.macro hyp_pa reg, tmp
> > +       ldr_l   \tmp, hyp_physvirt_offset
> > +       add     \reg, \reg, \tmp
> > +.endm
> > +
> >  /*
> > - * Convert a kernel image address to a PA
> > - * reg: kernel address to be converted in place
> > + * Convert a hypervisor VA to a kernel image address
> > + * reg: hypervisor address to be converted in place
> >   * tmp: temporary register
> >   *
> >   * The actual code generation takes place in kvm_get_kimage_voffset, and
> > @@ -82,18 +87,22 @@ alternative_cb_end
> >   * perform the register allocation (kvm_get_kimage_voffset uses the
> >   * specific registers encoded in the instructions).
> >   */
> > -.macro kimg_pa reg, tmp
> > +.macro hyp_kimg reg, tmp
> > +       /* Convert hyp VA -> PA. */
> > +       hyp_pa  \reg, \tmp
> > +
> > +       /* Load kimage_voffset. */
> >  alternative_cb kvm_get_kimage_voffset
> > -       movz    \tmp, #0
> > -       movk    \tmp, #0, lsl #16
> > -       movk    \tmp, #0, lsl #32
> > -       movk    \tmp, #0, lsl #48
> > +       movz    \tmp, #0
> > +       movk    \tmp, #0, lsl #16
> > +       movk    \tmp, #0, lsl #32
> > +       movk    \tmp, #0, lsl #48
> >  alternative_cb_end
> >
> > -       /* reg = __pa(reg) */
> > -       sub     \reg, \reg, \tmp
> > +       /* Convert PA -> kimg VA. */
> > +       add     \reg, \reg, \tmp
> >  .endm
> > -
> > +
> >  #else
> >
> >  #include <linux/pgtable.h>
> > diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> > index 596dd5ae8e77..bcb80d525d8c 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/host.S
> > +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> > @@ -74,27 +74,28 @@ SYM_FUNC_END(__host_enter)
> >   * void __noreturn __hyp_do_panic(bool restore_host, u64 spsr, u64 elr, u64 par);
> >   */
> >  SYM_FUNC_START(__hyp_do_panic)
> > -       /* Load the format arguments into x1-7 */
> > -       mov     x6, x3
> > -       get_vcpu_ptr x7, x3
> > -
> > -       mrs     x3, esr_el2
> > -       mrs     x4, far_el2
> > -       mrs     x5, hpfar_el2
> > -
> >         /* Prepare and exit to the host's panic funciton. */
> >         mov     lr, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
> >                       PSR_MODE_EL1h)
> >         msr     spsr_el2, lr
> >         ldr     lr, =panic
> > +       hyp_kimg lr, x6
> >         msr     elr_el2, lr
> >
> > -       /*
> > -        * Set the panic format string and enter the host, conditionally
> > -        * restoring the host context.
> > -        */
> > +       /* Set the panic format string. Use the, now free, LR as scratch. */
> > +       ldr     lr, =__hyp_panic_string
> > +       hyp_kimg lr, x6
> > +
> > +       /* Load the format arguments into x1-7. */
> > +       mov     x6, x3
> > +       get_vcpu_ptr x7, x3
> > +       mrs     x3, esr_el2
> > +       mrs     x4, far_el2
> > +       mrs     x5, hpfar_el2
> > +
> > +       /* Enter the host, conditionally restoring the host context. */
> >         cmp     x0, xzr
> > -       ldr     x0, =__hyp_panic_string
> > +       mov     x0, lr
> >         b.eq    __host_enter_without_restoring
> >         b       __host_enter_for_panic
> >  SYM_FUNC_END(__hyp_do_panic)
> > @@ -124,7 +125,7 @@ SYM_FUNC_END(__hyp_do_panic)
> >          * Preserve x0-x4, which may contain stub parameters.
> >          */
> >         ldr     x5, =__kvm_handle_stub_hvc
> > -       kimg_pa x5, x6
> > +       hyp_pa  x5, x6
> >         br      x5
> >  .L__vect_end\@:
> >  .if ((.L__vect_end\@ - .L__vect_start\@) > 0x80)
> > --
> > 2.29.2.299.gdc1121823c-goog
> >
