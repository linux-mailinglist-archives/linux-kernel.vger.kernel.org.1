Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B602A5C01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 02:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgKDBfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 20:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgKDBfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:35:00 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC5AC061A4D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 17:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QralSrBulzxB8NovVwoWh+i/AbrWlvBFhJysCZOTo1w=; b=nmuMK1K+XYR9/jibNq7mVO+JNw
        b6Q9Tm/covICS3E6nurISruLY/m7Y2D+5FVNZWillUCj8Q33j5h1AA30BkhdA0MIixPlzNi1vXSmV
        cVcf5zM/19kEZWymJTd1xPAMPNJ2WMM7vlHgrNxiknipsq8F9KhvGf2HNXVqSXxVkJiCwkIZKeHTa
        5RPhdddrYNua80QphV2gh8wV5A2KdYo5mZ1aPJJY76PsHfpKARuqeeJweoKiL0zJxKJxj4xqfElQK
        7j/iF71Zpb6/oRuD/0fze9zE7Q7cNYPVQrHgIx+p9VPe/ywQMuGpsE059XvKgStMOj76X0tf5Jc0R
        /7iGe4PQ==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=kapsi.fi)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@iki.fi>)
        id 1ka7hJ-0006YA-6e; Wed, 04 Nov 2020 03:34:49 +0200
Date:   Wed, 4 Nov 2020 03:34:47 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v3 1/7] compiler-clang: add build check for clang 10.0.1
Message-ID: <20201104013447.GA21728@kapsi.fi>
References: <20200902225911.209899-1-ndesaulniers@google.com>
 <20200902225911.209899-2-ndesaulniers@google.com>
 <20201103045521.GA58906@kernel.org>
 <CAKwvOdk-bMx3Jt6=oN=PHqRv_tx5cF=9cVmumazb4vMNHdj5Ag@mail.gmail.com>
 <20201104003826.GB19460@kernel.org>
 <CAKwvOdnZSLP_YF3iFDLTHFE=ORxsrCR06s-B2Hk7khSxdC0+5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdnZSLP_YF3iFDLTHFE=ORxsrCR06s-B2Hk7khSxdC0+5A@mail.gmail.com>
X-SA-Exim-Connect-IP: 83.245.197.237
X-SA-Exim-Mail-From: jarkko.sakkinen@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 05:18:38PM -0800, Nick Desaulniers wrote:
> On Tue, Nov 3, 2020 at 4:38 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Tue, Nov 03, 2020 at 10:48:27AM -0800, Nick Desaulniers wrote:
> > > On Mon, Nov 2, 2020 at 8:55 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >
> > > > On Wed, Sep 02, 2020 at 03:59:05PM -0700, Nick Desaulniers wrote:
> > > > > +#define CLANG_VERSION (__clang_major__ * 10000       \
> > > > > +                  + __clang_minor__ * 100    \
> > > > > +                  + __clang_patchlevel__)
> > > > > +
> > > > > +#if CLANG_VERSION < 100001
> > > > > +# error Sorry, your version of Clang is too old - please use 10.0.1 or newer.
> > > > > +#endif
> > > >
> > > >
> > > > I'm trying to compile a BPF enabled test kernel for a live system and I
> > > > get this error even though I have much newer clang:
> > > >
> > > > ➜  ~ (master) ✔ clang --version
> > > > Ubuntu clang version 11.0.0-2
> > > > Target: x86_64-pc-linux-gnu
> > > > Thread model: posix
> > > > InstalledDir: /usr/bin
> > > >
> > > > Tried to Google for troubleshooter tips but this patch is basically the
> > > > only hit I get :-)
> > >
> > > To check the values of the above preprocessor defines, please run:
> > > $ clang -dM -E - < /dev/null | grep -e __clang_m -e __clang_p
> > >
> > > If you have multiple versions of clang installed, you might not be
> > > running the version you think you are.  Particularly, if you're using
> > > bcc, idk if it includes a copy of clang?  If that's the case, we may
> > > have to work out how we can support older versions of clang for the
> > > express purposes of bpf.
> >
> > ➜  ~ (master) ✔ clang -dM -E - < /dev/null | grep -e __clang_m -e __clang_p
> > #define __clang_major__ 11
> > #define __clang_minor__ 0
> > #define __clang_patchlevel__ 0
> >
> > I'm compiling the kernel itself with GCC.
> >
> > Here's an example BPF script that fails on me:
> >
> > struct sgx_enclave_add_pages {
> >         unsigned long src;
> >         unsigned long offset;
> >         unsigned long length;
> >         unsigned long secinfo;
> >         unsigned long flags;
> >         unsigned long count;
> > };
> >
> > kprobe:sgx_ioctl
> > {
> >         if (arg1 == 0xc030a401) {
> >                 printf("sgx_ioctl: %d, %lu\n", pid, ((struct sgx_enclave_add_pages *)(arg2))->offset);
> >         }
> >
> > }
> > Note that it relies on code not yet in the mainline.
> >
> > If I don't declare structs, things work just fine. E.g. the following
> > works:
> >
> > kprobe:sgx_encl_get_backing
> > {
> >         printf("%s\n", func)
> > }
> >
> > BTW, I don't really understand how scripts/clang-version.sh is even
> > supposed to work, if you compile the kernel itself with GCC. In that
> > case there would be no output, right? And thus version gets set to
> > zero...
> 
> That script is only used by KBUILD.  include/linux/compiler-clang.h is
> what's included into include/linux/compiler_types.h and causes the
> error.  The eBFP tools must be including kernel headers and defining
> `__clang__`.  Forgive my complete ignorance of eBPF, but how do you
> build that script?  I assume the tool is using Clang, since eBPF

Thanks a lot for helping with this :-)

I'm using bpftrace as the frontend.

> relies on the LLVM backend (not sure if the GCC eBPF backend is good
> to go quite yet), and that version of clang is older.
> 
> I wonder if we should guard the version check with __BPF_TRACING__
> similar to arch/x86/include/asm/cpufeature.h? Care to test:


Before I received this response, I did git revert for this commit
and things started working again.

> ```
> diff --git a/include/linux/compiler-clang.h
> b/include/linux/compiler-clang.h
> index dd7233c48bf3..98cff1b4b088 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -8,8 +8,10 @@
>                      + __clang_patchlevel__)
> 
>  #if CLANG_VERSION < 100001
> +#ifndef __BPF_TRACING__
>  # error Sorry, your version of Clang is too old - please use 10.0.1 or newer.
>  #endif
> +#endif
> 
>  /* Compiler specific definitions for Clang compiler */
> ```
> -- 

Shouldn't "#ifndef" be before the whole version check? Otherwise,
LGTM. Please CC me once there is a properly formed patch to try out.

> Thanks,
> ~Nick Desaulniers

/Jarkko
