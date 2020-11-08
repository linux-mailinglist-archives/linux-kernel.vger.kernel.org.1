Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E2F2AACBB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgKHSJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHSJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:09:46 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC46AC0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 10:09:45 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g17so4536503qts.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 10:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G5g4G9/pMoKvIIjm2dH1OzGwv4YgDFb04vpHh+6il6Q=;
        b=HjUj3vk1YvHJ/1TU09xxN1u4zHLyXww0OEl1jfnbys6vjzhS8yumDvyL2d6SEK55xh
         qjO5EbMCMn/T+Hx0wpY4vp5QLy3rz76n75fLx+jOaJC09yWFm/9byZ+qslhAfeyO2804
         0MR5cGwTPd5YOGR4DxUzCjbqsVQrFarElHvrRhqFl5t4hKOnXlTndPe2gWJCVizOs1D3
         NG8Q2Zx+sEci1XEbabGWva1Q1e7VJHL6SL2aFYLjobrqUi1Otmqg7hMI+J8JqLwnQMOo
         FEc28LVi9p2R+n+5OV46xPleRYZTOQ4rFB9ZdoJpZ+EySM9wCTfx3YdoYA2GRJx2o8jA
         g5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=G5g4G9/pMoKvIIjm2dH1OzGwv4YgDFb04vpHh+6il6Q=;
        b=hsHsBTONbBPcGUGy2IlR9JLt1bduFGWL0duZy5yAqNt+3DQHUsmNmI4M7ObAqhorhw
         HQqvyyhNQzZ22eW9PhKdhBbWg/gAxDqrdxapGKFUpRH8NdvYtG2hMQ8JdOC6+hoIJiay
         nSJ1bK24XeE0BZI2Cpzo2T5qNcJJ5oM9m4BCKO0Jzg8kw3jRJ28z9gQrpAcOdCdG4ooq
         Z4YxeJaYZR5JMvlOLPi5tFPRwqpLD3aGAyzPkwgcRm5/2ciXufXxgV5b65ulkrABZGca
         Ar/7ReNiNWMyCLW5/mnjO1Tn5C+86M+ZkDUrh/bjV4wogVpD2plDP1MwhU+GlqboSE28
         QSgg==
X-Gm-Message-State: AOAM533CuMyVF4MeIrdk0Eh4uIdVztjgiPIv2LgeESgDTlHj7X1js/pt
        cXScOwzZsV0MH1Y43eTCiKk=
X-Google-Smtp-Source: ABdhPJyFsrYkJzsxcPe5TPtLx5Vk7cOEj9xIJsl1xckxeybmWUJdce8YE/1T+O4NhqRPRaTNgv2lJw==
X-Received: by 2002:ac8:b87:: with SMTP id h7mr10068398qti.87.1604858984780;
        Sun, 08 Nov 2020 10:09:44 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q70sm4790359qka.87.2020.11.08.10.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 10:09:44 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 8 Nov 2020 13:09:42 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
Message-ID: <20201108180942.GA226037@rani.riverdale.lan>
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com>
 <20201108174014.GA219672@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201108174014.GA219672@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 12:40:14PM -0500, Arvind Sankar wrote:
> On Fri, Nov 06, 2020 at 07:14:36AM +0200, Adrian Ratiu wrote:
> > Due to a Clang bug [1] neon autoloop vectorization does not happen or
> > happens badly with no gains and considering previous GCC experiences
> > which generated unoptimized code which was worse than the default asm
> > implementation, it is safer to default clang builds to the known good
> > generic implementation.
> > 
> > The kernel currently supports a minimum Clang version of v10.0.1, see
> > commit 1f7a44f63e6c ("compiler-clang: add build check for clang 10.0.1").
> > 
> > When the bug gets eventually fixed, this commit could be reverted or,
> > if the minimum clang version bump takes a long time, a warning could
> > be added for users to upgrade their compilers like was done for GCC.
> > 
> > [1] https://bugs.llvm.org/show_bug.cgi?id=40976
> > 
> > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > ---
> >  arch/arm/include/asm/xor.h | 3 ++-
> >  arch/arm/lib/Makefile      | 3 +++
> >  arch/arm/lib/xor-neon.c    | 4 ++++
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
> > index aefddec79286..49937dafaa71 100644
> > --- a/arch/arm/include/asm/xor.h
> > +++ b/arch/arm/include/asm/xor.h
> > @@ -141,7 +141,8 @@ static struct xor_block_template xor_block_arm4regs = {
> >  		NEON_TEMPLATES;			\
> >  	} while (0)
> >  
> > -#ifdef CONFIG_KERNEL_MODE_NEON
> > +/* disabled on clang/arm due to https://bugs.llvm.org/show_bug.cgi?id=40976 */
> > +#if defined(CONFIG_KERNEL_MODE_NEON) && !defined(CONFIG_CC_IS_CLANG)
> >  
> >  extern struct xor_block_template const xor_block_neon_inner;
> >  
> > diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> > index 6d2ba454f25b..53f9e7dd9714 100644
> > --- a/arch/arm/lib/Makefile
> > +++ b/arch/arm/lib/Makefile
> > @@ -43,8 +43,11 @@ endif
> >  $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
> >  $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
> >  
> > +# disabled on clang/arm due to https://bugs.llvm.org/show_bug.cgi?id=40976
> > +ifndef CONFIG_CC_IS_CLANG
> >  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> >    NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
> >    CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
> >    obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
> >  endif
> > +endif
> > diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> > index e1e76186ec23..84c91c48dfa2 100644
> > --- a/arch/arm/lib/xor-neon.c
> > +++ b/arch/arm/lib/xor-neon.c
> > @@ -18,6 +18,10 @@ MODULE_LICENSE("GPL");
> >   * Pull in the reference implementations while instructing GCC (through
> >   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
> >   * NEON instructions.
> > +
> > + * On Clang the loop vectorizer is enabled by default, but due to a bug
> > + * (https://bugs.llvm.org/show_bug.cgi?id=40976) vectorization is broke
> > + * so xor-neon is disabled in favor of the default reg implementations.
> >   */
> >  #ifdef CONFIG_CC_IS_GCC
> >  #pragma GCC optimize "tree-vectorize"
> > -- 
> > 2.29.0
> > 
> 
> It's actually a bad idea to use #pragma GCC optimize. This is basically
> the same as tagging all the functions with __attribute__((optimize)),
> which GCC does not recommend for production use, as it _replaces_
> optimization options rather than appending to them, and has been
> observed to result in dropping important compiler flags.
> 
> There've been a few discussions recently around other such cases:
> https://lore.kernel.org/lkml/20201028171506.15682-1-ardb@kernel.org/
> https://lore.kernel.org/lkml/20201028081123.GT2628@hirez.programming.kicks-ass.net/
> 
> For this file, given that it is supposed to use -ftree-vectorize for the
> whole file anyway, is there any reason it's not just added to CFLAGS via
> the Makefile? This seems to be the only use of pragma optimize in the
> kernel.

Eg, this shows that the pragma results in dropping -fno-strict-aliasing.
https://godbolt.org/z/1nfrKT

The first function does not use vectorization because s and s->a might
alias.
