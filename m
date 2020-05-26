Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13581C6397
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 00:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgEEWCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 18:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgEEWC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:02:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A02C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 15:02:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 207so151029pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=meutyvpqi9+qTZ06UEsokNwwGPTMphxT3NcJSXe1Pt4=;
        b=n4aYqZKuQDutp5OyuzgrDrbOfw46qnS5p3WJa9OrEVIOe7YEDc6L8MVm0rNqy/CM0v
         EPXZs5B3vT9m/tCOyzVjW/ooXqk0Um9CTxmTKrdzOvr1UOvH2Qk+/a+xz1RKzAlgxxn/
         +pdlW8483sPcBESg7tKJJzIWd/1En/kGux6bn2UKHxYtc/9s18CqMNz47UQ6MYEfRyON
         uM9jikZBuhRPBp+wtcIzN7M6atPXrcF1VQeK5vlUAZCtcNvMhPHTK3gJNWy4Je8tr7UI
         10hnifAwGP79iZJF9wqmIjs6NXBm00T1eiSZGgBgbmWGwd3IxBq9B+PC6QeOHFPTBGiF
         B18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meutyvpqi9+qTZ06UEsokNwwGPTMphxT3NcJSXe1Pt4=;
        b=JJK9XJfHNhikRIYXlNRCyAlYwrzsK7ANmt3VgLL3NvuWAt/f7IBV/u6Qp3E5XpoiRs
         yR2jx4KqRnCYO/yWg0exExU021BTa5aoQzrA9OyPo/awhBynYB0t7sgtom4LEbSDQHDC
         qjoGbmN6vZZakfoMGVsX0Z8QcVV655IGxTUh8t4F6WFwnvtX/mLs7ZOabvlaopW60Dq3
         Wod/ix2xhqzg/OeLbvV7BSBAUCJrir60zsrk4WyOHdGYElR4riNgOBF0X1r/byWbyiwb
         kqygQMRPfmaOekhfB/liirb3xF0eHz4YqqQhZ4a+MA9eJrz+5VA3ioFftRjjuMPd/rfk
         LXpQ==
X-Gm-Message-State: AGi0PuYRVCFvHe5i1urOY6SMbV+dzyj9edrcV+H7n0Ze9SiP4fUNU6AI
        2iyma+jOi6ZadT+3Bz+XwX6YfdiYcdi21042hGqXqQ==
X-Google-Smtp-Source: APiQypII92fzip+jhi9hD7251MPhAj00NvB2R8OUBsp6nQByudV49fC3OMI4LGDz7JOTRwkDao417VvP6RNTwjyMCU0=
X-Received: by 2002:a65:5ac4:: with SMTP id d4mr4267862pgt.381.1588716146345;
 Tue, 05 May 2020 15:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9oMcfY4nwkknwN9c4rB-O7xD4GCAOFPoZCbdnq=034=Vw@mail.gmail.com>
 <20200505215503.691205-1-Jason@zx2c4.com>
In-Reply-To: <20200505215503.691205-1-Jason@zx2c4.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 May 2020 15:02:16 -0700
Message-ID: <CAKwvOdk32cDowvrqRPKDRpf2ZiXh=jVnBTmhM-NWD=Ownq9v3w@mail.gmail.com>
Subject: Re: [PATCH] Kbuild: disable FORTIFY_SOURCE on clang-10
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        George Burgess <gbiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 2:55 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> clang-10 has a broken optimization stage that doesn't enable the
> compiler to prove at compile time that certain memcpys are within
> bounds, and thus the outline memcpy is always called, resulting in
> horrific performance, and in some cases, excessive stack frame growth.
> Here's a simple reproducer:
>
>     typedef unsigned long size_t;
>     void *c(void *dest, const void *src, size_t n) __asm__("memcpy");
>     extern inline __attribute__((gnu_inline)) void *memcpy(void *dest, const void *src, size_t n) { return c(dest, src, n); }
>     void blah(char *a)
>     {
>       unsigned long long b[10], c[10];
>       int i;
>
>       memcpy(b, a, sizeof(b));
>       for (i = 0; i < 10; ++i)
>         c[i] = b[i] ^ b[9 - i];
>       for (i = 0; i < 10; ++i)
>         b[i] = c[i] ^ a[i];
>       memcpy(a, b, sizeof(b));
>     }
>
> Compile this with clang-9 and clang-10 and observe:
>
> zx2c4@thinkpad /tmp/curve25519-hacl64-stack-frame-size-test $ clang-10 -Wframe-larger-than=0 -O3 -c b.c -o c10.o
> b.c:5:6: warning: stack frame size of 104 bytes in function 'blah' [-Wframe-larger-than=]
> void blah(char *a)
>      ^
> 1 warning generated.
> zx2c4@thinkpad /tmp/curve25519-hacl64-stack-frame-size-test $ clang-9 -Wframe-larger-than=0 -O3 -c b.c -o c9.o
>
> Looking at the disassembly of c10.o and c9.o, one can see that c9.o is
> properly optimized in the obvious way one would expect, while c10.o has
> blown up and includes extern calls to memcpy.
>
> This is present on the most trivial bits of code. Thus, for clang-10, we
> just set __NO_FORTIFY globally, so that this issue won't be incurred.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: clang-built-linux <clang-built-linux@googlegroups.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: George Burgess <gbiv@google.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://bugs.llvm.org/show_bug.cgi?id=45802
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

I'm going to request this not be merged until careful comment from
George and Kees. My hands are quite full at the moment with other
regressions.  I suspect these threads may be relevant, though I
haven't had time to read through them myself.
https://github.com/ClangBuiltLinux/linux/issues/979
https://github.com/ClangBuiltLinux/linux/pull/980


> ---
>  Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 49b2709ff44e..f022f077591d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -768,6 +768,13 @@ KBUILD_CFLAGS += -Wno-gnu
>  # source of a reference will be _MergedGlobals and not on of the whitelisted names.
>  # See modpost pattern 2
>  KBUILD_CFLAGS += -mno-global-merge
> +
> +# clang-10 has a broken optimization stage that causes memcpy to always be
> +# outline, resulting in excessive stack frame growth and poor performance.
> +ifeq ($(shell test $(CONFIG_CLANG_VERSION) -ge 100000 && test $(CONFIG_CLANG_VERSION) -lt 110000; echo $$?),0)
> +KBUILD_CFLAGS += -D__NO_FORTIFY
> +endif
> +
>  else
>
>  # These warnings generated too much noise in a regular build.
> --
> 2.26.2
>


-- 
Thanks,
~Nick Desaulniers
