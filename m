Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415162B7D03
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgKRLrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:47:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:35562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgKRLrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:47:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605700022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1/ffUsnTT+J+CBsXvSJtEjzMUV3AJ8nGTkvbVm0QFzQ=;
        b=NUk5W/pzAdXy/2/+8gL4jEZ7fzgxi4nJWqw5SQu4Cz0rkmv4GWlt2ZhROH0LzHuVRlE6QD
        3RD2h7Qff0//MJ0kzDNe4pzwCxKNWjb/SQRy8TK1DGO8jsJIXOwOCngJ1tCWOwqHGFuvD8
        vtV9Po7/JmRzZ/5UOLufh6BV9VtAYvk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDE31AD7C;
        Wed, 18 Nov 2020 11:47:02 +0000 (UTC)
Date:   Wed, 18 Nov 2020 12:47:02 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
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
Subject: Re: [PATCH] reboot: Fix variable assignments in type_store
Message-ID: <X7UJtlLqJ0ZljhXG@alley>
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
 <20201112035023.974748-1-natechancellor@gmail.com>
 <20201112151320.e0153ace2f2eb5b59eabbdcb@linux-foundation.org>
 <CAFnufp1j6ZzxLJA2x28BdxbTtnN_KtnXB49ibPcbze=B2ru3aA@mail.gmail.com>
 <20201112171826.0fa3c6158f3c2780f90faafe@linux-foundation.org>
 <CAFnufp1OrGeGgUn9_2V9HMtfb-7GwuEwz4+Co_W8ehcVOQVscw@mail.gmail.com>
 <20201112184637.de44afedf0ce0dcab36dd0ad@linux-foundation.org>
 <CAFnufp31YO9yTXVqgKNZGR9XXRKfGKM4Y4NLk+4_uXdoWa+G4w@mail.gmail.com>
 <20201113162043.GO1602@alley>
 <CAFnufp3NBHUQ8fT1TEw5BvazGQjP9KmsU3y7ioJScWQ9qGiq1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp3NBHUQ8fT1TEw5BvazGQjP9KmsU3y7ioJScWQ9qGiq1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-11-13 22:28:18, Matteo Croce wrote:
> On Fri, Nov 13, 2020 at 9:06 PM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Fri 2020-11-13 03:58:49, Matteo Croce wrote:
> > > On Fri, Nov 13, 2020 at 3:46 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Fri, 13 Nov 2020 02:38:18 +0100 Matteo Croce <mcroce@linux.microsoft.com> wrote:
> > > >
> > > > > At this point, since 'pci' enables BOOT_CF9_FORCE type and
> > > > > BOOT_CF9_SAFE is not user selectable, should I simply leave only
> > > > > 'pci'?
> > > > >
> > > > > This way, we'll have the same set of options for both sysfs and kernel cmdline.
> > > >
> > > > Well, you're the reboot expert ;)
> > > >
> > >
> > > So honored! :)
> > >
> > > > But my $0.02 is yes, let's keep the command-line and sysfs interfaces
> > > > in sync and cover it all in documentation.  It would of course be
> > > > problematic to change the existing reboot= interface.
> > > >
> > > > I assume that means doing this?
> > > >
> > > > - #define BOOT_CF9_FORCE_STR     "cf9_force"
> > > > + #define BOOT_CF9_FORCE_STR     "pci"
> > > > - #define BOOT_CF9_SAFE_STR      "cf9_safe"
> > >
> > > Either BOOT_PCI_STR or BOOT_CF9_FORCE_STR, I have no strong preference.
> > >
> > > The syntax is 'pci' while the enum BOOT_CF9_FORCE, so we can't please both.
> >
> > The question is whether we should modify/allow to set these values at
> > all.
> >
> > Anyway, we must prevent them on non-x86 architectures because
> > the reboot behavior would be undefined there. They could probably
> > make a mess even on many x86-architectures.
> >
> 
> That's right, but the same can be obtained by passing 'reboot=pci'  on
> non x86 machines: the cmdline parsing is generic and will set
> reboot_type on all arches.

Fair enough. Ah, I mixed reboot_type and reboot_mode and looked
into wrong part of reboot_setup().

> I looked at the reboot_type usage, there isn't any reference outside
> arch/x86. In fact, the parameter is just ignored:
> 
> # uname -m
> aarch64
> # cat /proc/cmdline
> console=ttyS0,115200n8 reboot=pci
> # reboot -ff
> Rebooting.
> [   43.893833] reboot: Restarting system

Good to know. Thanks for checking.

> The same applies for reboot_force, the only flags available on
> different architectures are reboot_mode and reboot_cpu.
> We could hide some handlers for some architectures. We save some
> space, and avoid letting the user set flags which do nothing.

I am fine with the current patchset after all. We could always make
it more safe when people hit it in the real life. All these
worries were because I thought that this interface allowed
to set values that were not possible before.


> > Anyway, we should get input from some x86-experts about the BOOT_CF9
> > values.
> 
> Sure, x86@kernel.org ?

Yes but I do not resist on it any longer. Just if you were going to send
another version just by chance then it would be nice to CC x86.

Best Regards,
Petr
