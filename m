Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D82EBB95
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbhAFJNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:13:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbhAFJNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:13:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A16952310E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 09:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609924388;
        bh=89h6d3JjXgl+2ZZ2ym/iV3agjZBNxZHYntIUZYADwas=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qAVGSrCcZj+K7cq/UdOHdhkBY3bf5f6ubRULXHtafdGpwROSDQ0NbB6QU8/i9YANm
         Even0WrA3wsxhlE7eWo/eAnMVKdeCX00OqkhW/prqKx2usFwgVfy5jYEBe2KLKvlZJ
         wjKDjglnunDvX7gsqydfQgYqpYQlQ3A00d2P5fThSoVZNAM6+YQz7+FNb+9XjRZ46z
         iwKZ2zq3pEwFfFGraQav91zXKzNxD2izBmToZdxfki3B476OCVVMZJXWwoO5EoB0Pe
         2yfQHG+nI+pDMNXHbbqCWfIw8LRloEyAspl6GwtvpELsU0ohMu7MwYJMYdCThjUQPD
         apKDuGSseQBGw==
Received: by mail-oi1-f179.google.com with SMTP id l200so2744960oig.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 01:13:08 -0800 (PST)
X-Gm-Message-State: AOAM533eOmKCCLkqOUXWK7K5hqXfXdHQ83pVf1JRt53JOACcF9AysooV
        i4IBBc2wgOFxMHOvBFcQnmEaR98kq55wTd9NiJk=
X-Google-Smtp-Source: ABdhPJx1BlOj5SAB0Fjd7UWfiQqbPyA/bWxmrDDOqlNFmzMgbaQ3+2XhVXTp7fJKrBBRfbHPe7oet5ohPIS7DtADFjg=
X-Received: by 2002:aca:44d:: with SMTP id 74mr2623761oie.4.1609924387851;
 Wed, 06 Jan 2021 01:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20201230154749.746641-1-arnd@kernel.org> <CANpmjNNGmbgg_pFMC6X_6vZcj53jy7PsNyZAC88rOQC5zrOiFw@mail.gmail.com>
 <20210104223336.GA2562866@ubuntu-m3-large-x86> <CAK8P3a3J1HGia3cPy+ArFQGzQWj1gy8bx7DdjnRFE=1+JmsrKw@mail.gmail.com>
In-Reply-To: <CAK8P3a3J1HGia3cPy+ArFQGzQWj1gy8bx7DdjnRFE=1+JmsrKw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 6 Jan 2021 10:12:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a01iSXxc+05sTtSWvxSYX=g4J1vK-nfnn5oNkR8FO_OTQ@mail.gmail.com>
Message-ID: <CAK8P3a01iSXxc+05sTtSWvxSYX=g4J1vK-nfnn5oNkR8FO_OTQ@mail.gmail.com>
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

On Tue, Jan 5, 2021 at 10:25 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Jan 4, 2021 at 11:33 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > On Wed, Dec 30, 2020 at 05:13:03PM +0100, Marco Elver wrote:
> > > On Wed, 30 Dec 2020 at 16:47, Arnd Bergmann <arnd@kernel.org> wrote:
> > > >
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > Building ubsan kernels even for compile-testing introduced these
> > > > warnings in my randconfig environment:
> > > >
> > > > crypto/blake2b_generic.c:98:13: error: stack frame size of 9636 bytes in function 'blake2b_compress' [-Werror,-Wframe-larger-than=]
> > > > static void blake2b_compress(struct blake2b_state *S,
> > > > crypto/sha512_generic.c:151:13: error: stack frame size of 1292 bytes in function 'sha512_generic_block_fn' [-Werror,-Wframe-larger-than=]
> > > > static void sha512_generic_block_fn(struct sha512_state *sst, u8 const *src,
> > > > lib/crypto/curve25519-fiat32.c:312:22: error: stack frame size of 2180 bytes in function 'fe_mul_impl' [-Werror,-Wframe-larger-than=]
> > > > static noinline void fe_mul_impl(u32 out[10], const u32 in1[10], const u32 in2[10])
> > > > lib/crypto/curve25519-fiat32.c:444:22: error: stack frame size of 1588 bytes in function 'fe_sqr_impl' [-Werror,-Wframe-larger-than=]
> > > > static noinline void fe_sqr_impl(u32 out[10], const u32 in1[10])
> > > >
> > > > Further testing showed that this is caused by
> > > > -fsanitize=unsigned-integer-overflow.
> > > >
> > > > The one in blake2b immediately overflows the 8KB stack area on 32-bit
> > > > architectures, so better ensure this never happens by making this
> > > > option gcc-only.
> >
> > This patch also fixes the failed BUILD_BUG issue in mm/mremap.c that you
> > sent a patch for [1], along with a couple of other issues I see such as:
>
> I'm fairly sure I still saw that BUILD_BUG() even after I had applied this
> patch, I would guess that one just depends on inlining decisions that
> are influenced by all kinds of compiler options including
> -fsanitize=unsigned-integer-overflow, so it becomes less likely.
>
> I'll revert my other patch in the randconfig tree to see if it comes back.

The qcom/gpi.c failure still happens with this patch applied:

In file included from /git/arm-soc/drivers/dma/qcom/gpi.c:8:
In function 'field_multiplier',
    inlined from 'gpi_update_reg' at
/git/arm-soc/include/linux/bitfield.h:124:17:
/git/arm-soc/include/linux/bitfield.h:119:3: error: call to
'__bad_mask' declared with attribute error: bad bitfield mask
  119 |   __bad_mask();
      |   ^~~~~~~~~~~~
In function 'field_multiplier',
    inlined from 'gpi_update_reg' at
/git/arm-soc/include/linux/bitfield.h:154:1:
/git/arm-soc/include/linux/bitfield.h:119:3: error: call to
'__bad_mask' declared with attribute error: bad bitfield mask
  119 |   __bad_mask();
      |   ^~~~~~~~~~~~

See https://pastebin.com/8UH6x4A2 for the .config

       Arnd
