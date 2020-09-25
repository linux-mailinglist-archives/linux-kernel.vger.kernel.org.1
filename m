Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C045A2792FF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgIYVJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgIYVJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:09:22 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF974239EC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 21:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601068162;
        bh=88OnxH8Vyd74g0UFkhcjwnzHM47ASZZ812ZbPggXg+8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nAc35Ob5odDDVZgfuI+99lsW9yc2bEzQJ8X74n6tyUFMGWatOOnc6PcdERXE6M79y
         H1oxXYWIenrpxVUaZ0u9Wz1lByM5nVR1C3h2N6wVOF4jL1jXGixs3ECxPhstQcOeu9
         pppBBvnvymSFxI29y7Jp7SeGXKQ5cO9hM0A6so2M=
Received: by mail-oo1-f42.google.com with SMTP id m25so1099345oou.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:09:21 -0700 (PDT)
X-Gm-Message-State: AOAM533mqOURcylb74MkQEcM8PD7a/c535tv+q+M+9JamEl7y166UVHP
        dJ3VzPaYXdRZLcWhjoit1Yb4ciW323YnpeIj1JM=
X-Google-Smtp-Source: ABdhPJyuhjhMUp48byLzT6YIyzmYRnzCJ+pBSVzm4VDnZsiwJxPAbVA7f3SG9stmkMACB/6Yunx5X/JYYUySYvEIhVw=
X-Received: by 2002:a4a:c541:: with SMTP id j1mr2155634ooq.13.1601068161083;
 Fri, 25 Sep 2020 14:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjtG_VHL1M8-=pKNNRmWQg_8oC0YG7C8H3gQcbJ+0B3=A@mail.gmail.com>
 <202009251301.A1FD183582@keescook> <CAMj1kXGtv84JHQfKoqOYyq=3m2w0Yuj_n4_Teo83zvdZ9kpZhw@mail.gmail.com>
 <202009251338.D17FB071@keescook>
In-Reply-To: <202009251338.D17FB071@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 25 Sep 2020 23:09:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEWutwE-fP9bc=tsyPoTuV6J7bLzLpkZ213P9y9JszkTw@mail.gmail.com>
Message-ID: <CAMj1kXEWutwE-fP9bc=tsyPoTuV6J7bLzLpkZ213P9y9JszkTw@mail.gmail.com>
Subject: Re: KASLR support on ARM with Kernel 4.9 and 4.14
To:     Kees Cook <keescook@chromium.org>
Cc:     Pintu Agarwal <pintu.ping@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, matt@codeblueprint.co.uk,
        nico@linaro.org, Thomas Garnier <thgarnie@google.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 at 22:47, Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 25, 2020 at 10:37:01PM +0200, Ard Biesheuvel wrote:
> > On Fri, 25 Sep 2020 at 22:28, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Sep 25, 2020 at 08:33:59PM +0530, Pintu Agarwal wrote:
> > > > This is regarding the KASLR feature support on ARM for the kernel
> > > > version 4.9 and 4.14.
> > > >
> > > > Is KASLR supported on ARM-32 Linux 4.9 and above ?
> > >
> > > Sorry, this feature did not yet land in upstream:
> > > https://github.com/KSPP/linux/issues/3
> > >
> > > Here was the earlier effort:
> > > https://lore.kernel.org/kernel-hardening/20170814125411.22604-1-ard.biesheuvel@linaro.org/
> > >
> > > > Is it dependent on CONFIG_RANDOMIZE_BASE or
> > >
> > > CONFIG_RANDOMIZE_BASE is what is used on other architectures to control
> > > the feature.
> > >
> > > > /proc/sys/kernel/randomize_va_space ?
> > > > Is there any relation between these two?
> > >
> > > No, the latter is about userspace addresses.
> > >
> > > > Is the changing kernel symbols (in every boot), only possible if KASLR
> > > > is enabled, or there is another way it can happen?
> > >
> > > I think you meant kernel symbol addresses (not the symbols themselves).
> > > But yes, I wouldn't expect the addresses to move if you didn't either
> > > rebuild the kernel or had something else moving the kernel at boot (i.e.
> > > the boot loader).
> > >
> > > > I have these queries because,
> > > > In one of the arm-32 devices with Kernel 4.14, I observed that
> > > > CONFIG_RANDOMIZE_BASE is not available.
> > > > But /proc/sys/kernel/randomize_va_space is set to 2.
> > > > However, I also observed that symbol addresses are changing in every boot.
> > > >
> > > > 1st boot cycle:
> > > > [root ~]# cat /proc/kallsyms | grep "sys_open"
> > > > a5b4de92 T sys_open
> > > > [root@sa515m ~]#
> > > >
> > > > 2nd boot cycle:
> > > > [root ~]# cat /proc/kallsyms | grep "sys_open"
> > > > f546ed66 T sys_open
> > > >
> > > > So, I am wondering how this is possible without KASLR
> > > > (CONFIG_RANDOMIZE_BASE) support in Kernel ?
> >
> > Those addresses were obfuscated by kptr_restrict
>
> Is that true? kptr_restrict zeros (rather than hashing) the kallsyms
> view. And besides, the %p hashing was added in v4.15 (but also doesn't
> touch kallsyms, which does all-or-nothing to avoid breaking stuff
> like perf).
>

Ah yes, good point. But it does look suspiciously like they are being
mangled in a similar way.

For a 3/1 split ARM kernel of the typical size, all kernel virtual
addresses start with 0xc0, and given that the kernel is located at the
start of the linear map, those addresses cannot change even if you
move the kernel around in physical memory.
