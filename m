Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8E22B03D4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgKLL1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:27:24 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57906 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbgKLL1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:27:24 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by linux.microsoft.com (Postfix) with ESMTPSA id AF83420C2869
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:27:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF83420C2869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605180442;
        bh=D5SYwO2ZAcQz2Tle24Zn5+RCmFa/75pAMkftOjCKMLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iFx83yH2IO2Mjl+sqTcRTKSIuoP27TT/vmTXaH1DWNhDiwz/8NI4zQ1LKHGcl9a+c
         LT1bnnRIg5CYiVSIl5ajrMbjhz6pzUa9St8uePEuUbs0TszSaWfT5kLWrigmVR0DMS
         IUE4IDz52fuTmKdFHi2Ly7KHLZgk+BohnawS873w=
Received: by mail-qk1-f176.google.com with SMTP id h15so4816144qkl.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:27:22 -0800 (PST)
X-Gm-Message-State: AOAM532HmBy/DlorcZPkU2KaTRuH1hwgvCLFsnRzaGLdK6C1d7q48MnV
        c/pqjXN1n1Wmq0Qpnefmx+NS1cf6MjmiuNJE71o=
X-Google-Smtp-Source: ABdhPJxezw2p2gsgOq6oLhpoYQtFBoKWM+F5j0IdHmjLbf/2ViY/u3IfA/8bXwj3aG66CjOIJN6GMhA8mVcf6fmfJsI=
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr31446371qkf.436.1605180441516;
 Thu, 12 Nov 2020 03:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20201110202746.9690-1-mcroce@linux.microsoft.com> <20201112035023.974748-1-natechancellor@gmail.com>
In-Reply-To: <20201112035023.974748-1-natechancellor@gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Thu, 12 Nov 2020 12:26:45 +0100
X-Gmail-Original-Message-ID: <CAFnufp2eEKW4tencrhUoYkY6C-eGB5xF_Fg5hms52zgJj68hJg@mail.gmail.com>
Message-ID: <CAFnufp2eEKW4tencrhUoYkY6C-eGB5xF_Fg5hms52zgJj68hJg@mail.gmail.com>
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
        ndesaulniers@google.com, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 4:50 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> kernel/reboot.c:707:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_TRIPLE;
>                             ~ ^~~~~~~~~~~
> kernel/reboot.c:709:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_KBD;
>                             ~ ^~~~~~~~
> kernel/reboot.c:711:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_BIOS;
>                             ~ ^~~~~~~~~
> kernel/reboot.c:713:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_ACPI;
>                             ~ ^~~~~~~~~
> kernel/reboot.c:715:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_EFI;
>                             ~ ^~~~~~~~
> kernel/reboot.c:717:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_CF9_FORCE;
>                             ~ ^~~~~~~~~~~~~~
> kernel/reboot.c:719:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_CF9_SAFE;
>                             ~ ^~~~~~~~~~~~~
> 7 warnings generated.
>
> It seems that these assignment should be to reboot_type, not
> reboot_mode. Fix it so there are no more warnings and the code works
> properly.
>
> Fixes: eab8da48579d ("reboot: allow to specify reboot mode via sysfs")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1197
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  kernel/reboot.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index deba133a071b..8599d0d44aec 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -704,19 +704,19 @@ static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
>                 return -EPERM;
>
>         if (!strncmp(buf, BOOT_TRIPLE_STR, strlen(BOOT_TRIPLE_STR)))
> -               reboot_mode = BOOT_TRIPLE;
> +               reboot_type = BOOT_TRIPLE;
>         else if (!strncmp(buf, BOOT_KBD_STR, strlen(BOOT_KBD_STR)))
> -               reboot_mode = BOOT_KBD;
> +               reboot_type = BOOT_KBD;
>         else if (!strncmp(buf, BOOT_BIOS_STR, strlen(BOOT_BIOS_STR)))
> -               reboot_mode = BOOT_BIOS;
> +               reboot_type = BOOT_BIOS;
>         else if (!strncmp(buf, BOOT_ACPI_STR, strlen(BOOT_ACPI_STR)))
> -               reboot_mode = BOOT_ACPI;
> +               reboot_type = BOOT_ACPI;
>         else if (!strncmp(buf, BOOT_EFI_STR, strlen(BOOT_EFI_STR)))
> -               reboot_mode = BOOT_EFI;
> +               reboot_type = BOOT_EFI;
>         else if (!strncmp(buf, BOOT_CF9_FORCE_STR, strlen(BOOT_CF9_FORCE_STR)))
> -               reboot_mode = BOOT_CF9_FORCE;
> +               reboot_type = BOOT_CF9_FORCE;
>         else if (!strncmp(buf, BOOT_CF9_SAFE_STR, strlen(BOOT_CF9_SAFE_STR)))
> -               reboot_mode = BOOT_CF9_SAFE;
> +               reboot_type = BOOT_CF9_SAFE;
>         else
>                 return -EINVAL;
>
>
> base-commit: 3e14f70c05cda4794901ed8f976de3a88deebcc0
> --
> 2.29.2
>

Hmm, this was introduced in v3 I think.

I wonder why my compiler doesn't warn about it, the two variables are
defined as different enum type.
I get the same warnings with GCC and -Wenum-conversion.

Thanks,
--
per aspera ad upstream
