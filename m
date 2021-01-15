Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF32F6FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbhAOAmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbhAOAmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:42:23 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC2FC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 16:41:40 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id p128so1795856vkf.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 16:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ss17mtZnH2/a4fJewDBpR3Mu5Wdw8UA3YC60wTDpAyE=;
        b=ksEpeZ2gTV1ULLs/pU1qdRktNsmLAcro7gbKwTHUeb6a/l5KCISLmLByJHwkxh/ykU
         WWNd6G/LPPJ2o6T3En1EkbQCIUyNa2zbGmvHxHJCg1j2EG0TO0hrSFEB5Flvyu42THVT
         PD72OOxasNgUsMmP17gSHN/dZwvIJ5eHCjMDeMZVxJkSrCU4M5RzFep1ys/BagsbJoNV
         BF0gcZT+Wx2bEWdWAd+MMZ9+6BOZsZHm31ZGpRkRZ7g4SkohUVka+mOOxeIj/s9YhPLa
         sVK/jwDlV4iOG7qn1EhPYeJeiKN4/r3AQgBGFWjsE12yKRAByzvp3neDTzf55S1e3Kn5
         951Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ss17mtZnH2/a4fJewDBpR3Mu5Wdw8UA3YC60wTDpAyE=;
        b=fLFyyeuCLH+w+1rwhpJx+fwqrRBnJf0ftZdgnwTR0Qh8Wd/wPTfkbkWhsCjRWneYhF
         1EmcHGLwAoL21/fJ2JyxlORPhVCsEXdpshGS/x92I2X0K37gH/qJHYbfjBnyEiQf7JZB
         yOzZ2zPoytx/fR9rQArUfbatx4jkuyB19aAFd3nxUBYYaX8mO+f1e4AO66Jrn1whbYz9
         fcPXjmqt9kazGBOgh9M2/NMgVNNFlkyUpiufI6Q37eDg0QQkMKzROULGG3JymRORixjq
         eZA3P6Q5soEg/Sjag+Yqe24cG4h7KSo09aZkLmAuw7Wz/R4W1I+yQE7ShSMQjOnfGECn
         GUYg==
X-Gm-Message-State: AOAM530cei/V3JclXCSTA+CmVMmgXbDu4SabIAHOgbpyp7+VEvBU7i4e
        UT7EGDoGg4m4eFfa7rlmGgQZJXIOATyGnHwGOPj7td+NyIFVtw==
X-Google-Smtp-Source: ABdhPJxsUFCFaeodqEAlhfUn1ibNZBc1Y6/UM74KsXEJxkABmzpIQMHLxQdoq3RNPVMLC2U8QcHDDN8LINGyCuD2Sg0=
X-Received: by 2002:a1f:ab43:: with SMTP id u64mr8571920vke.3.1610671299229;
 Thu, 14 Jan 2021 16:41:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 14 Jan 2021 16:41:28 -0800
Message-ID: <CABCJKudgPc5FFAD5BKX2dK7BJYs_Dpa_JRFgKgGh8b2Xs6khUA@mail.gmail.com>
Subject: Re: [PATCH 00/21] objtool: vmlinux.o and CLANG LTO support
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Thu, Jan 14, 2021 at 11:40 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Add support for proper vmlinux.o validation, which will be needed for
> Sami's upcoming x86 LTO set.  (And vmlinux validation is the future for
> objtool anyway, for other reasons.)
>
> This isn't 100% done -- most notably, crypto still needs to be supported
> -- but I think this gets us most of the way there.
>
> This can also be found at
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux
>
> And for more testing it can be combined with Sami's x86 LTO patches:
>
>   https://github.com/samitolvanen/linux clang-lto

Thank you for sending these! I applied this series on top of the
clang-lto tree and built allyesconfig with LTO_CLANG enabled and the
following crypto options disabled:

CRYPTO_AES_NI_INTEL
CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
CRYPTO_SHA1_SSSE3
CRYPTO_SHA256_SSSE3
CRYPTO_SHA512_SSSE3
CRYPTO_CRC32C_INTEL

I can confirm that all the warnings I previously saw are now fixed,
but I'm seeing a few new ones:

vmlinux.o: warning: objtool: balance_leaf_when_delete()+0x17d4: stack
state mismatch: cfa1=7+192 cfa2=7+176
vmlinux.o: warning: objtool: internal_move_pointers_items()+0x9f7:
stack state mismatch: cfa1=7+160 cfa2=7+176
vmlinux.o: warning: objtool: strncpy_from_user()+0x181: call to
do_strncpy_from_user() with UACCESS enabled
vmlinux.o: warning: objtool: strnlen_user()+0x12b: call to
do_strnlen_user() with UACCESS enabled
vmlinux.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x390: call
to __ubsan_handle_negate_overflow() with UACCESS enabled
vmlinux.o: warning: objtool: .text.snd_trident_free_voice: unexpected
end of section

I haven't had a chance to take a closer look yet, but some of these
are probably related to
https://github.com/ClangBuiltLinux/linux/issues/1192. However, I can
reproduce these also with ToT Clang, not just with Clang 11.

Sami
