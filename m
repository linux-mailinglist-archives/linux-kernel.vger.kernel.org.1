Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1240B2B0B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKLRt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgKLRt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:49:58 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04444C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 09:49:58 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id v11so4557255qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 09:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DOzovp/JPeex+MvYDmhccU6DaC2VE2y5zyRUd+90Qqg=;
        b=Xvx/OrnRUwTbZ2bBjnp9wQqquuufc8TZO/dgNdP81xpFW8FRSEsPkpSavZI95DcAOC
         zVvSKbvqlZFHpfpTV/iG788zfOquLq5dI0GJcMoWrZYoqzlUUielYUz0i1N1MX0Jfoc3
         zzV2GIyI+BSZzhUndj/lzwODTE0jrQRg0QWahTEbfDmiIMvcUS3uXeIYztDyAuI7CgHU
         QYENGgkGY7z8QymFfEG4NCF26yvCeDEIlcnQ5AJYptJTcY3GoP1ncbQMoaxWzs/jhd9E
         ubDxmjxTXlYoGjFL1u8pJtipF/r69KXGkFF7/kL8NnycUvuOrPpKs2mV3dR46SoWyqkh
         0fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DOzovp/JPeex+MvYDmhccU6DaC2VE2y5zyRUd+90Qqg=;
        b=hzto0r1VXeLKRgslhZK7naPBzJhVdVL0tDvkKmZhMYE5k1YDDICIOPHcR85mPKuh+v
         OKxLjtw56wPjZleW2J0kaRCYcpWrl4t/GJ/9yxpZ4SOXUSaV0J9X/13rJDY1YeknxMUf
         5xovePN0QK2BKi9mwKDbfgZ4Nj5dxPTW/1GTLCuUKfuFF6TZ0hxnui+V5RjB7Nym630m
         SSqUT77Q0yiUrp/GgbMTBNqqTcGFaIN/+NlGpdT7HDqPwwxIuiBAakxYX01oyqYNMmXO
         Jses1+lGSuagTl0fJiZQn5YJdKhyrrCFnHDHbir6ruu6rmFRbldWgv/y2TBpIYgiCKyF
         jemA==
X-Gm-Message-State: AOAM532lKH4WIvvPNDUhh5vydPO4p3WhMtgGEPMZ+a006K8TcJ9NAhhe
        HKnXda6snr2hVMQUskt76JQ=
X-Google-Smtp-Source: ABdhPJx1E8pGOMClqAKza+b10Id2CumoKmYCNyubMYXFsLshzNWSD38f9UuPzBsTw7QoKhDnU6z3Fw==
X-Received: by 2002:aed:22c5:: with SMTP id q5mr315410qtc.234.1605203396999;
        Thu, 12 Nov 2020 09:49:56 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id l79sm5421245qke.1.2020.11.12.09.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 09:49:56 -0800 (PST)
Date:   Thu, 12 Nov 2020 10:49:54 -0700
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
        ndesaulniers@google.com, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] reboot: Fix variable assignments in type_store
Message-ID: <20201112174954.GA934563@ubuntu-m3-large-x86>
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
 <20201112035023.974748-1-natechancellor@gmail.com>
 <CAFnufp2eEKW4tencrhUoYkY6C-eGB5xF_Fg5hms52zgJj68hJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp2eEKW4tencrhUoYkY6C-eGB5xF_Fg5hms52zgJj68hJg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matteo,

On Thu, Nov 12, 2020 at 12:26:45PM +0100, Matteo Croce wrote:
> On Thu, Nov 12, 2020 at 4:50 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > kernel/reboot.c:707:17: warning: implicit conversion from enumeration
> > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > [-Wenum-conversion]
> >                 reboot_mode = BOOT_TRIPLE;
> >                             ~ ^~~~~~~~~~~
> > kernel/reboot.c:709:17: warning: implicit conversion from enumeration
> > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > [-Wenum-conversion]
> >                 reboot_mode = BOOT_KBD;
> >                             ~ ^~~~~~~~
> > kernel/reboot.c:711:17: warning: implicit conversion from enumeration
> > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > [-Wenum-conversion]
> >                 reboot_mode = BOOT_BIOS;
> >                             ~ ^~~~~~~~~
> > kernel/reboot.c:713:17: warning: implicit conversion from enumeration
> > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > [-Wenum-conversion]
> >                 reboot_mode = BOOT_ACPI;
> >                             ~ ^~~~~~~~~
> > kernel/reboot.c:715:17: warning: implicit conversion from enumeration
> > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > [-Wenum-conversion]
> >                 reboot_mode = BOOT_EFI;
> >                             ~ ^~~~~~~~
> > kernel/reboot.c:717:17: warning: implicit conversion from enumeration
> > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > [-Wenum-conversion]
> >                 reboot_mode = BOOT_CF9_FORCE;
> >                             ~ ^~~~~~~~~~~~~~
> > kernel/reboot.c:719:17: warning: implicit conversion from enumeration
> > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > [-Wenum-conversion]
> >                 reboot_mode = BOOT_CF9_SAFE;
> >                             ~ ^~~~~~~~~~~~~
> > 7 warnings generated.
> >
> > It seems that these assignment should be to reboot_type, not
> > reboot_mode. Fix it so there are no more warnings and the code works
> > properly.
> >
> > Fixes: eab8da48579d ("reboot: allow to specify reboot mode via sysfs")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1197
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  kernel/reboot.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index deba133a071b..8599d0d44aec 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -704,19 +704,19 @@ static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
> >                 return -EPERM;
> >
> >         if (!strncmp(buf, BOOT_TRIPLE_STR, strlen(BOOT_TRIPLE_STR)))
> > -               reboot_mode = BOOT_TRIPLE;
> > +               reboot_type = BOOT_TRIPLE;
> >         else if (!strncmp(buf, BOOT_KBD_STR, strlen(BOOT_KBD_STR)))
> > -               reboot_mode = BOOT_KBD;
> > +               reboot_type = BOOT_KBD;
> >         else if (!strncmp(buf, BOOT_BIOS_STR, strlen(BOOT_BIOS_STR)))
> > -               reboot_mode = BOOT_BIOS;
> > +               reboot_type = BOOT_BIOS;
> >         else if (!strncmp(buf, BOOT_ACPI_STR, strlen(BOOT_ACPI_STR)))
> > -               reboot_mode = BOOT_ACPI;
> > +               reboot_type = BOOT_ACPI;
> >         else if (!strncmp(buf, BOOT_EFI_STR, strlen(BOOT_EFI_STR)))
> > -               reboot_mode = BOOT_EFI;
> > +               reboot_type = BOOT_EFI;
> >         else if (!strncmp(buf, BOOT_CF9_FORCE_STR, strlen(BOOT_CF9_FORCE_STR)))
> > -               reboot_mode = BOOT_CF9_FORCE;
> > +               reboot_type = BOOT_CF9_FORCE;
> >         else if (!strncmp(buf, BOOT_CF9_SAFE_STR, strlen(BOOT_CF9_SAFE_STR)))
> > -               reboot_mode = BOOT_CF9_SAFE;
> > +               reboot_type = BOOT_CF9_SAFE;
> >         else
> >                 return -EINVAL;
> >
> >
> > base-commit: 3e14f70c05cda4794901ed8f976de3a88deebcc0
> > --
> > 2.29.2
> >
> 
> Hmm, this was introduced in v3 I think.
> 
> I wonder why my compiler doesn't warn about it, the two variables are
> defined as different enum type.
> I get the same warnings with GCC and -Wenum-conversion.

What version of GCC do you have? -Wenum-conversion is a fairly new
warning in GCC I think. Although if you get it now, maybe it was some
configuration error?

Regardless, thank you for taking a look at the patch!

Cheers,
Nathan
