Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798152B1364
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgKMAmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:42:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47212 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKMAmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:42:09 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by linux.microsoft.com (Postfix) with ESMTPSA id 039BF20C288A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:42:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 039BF20C288A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605228129;
        bh=BLyq9e6WMsX58xvPzqQvR0qZa+PPwQVF0bTZmr9IcaE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jB9OEBKJWqCg0GF5/+v9yBMLJ2hRPDmeBNIuKyPWufGd2V2eu/vh2ANhECGRfffUs
         0hxwbkF/XQinH8TOveTkOIqp2Rj+H3as0tq4mW5w4sptyKFBjOkwlx5QwW5URBWTAG
         PK+eM18HYP07srrTOIkV5m5BjpXwlsBXCXV/CT70=
Received: by mail-qv1-f45.google.com with SMTP id q7so3810392qvt.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:42:08 -0800 (PST)
X-Gm-Message-State: AOAM530XsjOxYfdCDk3JRVEgny39rayOCWmGLPWjacur/axw9MbPJA9J
        vd04+GR7nBjgyf7SJFcAyqem5T1zEy1jkHahEFE=
X-Google-Smtp-Source: ABdhPJyvI4d/OmkAu+DV6lR+lj5GKnAHcl69TO0Kq5Xo7zV6O9OVusUDvNKAB/BF+9VAZQpu0SLcuKhEIfD7Pemh8GY=
X-Received: by 2002:a0c:cb04:: with SMTP id o4mr2565193qvk.15.1605228128037;
 Thu, 12 Nov 2020 16:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
 <20201112035023.974748-1-natechancellor@gmail.com> <20201112151320.e0153ace2f2eb5b59eabbdcb@linux-foundation.org>
 <CAFnufp1j6ZzxLJA2x28BdxbTtnN_KtnXB49ibPcbze=B2ru3aA@mail.gmail.com>
In-Reply-To: <CAFnufp1j6ZzxLJA2x28BdxbTtnN_KtnXB49ibPcbze=B2ru3aA@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 13 Nov 2020 01:41:32 +0100
X-Gmail-Original-Message-ID: <CAFnufp00cGHi708s=6UG6H_HkM5-7_nX8SJ8=RVvgXKaai=LZA@mail.gmail.com>
Message-ID: <CAFnufp00cGHi708s=6UG6H_HkM5-7_nX8SJ8=RVvgXKaai=LZA@mail.gmail.com>
Subject: Re: [PATCH] reboot: Fix variable assignments in type_store
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
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

On Fri, Nov 13, 2020 at 1:20 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> On Fri, Nov 13, 2020 at 12:13 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 11 Nov 2020 20:50:23 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > > Clang warns:
> > >
> > > kernel/reboot.c:707:17: warning: implicit conversion from enumeration
> > > type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> > > [-Wenum-conversion]
> > >                 reboot_mode = BOOT_TRIPLE;
> > >                             ~ ^~~~~~~~~~~
> > >
> > > ...
> > >
> > > --- a/kernel/reboot.c
> > > +++ b/kernel/reboot.c
> > > @@ -704,19 +704,19 @@ static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
> > >               return -EPERM;
> > >
> > >       if (!strncmp(buf, BOOT_TRIPLE_STR, strlen(BOOT_TRIPLE_STR)))
> > > -             reboot_mode = BOOT_TRIPLE;
> > > +             reboot_type = BOOT_TRIPLE;
> > >       else if (!strncmp(buf, BOOT_KBD_STR, strlen(BOOT_KBD_STR)))
> > > -             reboot_mode = BOOT_KBD;
> > > +             reboot_type = BOOT_KBD;
> > >       else if (!strncmp(buf, BOOT_BIOS_STR, strlen(BOOT_BIOS_STR)))
> > > -             reboot_mode = BOOT_BIOS;
> > > +             reboot_type = BOOT_BIOS;
> > >       else if (!strncmp(buf, BOOT_ACPI_STR, strlen(BOOT_ACPI_STR)))
> > > -             reboot_mode = BOOT_ACPI;
> > > +             reboot_type = BOOT_ACPI;
> > >       else if (!strncmp(buf, BOOT_EFI_STR, strlen(BOOT_EFI_STR)))
> > > -             reboot_mode = BOOT_EFI;
> > > +             reboot_type = BOOT_EFI;
> > >       else if (!strncmp(buf, BOOT_CF9_FORCE_STR, strlen(BOOT_CF9_FORCE_STR)))
> > > -             reboot_mode = BOOT_CF9_FORCE;
> > > +             reboot_type = BOOT_CF9_FORCE;
> > >       else if (!strncmp(buf, BOOT_CF9_SAFE_STR, strlen(BOOT_CF9_SAFE_STR)))
> > > -             reboot_mode = BOOT_CF9_SAFE;
> > > +             reboot_type = BOOT_CF9_SAFE;
> > >       else
> > >               return -EINVAL;
> >
> > This is a fairly dramatic change to the original patch, but it eyeballs
> > OK.
> >
> > Matteo, could you please comment?  And preferably retest?
> >
>
> Hi,
>
> I reviewed the patch and it looks good to me.
> I tested it with this script which passes now with Nathan's fix:
>
> for i in cold warm hard soft gpio; do
>     echo $i > mode
>     read j <mode
>     [ $i = $j ] || echo "mode $i = $j"
> done
>
> for i in bios acpi kbd triple efi cf9_force cf9_safe; do
>     echo $i > type
>     read j <type
>     [ $i = $j ] || echo "type $i = $j"
> done
>
> for i in $(seq 0 $(nproc --ignore=1)); do
>     echo $i > cpu
>     read j <cpu
>     [ $i = $j ] || echo "cpu $i = $j"
> done
>
> for i in 0 1; do
>     echo $i >force
>     read j <force
>     [ $i = $j ] || echo "force $i = $j"
> done
>
> While writing the script I found that in the documentation I left for
> 'type' the values from
> Documentation/admin-guide/kernel-parameters.txt, which is 'pci' for
> cf9_force reboot.
> While at it, should we update the doc with the values 'cf9_force' and
> 'cf9_safe', or rename to 'pci' and 'pci_safe' to be coherent with the
> kernel cmdline?
>
> In any case, kernel-parameters.txt doesn't mention that reboot=q does
> the 'cf9_safe' reboot type, so it must be fixed anyway.
>
> Regards,
> --
> per aspera ad upstream

Reviewed-and-tested-by: Matteo Croce <mcroce@microsoft.com>

-- 
per aspera ad upstream
