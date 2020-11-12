Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602842B0C52
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgKLSJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgKLSJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:09:06 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633C7C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:09:06 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q5so6123590qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O8w5eL8a+QV57B/jVWr5Nut2fi1R7VtNR2kkAi+fZ/k=;
        b=A2xuNt+PZ2/q9wCKnWnpZmTababpY4oUwOLeq5eBsSx5YPhK5h2ojepw15P6dlRRjM
         q+JmUPF6fe7vVNLzEO0xFwC5a32ObpFV2wzOVpdejQEhGoYFep2urisgH5e6+jWs03Mw
         VYjDFH80VpBAPTb4yqI2MtOoGb/vJ8LLoSwXP/CxBRoeZVhPoEur4dkWTk/lsD8e5NWw
         Xww/m1nhCnEXw70EsDJbypHtMeOo4TL5wmVaueIw3XmWZe+MyZO1qwCOp56SWr/CJaTx
         7yiMpMD8scQigVptr0nfOrWI4lh26CyB4Vs1EmL9qhVFADfD3lwhUUG/7/zxkTLFvMjr
         itUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O8w5eL8a+QV57B/jVWr5Nut2fi1R7VtNR2kkAi+fZ/k=;
        b=EtSSLieyDMiy/URke6F3yOqbWoy9BQGvmgNgT02tSmDIQCjUL2+JhRBl7F9pbqc76s
         C/OpdcciLacleveaIpBzzswZWu1KnKS7aozx/+mFaiDe+F8mycVByCVmco3tWN99h9O9
         APo1lfrkXzcQSgagCOJBXrvwuKnEO1MyC3XgPC9wSHCtj9EVf8nBk8dBpYJxwMrzWjSe
         fUsukSdjYdnoMOhYM/zK4t+1jCm5ObglgXgPy8QrYftOS2BUlXl6R3aguyxwxfVrbA+2
         mtTrRwqzyb/bRvCUxpvIV5AEeode3VsWK58CPVP+o5LgtPWsiCd2yX1X57GLlrHd9YUs
         imqg==
X-Gm-Message-State: AOAM530HmjNhvLRWBFiwqLIy0aaI4pKMS1TaT+Ai2IDqv7uzk9GExESI
        trZy/t4AZ3lG2T9uzMJe++k=
X-Google-Smtp-Source: ABdhPJzgKolcXeACmXSdi+QCWhu/UoAj5oNdpvJi3wMmTOhi6W19HOzcJpGTKPaCDT4+X53AcDU3GA==
X-Received: by 2002:a37:2f43:: with SMTP id v64mr1003475qkh.127.1605204545543;
        Thu, 12 Nov 2020 10:09:05 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id e186sm5122506qkd.117.2020.11.12.10.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 10:09:04 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:09:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
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
Subject: Re: [PATCH] reboot: Fix variable assignments in type_store
Message-ID: <20201112180903.GA935117@ubuntu-m3-large-x86>
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
 <20201112035023.974748-1-natechancellor@gmail.com>
 <CAFnufp2eEKW4tencrhUoYkY6C-eGB5xF_Fg5hms52zgJj68hJg@mail.gmail.com>
 <20201112174954.GA934563@ubuntu-m3-large-x86>
 <CAFnufp2edm5wkRtLzZf0XwL2xCKzJ7EgpZAKKg70QzZog_ND-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp2edm5wkRtLzZf0XwL2xCKzJ7EgpZAKKg70QzZog_ND-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 06:59:36PM +0100, Matteo Croce wrote:
> On Thu, Nov 12, 2020 at 6:49 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Hi Matteo,
> >
> > On Thu, Nov 12, 2020 at 12:26:45PM +0100, Matteo Croce wrote:
> > > On Thu, Nov 12, 2020 at 4:50 AM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > Clang warns:
> > > >
> > > > kernel/reboot.c:707:17: warning: implicit conversion from enumeration
> > > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > > [-Wenum-conversion]
> > > >                 reboot_mode = BOOT_TRIPLE;
> > > >                             ~ ^~~~~~~~~~~
> > > > kernel/reboot.c:709:17: warning: implicit conversion from enumeration
> > > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > > [-Wenum-conversion]
> > > >                 reboot_mode = BOOT_KBD;
> > > >                             ~ ^~~~~~~~
> > > > kernel/reboot.c:711:17: warning: implicit conversion from enumeration
> > > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > > [-Wenum-conversion]
> > > >                 reboot_mode = BOOT_BIOS;
> > > >                             ~ ^~~~~~~~~
> > > > kernel/reboot.c:713:17: warning: implicit conversion from enumeration
> > > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > > [-Wenum-conversion]
> > > >                 reboot_mode = BOOT_ACPI;
> > > >                             ~ ^~~~~~~~~
> > > > kernel/reboot.c:715:17: warning: implicit conversion from enumeration
> > > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > > [-Wenum-conversion]
> > > >                 reboot_mode = BOOT_EFI;
> > > >                             ~ ^~~~~~~~
> > > > kernel/reboot.c:717:17: warning: implicit conversion from enumeration
> > > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > > [-Wenum-conversion]
> > > >                 reboot_mode = BOOT_CF9_FORCE;
> > > >                             ~ ^~~~~~~~~~~~~~
> > > > kernel/reboot.c:719:17: warning: implicit conversion from enumeration
> > > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > > [-Wenum-conversion]
> > > >                 reboot_mode = BOOT_CF9_SAFE;
> > > >                             ~ ^~~~~~~~~~~~~
> > > > 7 warnings generated.
> > > >
> > > > It seems that these assignment should be to reboot_type, not
> > > > reboot_mode. Fix it so there are no more warnings and the code works
> > > > properly.
> > > >
> > > > Fixes: eab8da48579d ("reboot: allow to specify reboot mode via sysfs")
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/1197
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  kernel/reboot.c | 14 +++++++-------
> > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > > > index deba133a071b..8599d0d44aec 100644
> > > > --- a/kernel/reboot.c
> > > > +++ b/kernel/reboot.c
> > > > @@ -704,19 +704,19 @@ static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
> > > >                 return -EPERM;
> > > >
> > > >         if (!strncmp(buf, BOOT_TRIPLE_STR, strlen(BOOT_TRIPLE_STR)))
> > > > -               reboot_mode = BOOT_TRIPLE;
> > > > +               reboot_type = BOOT_TRIPLE;
> > > >         else if (!strncmp(buf, BOOT_KBD_STR, strlen(BOOT_KBD_STR)))
> > > > -               reboot_mode = BOOT_KBD;
> > > > +               reboot_type = BOOT_KBD;
> > > >         else if (!strncmp(buf, BOOT_BIOS_STR, strlen(BOOT_BIOS_STR)))
> > > > -               reboot_mode = BOOT_BIOS;
> > > > +               reboot_type = BOOT_BIOS;
> > > >         else if (!strncmp(buf, BOOT_ACPI_STR, strlen(BOOT_ACPI_STR)))
> > > > -               reboot_mode = BOOT_ACPI;
> > > > +               reboot_type = BOOT_ACPI;
> > > >         else if (!strncmp(buf, BOOT_EFI_STR, strlen(BOOT_EFI_STR)))
> > > > -               reboot_mode = BOOT_EFI;
> > > > +               reboot_type = BOOT_EFI;
> > > >         else if (!strncmp(buf, BOOT_CF9_FORCE_STR, strlen(BOOT_CF9_FORCE_STR)))
> > > > -               reboot_mode = BOOT_CF9_FORCE;
> > > > +               reboot_type = BOOT_CF9_FORCE;
> > > >         else if (!strncmp(buf, BOOT_CF9_SAFE_STR, strlen(BOOT_CF9_SAFE_STR)))
> > > > -               reboot_mode = BOOT_CF9_SAFE;
> > > > +               reboot_type = BOOT_CF9_SAFE;
> > > >         else
> > > >                 return -EINVAL;
> > > >
> > > >
> > > > base-commit: 3e14f70c05cda4794901ed8f976de3a88deebcc0
> > > > --
> > > > 2.29.2
> > > >
> > >
> > > Hmm, this was introduced in v3 I think.
> > >
> > > I wonder why my compiler doesn't warn about it, the two variables are
> > > defined as different enum type.
> > > I get the same warnings with GCC and -Wenum-conversion.
> >
> > What version of GCC do you have? -Wenum-conversion is a fairly new
> > warning in GCC I think. Although if you get it now, maybe it was some
> > configuration error?
> >
> 
> Hi,
> 
> the one shipped in Fedora 33:
> gcc version 10.2.1 20201016 (Red Hat 10.2.1-6) (GCC)
> 
> I enabled -Wenum-compare -Wenum-conversion globally in the root
> Makefile and I had only 15 warnings for an 'allyesconfig' x86_64
> build.
> 
> Maybe it's worth fixing them and enable the warning, it's very useful.

Ahh, I thought that -Wenum-conversion was enabled with -Wall for GCC, it
appears to be enabled by -Wextra. I believe that Arnd has been tracking
down these instances with GCC and sending patches, I assume in hopes of
turning on the warning globally. I agree, the warning is definitely
helpful and clang has helped catch several bugs with it.

Cheers,
Nathan
