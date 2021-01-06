Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311562EC5D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbhAFVjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 16:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFVjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 16:39:36 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE2FC061757
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 13:38:56 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 19so3891729qkm.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dl1djWeKeSwJeX9gv/m26fBrhfl77JKKmwSMVyYVnk8=;
        b=FBNS7GR/ve44GhwbR7o87MFtwxy8te1QAspY1GygkskBrckPaFQbMBJh2Zfnb8GWNX
         iTlw0xaMortAHCOr8lWDBYRD5XB/Elv507PTr1wm7xEt+4IuLhEbEuDm/qbaP6ldcrFo
         jFTAU2gKKqactHSaw5Bk8cLj/DNlPu4zrcih7qfBPwOvD/tXZqK6WwuoY3kpEUhr7te3
         QIDyX2lw7Zk1BjacHIhuozvxFtjoJKfcVrb/X1kei8pSSjp6APC7DV0Igwnwf/Gh86vX
         GM6w7ZssRLz8wDmZQvziiRXBIvp5/fbWVkdb1g5qN8e5PBRQCM7ExEZJO+r5KcXyDr8D
         M0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dl1djWeKeSwJeX9gv/m26fBrhfl77JKKmwSMVyYVnk8=;
        b=IZy6Fg+WFDze/YHTFKZj9rKztpw0LbexqfDZ81a4wd78Lk7Lb9EUaRFeA46d194GYI
         1uH3HUTubLd9r0rPhzu01BNRliXrq40l6Wcf4pMRW/sGXMJgD2mwVUmEm5uu1Rhn2KsU
         PJ3+ru3SqLKS+IdcXhrcQlZzUHCpvWYlpIPiqrK5zkDTVXwms67nuzOThGYYwSguXGCG
         Qw3dahnJaY7YEbQSwx2sk5/Cuei7N0kU7OG41u61764KoehJSmUIWX6UG5CXubCgUwYP
         NuKkXU2I6HFnr6V5iuCOZUcTigu7SA3JRR/HiLvPCNEKgVgYPRVEBTM6Z/jBV5NEVoXa
         V/SA==
X-Gm-Message-State: AOAM532K+91rEIDOMxPWg1CZjo1a9huQZX8KKXugDA69VZCgMUr24qNK
        Sg92KKxRIubbYv3jeoxJ9rg=
X-Google-Smtp-Source: ABdhPJzKWhPBG8CeBzhDpw9fyTR7YHM2yMSd6/NyciKSXA4EoViz1vJB8qULe4d3sxp35xN1ULKqIw==
X-Received: by 2002:a05:620a:147a:: with SMTP id j26mr6313243qkl.190.1609969135209;
        Wed, 06 Jan 2021 13:38:55 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id 5sm1800666qtp.55.2021.01.06.13.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 13:38:54 -0800 (PST)
Date:   Wed, 6 Jan 2021 14:38:53 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        George Popescu <georgepope@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with
 clang
Message-ID: <20210106213853.GA3617315@ubuntu-m3-large-x86>
References: <20201230154749.746641-1-arnd@kernel.org>
 <CANpmjNNGmbgg_pFMC6X_6vZcj53jy7PsNyZAC88rOQC5zrOiFw@mail.gmail.com>
 <20210104223336.GA2562866@ubuntu-m3-large-x86>
 <CAK8P3a3J1HGia3cPy+ArFQGzQWj1gy8bx7DdjnRFE=1+JmsrKw@mail.gmail.com>
 <CAK8P3a01iSXxc+05sTtSWvxSYX=g4J1vK-nfnn5oNkR8FO_OTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a01iSXxc+05sTtSWvxSYX=g4J1vK-nfnn5oNkR8FO_OTQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 10:12:51AM +0100, Arnd Bergmann wrote:
> On Tue, Jan 5, 2021 at 10:25 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Mon, Jan 4, 2021 at 11:33 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > > On Wed, Dec 30, 2020 at 05:13:03PM +0100, Marco Elver wrote:
> > > > On Wed, 30 Dec 2020 at 16:47, Arnd Bergmann <arnd@kernel.org> wrote:
> > > > >
> > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > >
> > > > > Building ubsan kernels even for compile-testing introduced these
> > > > > warnings in my randconfig environment:
> > > > >
> > > > > crypto/blake2b_generic.c:98:13: error: stack frame size of 9636 bytes in function 'blake2b_compress' [-Werror,-Wframe-larger-than=]
> > > > > static void blake2b_compress(struct blake2b_state *S,
> > > > > crypto/sha512_generic.c:151:13: error: stack frame size of 1292 bytes in function 'sha512_generic_block_fn' [-Werror,-Wframe-larger-than=]
> > > > > static void sha512_generic_block_fn(struct sha512_state *sst, u8 const *src,
> > > > > lib/crypto/curve25519-fiat32.c:312:22: error: stack frame size of 2180 bytes in function 'fe_mul_impl' [-Werror,-Wframe-larger-than=]
> > > > > static noinline void fe_mul_impl(u32 out[10], const u32 in1[10], const u32 in2[10])
> > > > > lib/crypto/curve25519-fiat32.c:444:22: error: stack frame size of 1588 bytes in function 'fe_sqr_impl' [-Werror,-Wframe-larger-than=]
> > > > > static noinline void fe_sqr_impl(u32 out[10], const u32 in1[10])
> > > > >
> > > > > Further testing showed that this is caused by
> > > > > -fsanitize=unsigned-integer-overflow.
> > > > >
> > > > > The one in blake2b immediately overflows the 8KB stack area on 32-bit
> > > > > architectures, so better ensure this never happens by making this
> > > > > option gcc-only.
> > >
> > > This patch also fixes the failed BUILD_BUG issue in mm/mremap.c that you
> > > sent a patch for [1], along with a couple of other issues I see such as:
> >
> > I'm fairly sure I still saw that BUILD_BUG() even after I had applied this
> > patch, I would guess that one just depends on inlining decisions that
> > are influenced by all kinds of compiler options including
> > -fsanitize=unsigned-integer-overflow, so it becomes less likely.
> >
> > I'll revert my other patch in the randconfig tree to see if it comes back.
> 
> The qcom/gpi.c failure still happens with this patch applied:
> 
> In file included from /git/arm-soc/drivers/dma/qcom/gpi.c:8:
> In function 'field_multiplier',
>     inlined from 'gpi_update_reg' at
> /git/arm-soc/include/linux/bitfield.h:124:17:
> /git/arm-soc/include/linux/bitfield.h:119:3: error: call to
> '__bad_mask' declared with attribute error: bad bitfield mask
>   119 |   __bad_mask();
>       |   ^~~~~~~~~~~~
> In function 'field_multiplier',
>     inlined from 'gpi_update_reg' at
> /git/arm-soc/include/linux/bitfield.h:154:1:
> /git/arm-soc/include/linux/bitfield.h:119:3: error: call to
> '__bad_mask' declared with attribute error: bad bitfield mask
>   119 |   __bad_mask();
>       |   ^~~~~~~~~~~~
> 
> See https://pastebin.com/8UH6x4A2 for the .config
> 
>        Arnd

That config does not build for me, am I holding it wrong?

$ curl -LSso .config https://pastebin.com/raw/8UH6x4A2

$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- LLVM=1 olddefconfig vmlinux
.config:364:warning: override: ARCH_DOVE changes choice state
arch/arm/kernel/sys_oabi-compat.c:257:6: error: implicit declaration of function 'ep_op_has_event' [-Werror,-Wimplicit-function-declaration]
        if (ep_op_has_event(op) &&
            ^
arch/arm/kernel/sys_oabi-compat.c:264:9: error: implicit declaration of function 'do_epoll_ctl' [-Werror,-Wimplicit-function-declaration]
        return do_epoll_ctl(epfd, op, fd, &kernel, false);
               ^
arch/arm/kernel/sys_oabi-compat.c:264:9: note: did you mean 'sys_epoll_ctl'?
./include/linux/syscalls.h:359:17: note: 'sys_epoll_ctl' declared here
asmlinkage long sys_epoll_ctl(int epfd, int op, int fd,
                ^
2 errors generated.
...

Cheers,
Nathan
