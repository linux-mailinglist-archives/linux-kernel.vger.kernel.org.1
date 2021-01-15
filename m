Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17BA2F85BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbhAOTu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbhAOTu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:50:56 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34F7C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:50:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id v24so8227880lfr.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PnPuJYU4PXQYlGf79G8ijZzEVP+6toQVVVmd55UETSI=;
        b=XWKvrIeTxTf2RNy2JOHnXPqjTI8NmkQqS2QCk2n+lbqfoQXsmL1GCz5kcI9Pnzqx+y
         jz1lU1nz8wNWF1NyDPI8MIYbNQii0FEkon3Nsh2rS0hH1aAI+obFgELriU13/kjMUXJx
         6VBk1TQbUWPF5jFubPVTh6XylOc1/Y0bEBUStlS7tqVdIAZHxMFEZf89+VSJqqKGyJln
         tCQDjxaLArubOCUB+KeNNcysy1E238kCNIAorjzZIwewxfo1BP9euUxkCuCotT69mX+H
         0uZPyOHbu0HQbl5+VwquLIUzkawRHK2scvg6SPU0rD1txsfjZ7zgO6wDClU1KtzC1srL
         bYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PnPuJYU4PXQYlGf79G8ijZzEVP+6toQVVVmd55UETSI=;
        b=rI9z8VPPFW2PCbK9eZewJRD3pSrOgXEOcxqZBWe7iaJukXR97kcGQujwJ7hW1DNvF+
         PPZKu+iYnDkRh2PTVd0E9NV6tr129Gazxpn67nji3PN4vouKJI5+UzADDOWFz/k78wqs
         FojX+Gw48b6qjU5h5R3ujPGe8IDXR9QzUImCK+DxWqz8PVhwX0Mi8VbJb5MhywW5Es+a
         XP/Y3y2LZYghuhK6bzKipZFjDJHvQiVaahbAzQBdJ3qKWD+BVlsFSrS+6QPzs1tuxuqk
         q2d4d9UJMGybSA7vfawT6N8XxPXKFRTamukhD6lPuEo0fSkCi87+wZqtokIIc5a5lvCa
         +F3A==
X-Gm-Message-State: AOAM532BKja8/Peu8fEHeYQN0mWvGBSiDEgl9V50PTnw0e+yof26ExAS
        ZzOCEi+81iNC1LZKJvQVfDjkVKGbyrqCrKAkZI/rXw==
X-Google-Smtp-Source: ABdhPJyAmyeGQCTl2Rb5Caxq7H62OwJPz/0bgHn6Qu3gaYk1Ea8BtiAco2vxKUPVQUZod+RloWWJbDA2K3aLQEoAuic=
X-Received: by 2002:ac2:593a:: with SMTP id v26mr4310238lfi.591.1610740214143;
 Fri, 15 Jan 2021 11:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20210114211840.GA5617@linux-8ccs> <20210114215416.993167-1-maskray@google.com>
 <CANpmjNOrD76O2_Zpwo5RJ2d12gczuQpG9bJkXYLY_sOVeEVZGQ@mail.gmail.com>
In-Reply-To: <CANpmjNOrD76O2_Zpwo5RJ2d12gczuQpG9bJkXYLY_sOVeEVZGQ@mail.gmail.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Fri, 15 Jan 2021 11:50:02 -0800
Message-ID: <CAFP8O3Jv23Vztn0puyXVDtpqAN9sHKd6PdHGUdzA5q7v-dmp4w@mail.gmail.com>
Subject: Re: [PATCH v2] module: Ignore _GLOBAL_OFFSET_TABLE_ when warning for
 undefined symbols
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 11:04 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, 14 Jan 2021 at 22:54, Fangrui Song <maskray@google.com> wrote:
> > clang-12 -fno-pic (since
> > https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083=
333232da3f1d6)
> > can emit `call __stack_chk_fail@PLT` instead of `call __stack_chk_fail`
> > on x86.  The two forms should have identical behaviors on x86-64 but th=
e
> > former causes GNU as<2.37 to produce an unreferenced undefined symbol
> > _GLOBAL_OFFSET_TABLE_.
> >
> > (On x86-32, there is an R_386_PC32 vs R_386_PLT32 difference but the
> > linker behavior is identical as far as Linux kernel is concerned.)
> >
> > Simply ignore _GLOBAL_OFFSET_TABLE_ for now, like what
> > scripts/mod/modpost.c:ignore_undef_symbol does. This also fixes the
> > problem for gcc/clang -fpie and -fpic, which may emit `call foo@PLT` fo=
r
> > external function calls on x86.
> >
> > Note: ld -z defs and dynamic loaders do not error for unreferenced
> > undefined symbols so the module loader is reading too much.  If we ever
> > need to ignore more symbols, the code should be refactored to ignore
> > unreferenced symbols.
> >
> > Reported-by: Marco Elver <elver@google.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1250
> > Signed-off-by: Fangrui Song <maskray@google.com>
>
> Tested-by: Marco Elver <elver@google.com>
>
> Thank you for the patch!
>
> > ---
> >  kernel/module.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > ---
> > Changes in v2:
> > * Fix Marco's email address
> > * Add a function ignore_undef_symbol similar to scripts/mod/modpost.c:i=
gnore_undef_symbol
> >
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 4bf30e4b3eaa..278f5129bde2 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -2348,6 +2348,20 @@ static int verify_exported_symbols(struct module=
 *mod)
> >         return 0;
> >  }
> >
> > +static int ignore_undef_symbol(Elf_Half emachine, const char *name)
>
> Why not 'bool' return-type?

Will use bool and false in v3.

> > +{
> > +       /* On x86, PIC code and Clang non-PIC code may have call foo@PL=
T. GNU as
>
> Not sure if checkpatch.pl warns about this, but this multi-line
> comment does not follow the normal kernel-style (see elsewhere in
> file):

It doesn't warn about this. (The commit description warning cannot be
fixed, even if I place the closing paren on the next line.)

% ./scripts/checkpatch.pl
v2-0001-module-Ignore-_GLOBAL_OFFSET_TABLE_-when-warning-.patch
WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#8:
https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de00833332=
32da3f1d6)

total: 0 errors, 1 warnings, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

v2-0001-module-Ignore-_GLOBAL_OFFSET_TABLE_-when-warning-.patch has
style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

> /*
>  * ...
>  */
>
> > +        * before 2.37 produces an unreferenced _GLOBAL_OFFSET_TABLE_ o=
n x86-64.
> > +        * i386 has a similar problem but may not deserve a fix.
> > +        *
> > +        * If we ever have to ignore many symbols, consider refactoring=
 the code to
> > +        * only warn if referenced by a relocation.
> > +        */
> > +       if (emachine =3D=3D EM_386 || emachine =3D=3D EM_X86_64)
> > +               return !strcmp(name, "_GLOBAL_OFFSET_TABLE_");
> > +       return 0;
> > +}
> > +
> >  /* Change all symbols so that st_value encodes the pointer directly. *=
/
> >  static int simplify_symbols(struct module *mod, const struct load_info=
 *info)
> >  {
> > @@ -2395,8 +2409,10 @@ static int simplify_symbols(struct module *mod, =
const struct load_info *info)
> >                                 break;
> >                         }
> >
> > -                       /* Ok if weak.  */
> > -                       if (!ksym && ELF_ST_BIND(sym[i].st_info) =3D=3D=
 STB_WEAK)
> > +                       /* Ok if weak or ignored.  */
> > +                       if (!ksym &&
> > +                           (ELF_ST_BIND(sym[i].st_info) =3D=3D STB_WEA=
K ||
> > +                            ignore_undef_symbol(info->hdr->e_machine, =
name)))
> >                                 break;
> >
> >                         ret =3D PTR_ERR(ksym) ?: -ENOENT;
> > --
> > 2.30.0.296.g2bfb1c46d8-goog
> >



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
