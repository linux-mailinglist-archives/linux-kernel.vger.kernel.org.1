Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8553229F246
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgJ2Qxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJ2QwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:52:23 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68ADC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:52:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h6so2835570pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z84dO34gfl99F5MNenPSh6+wKNbdWfjMSfVr1uk1Zcc=;
        b=lTkAVN1IJ0u+pKWfduvkdW4V2aI5akhT9u6AeN52IIzGGwtJh0+qHIgTscGwLm/QSM
         UUUsMsT8tOotnB/FGnuzuZWvX7QpIOaRgxfkzAjXzj8bljMMTOOqlzPlRWo/O3NY+928
         XIGteiQTEq5MG1HGKEm4+4wcKZVG4+TxMGTffq6neliPrMSYMZayc/8paKY0Z8WAOoQN
         RqBb2Lm7229hq4e2GW1KoaIDKH4jFoCc4AOnj7SCPHIMLX2vA+zIGHKKgey0BC0YhXvO
         MbyV1ljpZ4AfEFVGUcT+Na+OtRrBfgJHspO/hnD0fCz12zKUdAQjzSwpnNYWC3Mp/ORG
         rMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z84dO34gfl99F5MNenPSh6+wKNbdWfjMSfVr1uk1Zcc=;
        b=tpj03Nf88/yxR4i9J5WYaTOYUNIblPda0uPF0IZlZhxDIVgaxC8Knp5B9GYtUoA+tk
         N3GwoOcUdEe+Ba4F20JOqqNhE+rDaYkUYaVi/0IM1QbS2hcNNpJOPkM2d2mAN6CUbCpF
         IbwcTKa62dRDjE1zx8qFep+uBvJ2WqX0P7hQ7aibAMSC+k15mjLv3JY2/7SuSVNFI8/A
         jdDNma28s+aZQLe07Dm+fNe1ZS+ASAz/Tg717x+gNXGs64ZNSHrmXS5st7eGFZ/PxUHG
         pe8HOyt/WEE13DgY+k0D7ka5hINCITnz0NLx7M61OaOvdIomZ4TQ2OXSaNO3cI5q+X7W
         k6EQ==
X-Gm-Message-State: AOAM532gkBDSuSNDa2AiTIJyULrOjNQuD6s2CrhWvD9ZJIsRj2s+dGNa
        EGuseVoAekwZBunhs/0XlCRK/mzdv1q/dfdkSExrJw==
X-Google-Smtp-Source: ABdhPJwba1blBblmNLamfOiQpwVut/Dz4vzsBzNZQgnle8M6CLRQ+9XZf9k3CsbpwRv6iclnVLaOocruH7JqXaKt1p8=
X-Received: by 2002:a17:90a:f293:: with SMTP id fs19mr664418pjb.41.1603990342099;
 Thu, 29 Oct 2020 09:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com> <33c0811d707356b7b267b2de41b55b2728940723.1602535397.git.andreyknvl@google.com>
 <CACT4Y+ZyaqdYic_K6Mj9RcvO+23OQ0q2Pe-c3YS1zMW4j1woQw@mail.gmail.com>
In-Reply-To: <CACT4Y+ZyaqdYic_K6Mj9RcvO+23OQ0q2Pe-c3YS1zMW4j1woQw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 29 Oct 2020 17:52:11 +0100
Message-ID: <CAAeHK+yARu1Qh46DPbfs4h37yHPAVgx6r8r=86L6jfHD3up8-g@mail.gmail.com>
Subject: Re: [PATCH v5 08/40] arm64: mte: Switch GCR_EL1 in kernel entry and exit
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 11:07 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Oct 12, 2020 at 10:45 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >
> > When MTE is present, the GCR_EL1 register contains the tags mask that
> > allows to exclude tags from the random generation via the IRG instruction.
> >
> > With the introduction of the new Tag-Based KASAN API that provides a
> > mechanism to reserve tags for special reasons, the MTE implementation
> > has to make sure that the GCR_EL1 setting for the kernel does not affect
> > the userspace processes and viceversa.
> >
> > Save and restore the kernel/user mask in GCR_EL1 in kernel entry and exit.
> >
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> > Change-Id: I0081cba5ace27a9111bebb239075c9a466af4c84
> > ---
> >  arch/arm64/include/asm/mte-def.h   |  1 -
> >  arch/arm64/include/asm/mte-kasan.h |  6 +++++
> >  arch/arm64/include/asm/mte.h       |  2 ++
> >  arch/arm64/kernel/asm-offsets.c    |  3 +++
> >  arch/arm64/kernel/cpufeature.c     |  3 +++
> >  arch/arm64/kernel/entry.S          | 41 ++++++++++++++++++++++++++++++
> >  arch/arm64/kernel/mte.c            | 22 +++++++++++++---
> >  7 files changed, 74 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/mte-def.h b/arch/arm64/include/asm/mte-def.h
> > index 8401ac5840c7..2d73a1612f09 100644
> > --- a/arch/arm64/include/asm/mte-def.h
> > +++ b/arch/arm64/include/asm/mte-def.h
> > @@ -10,6 +10,5 @@
> >  #define MTE_TAG_SHIFT          56
> >  #define MTE_TAG_SIZE           4
> >  #define MTE_TAG_MASK           GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
> > -#define MTE_TAG_MAX            (MTE_TAG_MASK >> MTE_TAG_SHIFT)
> >
> >  #endif /* __ASM_MTE_DEF_H  */
> > diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> > index 3a70fb1807fd..a4c61b926d4a 100644
> > --- a/arch/arm64/include/asm/mte-kasan.h
> > +++ b/arch/arm64/include/asm/mte-kasan.h
> > @@ -29,6 +29,8 @@ u8 mte_get_mem_tag(void *addr);
> >  u8 mte_get_random_tag(void);
> >  void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
> >
> > +void mte_init_tags(u64 max_tag);
>
> This should be marked as __init?

Makes sense. I'll add this change into the other series together with
the patch that marks kasan_init_tags() as __init.

>
>
> >  #else /* CONFIG_ARM64_MTE */
> >
> >  static inline u8 mte_get_ptr_tag(void *ptr)
> > @@ -49,6 +51,10 @@ static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> >         return addr;
> >  }
> >
> > +static inline void mte_init_tags(u64 max_tag)
> > +{
> > +}
> > +
> >  #endif /* CONFIG_ARM64_MTE */
> >
> >  #endif /* __ASSEMBLY__ */
> > diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> > index cf1cd181dcb2..d02aff9f493d 100644
> > --- a/arch/arm64/include/asm/mte.h
> > +++ b/arch/arm64/include/asm/mte.h
> > @@ -18,6 +18,8 @@
> >
> >  #include <asm/pgtable-types.h>
> >
> > +extern u64 gcr_kernel_excl;
> > +
> >  void mte_clear_page_tags(void *addr);
> >  unsigned long mte_copy_tags_from_user(void *to, const void __user *from,
> >                                       unsigned long n);
> > diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> > index 7d32fc959b1a..dfe6ed8446ac 100644
> > --- a/arch/arm64/kernel/asm-offsets.c
> > +++ b/arch/arm64/kernel/asm-offsets.c
> > @@ -47,6 +47,9 @@ int main(void)
> >  #ifdef CONFIG_ARM64_PTR_AUTH
> >    DEFINE(THREAD_KEYS_USER,     offsetof(struct task_struct, thread.keys_user));
> >    DEFINE(THREAD_KEYS_KERNEL,   offsetof(struct task_struct, thread.keys_kernel));
> > +#endif
> > +#ifdef CONFIG_ARM64_MTE
> > +  DEFINE(THREAD_GCR_EL1_USER,  offsetof(struct task_struct, thread.gcr_user_excl));
> >  #endif
> >    BLANK();
> >    DEFINE(S_X0,                 offsetof(struct pt_regs, regs[0]));
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index eca06b8c74db..e76634ad5bc7 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1721,6 +1721,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
> >
> >         /* Enable in-kernel MTE only if KASAN_HW_TAGS is enabled */
> >         if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {
> > +               /* Enable the kernel exclude mask for random tags generation */
> > +               write_sysreg_s(SYS_GCR_EL1_RRND | gcr_kernel_excl, SYS_GCR_EL1);
> > +
> >                 /* Enable MTE Sync Mode for EL1 */
> >                 sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> >                 isb();
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index ff34461524d4..eeaac91021bf 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -175,6 +175,43 @@ alternative_else_nop_endif
> >  #endif
> >         .endm
> >
> > +       .macro mte_set_gcr, tmp, tmp2
> > +#ifdef CONFIG_ARM64_MTE
> > +       /*
> > +        * Calculate and set the exclude mask preserving
> > +        * the RRND (bit[16]) setting.
> > +        */
> > +       mrs_s   \tmp2, SYS_GCR_EL1
> > +       bfi     \tmp2, \tmp, #0, #16
> > +       msr_s   SYS_GCR_EL1, \tmp2
> > +       isb
> > +#endif
> > +       .endm
> > +
> > +       .macro mte_set_kernel_gcr, tmp, tmp2
> > +#ifdef CONFIG_KASAN_HW_TAGS
> > +alternative_if_not ARM64_MTE
> > +       b       1f
> > +alternative_else_nop_endif
> > +       ldr_l   \tmp, gcr_kernel_excl
> > +
> > +       mte_set_gcr \tmp, \tmp2
> > +1:
> > +#endif
> > +       .endm
> > +
> > +       .macro mte_set_user_gcr, tsk, tmp, tmp2
> > +#ifdef CONFIG_ARM64_MTE
> > +alternative_if_not ARM64_MTE
> > +       b       1f
> > +alternative_else_nop_endif
> > +       ldr     \tmp, [\tsk, #THREAD_GCR_EL1_USER]
> > +
> > +       mte_set_gcr \tmp, \tmp2
> > +1:
> > +#endif
> > +       .endm
> > +
> >         .macro  kernel_entry, el, regsize = 64
> >         .if     \regsize == 32
> >         mov     w0, w0                          // zero upper 32 bits of x0
> > @@ -214,6 +251,8 @@ alternative_else_nop_endif
> >
> >         ptrauth_keys_install_kernel tsk, x20, x22, x23
> >
> > +       mte_set_kernel_gcr x22, x23
> > +
> >         scs_load tsk, x20
> >         .else
> >         add     x21, sp, #S_FRAME_SIZE
> > @@ -332,6 +371,8 @@ alternative_else_nop_endif
> >         /* No kernel C function calls after this as user keys are set. */
> >         ptrauth_keys_install_user tsk, x0, x1, x2
> >
> > +       mte_set_user_gcr tsk, x0, x1
> > +
> >         apply_ssbd 0, x0, x1
> >         .endif
> >
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index a9f03be75cef..ca8206b7f9a6 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -23,6 +23,8 @@
> >  #include <asm/ptrace.h>
> >  #include <asm/sysreg.h>
> >
> > +u64 gcr_kernel_excl __ro_after_init;
> > +
> >  static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
> >  {
> >         pte_t old_pte = READ_ONCE(*ptep);
> > @@ -121,6 +123,17 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> >         return ptr;
> >  }
> >
> > +void mte_init_tags(u64 max_tag)
> > +{
> > +       /*
> > +        * The format of the tags in KASAN is 0xFF and in MTE is 0xF.
> > +        * This conversion is required to extract the MTE tag from a KASAN one.
> > +        */
> > +       u64 incl = GENMASK(FIELD_GET(MTE_TAG_MASK >> MTE_TAG_SHIFT, max_tag), 0);
> > +
> > +       gcr_kernel_excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
> > +}
> > +
> >  static void update_sctlr_el1_tcf0(u64 tcf0)
> >  {
> >         /* ISB required for the kernel uaccess routines */
> > @@ -156,7 +169,11 @@ static void update_gcr_el1_excl(u64 excl)
> >  static void set_gcr_el1_excl(u64 excl)
> >  {
> >         current->thread.gcr_user_excl = excl;
> > -       update_gcr_el1_excl(excl);
> > +
> > +       /*
> > +        * SYS_GCR_EL1 will be set to current->thread.gcr_user_excl value
> > +        * by mte_set_user_gcr() in kernel_exit,
> > +        */
> >  }
> >
> >  void flush_mte_state(void)
> > @@ -182,7 +199,6 @@ void mte_thread_switch(struct task_struct *next)
> >         /* avoid expensive SCTLR_EL1 accesses if no change */
> >         if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
> >                 update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
> > -       update_gcr_el1_excl(next->thread.gcr_user_excl);
> >  }
> >
> >  void mte_suspend_exit(void)
> > @@ -190,7 +206,7 @@ void mte_suspend_exit(void)
> >         if (!system_supports_mte())
> >                 return;
> >
> > -       update_gcr_el1_excl(current->thread.gcr_user_excl);
> > +       update_gcr_el1_excl(gcr_kernel_excl);
> >  }
> >
> >  long set_mte_ctrl(struct task_struct *task, unsigned long arg)
> > --
> > 2.28.0.1011.ga647a8990f-goog
> >
