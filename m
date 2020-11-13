Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684E12B13A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgKMBFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgKMBFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:05:37 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F02BC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:05:21 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id e21so5705651pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIfDUcpgQLukCTUlGGpYpdoSftsRK2kFhecxA1sd1hE=;
        b=LIWg6Jh7ZjykDtBtTJRkWvN1BdZ7x+5a3bx6T2Zw/HSDC/Dj37410kaYS0/y0BdOkz
         NxfuKMbOrRtptDZ3gqqOpS9BNqTJwaTBCq7p1pOHH6XApsS6ccLN+EuNyGvc5tWB5t1y
         rDLz2Pn+3jAXvdZWPA5bcydT6qwVW+XLhKoAavSO9ggmmYf/+codktPVehDN2fEMW7xf
         GDYzT/HCZHaD3FlXHxnu1yFS6aJ2wBnnOHu6X5aViu/u0AtyBBTN4zPcJD5PCfY35cG0
         29sNCvqDoqT/aSqVYDVSU44awQ/EjDCiPAXPu98K/eCQKESmgW4GbZYpYxy8cNBe2maI
         cUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIfDUcpgQLukCTUlGGpYpdoSftsRK2kFhecxA1sd1hE=;
        b=IYcLkq9pS/LLMBI3A3pi2uqUmi161e9IKyIbtzcjW0STlupdpEDV5Rc2zLj66P/Gc+
         p8rQR/5p9V5s040G5w/tqUMZuSkr8l4rRFUM7FcDDP8Ghn+lHitTo1iONrTgFNYjmi/N
         yn7jBORDxlBkM3E9CvDlN2VvQJg2xZ97uBxVUconQDQnOHVMpVuHXzSnyJO5CasDM4IL
         roaQs7dgWzI/fM1fd84sYEestSDHTE+eN+geC9mlx3SEZKATByjaRU7+D+7UdI+pXoLP
         h2luln9V4Y3EZCv2ayhjIPDytBEQA9TJY9JNdYxr8G8QPPQjjHxdzAerLnBbFARiOEGI
         PQ7g==
X-Gm-Message-State: AOAM532PEhqRzNAN9qQQkmMfrKXIvtnQPwXsL6+VVsvH3wItpCiYZ6+O
        zv41/aPThXLk6IKgkQnLbor8Fk+VgjM+x/x9m5h5IQ==
X-Google-Smtp-Source: ABdhPJxM1CSF3iJAHsWSDZIUBVZD+m+amh+kNvHu5KEupiMMVlCxSbhfwFwIwYj6pQj7E9R6vWpTpqpMkRm0SY2C+cI=
X-Received: by 2002:a63:b55e:: with SMTP id u30mr17459pgo.381.1605229520588;
 Thu, 12 Nov 2020 17:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20201108203737.94270-1-natechancellor@gmail.com>
 <CAKwvOd=P2yFxkAXh9TUpJ=D5=jNnxnx7O5Nr3iTDeqV40UA19A@mail.gmail.com> <CAGG=3QVQTQsHhsb5cSEejZ=D4Gq60cz7kMfD8moXWeVU1odTdQ@mail.gmail.com>
In-Reply-To: <CAGG=3QVQTQsHhsb5cSEejZ=D4Gq60cz7kMfD8moXWeVU1odTdQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Nov 2020 17:05:09 -0800
Message-ID: <CAKwvOdm-weMaWyAK-O80aC+Y21TTeKKvgXe4kLoD2Fq1forYcQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Explicitly specify the build id style in vDSO
 Makefile again
To:     Bill Wendling <morbo@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 5:03 PM Bill Wendling <morbo@google.com> wrote:
>
> On Thu, Nov 12, 2020 at 4:53 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Sun, Nov 8, 2020 at 12:37 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Commit a96843372331 ("kbuild: explicitly specify the build id style")
> > > explicitly set the build ID style to SHA1. Commit c2c81bb2f691 ("RISC-V:
> > > Fix the VDSO symbol generaton for binutils-2.35+") undid this change,
> > > likely unintentionally.
> > >
> > > Restore it so that the build ID style stays consistent across the tree
> > > regardless of linker.
> > >
> > > Fixes: c2c81bb2f691 ("RISC-V: Fix the VDSO symbol generaton for binutils-2.35+")
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >
> > Thanks for the fixup!
> >
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > (I'm curious what --build-id linker flag does, and what kind of spooky
> > bugs that led to a96843372331?)
> >
> --build-id generates a unique "build id" for the build. It can use
> several different algorithms to do this. The BFD linker uses sha1 by
> default while LLD uses a "fast" algorithm. The difference is that the
> fast algorithm generates a shorter build id. This shouldn't matter in
> general, but there are some tools out there that expect the build id
> to be of a certain length, i.e. the BFD style's length, because BFD is
> more prevalent. The obvious response "well, why don't they just change
> the expected length?" is difficult in all situations. (Once an
> assumption is made, it's hard to backtrack.)
>
> You can add this if you like:
>
> Reviewed-by: Bill Wendling <morbo@google.com>

Cool, thanks for the context, and the review!

>
> > > ---
> > >  arch/riscv/kernel/vdso/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> > > index cb8f9e4cfcbf..0cfd6da784f8 100644
> > > --- a/arch/riscv/kernel/vdso/Makefile
> > > +++ b/arch/riscv/kernel/vdso/Makefile
> > > @@ -44,7 +44,7 @@ SYSCFLAGS_vdso.so.dbg = $(c_flags)
> > >  $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
> > >         $(call if_changed,vdsold)
> > >  SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
> > > -       -Wl,--build-id -Wl,--hash-style=both
> > > +       -Wl,--build-id=sha1 -Wl,--hash-style=both
> > >
> > >  # We also create a special relocatable object that should mirror the symbol
> > >  # table and layout of the linked DSO. With ld --just-symbols we can then
> > >
> > > base-commit: c2c81bb2f69138f902e1a58d3bef6ad97fb8a92c
> > > --
> > > 2.29.2
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20201108203737.94270-1-natechancellor%40gmail.com.
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
