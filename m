Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554642EC928
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbhAGDfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbhAGDfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:35:22 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29B0C0612F3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 19:34:41 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id p5so5937029oif.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 19:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=djrXw5iqjaFHZpO+usSbcPQ48WqkacHGLQM3yEuz/cs=;
        b=OgrKWUCEZ+n+Gi65QRSr4qI3P3NUUWjz7ONJxJ3YRNbDf7ztpM+mhHFO0hbKYHGQme
         SYr5Kpt27I9esEHDFYdgr7fF7/SQKjTdZSxHhtnkQI3ZmIyMWbpJhM/w5wfwJDqi/okm
         Uvc0pJvoIYGkilxh6AVMKe5U3nUYgPCnPN0JDGcqiTG9yrVd0aOlHZHAt/BAupA4fImI
         uRJBvfN4CYGm/JzCDQo3GwdKpPJzFQQMLF0NpI4kg0PctTcuOZEfVvoRrvo5UPvdEb4K
         /vYxslXxwN3OvJ/n2IcR1V4WurHxGObAcaLGCssuAO1R1Cyl1wm+H8zPW4pujD1XJIYt
         gmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djrXw5iqjaFHZpO+usSbcPQ48WqkacHGLQM3yEuz/cs=;
        b=V0vwbrxxyy3ExPhco/mwKoANMNlygB8wlSYFZ3qb3xS3CqpIuXE604fblKBpzVZeEM
         phEiP9mf1UW1IcNAepMLwJu0BJpHpkUx85APFXfWo+JoEzM0Vurm5q7Fec2rfcD/MP+1
         Ys4sDwZ6JLd8dgiEiOi+vSag8V3GCH0IF7djvu4v68eSmY9lp4f+ltpt/lN4xI9uOPdI
         zm0ERq/pLFPuh6A6XlMuMXT39ByGEDRbMw8gQzm4+sS4XD4J83EpB5db2l0trZmymZMW
         DW3xj9kZuFcOwfHAYjWxzoJh9d1HwZQXRT8pPrwd1ow58pOqjV9RqAr87J6TL9NgVekd
         0BdQ==
X-Gm-Message-State: AOAM532RC0etym4x+VymxN3uZPGb7JUDvwQqVtAlCapqcFDLLR5NJrli
        BRb4SYPNbO9Tu2fI6o0dCMfiztNMY/mGYcVXFZa37mk5Fn0=
X-Google-Smtp-Source: ABdhPJwqDmTXKauIbwIp0dl0cPtVO8jYQ/J/9v8sbqoAwYXd50b3hoOz/mJeTi9qC+EYq7J+drG+24AiTFDc2yIdNaE=
X-Received: by 2002:a54:448f:: with SMTP id v15mr173332oiv.106.1609990480929;
 Wed, 06 Jan 2021 19:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20201230154749.746641-1-arnd@kernel.org> <CANpmjNNGmbgg_pFMC6X_6vZcj53jy7PsNyZAC88rOQC5zrOiFw@mail.gmail.com>
 <20210104223336.GA2562866@ubuntu-m3-large-x86> <CAK8P3a3J1HGia3cPy+ArFQGzQWj1gy8bx7DdjnRFE=1+JmsrKw@mail.gmail.com>
 <CAK8P3a01iSXxc+05sTtSWvxSYX=g4J1vK-nfnn5oNkR8FO_OTQ@mail.gmail.com>
 <20210106213853.GA3617315@ubuntu-m3-large-x86> <CAK8P3a3JHLKc=1V_6mgvQeS_oP+_Y=m_nhHzWSPrs2S+p7gvMg@mail.gmail.com>
In-Reply-To: <CAK8P3a3JHLKc=1V_6mgvQeS_oP+_Y=m_nhHzWSPrs2S+p7gvMg@mail.gmail.com>
From:   Nathan Chancellor <natechancellor@gmail.com>
Date:   Wed, 6 Jan 2021 20:34:30 -0700
Message-ID: <CAEVzpNnttP0EZq9M5cUCAfEeJcKNxkK-t3Bw8eyia2_wGV6vYQ@mail.gmail.com>
Subject: Re: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with clang
To:     Arnd Bergmann <arnd@kernel.org>
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

On Wed, Jan 06, 2021 at 11:06:39PM +0100, Arnd Bergmann wrote:
> On Wed, Jan 6, 2021 at 10:38 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > On Wed, Jan 06, 2021 at 10:12:51AM +0100, Arnd Bergmann wrote:
> > > On Tue, Jan 5, 2021 at 10:25 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > > >
> > > > On Mon, Jan 4, 2021 at 11:33 PM Nathan Chancellor
> > > > <natechancellor@gmail.com> wrote:
> > > > > On Wed, Dec 30, 2020 at 05:13:03PM +0100, Marco Elver wrote:
> > > > > > On Wed, 30 Dec 2020 at 16:47, Arnd Bergmann <arnd@kernel.org> wrote:
> > > > > > >
> > > > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > > > >
> > > > > > > Building ubsan kernels even for compile-testing introduced these
> > > > > > > warnings in my randconfig environment:
> > > > > > >
> > > > > > > crypto/blake2b_generic.c:98:13: error: stack frame size of 9636 bytes in function 'blake2b_compress' [-Werror,-Wframe-larger-than=]
> > > > > > > static void blake2b_compress(struct blake2b_state *S,
> > > > > > > crypto/sha512_generic.c:151:13: error: stack frame size of 1292 bytes in function 'sha512_generic_block_fn' [-Werror,-Wframe-larger-than=]
> > > > > > > static void sha512_generic_block_fn(struct sha512_state *sst, u8 const *src,
> > > > > > > lib/crypto/curve25519-fiat32.c:312:22: error: stack frame size of 2180 bytes in function 'fe_mul_impl' [-Werror,-Wframe-larger-than=]
> > > > > > > static noinline void fe_mul_impl(u32 out[10], const u32 in1[10], const u32 in2[10])
> > > > > > > lib/crypto/curve25519-fiat32.c:444:22: error: stack frame size of 1588 bytes in function 'fe_sqr_impl' [-Werror,-Wframe-larger-than=]
> > > > > > > static noinline void fe_sqr_impl(u32 out[10], const u32 in1[10])
> > > > > > >
> > > > > > > Further testing showed that this is caused by
> > > > > > > -fsanitize=unsigned-integer-overflow.
> > > > > > >
> > > > > > > The one in blake2b immediately overflows the 8KB stack area on 32-bit
> > > > > > > architectures, so better ensure this never happens by making this
> > > > > > > option gcc-only.
> > > > >
> > > > > This patch also fixes the failed BUILD_BUG issue in mm/mremap.c that you
> > > > > sent a patch for [1], along with a couple of other issues I see such as:
> > > >
> > > > I'm fairly sure I still saw that BUILD_BUG() even after I had applied this
> > > > patch, I would guess that one just depends on inlining decisions that
> > > > are influenced by all kinds of compiler options including
> > > > -fsanitize=unsigned-integer-overflow, so it becomes less likely.
> > > >
> > > > I'll revert my other patch in the randconfig tree to see if it comes back.
> > >
> > > The qcom/gpi.c failure still happens with this patch applied:
> > >
> > > In file included from /git/arm-soc/drivers/dma/qcom/gpi.c:8:
> > > In function 'field_multiplier',
> > >     inlined from 'gpi_update_reg' at
> > > /git/arm-soc/include/linux/bitfield.h:124:17:
> > > /git/arm-soc/include/linux/bitfield.h:119:3: error: call to
> > > '__bad_mask' declared with attribute error: bad bitfield mask
> > >   119 |   __bad_mask();
> > >       |   ^~~~~~~~~~~~
> > > In function 'field_multiplier',
> > >     inlined from 'gpi_update_reg' at
> > > /git/arm-soc/include/linux/bitfield.h:154:1:
> > > /git/arm-soc/include/linux/bitfield.h:119:3: error: call to
> > > '__bad_mask' declared with attribute error: bad bitfield mask
> > >   119 |   __bad_mask();
> > >       |   ^~~~~~~~~~~~
> > >
> > > See https://pastebin.com/8UH6x4A2 for the .config
> > >
> > >        Arnd
> >
> > That config does not build for me, am I holding it wrong?
> >
> > $ curl -LSso .config https://pastebin.com/raw/8UH6x4A2
>
> Sorry about that, you ran into a bug that I have applied a
> local fix for. You could enable CONFIG_EPOLL, or apply
> this patch:
>
> https://lore.kernel.org/linux-arm-kernel/20200429132349.1294904-1-arnd@arndb.de/
>
>       Arnd

I decided to just try to build the file directly. As it turns out,
ARCH=arm allyesconfig does not show any error in get_extent or
gpi_update_reg but ARCH=arm64 allyesconfig does. Looks like this is
because of the lack of CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL for ARCH=arm.

$ rg UBSAN out/{arm,arm64}/.config
out/arm64/.config
13853:CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
13854:CONFIG_UBSAN=y
13855:CONFIG_CC_HAS_UBSAN_BOUNDS=y
13856:CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
13857:CONFIG_UBSAN_BOUNDS=y
13858:CONFIG_UBSAN_ARRAY_BOUNDS=y
13859:CONFIG_UBSAN_SHIFT=y
13860:CONFIG_UBSAN_DIV_ZERO=y
13861:CONFIG_UBSAN_UNREACHABLE=y
13862:CONFIG_UBSAN_SIGNED_OVERFLOW=y
13863:CONFIG_UBSAN_UNSIGNED_OVERFLOW=y
13864:CONFIG_UBSAN_OBJECT_SIZE=y
13865:CONFIG_UBSAN_BOOL=y
13866:CONFIG_UBSAN_ENUM=y
13867:CONFIG_UBSAN_SANITIZE_ALL=y
13868:CONFIG_TEST_UBSAN=m

out/arm/.config
14133:CONFIG_UBSAN=y
14134:CONFIG_CC_HAS_UBSAN_BOUNDS=y
14135:CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
14136:CONFIG_UBSAN_BOUNDS=y
14137:CONFIG_UBSAN_ARRAY_BOUNDS=y
14138:CONFIG_UBSAN_SHIFT=y
14139:CONFIG_UBSAN_DIV_ZERO=y
14140:CONFIG_UBSAN_UNREACHABLE=y
14141:CONFIG_UBSAN_SIGNED_OVERFLOW=y
14142:CONFIG_UBSAN_UNSIGNED_OVERFLOW=y
14143:CONFIG_UBSAN_OBJECT_SIZE=y
14144:CONFIG_UBSAN_BOOL=y
14145:CONFIG_UBSAN_ENUM=y
14146:CONFIG_TEST_UBSAN=m

$ llvm-nm -S out/arm64/drivers/dma/qcom/gpi.o |& rg __bad_mask
                                  U __bad_mask

$ llvm-nm -S out/arm/drivers/dma/qcom/gpi.o |& rg __bad_mask

Applying this diff causes __bad_mask to show up:

diff --git a/drivers/dma/qcom/Makefile b/drivers/dma/qcom/Makefile
index 50f1e7014693..c261adb47960 100644
--- a/drivers/dma/qcom/Makefile
+++ b/drivers/dma/qcom/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_QCOM_ADM) += qcom_adm.o
 obj-$(CONFIG_QCOM_BAM_DMA) += bam_dma.o
 obj-$(CONFIG_QCOM_GPI_DMA) += gpi.o
+UBSAN_SANITIZE_gpi.o := y
 obj-$(CONFIG_QCOM_HIDMA_MGMT) += hdma_mgmt.o
 hdma_mgmt-objs  := hidma_mgmt.o hidma_mgmt_sys.o
 obj-$(CONFIG_QCOM_HIDMA) +=  hdma.o

$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- LLVM=1 \
       O=out/arm distclean allyesconfig drivers/dma/qcom/gpi.o

$ llvm-nm -S out/arm/drivers/dma/qcom/gpi.o |& rg __bad_mask
                  U __bad_mask

So I guess I am curious how you saw this pop up. Not to mention it seems
like that error is with GCC rather than clang?

For what it's worth, when I run that .config through olddefconfig,
CONFIG_ARCH_QCOM and CONFIG_QCOM_GPI_DMA get disabled... Am I doing
something wrong?

$ curl -LSso /tmp/out/arm/.config https://pastebin.com/raw/8UH6x4A2

$ rg "CONFIG_ARCH_QCOM|CONFIG_QCOM_GPI_DMA" /tmp/out/arm/.config
377:CONFIG_ARCH_QCOM=y
4437:CONFIG_QCOM_GPI_DMA=y

$ make.sh ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- LLVM=1
O=/tmp/out/arm olddefconfig
.config:364:warning: override: ARCH_DOVE changes choice state

$ rg "CONFIG_ARCH_QCOM|CONFIG_QCOM_GPI_DMA" /tmp/out/arm/.config

Cheers,
Nathan
