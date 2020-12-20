Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A72DF719
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 00:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgLTXTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 18:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgLTXTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 18:19:30 -0500
X-Gm-Message-State: AOAM530rwWaL85QnKljusGNgcSvyoaqLEMZgsrpofqicuWZ5TCZek5uf
        Jw4tQjpP+fxHRumvKgd+sElgTv39JhTr+ye8re0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608506329;
        bh=g56HYtAMLl4N1b6QWGPO7nQfhmnIazVA7XRhb0T6evw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kGXUP/IIJnkRe34EB05absXZsOywr7iYfZRTsmDL47+aFeoGs6uIS786jj4w/dzOL
         i2hATrjqbAEjWbzlCaZ1or+FLI/WuPPln9+QH7mQNBrZbVpun04lXesEOa4WFCR8np
         2g5N1szLa2HbfCwG2/i0wZeiFhrEsQdSEwQlioqs03U5nuTZ9qdxXLdO5Gmv0394UD
         PRG3OABqbXzNUy4AVK/EgfvV3bA8y20YqVaktJLeYOV6zp7QSY10JGzhEr0Ym6oia4
         W4537fVfLyEFZHugX48iSExPjhqlI6Ko5XCDH/hJXuJG5MFG0zDeBxiukl+i6jdzdE
         EO07Vvr38hAXw==
X-Google-Smtp-Source: ABdhPJz3yFWnPKsxpBAOKkGvYhgw90eyIg8/NiFhnNFRhTgryqNCr4Xh+Zxysxqcavxq6zoGhwsfY3/hHMd+4RFIJo4=
X-Received: by 2002:aca:44d:: with SMTP id 74mr9628726oie.4.1608506328757;
 Sun, 20 Dec 2020 15:18:48 -0800 (PST)
MIME-Version: 1.0
References: <20201220095830.17843-1-hca@linux.ibm.com> <CAK8P3a1NPMbKnuZ7-b0qbVVtLHT2YG6eEtzKUOf4AZkcu5VO4g@mail.gmail.com>
 <CA+FuTSeKfSouk7SV0cfuZ122J3fAc_ddy_a9unyCRq4F7f6+pw@mail.gmail.com>
 <CAHk-=wjXFfeCHdhAwH8ciXhMJwAc3dOnCAug4G8=eb=+zFnkTQ@mail.gmail.com>
 <CAK8P3a37qym_RKvCcKn1o53qBuA1gEk4FwPJ644LcPSJW-DrfA@mail.gmail.com> <CAHk-=wimOSd-41nDAYKfbUCNN=o22NOrGT6U38=KLqw5NBsZNg@mail.gmail.com>
In-Reply-To: <CAHk-=wimOSd-41nDAYKfbUCNN=o22NOrGT6U38=KLqw5NBsZNg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 21 Dec 2020 00:18:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2fUpnhxmOPbzD=z10_uuWQsHyEUv+YQ19wNWrxiUVwvQ@mail.gmail.com>
Message-ID: <CAK8P3a2fUpnhxmOPbzD=z10_uuWQsHyEUv+YQ19wNWrxiUVwvQ@mail.gmail.com>
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

On Sun, Dec 20, 2020 at 10:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Dec 20, 2020 at 12:14 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > The sigset_t argument is actually compatible between x86-32 and x86-64
>
> Well, random high bits in size_t or the pointer value aren't. So it
> still looks a bit iffy to me.
>
> But it might end up working almost by accident.

The direct syscall arguments all get the correct zero-extension with
asm/syscall_wrapper.h, just like they do with any other syscall that
is used in both native and compat mode, like epoll_wait().

It probably makes sense to change it just for consistency with the other
architectures, but I would assume that it was intentional when this was
added originally, as the compat handling for epoll_pwait() went through
several iterations before it first worked correctly.

        Arnd
