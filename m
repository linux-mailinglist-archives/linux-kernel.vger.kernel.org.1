Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9F6205B01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 20:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbgFWSoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 14:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733165AbgFWSoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:44:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E9CC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:44:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k6so9476882pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tVAIyD3Q99J/GMICmIeAkqQ2ozy/kJogio/DjqwTxd4=;
        b=EEtuDPY1GbikBTAidPmbruDGK25MoKvifRm2YmKNSvVSMvFkFGfcPTszizFx2ZO3Uc
         VNDcm8tXj7W4BZ67+zXiWFMUJeQMWwX7CJ+SmVkQwAhpSmSqz6RooI3VNHZvSI22AX4q
         GhueAACCOt8kapWjNle+aPk73Tv67szjODnpgYlgly1k0XkWlFEdJ9aQe3UQcXyAYIQh
         7VkjMTQXs7Cq3aiwm6zuFGGWz71MaoIv056BfM1iILj/PYWhcssB1XpQB4SaQ0PCgmKd
         pZUCqmFogFjudphRkRaHEekSJo8uPDk6HpzBuBQexLeH10hIbWEbGvUBi0Fd7ag2gRP3
         CX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tVAIyD3Q99J/GMICmIeAkqQ2ozy/kJogio/DjqwTxd4=;
        b=kHnnQzCCLg68QDuPvLcC8QUt5FSvwWSCE8IcGtau2sGwGZs0I8XvzUNtKT6e8Ie/X/
         vFNjdEJP1v2uG2Ag2GYsJkW/NrMviqcLMkqvJLaLP9Bva/Bmd+Ar7GY+fCoP/Fv+1QBh
         4M86CXX+6A0Tt2lTDSRe0JwG825JP1Fi5O9FmJSxumpW0K+qi0rZsDocWrJoJ/lhKipo
         uIpti7OQi2JlYDvoMfKWP9IyB0daJTvT3yDaifa0YqNIH5tF8P0uuCT2uFiz5R4J/5T6
         3D/Zj7g9OiB7Ol2qexsQ0w7Fu+BaRcPGlz1W/qhRQIHm5xPlecJs8n2uugc7l1MvV+Vv
         PxTg==
X-Gm-Message-State: AOAM530L0Y7x02HprALrd9ya/LcvDk0rGhUg2gNtURcTvsccKzbshLJn
        F5nmk9zjqQ5exzJPVHQnyv67Pja9bOHmKv+2u32QaQ==
X-Google-Smtp-Source: ABdhPJxkTZ8OklVq6XLVRvsgjCCRCx7YdX1c5S+WBmUv2yWaRyLG3XJ1oou4wB7ZHPrctcGYyTcpwJZg9kPeBehN0TY=
X-Received: by 2002:a17:90b:949:: with SMTP id dw9mr25483894pjb.101.1592937848930;
 Tue, 23 Jun 2020 11:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200623025628.18467-1-sedat.dilek@gmail.com>
In-Reply-To: <20200623025628.18467-1-sedat.dilek@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Jun 2020 11:43:58 -0700
Message-ID: <CAKwvOdmR10E2uzKnq2Jt0DSw9+3uvjSfqidxppCoYmhNZPLx5Q@mail.gmail.com>
Subject: Re: [PATCH 5.7 v2] x86/crypto: aesni: Fix build with LLVM_IAS=1
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Craig Topper <craig.topper@intel.com>,
        Craig Topper <craig.topper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 7:56 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> When building with LLVM_IAS=1 means using Clang's Integrated Assembly (IAS)
> from LLVM/Clang >= v10.0.1-rc1+ instead of GNU/as from GNU/binutils
> I see the following breakage in Debian/testing AMD64:
>
> <instantiation>:15:74: error: too many positional arguments
>  PRECOMPUTE 8*3+8(%rsp), %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
>                                                                          ^
>  arch/x86/crypto/aesni-intel_asm.S:1598:2: note: while in macro instantiation
>  GCM_INIT %r9, 8*3 +8(%rsp), 8*3 +16(%rsp), 8*3 +24(%rsp)
>  ^
> <instantiation>:47:2: error: unknown use of instruction mnemonic without a size suffix
>  GHASH_4_ENCRYPT_4_PARALLEL_dec %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, enc
>  ^
> arch/x86/crypto/aesni-intel_asm.S:1599:2: note: while in macro instantiation
>  GCM_ENC_DEC dec
>  ^
> <instantiation>:15:74: error: too many positional arguments
>  PRECOMPUTE 8*3+8(%rsp), %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
>                                                                          ^
> arch/x86/crypto/aesni-intel_asm.S:1686:2: note: while in macro instantiation
>  GCM_INIT %r9, 8*3 +8(%rsp), 8*3 +16(%rsp), 8*3 +24(%rsp)
>  ^
> <instantiation>:47:2: error: unknown use of instruction mnemonic without a size suffix
>  GHASH_4_ENCRYPT_4_PARALLEL_enc %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, enc
>  ^
> arch/x86/crypto/aesni-intel_asm.S:1687:2: note: while in macro instantiation
>  GCM_ENC_DEC enc
>
> Craig Topper suggested me in ClangBuiltLinux issue #1050:
>
> > I think the "too many positional arguments" is because the parser isn't able
> > to handle the trailing commas.
> >
> > The "unknown use of instruction mnemonic" is because the macro was named
> > GHASH_4_ENCRYPT_4_PARALLEL_DEC but its being instantiated with
> > GHASH_4_ENCRYPT_4_PARALLEL_dec I guess gas ignores case on the
> > macro instantiation, but llvm doesn't.
>
> First, I removed the trailing comma in the PRECOMPUTE line.
>
> Second, I substituted:
> 1. GHASH_4_ENCRYPT_4_PARALLEL_DEC -> GHASH_4_ENCRYPT_4_PARALLEL_dec
> 2. GHASH_4_ENCRYPT_4_PARALLEL_ENC -> GHASH_4_ENCRYPT_4_PARALLEL_enc
>
> With these changes I was able to build with LLVM_IAS=1 and boot on bare metal.
>
> I confirmed that this works with Linux-kernel v5.7.5 final.
>
> NOTE: This patch is on top of Linux v5.7 final.

Thanks for the note, still applies cleanly on top of linux-next today for me.

>
> Thanks to Craig and especially Nick for double-checking and his comments.
>
> Suggested-by: Craig Topper <craig.topper@intel.com>
> Suggested-by: Craig Topper <craig.topper@gmail.com>
> Suggested-by: Nick Desaulniers ndesaulniers@google.com

^ oh, may have missed <> around email addr.

> Cc: "ClangBuiltLinux" <clang-built-linux@googlegroups.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1050
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>

Following the same testing methodology from V1
(https://lore.kernel.org/patchwork/comment/1456822/) I verified for
GCC+GAS this is no functional change.

$ wget https://lore.kernel.org/patchwork/patch/1261340/mbox/ -O sedat_v3.patch
$ git am sedat_v3.patch
$ make -j71 arch/x86/crypto/aesni-intel_asm.o
$ llvm-objdump -dr arch/x86/crypto/aesni-intel_asm.o > postpatch_v3.txt
$ diff -u <(cat prepatch.txt | tr -s ' ' | cut -d '    ' -f 2-) <(cat
postpatch_v3.txt| tr -s ' ' | cut -d '   ' -f 2-) | less
(no output)

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/crypto/aesni-intel_asm.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
> index cad6e1bfa7d5..c216de287742 100644
> --- a/arch/x86/crypto/aesni-intel_asm.S
> +++ b/arch/x86/crypto/aesni-intel_asm.S
> @@ -266,7 +266,7 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
>         PSHUFB_XMM %xmm2, %xmm0
>         movdqu %xmm0, CurCount(%arg2) # ctx_data.current_counter = iv
>
> -       PRECOMPUTE \SUBKEY, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
> +       PRECOMPUTE \SUBKEY, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7
>         movdqu HashKey(%arg2), %xmm13
>
>         CALC_AAD_HASH %xmm13, \AAD, \AADLEN, %xmm0, %xmm1, %xmm2, %xmm3, \
> @@ -978,7 +978,7 @@ _initial_blocks_done\@:
>  * arg1, %arg3, %arg4 are used as pointers only, not modified
>  * %r11 is the data offset value
>  */
> -.macro GHASH_4_ENCRYPT_4_PARALLEL_ENC TMP1 TMP2 TMP3 TMP4 TMP5 \
> +.macro GHASH_4_ENCRYPT_4_PARALLEL_enc TMP1 TMP2 TMP3 TMP4 TMP5 \
>  TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
>
>         movdqa    \XMM1, \XMM5
> @@ -1186,7 +1186,7 @@ aes_loop_par_enc_done\@:
>  * arg1, %arg3, %arg4 are used as pointers only, not modified
>  * %r11 is the data offset value
>  */
> -.macro GHASH_4_ENCRYPT_4_PARALLEL_DEC TMP1 TMP2 TMP3 TMP4 TMP5 \
> +.macro GHASH_4_ENCRYPT_4_PARALLEL_dec TMP1 TMP2 TMP3 TMP4 TMP5 \
>  TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
>
>         movdqa    \XMM1, \XMM5
> --

-- 
Thanks,
~Nick Desaulniers
