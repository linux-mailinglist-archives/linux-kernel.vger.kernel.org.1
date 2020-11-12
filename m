Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D89E2B0BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgKLSAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:00:24 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52774 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgKLSAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:00:14 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by linux.microsoft.com (Postfix) with ESMTPSA id D0BE120C287D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:00:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D0BE120C287D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605204012;
        bh=rWOh7GylTqiAkTDgEMzJCdlRF0cb3PsMAOZugOSpS1M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J3+gj81JSfp/rX8sqnQ/HshhbCMpmkpaOU9NXMWxdPAxiEdVr1lqF+5zAtCgPp7us
         m98v+Efc4HgGOTFMtzbURwLcoPDsAfnx4wiEubzGf6k9gpF+GZgbWtw8TBI7PBPjdm
         cYcDVHM9w0aHEa1mAylu1zSnfEOOzGxF3HiL2EbM=
Received: by mail-qv1-f45.google.com with SMTP id 63so3198849qva.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:00:12 -0800 (PST)
X-Gm-Message-State: AOAM532GUzfoVDkwEX1MWycD8942Tj+Qt5S4V+CT7mQN4j1uLz5A2Amq
        qUsHrZU0j5E2lw/A+8TJAWSiJTibezXhKOzxuak=
X-Google-Smtp-Source: ABdhPJwRbXkuEjeOv1DIoWIOKduAW/kWehPNWFoF6tP6LG3PD5GR+c3fEpeUyDxJhTnzzL4ytHNeTDNZb4cUvtEsQ4Q=
X-Received: by 2002:a0c:cb04:: with SMTP id o4mr953748qvk.15.1605204011871;
 Thu, 12 Nov 2020 10:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
 <20201112035023.974748-1-natechancellor@gmail.com> <CAFnufp2eEKW4tencrhUoYkY6C-eGB5xF_Fg5hms52zgJj68hJg@mail.gmail.com>
 <20201112174954.GA934563@ubuntu-m3-large-x86>
In-Reply-To: <20201112174954.GA934563@ubuntu-m3-large-x86>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Thu, 12 Nov 2020 18:59:36 +0100
X-Gmail-Original-Message-ID: <CAFnufp2edm5wkRtLzZf0XwL2xCKzJ7EgpZAKKg70QzZog_ND-Q@mail.gmail.com>
Message-ID: <CAFnufp2edm5wkRtLzZf0XwL2xCKzJ7EgpZAKKg70QzZog_ND-Q@mail.gmail.com>
Subject: Re: [PATCH] reboot: Fix variable assignments in type_store
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Mladek <pmladek@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 6:49 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi Matteo,
>
> On Thu, Nov 12, 2020 at 12:26:45PM +0100, Matteo Croce wrote:
> > On Thu, Nov 12, 2020 at 4:50 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns:
> > >
> > > kernel/reboot.c:707:17: warning: implicit conversion from enumeration
> > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > [-Wenum-conversion]
> > >                 reboot_mode = BOOT_TRIPLE;
> > >                             ~ ^~~~~~~~~~~
> > > kernel/reboot.c:709:17: warning: implicit conversion from enumeration
> > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > [-Wenum-conversion]
> > >                 reboot_mode = BOOT_KBD;
> > >                             ~ ^~~~~~~~
> > > kernel/reboot.c:711:17: warning: implicit conversion from enumeration
> > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > [-Wenum-conversion]
> > >                 reboot_mode = BOOT_BIOS;
> > >                             ~ ^~~~~~~~~
> > > kernel/reboot.c:713:17: warning: implicit conversion from enumeration
> > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > [-Wenum-conversion]
> > >                 reboot_mode = BOOT_ACPI;
> > >                             ~ ^~~~~~~~~
> > > kernel/reboot.c:715:17: warning: implicit conversion from enumeration
> > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > [-Wenum-conversion]
> > >                 reboot_mode = BOOT_EFI;
> > >                             ~ ^~~~~~~~
> > > kernel/reboot.c:717:17: warning: implicit conversion from enumeration
> > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > [-Wenum-conversion]
> > >                 reboot_mode = BOOT_CF9_FORCE;
> > >                             ~ ^~~~~~~~~~~~~~
> > > kernel/reboot.c:719:17: warning: implicit conversion from enumeration
> > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > [-Wenum-conversion]
> > >                 reboot_mode = BOOT_CF9_SAFE;
> > >                             ~ ^~~~~~~~~~~~~
> > > 7 warnings generated.
> > >
> > > It seems that these assignment should be to reboot_type, not
> > > reboot_mode. Fix it so there are no more warnings and the code works
> > > properly.
> > >
> > > Fixes: eab8da48579d ("reboot: allow to specify reboot mode via sysfs")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1197
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  kernel/reboot.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > > index deba133a071b..8599d0d44aec 100644
> > > --- a/kernel/reboot.c
> > > +++ b/kernel/reboot.c
> > > @@ -704,19 +704,19 @@ static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
> > >                 return -EPERM;
> > >
> > >         if (!strncmp(buf, BOOT_TRIPLE_STR, strlen(BOOT_TRIPLE_STR)))
> > > -               reboot_mode = BOOT_TRIPLE;
> > > +               reboot_type = BOOT_TRIPLE;
> > >         else if (!strncmp(buf, BOOT_KBD_STR, strlen(BOOT_KBD_STR)))
> > > -               reboot_mode = BOOT_KBD;
> > > +               reboot_type = BOOT_KBD;
> > >         else if (!strncmp(buf, BOOT_BIOS_STR, strlen(BOOT_BIOS_STR)))
> > > -               reboot_mode = BOOT_BIOS;
> > > +               reboot_type = BOOT_BIOS;
> > >         else if (!strncmp(buf, BOOT_ACPI_STR, strlen(BOOT_ACPI_STR)))
> > > -               reboot_mode = BOOT_ACPI;
> > > +               reboot_type = BOOT_ACPI;
> > >         else if (!strncmp(buf, BOOT_EFI_STR, strlen(BOOT_EFI_STR)))
> > > -               reboot_mode = BOOT_EFI;
> > > +               reboot_type = BOOT_EFI;
> > >         else if (!strncmp(buf, BOOT_CF9_FORCE_STR, strlen(BOOT_CF9_FORCE_STR)))
> > > -               reboot_mode = BOOT_CF9_FORCE;
> > > +               reboot_type = BOOT_CF9_FORCE;
> > >         else if (!strncmp(buf, BOOT_CF9_SAFE_STR, strlen(BOOT_CF9_SAFE_STR)))
> > > -               reboot_mode = BOOT_CF9_SAFE;
> > > +               reboot_type = BOOT_CF9_SAFE;
> > >         else
> > >                 return -EINVAL;
> > >
> > >
> > > base-commit: 3e14f70c05cda4794901ed8f976de3a88deebcc0
> > > --
> > > 2.29.2
> > >
> >
> > Hmm, this was introduced in v3 I think.
> >
> > I wonder why my compiler doesn't warn about it, the two variables are
> > defined as different enum type.
> > I get the same warnings with GCC and -Wenum-conversion.
>
> What version of GCC do you have? -Wenum-conversion is a fairly new
> warning in GCC I think. Although if you get it now, maybe it was some
> configuration error?
>

Hi,

the one shipped in Fedora 33:
gcc version 10.2.1 20201016 (Red Hat 10.2.1-6) (GCC)

I enabled -Wenum-compare -Wenum-conversion globally in the root
Makefile and I had only 15 warnings for an 'allyesconfig' x86_64
build.

Maybe it's worth fixing them and enable the warning, it's very useful.

Thanks,
-- 
per aspera ad upstream
