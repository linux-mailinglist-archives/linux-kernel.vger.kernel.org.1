Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD6C21F879
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 19:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgGNRqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 13:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgGNRqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:46:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2867AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:46:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t6so4164684plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVAqQ1RrD/8AbvIkruHdsHuHjF9WaxXjKmuECQBQMDs=;
        b=rQRl75iUGDhFskIErM2L0Noay1KPR2rp4AlXszWBUkvVzdkMl4mSjOfCMyzKXF1fVp
         kBMkoR7UUJ82bUFSjkETHmu5RQLEmPl06vVxEv+MR9OfHpKVQI+/MSEJqahn5m+XXyCs
         MNX6455aC6pGi0AnCMcUzJdslORghD5r7PQZSnOmnqNPF89ugqETciSbKZC7PJQ/AdEy
         T8AsRDNheIWhPPz9mZte4Wtsymr3QRBcHg+6oI5xAmicXIVtEnKuR3KFbYo+W4xSCd8Q
         qkvRPudgYTzIvk3aNev9ZfxFC5f/+ey0KuGjtXJrf0Cg2uDwRY0XowTvRiim/S224BS/
         i4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVAqQ1RrD/8AbvIkruHdsHuHjF9WaxXjKmuECQBQMDs=;
        b=JnXgKszSIfJvTmg4RlrEwimmMUvUzvQ52QvV+9U5EZ5tAKbyUq6lt740/kJ2qUG4Qh
         YTNnt7kixPcAzCGvLqZ97X//ak7Zo/+IfRrCZwW8gLbAEmSk9ZMc1lV9e2ho2CDKZnb5
         q/UqWF8AAYNptEGbli1VuxPON1GsLVjPtr4i5JsVUOrSHoWCC/z4FiKeWAy1jtvLclg5
         E2zbUd2SZANe3wvazaD7+T9SI5hpP2XK/qe68vRKoLDjvO1jX+oYw/741PCfVhsFIIbC
         bNFEM/CFlacZ075/JXndc8oPXzGJ1mMnM+W1jxlQjj1zevGd+b/Edhx/184yiR70WIdB
         GCDQ==
X-Gm-Message-State: AOAM533afQQyqyzlvO8f7XxSBNiPy/s+vaDpFq2+7bFLs8QQUIX1ctlF
        dVMdVrDT6vTB3LpD+n4FS86JgSLrmBZwmxI5klD/YQ==
X-Google-Smtp-Source: ABdhPJys8XlKLqMxlDNDBEQtANTmDynliAQELgoKV6tKqh7iKneYzDtXHXBrbmKS20IGMwXLi1ymVvnbP193mwrqqhI=
X-Received: by 2002:a17:902:d311:: with SMTP id b17mr4752076plc.223.1594748796321;
 Tue, 14 Jul 2020 10:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200714111103.14591-1-sedat.dilek@gmail.com>
In-Reply-To: <20200714111103.14591-1-sedat.dilek@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Jul 2020 10:46:24 -0700
Message-ID: <CAKwvOdk3WSMhMxxaWfFeWYkR=xYgwrREckS+X5Yg5QeC48UVrg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Wei Liu <wei.liu@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jian Cai <caij2003@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 4:11 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> When using Clang's Integrated Assembler (LLVM_IAS=1) we fell over
> ClangBuiltLinux (CBL) issue #1043 where Jian Cai provided a patch.
>
> With Jian's patch applied another issue raised up when CONFIG_HYPERV=m.
>
> It turned out that the conversion of vectors to IDTENTRY_SYSVEC in
> case of CONFIG_HYPERV was incomplete and fails with a build error:
>
> <instantiation>:9:6: error: expected absolute expression
>  .if HYPERVISOR_REENLIGHTENMENT_VECTOR == 3
>      ^
> <instantiation>:1:1: note: while in macro instantiation
> idtentry HYPERVISOR_REENLIGHTENMENT_VECTOR asm_sysvec_hyperv_reenlightenment sysvec_hyperv_reenlightenment has_error_code=0
> ^
> ./arch/x86/include/asm/idtentry.h:627:1: note: while in macro instantiation
> idtentry_sysvec HYPERVISOR_REENLIGHTENMENT_VECTOR sysvec_hyperv_reenlightenment;
> ^
> <instantiation>:9:6: error: expected absolute expression
>  .if HYPERVISOR_STIMER0_VECTOR == 3
>      ^
> <instantiation>:1:1: note: while in macro instantiation
> idtentry HYPERVISOR_STIMER0_VECTOR asm_sysvec_hyperv_stimer0 sysvec_hyperv_stimer0 has_error_code=0
> ^
> ./arch/x86/include/asm/idtentry.h:628:1: note: while in macro instantiation
> idtentry_sysvec HYPERVISOR_STIMER0_VECTOR sysvec_hyperv_stimer0;
>
> I and Nathan double-checked the hyperv(isor) vectors:
>
> $ rg --no-heading "HYPERVISOR_REENLIGHTENMENT_VECTOR|HYPERVISOR_STIMER0_VECTOR"
> $ rg --no-heading "HYPERV_REENLIGHTENMENT_VECTOR|HYPERV_STIMER0_VECTOR"
>
> Fix these typos in arch/x86/include/asm/idtentry.h:
>
> HYPERVISOR_REENLIGHTENMENT_VECTOR -> HYPERV_REENLIGHTENMENT_VECTOR
> HYPERVISOR_STIMER0_VECTOR         -> HYPERV_STIMER0_VECTOR
>
> For more details see CBL issue #1088.
>
> With both fixes applied I was able to build/assemble with a snapshot
> version of LLVM/Clang from Debian/experimental.
>
> NOTE: My patch is independent from Jian's patch and should be applied separately.

Hi Sedat,
Thanks for the patch!  Nice job finding the fix.

I would like to see a v3 with the commit message trimmed a bit.  In
particular, you mention that Jian's patch is unrelated.  In that case,
please don't mention it in the commit message, drop the link to issue
#1043, and drop the lore link.  I think if the commit was just simply:

```
x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV

When assembling with Clang via `make LLVM_IAS=1`, we observe the
following error:
<instantiation>:9:6: error: expected absolute expression
<rest of the diagnostic>

This is caused by typos in arch/x86/include/asm/idtentry.h:

HYPERVISOR_REENLIGHTENMENT_VECTOR -> HYPERV_REENLIGHTENMENT_VECTOR
HYPERVISOR_STIMER0_VECTOR         -> HYPERV_STIMER0_VECTOR
```
Then the tags you have below minus the unrelated ones.

>
> Cc: Jian Cai <caij2003@gmail.com>
> Cc: clang-built-linux@googlegroups.com
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> Fixes: a16be368dd3f ("x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1043
> Link: https://lore.kernel.org/patchwork/patch/1272115/
> Link: https://github.com/ClangBuiltLinux/linux/issues/1088
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---

Otherwise you can put some additional info here "below the fold."  It
doesn't hurt to say "I also need Jian's patch to completely build with
LLVM_IAS=1" but I don't think that should be in the message that gets
committed per se.  Sorry to be a pedant about this.  With those
changes, I'd be happy to sign off on the patch.

> Changes v1->v2:
> - Add Wei Liu's Reviewed-by
> - Add note to clarify my patch is independent from Jian's patch
> - Add link to latest version of Jian's patch
>
>  arch/x86/include/asm/idtentry.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index eeac6dc2adaa..d79541bfc36f 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -626,8 +626,8 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,  sysvec_kvm_posted_intr_nested
>
>  #if IS_ENABLED(CONFIG_HYPERV)
>  DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,    sysvec_hyperv_callback);
> -DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_REENLIGHTENMENT_VECTOR,     sysvec_hyperv_reenlightenment);
> -DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIMER0_VECTOR,     sysvec_hyperv_stimer0);
> +DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR, sysvec_hyperv_reenlightenment);
> +DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR, sysvec_hyperv_stimer0);
>  #endif
>
>  #if IS_ENABLED(CONFIG_ACRN_GUEST)
> --

-- 
Thanks,
~Nick Desaulniers
