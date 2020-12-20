Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17AA2DF6C5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 21:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgLTUPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 15:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbgLTUPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 15:15:31 -0500
X-Gm-Message-State: AOAM533yyAsNtl8Ei61tZzJI5+UujS+sfIGzeZFcSyKqHmo/mreOabIY
        jeA11DFQdeu6Yx8zt9HcSoz5DXrYqRjNCbcW3MQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608495291;
        bh=7am4UsebiBgtGgl0iply8PUli5JbFVpWeHcirmVJ4u4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=StgPQ6zrnn5S/spd4KvWmpEukOpLOh0NRZ5plvtwMjcUOoXUgiyaLVa0X/TS86PWc
         +47G8JVz2G4jmNU11GFyYCCsWF3IhxITEBPCBF+/sxbva8haAk6ojdoioxF32JwDtX
         VGuqb3qRpCiyojjYrzV7T7JeTk8coWcApc8euDwchkUzHVU28XBgA4Ieow1E8tIsfQ
         Z4IDoftQfCz6N12SSMRR0bd9qEQ8BQN+SDGYSQD0BunecRmwqKNamXg9iPJhH1DCG3
         EVa0VDd+Z3nSBMmnV8m9QEPmDEejrZ6eu9b5FK6IVPy140c9HkmJw45EpN3cml62j/
         vyfRmGB/73xqg==
X-Google-Smtp-Source: ABdhPJyxGVi+NvR0d2WpjBSmnsgLFl1g9pum5y/F6l8abjXUDtthBIX9EJc80tbb3D+jR+5cbd9U6xLgNSI4XGzy5VU=
X-Received: by 2002:a05:6830:1e14:: with SMTP id s20mr9864557otr.210.1608495290991;
 Sun, 20 Dec 2020 12:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20201220095830.17843-1-hca@linux.ibm.com> <CAK8P3a1NPMbKnuZ7-b0qbVVtLHT2YG6eEtzKUOf4AZkcu5VO4g@mail.gmail.com>
 <CA+FuTSeKfSouk7SV0cfuZ122J3fAc_ddy_a9unyCRq4F7f6+pw@mail.gmail.com> <CAHk-=wjXFfeCHdhAwH8ciXhMJwAc3dOnCAug4G8=eb=+zFnkTQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjXFfeCHdhAwH8ciXhMJwAc3dOnCAug4G8=eb=+zFnkTQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 20 Dec 2020 21:14:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a37qym_RKvCcKn1o53qBuA1gEk4FwPJ644LcPSJW-DrfA@mail.gmail.com>
Message-ID: <CAK8P3a37qym_RKvCcKn1o53qBuA1gEk4FwPJ644LcPSJW-DrfA@mail.gmail.com>
Subject: Re: [PATCH] epoll: fix compat syscall wire up of epoll_pwait2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 7:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Dec 20, 2020 at 10:22 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Slightly tangential, it's not immediately clear to me why in
> > arch/x86/entry/syscalls/syscall_32.tbl epoll_pwait does not need a
> > compat entry, unlike on other architectures and unlike signalfd.
>
> Hmm. Good question. That looks like a bug to me. Probably nobody
> noticed because it's so rarely used.
>
> Or maybe I'm missing something too.
>
> Adding x86 entry code people to the participants.

The sigset_t argument is actually compatible between x86-32 and x86-64
because

- The bits are in the same order on little-endian machines
- _NSIG is the same as _COMPAT_NSIG (unlike old sparc kernels)
- accessing a 64-bit with 32-bit alignment is always allowed on x86

All other architectures with compat mode support big-endian
code at least as an option, so they have to use the compat
version.

         Arnd
