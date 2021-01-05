Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CFF2EA746
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbhAEJ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:26:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbhAEJ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:26:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E91D225AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 09:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609838751;
        bh=6YcEbyb0mWj5M2FEgdl7ah8B/CmHEaHYSdxmMoFXLk4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z/71uaSm0zwFCN/MPDEALltHXlKLmxlduCv9AMIO8wRSJkLjCXP7xqKVs5+IH4xgq
         MB/WeU5sS+QVTomwOIDRkACs/a7Lgz//pnk7vddNy8Q4k7NrNPyMvMj1LGfjHq2BQ/
         /hM00ZwBWBQEEzK4EFAKzYl4Heex0CnHByckwUWa9ZnBL+Oyw3XJy5/FcCx9xzpUIw
         ABh8FqRwro8JLcZ3umeAAaBj5Kt/yCgMPOa1tcQcCK8OZL++lAsnIlrMX75YfHY7PX
         YgAoZDCpy+Hh181P4eeZKN/sXB0hKwXyoswty8rRZbPT4OmzzsYk7sakMNgl6PEiDE
         mBgYcMPx8ePgg==
Received: by mail-oi1-f182.google.com with SMTP id f132so35296165oib.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:25:51 -0800 (PST)
X-Gm-Message-State: AOAM5332JFNdqBDJPsdQ1fd0Hih0JcFAcP0dICJaYqwe3K0dilfVto7O
        37My9woaOBibwB2dj6xe9xulubHZ2/fMs8GA1/0=
X-Google-Smtp-Source: ABdhPJxG6BDEpmw49rUMPuoc6EceKxV9Srws+1fH28WqHYy0IyZzT6fUPTwjbJYpUluapDVt1eFdKl9hW/hsNv+9axc=
X-Received: by 2002:aca:e103:: with SMTP id y3mr1948395oig.11.1609838750247;
 Tue, 05 Jan 2021 01:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20201230154749.746641-1-arnd@kernel.org> <CANpmjNNGmbgg_pFMC6X_6vZcj53jy7PsNyZAC88rOQC5zrOiFw@mail.gmail.com>
 <20210104223336.GA2562866@ubuntu-m3-large-x86>
In-Reply-To: <20210104223336.GA2562866@ubuntu-m3-large-x86>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 5 Jan 2021 10:25:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3J1HGia3cPy+ArFQGzQWj1gy8bx7DdjnRFE=1+JmsrKw@mail.gmail.com>
Message-ID: <CAK8P3a3J1HGia3cPy+ArFQGzQWj1gy8bx7DdjnRFE=1+JmsrKw@mail.gmail.com>
Subject: Re: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        George Popescu <georgepope@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 11:33 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Wed, Dec 30, 2020 at 05:13:03PM +0100, Marco Elver wrote:
> > On Wed, 30 Dec 2020 at 16:47, Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Building ubsan kernels even for compile-testing introduced these
> > > warnings in my randconfig environment:
> > >
> > > crypto/blake2b_generic.c:98:13: error: stack frame size of 9636 bytes in function 'blake2b_compress' [-Werror,-Wframe-larger-than=]
> > > static void blake2b_compress(struct blake2b_state *S,
> > > crypto/sha512_generic.c:151:13: error: stack frame size of 1292 bytes in function 'sha512_generic_block_fn' [-Werror,-Wframe-larger-than=]
> > > static void sha512_generic_block_fn(struct sha512_state *sst, u8 const *src,
> > > lib/crypto/curve25519-fiat32.c:312:22: error: stack frame size of 2180 bytes in function 'fe_mul_impl' [-Werror,-Wframe-larger-than=]
> > > static noinline void fe_mul_impl(u32 out[10], const u32 in1[10], const u32 in2[10])
> > > lib/crypto/curve25519-fiat32.c:444:22: error: stack frame size of 1588 bytes in function 'fe_sqr_impl' [-Werror,-Wframe-larger-than=]
> > > static noinline void fe_sqr_impl(u32 out[10], const u32 in1[10])
> > >
> > > Further testing showed that this is caused by
> > > -fsanitize=unsigned-integer-overflow.
> > >
> > > The one in blake2b immediately overflows the 8KB stack area on 32-bit
> > > architectures, so better ensure this never happens by making this
> > > option gcc-only.
>
> This patch also fixes the failed BUILD_BUG issue in mm/mremap.c that you
> sent a patch for [1], along with a couple of other issues I see such as:

I'm fairly sure I still saw that BUILD_BUG() even after I had applied this
patch, I would guess that one just depends on inlining decisions that
are influenced by all kinds of compiler options including
-fsanitize=unsigned-integer-overflow, so it becomes less likely.

I'll revert my other patch in the randconfig tree to see if it comes back.

      Arnd
