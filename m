Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D9F2B26B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgKMV2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:28:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:60090 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgKMV2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:28:55 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by linux.microsoft.com (Postfix) with ESMTPSA id B30BC20B71B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:28:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B30BC20B71B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605302934;
        bh=Q8tBea9wG2ltNWXDqKwNyyqi3spAu6w8nUfb7d6YXPM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ekV+DQ3eV4V/h41le2WjVH5Pe7KaGvAFmjNJRwWSbjnNHmU3NW9ugzflnJrh4ljHh
         dtzOwotSvo97i4KH1O3znSWnwY7x7bSi2HmhC9ji0cmmN7Q9PsUTAmxeySELQ5wqPX
         gEjnDrkXBrMUQNkzQtdveJcWzxLKuoK1AeEZIlKE=
Received: by mail-qk1-f176.google.com with SMTP id l2so10352585qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:28:54 -0800 (PST)
X-Gm-Message-State: AOAM531a/ZP9r8Ahiq7MfL6ADRfQKibdS0DlUHby4WvqNt1w8v1uZhN0
        PXb6B6+q8W4nWG0mDPT+d4beDNAlNWrhFPJWGXA=
X-Google-Smtp-Source: ABdhPJzKpfDUt8oKq6lB0q2F5+sHX0lLIMP1PUq2TnlD3i65IrF7aT/t60WWdXtX7SpNTmTFkamd791qEgNLoqBelnk=
X-Received: by 2002:a37:4e0a:: with SMTP id c10mr4012902qkb.492.1605302933880;
 Fri, 13 Nov 2020 13:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
 <20201112035023.974748-1-natechancellor@gmail.com> <20201112151320.e0153ace2f2eb5b59eabbdcb@linux-foundation.org>
 <CAFnufp1j6ZzxLJA2x28BdxbTtnN_KtnXB49ibPcbze=B2ru3aA@mail.gmail.com>
 <20201112171826.0fa3c6158f3c2780f90faafe@linux-foundation.org>
 <CAFnufp1OrGeGgUn9_2V9HMtfb-7GwuEwz4+Co_W8ehcVOQVscw@mail.gmail.com>
 <20201112184637.de44afedf0ce0dcab36dd0ad@linux-foundation.org>
 <CAFnufp31YO9yTXVqgKNZGR9XXRKfGKM4Y4NLk+4_uXdoWa+G4w@mail.gmail.com> <20201113162043.GO1602@alley>
In-Reply-To: <20201113162043.GO1602@alley>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 13 Nov 2020 22:28:18 +0100
X-Gmail-Original-Message-ID: <CAFnufp3NBHUQ8fT1TEw5BvazGQjP9KmsU3y7ioJScWQ9qGiq1A@mail.gmail.com>
Message-ID: <CAFnufp3NBHUQ8fT1TEw5BvazGQjP9KmsU3y7ioJScWQ9qGiq1A@mail.gmail.com>
Subject: Re: [PATCH] reboot: Fix variable assignments in type_store
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 9:06 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Fri 2020-11-13 03:58:49, Matteo Croce wrote:
> > On Fri, Nov 13, 2020 at 3:46 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 13 Nov 2020 02:38:18 +0100 Matteo Croce <mcroce@linux.microsoft.com> wrote:
> > >
> > > > At this point, since 'pci' enables BOOT_CF9_FORCE type and
> > > > BOOT_CF9_SAFE is not user selectable, should I simply leave only
> > > > 'pci'?
> > > >
> > > > This way, we'll have the same set of options for both sysfs and kernel cmdline.
> > >
> > > Well, you're the reboot expert ;)
> > >
> >
> > So honored! :)
> >
> > > But my $0.02 is yes, let's keep the command-line and sysfs interfaces
> > > in sync and cover it all in documentation.  It would of course be
> > > problematic to change the existing reboot= interface.
> > >
> > > I assume that means doing this?
> > >
> > > - #define BOOT_CF9_FORCE_STR     "cf9_force"
> > > + #define BOOT_CF9_FORCE_STR     "pci"
> > > - #define BOOT_CF9_SAFE_STR      "cf9_safe"
> >
> > Either BOOT_PCI_STR or BOOT_CF9_FORCE_STR, I have no strong preference.
> >
> > The syntax is 'pci' while the enum BOOT_CF9_FORCE, so we can't please both.
>
> The question is whether we should modify/allow to set these values at
> all.
>
> Anyway, we must prevent them on non-x86 architectures because
> the reboot behavior would be undefined there. They could probably
> make a mess even on many x86-architectures.
>

That's right, but the same can be obtained by passing 'reboot=pci'  on
non x86 machines: the cmdline parsing is generic and will set
reboot_type on all arches.

> I have to admit it has become much more complicated than I thought.
> It brings back Andrew's original question whether this interface is
> really needed. Are you going to use in the real life?
>

Yes, there are some cases.
Not to mention complex use cases like let persist some memory regions,
or change the page size,
if a network driver fails to rmmod with the infamous
"unregistered_netdevice: waiting for wlan0 to become free",
enabling force on the fly allows to reboot the machine.


> The interface might do more harm then good when it allows to set
> reboot_type that is not normally accessible or disable it when
> it is strictly needed.
>

I looked at the reboot_type usage, there isn't any reference outside
arch/x86. In fact, the parameter is just ignored:

# uname -m
aarch64
# cat /proc/cmdline
console=ttyS0,115200n8 reboot=pci
# reboot -ff
Rebooting.
[   43.893833] reboot: Restarting system

The same applies for reboot_force, the only flags available on
different architectures are reboot_mode and reboot_cpu.
We could hide some handlers for some architectures. We save some
space, and avoid letting the user set flags which do nothing.

> Anyway, we should get input from some x86-experts about the BOOT_CF9
> values.
>

Sure, x86@kernel.org ?

Regards,
-- 
per aspera ad upstream
