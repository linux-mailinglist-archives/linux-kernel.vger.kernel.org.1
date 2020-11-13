Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB7A2B251C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKMUGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:06:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:48552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgKMUGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:06:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605297989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oQwnOHsy/0jBPQajX/pBzBhWuSfClhYpeZwlUl+SZ70=;
        b=rgV12Nx8hK6b4BRekLkhkiwL6CFsCKz3yEXJ/KxTa0JCiRSrO6njFoa6x9fTTSUPySzEoo
        6QkOeWIT9+q9hOkpI/r5lLNQIO56x6noHI4EqsLAiuW9T7Js+4A0kFT3yRVeJ+eH9uzqqG
        yqMy0JQ/wuLXPBuiUVKQIoRA1QXeJ4o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 166FCABD6;
        Fri, 13 Nov 2020 20:06:29 +0000 (UTC)
Date:   Fri, 13 Nov 2020 21:06:28 +0100
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
Message-ID: <20201113162043.GO1602@alley>
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
 <20201112035023.974748-1-natechancellor@gmail.com>
 <20201112151320.e0153ace2f2eb5b59eabbdcb@linux-foundation.org>
 <CAFnufp1j6ZzxLJA2x28BdxbTtnN_KtnXB49ibPcbze=B2ru3aA@mail.gmail.com>
 <20201112171826.0fa3c6158f3c2780f90faafe@linux-foundation.org>
 <CAFnufp1OrGeGgUn9_2V9HMtfb-7GwuEwz4+Co_W8ehcVOQVscw@mail.gmail.com>
 <20201112184637.de44afedf0ce0dcab36dd0ad@linux-foundation.org>
 <CAFnufp31YO9yTXVqgKNZGR9XXRKfGKM4Y4NLk+4_uXdoWa+G4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp31YO9yTXVqgKNZGR9XXRKfGKM4Y4NLk+4_uXdoWa+G4w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-11-13 03:58:49, Matteo Croce wrote:
> On Fri, Nov 13, 2020 at 3:46 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 13 Nov 2020 02:38:18 +0100 Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > > At this point, since 'pci' enables BOOT_CF9_FORCE type and
> > > BOOT_CF9_SAFE is not user selectable, should I simply leave only
> > > 'pci'?
> > > 
> > > This way, we'll have the same set of options for both sysfs and kernel cmdline.
> >
> > Well, you're the reboot expert ;)
> >
> 
> So honored! :)
> 
> > But my $0.02 is yes, let's keep the command-line and sysfs interfaces
> > in sync and cover it all in documentation.  It would of course be
> > problematic to change the existing reboot= interface.
> >
> > I assume that means doing this?
> >
> > - #define BOOT_CF9_FORCE_STR     "cf9_force"
> > + #define BOOT_CF9_FORCE_STR     "pci"
> > - #define BOOT_CF9_SAFE_STR      "cf9_safe"
> 
> Either BOOT_PCI_STR or BOOT_CF9_FORCE_STR, I have no strong preference.
> 
> The syntax is 'pci' while the enum BOOT_CF9_FORCE, so we can't please both.

The question is whether we should modify/allow to set these values at
all.

Anyway, we must prevent them on non-x86 architectures because
the reboot behavior would be undefined there. They could probably
make a mess even on many x86-architectures.

I have to admit it has become much more complicated than I thought.
It brings back Andrew's original question whether this interface is
really needed. Are you going to use in the real life?

The interface might do more harm then good when it allows to set
reboot_type that is not normally accessible or disable it when
it is strictly needed.

Anyway, we should get input from some x86-experts about the BOOT_CF9
values.

Best Regards,
Petr
