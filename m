Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C352ABF5A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbgKIPEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:04:12 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48710 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731258AbgKIPEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:04:12 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1ECB920B36E7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 07:04:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1ECB920B36E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604934250;
        bh=vX7roJvyLMewrXaCQOBzjtDzAMsDxHdFlJhLaF54gq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sGRg+z9YQokHWI8OGEIU9C/puqqb6I3c16tvGOU89bmxd30hB5XZ4TZgb8JoT/aDb
         j5REkfQ6rom/QeQpIaRkZxbmgmxYSyR3XEykLHOtKdZ5K74CABYBUVLd/fnlr/O2WT
         vUk2UYevQDIN05oGdFFmmF2oOXMcUJe+oEmspTTo=
Received: by mail-qt1-f182.google.com with SMTP id 3so6145718qtx.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 07:04:10 -0800 (PST)
X-Gm-Message-State: AOAM530rQ7FFugbrXKhnc7asPhUsBqGZqY67t+BIDAuPPrb8Y//wdEwN
        z4ve8oBcFlCMkWMYSdE+QRUYhIh1CvgXF92fzMU=
X-Google-Smtp-Source: ABdhPJzrnbtB8L6IOA9KR4q/fY9qokewS086TeK/ke1HfjNK4hABw2MSItAdukzEb19AgkXxkxszJxiRjhfIxB7L9+c=
X-Received: by 2002:ac8:73ce:: with SMTP id v14mr6465662qtp.320.1604934249042;
 Mon, 09 Nov 2020 07:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20201106200704.192894-1-mcroce@linux.microsoft.com> <20201109141628.GL1602@alley>
In-Reply-To: <20201109141628.GL1602@alley>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Mon, 9 Nov 2020 16:03:33 +0100
X-Gmail-Original-Message-ID: <CAFnufp0fkdLnYRdcRqE9RzB4eDbbmpfRUqd96Bs1EoFTz2QpVA@mail.gmail.com>
Message-ID: <CAFnufp0fkdLnYRdcRqE9RzB4eDbbmpfRUqd96Bs1EoFTz2QpVA@mail.gmail.com>
Subject: Re: [PATCH v2] reboot: allow to specify reboot mode via sysfs
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 3:16 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Fri 2020-11-06 21:07:04, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > The kernel cmdline reboot= option offers some sort of control
> > on how the reboot is issued.
> > Add handles in sysfs to allow setting these reboot options, so they
> > can be changed when the system is booted, other than at boot time.
> >
> > The handlers are under <sysfs>/kernel/reboot, can be read to
> > get the current configuration and written to alter it.
> >
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-kernel-reboot
> > @@ -0,0 +1,26 @@
> > +What:                /sys/kernel/reboot
> > +Date:                October 2020
> > +KernelVersion:       5.11
> > +Contact:     Matteo Croce <mcroce@microsoft.com>
> > +Description: Interface to set the kernel reboot mode, similarly to
> > +             what can be done via the reboot= cmdline option.
> > +             (see Documentation/admin-guide/kernel-parameters.txt)
> > +
> > +What:                /sys/kernel/reboot/mode
> > +What:                /sys/kernel/reboot/type
> > +What:                /sys/kernel/reboot/cpu
> > +What:                /sys/kernel/reboot/force
>
> I do not see any file where it is accumulated this way.
> It seems that each path is always described separately.
>

I've found it in Documentation/ABI/testing/sysfs-kernel-mm-ksm


> I am not sure if it is really needed. But it might be needed
> when processing the API documentation.
>
> Please, split it.
>

Ok

>
> > +
> > +Date:                October 2020
> > +Contact:     Matteo Croce <mcroce@microsoft.com>
> > +Description: Tune reboot parameters.
> > +
> > +             mode: Reboot mode. Valid values are:
> > +             cold warm hard soft gpio
> > +
> > +             type: Reboot type. Valid values are:
> > +             bios acpi kbd triple efi pci
> > +
> > +             cpu: CPU number to use to reboot.
> > +
> > +             force: Force an immediate reboot.
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index e7b78d5ae1ab..b9e607517ae3 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -594,3 +594,196 @@ static int __init reboot_setup(char *str)
> >       return 1;
> >  }
> >  __setup("reboot=", reboot_setup);
> > +
> > +#ifdef CONFIG_SYSFS
> > +
> > +#define STARTS_WITH(s, sc) (!strncmp(s, sc, sizeof(sc)-1))
> > +
> > +static ssize_t mode_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> > +{
> > +     const char *val;
> > +
> > +     switch (reboot_mode) {
> > +     case REBOOT_COLD:
> > +             val = "cold\n";
>
> Using "\n" everywhere is weird. Also the same strings are
> repeated in the next functions.
>
> I suggest to define them only once, e.g.
>
> #define REBOOT_COLD_STR "cold"
> #define REBOOT_WARM_STR "warm"
>
> and use here:
>
>         case REBOOT_COLD:
>                 val = REBOOT_COLD_STR;
>
> and then at the end
>
>         return sprintf(buf, "%s\n", val);
>
>

Ok.

> > +             break;
> > +     case REBOOT_WARM:
> > +             val = "warm\n";
> > +             break;
> > +     case REBOOT_HARD:
> > +             val = "hard\n";
> > +             break;
> > +     case REBOOT_SOFT:
> > +             val = "soft\n";
> > +             break;
> > +     case REBOOT_GPIO:
> > +             val = "gpio\n";
> > +             break;
> > +     default:
> > +             val = "undefined\n";
> > +     }
> > +
> > +     return strscpy(buf, val, 10);
>
> "undefined\n" needs 11 bytes to store also the trailing '\0'.
> Anyway, the buffer should be big enough for all variants.
>
>

Oops, missed it.

> > +}
> > +static ssize_t mode_store(struct kobject *kobj, struct kobj_attribute *attr,
> > +                       const char *buf, size_t count)
> > +{
> > +     if (!capable(CAP_SYS_BOOT))
> > +             return -EPERM;
> > +
> > +     if (STARTS_WITH(buf, "cold"))
> > +             reboot_mode = REBOOT_COLD;
>
> I would prefer to open code this and use strlen(). It will be obvious
> what the code does immediately. And I am sure that compilators
> will optimize out the strlen().
>
>
>         if (strncmp(buf, REBOOT_COLD_STR, strlen(REBOOT_COLD_STR)) == 0)
>                 reboot_mode = REBOOT_COLD;
>         else if (strncmp(buf, REBOOT_WARM_STR, strlen(REBOOT_WARM_STR) == 0)
>                 reboot_mode = REBOOT_WARM;
>         ...
>

Yes, since they are constant.

>
>
> > +     else if (STARTS_WITH(buf, "warm"))
> > +             reboot_mode = REBOOT_WARM;
> > +     else if (STARTS_WITH(buf, "hard"))
> > +             reboot_mode = REBOOT_HARD;
> > +     else if (STARTS_WITH(buf, "soft"))
> > +             reboot_mode = REBOOT_SOFT;
> > +     else if (STARTS_WITH(buf, "gpio"))
> > +             reboot_mode = REBOOT_GPIO;
> > +     else
> > +             return -EINVAL;
> > +
> > +     return count;
> > +}
> > +static struct kobj_attribute reboot_mode_attr = __ATTR_RW(mode);
> > +
> > +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> > +{
> > +     const char *val;
> > +
> > +     switch (reboot_type) {
> > +     case BOOT_TRIPLE:
> > +             val = "triple\n";
>
> Same here
>
>                 var = BOOT_TRIPLE_STR;
>
> > +             break;
> > +     case BOOT_KBD:
> > +             val = "kbd\n";
> > +             break;
> > +     case BOOT_BIOS:
> > +             val = "bios\n";
> > +             break;
> > +     case BOOT_ACPI:
> > +             val = "acpi\n";
> > +             break;
> > +     case BOOT_EFI:
> > +             val = "efi\n";
> > +             break;
> > +     case BOOT_CF9_FORCE:
> > +             val = "cf9_force\n";
> > +             break;
> > +     case BOOT_CF9_SAFE:
> > +             val = "cf9_safe\n";
> > +             break;
> > +     default:
> > +             val = "undefined\n";
> > +     }
> > +
> > +     return strscpy(buf, val, 10);
> > +}
> > +static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
> > +                       const char *buf, size_t count)
> > +{
> > +     if (!capable(CAP_SYS_BOOT))
> > +             return -EPERM;
> > +
> > +     if (STARTS_WITH(buf, "triple"))
> > +             reboot_type = BOOT_TRIPLE;
>
> and here:
>
>         if (strncmp(buf, REBOOT_TRIPLE_STR, strlen(REBOOT_TRIPLE_STR)) == 0)
>                 reboot_type = REBOOT_TRIPLE;
>
>
> > +     else if (STARTS_WITH(buf, "kbd"))
> > +             reboot_type = BOOT_KBD;
> > +     else if (STARTS_WITH(buf, "bios"))
> > +             reboot_type = BOOT_BIOS;
> > +     else if (STARTS_WITH(buf, "acpi"))
> > +             reboot_type = BOOT_ACPI;
> > +     else if (STARTS_WITH(buf, "efi"))
> > +             reboot_type = BOOT_EFI;
> > +     else if (STARTS_WITH(buf, "cf9_force"))
> > +             reboot_type = BOOT_CF9_FORCE;
> > +     else if (STARTS_WITH(buf, "cf9_safe"))
> > +             reboot_type = BOOT_CF9_SAFE;
> > +     else
> > +             return -EINVAL;
> > +
> > +     return count;
> > +}
> > +static struct kobj_attribute reboot_type_attr = __ATTR_RW(type);
> > +
> > +static ssize_t force_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> > +{
> > +     return sprintf(buf, "%d\n", reboot_force);
> > +}
> > +static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
> > +                       const char *buf, size_t count)
> > +{
> > +     if (!capable(CAP_SYS_BOOT))
> > +             return -EPERM;
> > +
> > +     if (buf[0] != '0' && buf[0] != '1')
> > +             return -EINVAL;
>
> Please use kstrtobool() that supports also other boolean values,
> for example, 'Y', 'n'.
>

Nice, will do.

> > +     rc = kstrtouint(buf, 0, &cpunum);
> > +
> > +     reboot_force = buf[0] - '0';
> > +
> > +     return count;
> > +}
>
> > +static int __init reboot_ksysfs_init(void)
> > +{
> > +     struct kobject *reboot_kobj;
> > +     int ret;
> > +
> > +     reboot_kobj = kobject_create_and_add("reboot", kernel_kobj);
> > +     if (!reboot_kobj)
> > +             return -ENOMEM;
> > +
> > +     ret = sysfs_create_group(reboot_kobj, &reboot_attr_group);
> > +     if (ret) {
> > +             kobject_put(reboot_kobj);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +core_initcall(reboot_ksysfs_init);
>
> There is no need to create the sysfs interface this early. In fact, it
> might even break because the parent "kernel" node is defined
> as core_initcall() as well. The order is not defined in this case.
>
> I would do it as sybsys_initcall() like or even late_initcall().
>

I'll postpone it to late_initcall().

Thanks,
-- 
per aspera ad upstream
