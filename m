Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C142E2DA5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 08:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgLZHya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 02:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgLZHya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 02:54:30 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C21C061757
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 23:53:50 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id p187so5255233iod.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 23:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NGNEUvGMlB9kamBKy3F0042bww9MOHsmz3qAxswwrG4=;
        b=QMo9OLxcp57tzIXTLcYu/cpoXyjzH4RaNogkFGC/nuZcnrz13coab8rlNyOdd6OCY1
         kH5ecgFVHeKxhAB6V5p8mct3qmsSWrlFgXDws5Bu3kQqVWWh8+Q9ZylJRehKV8kV8vaB
         26KVR9xF27o0kkrd6MQ1lm3WurGbeFYfPheveWUx1CVrnu85EILoraNcJ2H0Gj7ELma9
         N5n5k+GItpim1daYRBobVXbGIl0aY6ob6++nuxW4YXYXRWBWmRzX05kw4x5nNgU78pTW
         rOGrc4QVZitsaTYKdjMTD4A0lHxxUXRpikifrwnYVSx2PbaOk3k511p+Gt5FX3/ku5Jp
         zN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NGNEUvGMlB9kamBKy3F0042bww9MOHsmz3qAxswwrG4=;
        b=RBcOz8acqUPhCyFmiEGVzVsXVOoStjObrZD586GsESEiUEfn/vbaztrY2JOXj8xFA5
         l7ZGwLoJuQRloEvm8iI/I9XmV/zb2kfDMGGzWz+3RT8UJs04QZYfVtRc1q06cbGtGlgV
         No6YwdAMaP8bTApEGBa4m1tghGnh0/Zof1pDU41c07x8M22dfiYQX3hg6GAt4qN9S0QG
         Escf6ldgTFMvvIw7zzwCeLgCo9+ENKH1TkUGCf0URaI7QuXW2i+Q4mCBYf/eLbMgoKSN
         jlSFxN9h1c+igxv0FTanSFWc2T88g+d+Dp6pUqgWcR0iaHvYdZdsp835jy4r50Ugc04L
         drag==
X-Gm-Message-State: AOAM531jAZ9zyQGWSzA2NXTJG4UGzBmGYLbZOah/oUkhnGFEROCWHUZ1
        nNL9fv76sa8mFDtHILycG7g=
X-Google-Smtp-Source: ABdhPJxVZOIOLQHylV5LAj/mh4TU/hee2VQ6cRrgXHN/48t+FQFrbjLeQpcc4491nXdmG9qe4JYRXg==
X-Received: by 2002:a02:3f62:: with SMTP id c34mr32162065jaf.16.1608969229712;
        Fri, 25 Dec 2020 23:53:49 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id b12sm23205166ilc.21.2020.12.25.23.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 23:53:49 -0800 (PST)
Date:   Sat, 26 Dec 2020 00:53:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     hpa@zytor.com
Cc:     John Millikin <jmillikin@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        John Millikin <john@john-millikin.com>
Subject: Re: [PATCH] arch/x86: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)
Message-ID: <20201226075347.GA1977841@ubuntu-m3-large-x86>
References: <cceb074c-861c-d716-5e19-834a8492f245@gmail.com>
 <37DE7046-5096-4C0C-A96D-FD168A849DFD@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37DE7046-5096-4C0C-A96D-FD168A849DFD@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 11:35:28PM -0800, hpa@zytor.com wrote:
> On December 25, 2020 11:29:30 PM PST, John Millikin <jmillikin@gmail.com> wrote:
> >When compiling with Clang, the `$(CLANG_FLAGS)' variable contains
> >additional flags needed to cross-compile C and Assembly sources:

I am not sure how or if others agree but it took me a second to realize
the purpose of this change was cross compiling even though I read the
commit message so I think it should be called out a bit more. I would
argue that it is not very common to see x86 cross compiled (I know
Stephen Rothwell does) :) x86 is one of the most tested architectures
for building with clang and we have see no recent failures in the boot
or realmode code.

> >* `-no-integrated-as' tells clang to assemble with GNU Assembler
> >  instead of its built-in LLVM assembler. This flag is set by default
> >  unless `LLVM_IAS=1' is set, because the LLVM assembler can't yet
> >  parse certain GNU extensions.
> >
> >* `--target' sets the target architecture when cross-compiling. This
> >  flag must be set for both compilation and assembly (`KBUILD_AFLAGS')
> >  to support architecture-specific assembler directives.
> >
> >Signed-off-by: John Millikin <john@john-millikin.com>
> >---
> > arch/x86/Makefile | 5 +++++
> > 1 file changed, 5 insertions(+)
> >
> >diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> >index 7116da3980be..725c65532482 100644
> >--- a/arch/x86/Makefile
> >+++ b/arch/x86/Makefile
> >@@ -33,6 +33,11 @@ REALMODE_CFLAGS += -ffreestanding
> > REALMODE_CFLAGS += -fno-stack-protector
> > REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS),
> >-Wno-address-of-packed-member)
> > REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS),
> >$(cc_stack_align4))
> >+
> >+ifdef CONFIG_CC_IS_CLANG
> >+REALMODE_CFLAGS += $(CLANG_FLAGS)
> >+endif
> >+
> > export REALMODE_CFLAGS
> > 
> > # BITS is used as extension for files which are available in a 32 bit
> 
> Why is CLANG_FLAGS non-null when unused? It would be better to centralize that.

It isn't.

$ rg "CLANG_FLAGS :=" Makefile
507:CLANG_FLAGS :=

$ rg "CLANG_FLAGS\t" Makefile
564:CLANG_FLAGS += --target=$(notdir $(CROSS_COMPILE:%-=%))
566:CLANG_FLAGS += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
570:CLANG_FLAGS += --gcc-toolchain=$(GCC_TOOLCHAIN)
573:CLANG_FLAGS += -no-integrated-as
575:CLANG_FLAGS += -Werror=unknown-warning-option

The ifdef can be dropped and unconditonally add CLANG_FLAGS to
REALMODE_CFLAGS, as is done in a few arch directories:

$ rg "\(CLANG_FLAGS\)" arch | cat
arch/s390/purgatory/Makefile:KBUILD_CFLAGS += $(CLANG_FLAGS)
arch/s390/Makefile:KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
arch/s390/Makefile:KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2
arch/powerpc/boot/Makefile:BOOTCFLAGS += $(CLANG_FLAGS)
arch/powerpc/boot/Makefile:BOOTAFLAGS += $(CLANG_FLAGS)

Cheers,
Nathan
