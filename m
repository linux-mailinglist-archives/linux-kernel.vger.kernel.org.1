Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8C3280B62
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733247AbgJAXjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733002AbgJAXjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:39:19 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22CA520872
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 23:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601595558;
        bh=0NkZxOEHqQ/8Pfct8MU/KVq8PnpwI8tseENHdRfophk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uLA24LBnYX7CaVPIXB0dGV5PuPALeuQJvv8UyeSGRAxp10j4Z8vb2riA8eyKvkUH5
         ZLZrvgNp2Y9ouVqFHa2ZsCNyCv3slKxFDhRv2qqZ5Qw7c6F2i3a7FdtvLVIOaUurEe
         nEf3ygU5JQsCRwYAIlrJa+jfyPe5GIVlv+afQNjI=
Received: by mail-wr1-f50.google.com with SMTP id e16so572334wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:39:18 -0700 (PDT)
X-Gm-Message-State: AOAM531ur+kQSQLV606wXqJ/FrHCY4QU+MQN0lm1XnYHcmx/yQT+Ei/j
        hH7cmdQWIzozF9qm7c4x4ZNW226rKHX4Hr1D2nCjkw==
X-Google-Smtp-Source: ABdhPJyB/Z2FKa+/ilJUi48zTiAbZNNdzzX0GCqSXkDtKnR9YkbNkxY/H3j/rid5Fwl028pTNHkVKAZqscp7CmZr9VI=
X-Received: by 2002:a5d:5281:: with SMTP id c1mr11473215wrv.184.1601595556659;
 Thu, 01 Oct 2020 16:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201001203913.9125-1-chang.seok.bae@intel.com> <20201001203913.9125-14-chang.seok.bae@intel.com>
In-Reply-To: <20201001203913.9125-14-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 1 Oct 2020 16:39:05 -0700
X-Gmail-Original-Message-ID: <CALCETrWKMYcuyohpctb1SoDueU1-nwAtrirJbdJTp4tZwCMXZA@mail.gmail.com>
Message-ID: <CALCETrWKMYcuyohpctb1SoDueU1-nwAtrirJbdJTp4tZwCMXZA@mail.gmail.com>
Subject: Re: [RFC PATCH 13/22] x86/fpu/xstate: Expand dynamic user state area
 on first use
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, jing2.liu@intel.com,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 1:43 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> Intel's Extended Feature Disable (XFD) feature is an extension of the XSAVE
> architecture. XFD allows the kernel to enable a feature state in XCR0 and
> to receive a #NM trap when a task uses instructions accessing that state.
> In this way, Linux can allocate the large task->fpu buffer only for tasks
> that use it.
>
> XFD introduces two MSRs: IA32_XFD to enable/disable the feature and
> IA32_XFD_ERR to assist the #NM trap handler. Both use the same
> state-component bitmap format, used by XCR0.
>
> Use this hardware capability to find the right time to expand xstate area.
> Introduce two sets of helper functions for that:
>
> 1. The first set is primarily for interacting with the XFD hardware
>    feature. Helpers for configuring disablement, e.g. in context switching,
>    are:
>         xdisable_setbits()
>         xdisable_getbits()
>         xdisable_switch()
>
> 2. The second set is for managing the first-use status and handling #NM
>    trap:
>         xfirstuse_enabled()
>         xfirstuse_not_detected()
>         xfirstuse_event_handler()
>
> The #NM handler induces the xstate area expansion to save the first-used
> states.
>
> No functional change until the kernel enables dynamic user states and XFD.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/include/asm/cpufeatures.h  |  1 +
>  arch/x86/include/asm/fpu/internal.h | 53 ++++++++++++++++++++++++++++-
>  arch/x86/include/asm/msr-index.h    |  2 ++
>  arch/x86/kernel/fpu/core.c          | 37 ++++++++++++++++++++
>  arch/x86/kernel/fpu/xstate.c        | 34 ++++++++++++++++--
>  arch/x86/kernel/process.c           |  5 +++
>  arch/x86/kernel/process_32.c        |  2 +-
>  arch/x86/kernel/process_64.c        |  2 +-
>  arch/x86/kernel/traps.c             |  3 ++
>  9 files changed, 133 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 2901d5df4366..7d7fe1d82966 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -274,6 +274,7 @@
>  #define X86_FEATURE_XSAVEC             (10*32+ 1) /* XSAVEC instruction */
>  #define X86_FEATURE_XGETBV1            (10*32+ 2) /* XGETBV with ECX = 1 instruction */
>  #define X86_FEATURE_XSAVES             (10*32+ 3) /* XSAVES/XRSTORS instructions */
> +#define X86_FEATURE_XFD                        (10*32+ 4) /* eXtended Feature Disabling */
>
>  /*
>   * Extended auxiliary flags: Linux defined - for features scattered in various
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 3b03ead87a46..f5dbbaa060fb 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -572,11 +572,60 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
>   * Misc helper functions:
>   */
>
> +/* The first-use detection helpers: */
> +
> +static inline void xdisable_setbits(u64 value)
> +{
> +       wrmsrl_safe(MSR_IA32_XFD, value);
> +}
> +
> +static inline u64 xdisable_getbits(void)
> +{
> +       u64 value;
> +
> +       rdmsrl_safe(MSR_IA32_XFD, &value);
> +       return value;
> +}
> +
> +static inline u64 xfirstuse_enabled(void)
> +{
> +       /* All the dynamic user components are first-use enabled. */
> +       return xfeatures_mask_user_dynamic;
> +}
> +
> +/*
> + * Convert fpu->firstuse_bv to xdisable configuration in MSR IA32_XFD.
> + * xdisable_setbits() only uses this.
> + */
> +static inline u64 xfirstuse_not_detected(struct fpu *fpu)
> +{
> +       u64 firstuse_bv = (fpu->state_mask & xfirstuse_enabled());
> +
> +       /*
> +        * If first-use is not detected, set the bit. If the detection is
> +        * not enabled, the bit is always zero in firstuse_bv. So, make
> +        * following conversion:
> +        */
> +       return  (xfirstuse_enabled() ^ firstuse_bv);
> +}
> +
> +/* Update MSR IA32_XFD based on fpu->firstuse_bv */
> +static inline void xdisable_switch(struct fpu *prev, struct fpu *next)
> +{
> +       if (!static_cpu_has(X86_FEATURE_XFD) || !xfirstuse_enabled())
> +               return;
> +
> +       if (unlikely(prev->state_mask != next->state_mask))
> +               xdisable_setbits(xfirstuse_not_detected(next));
> +}
> +
> +bool xfirstuse_event_handler(struct fpu *fpu);
> +
>  /*
>   * Load PKRU from the FPU context if available. Delay loading of the
>   * complete FPU state until the return to userland.
>   */
> -static inline void switch_fpu_finish(struct fpu *new_fpu)
> +static inline void switch_fpu_finish(struct fpu *old_fpu, struct fpu *new_fpu)
>  {
>         u32 pkru_val = init_pkru_value;
>         struct pkru_state *pk;
> @@ -586,6 +635,8 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
>
>         set_thread_flag(TIF_NEED_FPU_LOAD);
>
> +       xdisable_switch(old_fpu, new_fpu);
> +
>         if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
>                 return;
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 2859ee4f39a8..0ccbe8cc99ad 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -610,6 +610,8 @@
>  #define MSR_IA32_BNDCFGS_RSVD          0x00000ffc
>
>  #define MSR_IA32_XSS                   0x00000da0
> +#define MSR_IA32_XFD                   0x000001c4
> +#define MSR_IA32_XFD_ERR               0x000001c5
>
>  #define MSR_IA32_APICBASE              0x0000001b
>  #define MSR_IA32_APICBASE_BSP          (1<<8)
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index ece6428ba85b..2e07bfcd54b3 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -518,3 +518,40 @@ int fpu__exception_code(struct fpu *fpu, int trap_nr)
>          */
>         return 0;
>  }
> +
> +bool xfirstuse_event_handler(struct fpu *fpu)
> +{
> +       bool handled = false;
> +       u64 event_mask;
> +
> +       /* Check whether the first-use detection is running. */
> +       if (!static_cpu_has(X86_FEATURE_XFD) || !xfirstuse_enabled())
> +               return handled;
> +
> +       rdmsrl_safe(MSR_IA32_XFD_ERR, &event_mask);

NAK.

MSR_IA32_XFD_ERR needs to be wired up in the exception handler, not in
some helper called farther down the stack

But this raises an interesting point -- what happens if allocation
fails?  I think that, from kernel code, we simply cannot support this
exception mechanism.  If kernel code wants to use AMX (and that would
be very strange indeed), it should call x86_i_am_crazy_amx_begin() and
handle errors, not rely on exceptions.  From user code, I assume we
send a signal if allocation fails.
