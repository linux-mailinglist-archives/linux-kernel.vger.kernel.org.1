Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB642A5BB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 02:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgKDBSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 20:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgKDBSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:18:49 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0EAC040203
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 17:18:49 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id z3so487797pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 17:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AAtQa0oG++/s5LnuUSFxmi9+u0mej5RnNrUSF/ToGgQ=;
        b=Jm2Pw6FFwrksq+bVP/rTjV9YsWvaxd7fSOxISdndn/16dKLP2CcTfal4VVKkyYXGSf
         OTBCA18lg0TrpMIzgR9n7Pf7yF6lLakI/F5cmgtclN5L9QQqVmhQMnEVbaUR6btT0L3f
         Yzp7Ly49SdsuaBJpROmBxTognhka3/obM6mAd0r1Zzxlw3LPHeL5d1aBVjt67ZaBO/7S
         XTZeU3oKx7II7EVjHKPvMZMSin/dL6pKe1tYV33ywW5bvJZcOWsvewCPlWHtGI/uoFt0
         1Gag1pt2HkWVV2OEbsDXY3KjFvt8N3CeHYvH+RUxZnR/3qKFDIzjN6cB/gIQ8B5VMtxS
         LVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AAtQa0oG++/s5LnuUSFxmi9+u0mej5RnNrUSF/ToGgQ=;
        b=VTTcMl74CldFuQ/3xulkLuDOHDOzPAOj1JQMsxuEYOgMvem2ppqnwIyNwZoaKHi1rX
         S+x2kJfwSxFvPIoGZFT68cbanZrotY83n2yp684AsHREqtiGLWtJwaRDjVo7JPqWjc5r
         DM0Kx+4aSejEwjpjqFCQuBz7tE6upwNwMjvbU9ZqjUWvTyL1q+3Kjve4rSc3eecmEdf/
         KWwA/4URSj8iJ3L5b0zxa3y4RSCoijlPqQhAaOp4XRbWDZxm54LBqEG6e5faMLjNXqxf
         921/UQGLkh0D9KmkgJInjemGwDqTDThZhqd2fw7TEOQemWmQeVTIDCI/uYQWIbkFckfz
         Ykqg==
X-Gm-Message-State: AOAM532S47IjBtRGfdvUP7J0bQX6yvboYSyhzLh0Ewz8qzHg6nOaor4Q
        g7d/qWRrCwyXRg0kr4Ia8x/ogthFku6Lu0o4/5DP1g==
X-Google-Smtp-Source: ABdhPJw430QLz59WeDqT3Sg8ETILTyh+Ukhi+RBRlgDEMfxTy0jIaBlfY2Jnd8k5GIVqoNMsIsrPE0ifErqsb5nA7Ew=
X-Received: by 2002:a65:4b81:: with SMTP id t1mr3097057pgq.263.1604452729161;
 Tue, 03 Nov 2020 17:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20200902225911.209899-1-ndesaulniers@google.com>
 <20200902225911.209899-2-ndesaulniers@google.com> <20201103045521.GA58906@kernel.org>
 <CAKwvOdk-bMx3Jt6=oN=PHqRv_tx5cF=9cVmumazb4vMNHdj5Ag@mail.gmail.com> <20201104003826.GB19460@kernel.org>
In-Reply-To: <20201104003826.GB19460@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 3 Nov 2020 17:18:38 -0800
Message-ID: <CAKwvOdnZSLP_YF3iFDLTHFE=ORxsrCR06s-B2Hk7khSxdC0+5A@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] compiler-clang: add build check for clang 10.0.1
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 4:38 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Nov 03, 2020 at 10:48:27AM -0800, Nick Desaulniers wrote:
> > On Mon, Nov 2, 2020 at 8:55 PM Jarkko Sakkinen <jarkko@kernel.org> wrot=
e:
> > >
> > > On Wed, Sep 02, 2020 at 03:59:05PM -0700, Nick Desaulniers wrote:
> > > > +#define CLANG_VERSION (__clang_major__ * 10000       \
> > > > +                  + __clang_minor__ * 100    \
> > > > +                  + __clang_patchlevel__)
> > > > +
> > > > +#if CLANG_VERSION < 100001
> > > > +# error Sorry, your version of Clang is too old - please use 10.0.=
1 or newer.
> > > > +#endif
> > >
> > >
> > > I'm trying to compile a BPF enabled test kernel for a live system and=
 I
> > > get this error even though I have much newer clang:
> > >
> > > =E2=9E=9C  ~ (master) =E2=9C=94 clang --version
> > > Ubuntu clang version 11.0.0-2
> > > Target: x86_64-pc-linux-gnu
> > > Thread model: posix
> > > InstalledDir: /usr/bin
> > >
> > > Tried to Google for troubleshooter tips but this patch is basically t=
he
> > > only hit I get :-)
> >
> > To check the values of the above preprocessor defines, please run:
> > $ clang -dM -E - < /dev/null | grep -e __clang_m -e __clang_p
> >
> > If you have multiple versions of clang installed, you might not be
> > running the version you think you are.  Particularly, if you're using
> > bcc, idk if it includes a copy of clang?  If that's the case, we may
> > have to work out how we can support older versions of clang for the
> > express purposes of bpf.
>
> =E2=9E=9C  ~ (master) =E2=9C=94 clang -dM -E - < /dev/null | grep -e __cl=
ang_m -e __clang_p
> #define __clang_major__ 11
> #define __clang_minor__ 0
> #define __clang_patchlevel__ 0
>
> I'm compiling the kernel itself with GCC.
>
> Here's an example BPF script that fails on me:
>
> struct sgx_enclave_add_pages {
>         unsigned long src;
>         unsigned long offset;
>         unsigned long length;
>         unsigned long secinfo;
>         unsigned long flags;
>         unsigned long count;
> };
>
> kprobe:sgx_ioctl
> {
>         if (arg1 =3D=3D 0xc030a401) {
>                 printf("sgx_ioctl: %d, %lu\n", pid, ((struct sgx_enclave_=
add_pages *)(arg2))->offset);
>         }
>
> }
> Note that it relies on code not yet in the mainline.
>
> If I don't declare structs, things work just fine. E.g. the following
> works:
>
> kprobe:sgx_encl_get_backing
> {
>         printf("%s\n", func)
> }
>
> BTW, I don't really understand how scripts/clang-version.sh is even
> supposed to work, if you compile the kernel itself with GCC. In that
> case there would be no output, right? And thus version gets set to
> zero...

That script is only used by KBUILD.  include/linux/compiler-clang.h is
what's included into include/linux/compiler_types.h and causes the
error.  The eBFP tools must be including kernel headers and defining
`__clang__`.  Forgive my complete ignorance of eBPF, but how do you
build that script?  I assume the tool is using Clang, since eBPF
relies on the LLVM backend (not sure if the GCC eBPF backend is good
to go quite yet), and that version of clang is older.

I wonder if we should guard the version check with __BPF_TRACING__
similar to arch/x86/include/asm/cpufeature.h? Care to test:
```
diff --git a/include/linux/compiler-clang.h
b/include/linux/compiler-clang.h
index dd7233c48bf3..98cff1b4b088 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -8,8 +8,10 @@
                     + __clang_patchlevel__)

 #if CLANG_VERSION < 100001
+#ifndef __BPF_TRACING__
 # error Sorry, your version of Clang is too old - please use 10.0.1 or new=
er.
 #endif
+#endif

 /* Compiler specific definitions for Clang compiler */
```
--=20
Thanks,
~Nick Desaulniers
