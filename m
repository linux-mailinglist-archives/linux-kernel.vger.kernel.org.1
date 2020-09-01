Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D4D259D45
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 19:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgIARgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 13:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgIARgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:36:36 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACCDC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 10:36:35 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 37so1889792oto.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 10:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+VnyCUAkTo6LTaWWSSmduxUOFyHV2SatZbV/3czen18=;
        b=Mc8biK6/xX3BESGRgziNkoa5bzFiXaDd4hWZmM0VCsCwkRzunWw+m7w2C9AlCNqQIp
         dlC8NGVzHGjJw5ri/8s4nnuEpMKSketgGd+gsy2E4B/t9ahF8QNq8vbBs2qi/c0CxzPf
         +JjLoc+Q++yxt4KK3xYLzPXDuDo2Vm+9qZpWQvZC4SIriCJSuTTbutRD3G5v4RE3MK5e
         UcTsPlNNhPzfX0stjuVy/UYjFWEf4fz7T5UKYyw4ETB9OjwpA3nfH2XoIwvBEePljLBr
         5NRzjOWvjsKBvpnwdKtzMNnEfcpsu2K8d6rmzivc00j48HXZ0306ip66LSxAtOeN6b9N
         87Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+VnyCUAkTo6LTaWWSSmduxUOFyHV2SatZbV/3czen18=;
        b=gOzjnznfeUThlBKScebMBc6hv7l0Wn6ibVCWdX/wtaaWmql8GP5BKB/GFTWvyL9og+
         T6cxjIBhC5v2YkarlmBvTT+3a8m57i965n+hejkdkKiEKmxyH7SkMn5gUO1zX9s0idxD
         +1CmgeMyUz7+kG+hnS+GInJ1lLPYo+OntYuAVRh5dZJ5D5UjvkdR5lJ1EFaElKeZl7Vv
         qHGL722bP2juEMPTIwjfw0yelAwG2tqMG0BYb94OHF76bHc4HiykSxbzlJSVX03avS22
         xPJIyMh/0JRCoX5Di0geNqDI0swEiaCA9gieKCwEcBARkLdsToPBwz1ygKYiIzkzGORH
         Pu/A==
X-Gm-Message-State: AOAM5315WxKlxwkFNSOEtekhQvQfqZ8d6k5oN8p4YkVaDNP0pTKooZvf
        62pZ1cg5Yl/uHzjCb90DUnt8F5kvc9SemTretp0=
X-Google-Smtp-Source: ABdhPJzB8bGljGqVInE6CbzLg6iJ/l38Unvuf1J6uS1WgnFBhw27PcLfUK3MzJNBe/0sHiuQ0v6r+XPrdcsjEWyPoGs=
X-Received: by 2002:a9d:7656:: with SMTP id o22mr2109049otl.109.1598981795095;
 Tue, 01 Sep 2020 10:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200901002326.1137289-1-ndesaulniers@google.com> <20200901002326.1137289-3-ndesaulniers@google.com>
In-Reply-To: <20200901002326.1137289-3-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 1 Sep 2020 19:36:23 +0200
Message-ID: <CA+icZUXzSGAAZ=fs1rTwDUT5aqEzMSsDdTr2V+fO0s4FGOmAAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] Revert "kbuild: disable clang's default use of -fmerge-all-constants"
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 2:23 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> This reverts commit 87e0d4f0f37fb0c8c4aeeac46fff5e957738df79.
>
> This was fixed in clang-6; the minimum supported version of clang in the
> kernel is clang-10 (10.0.1).
>
> Link: https://reviews.llvm.org/rL329300.
> Link: https://github.com/ClangBuiltLinux/linux/issues/9
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> ---
>  Makefile | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 37739ee53f27..144ac6a073ff 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -932,15 +932,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)
>  # disable invalid "can't wrap" optimizations for signed / pointers
>  KBUILD_CFLAGS  += $(call cc-option,-fno-strict-overflow)
>
> -# clang sets -fmerge-all-constants by default as optimization, but this
> -# is non-conforming behavior for C and in fact breaks the kernel, so we
> -# need to disable it here generally.
> -KBUILD_CFLAGS  += $(call cc-option,-fno-merge-all-constants)
> -
> -# for gcc -fno-merge-all-constants disables everything, but it is fine
> -# to have actual conforming behavior enabled.
> -KBUILD_CFLAGS  += $(call cc-option,-fmerge-constants)
> -
>  # Make sure -fstack-check isn't enabled (like gentoo apparently did)
>  KBUILD_CFLAGS  += $(call cc-option,-fno-stack-check,)
>
> --
> 2.28.0.402.g5ffc5be6b7-goog
>
