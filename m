Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDF52DF672
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 19:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgLTSX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 13:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgLTSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 13:23:26 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A21DC061282
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 10:22:46 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id s2so4222665vsk.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 10:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ewiasbX5Wt7O5WTO8wVgis9t5IKu03BoQttlzC3okGw=;
        b=aTIOBrrNyrGtOswFvJvoP6Pcm/EMGg7b6De9JrEsKbMAnLP4dbtKBPS5GJQ5lYPic/
         XK/5aExskawOWvFU+lOhPTIPitt8B6jUiJw7mxU3H26EMLpHJQ7wXyWBaZta0IHirvPw
         5ici2WYmyOlLmivUAHpc8+wYQK4eIJH+LxjAqvldAoItZiu1gyAUO2k5QzKXH3EW1Vk9
         4Ggf+YMNZ1YOMuZtqIvK8dQ1Biwc6WuGY9XkuSPQ3ALtvhDWqD/iMUybbq4R5EvS83vF
         R/Adg8IaSrWfljHGemePp8Oypy13UebWJxLmHrulrI4SwaHpOYPYhrkua46Xu99lSIqA
         0lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ewiasbX5Wt7O5WTO8wVgis9t5IKu03BoQttlzC3okGw=;
        b=PUpxXoWXaIMtxs3yrJRX+lqcC6XLb7rdhb1vg2ivif0UIR0omurejLOEZo9YhL9Io+
         uHcePKTOPjkAhpbGr0W9/dqahEoTTSqcqR1Eyt5+MSgLebBF5prldb1zc72LRid7AXqw
         hyb8u3s7ymJmZCE/unwK5toyAfqq2axAgJPIqaAmg6Ojnzdejf8sS7/o93huWkIDt/Ix
         sjSexEuM4AmrETXetFyDWXHzm/kbVzTSDsbRCYuwTprBs4FU8836TqIfwxv7+flFLhbL
         4ZH+7+PzeQEcoJdt6EYAzoLnkrIICm0QJowQxl7PcecPUaVlAQ6fvcw5Rph9dTvTdaUq
         ansg==
X-Gm-Message-State: AOAM532CTMvbsL8WJwUa8G4sy5PDMMxbPRGYvjxXlK/Fys8jyt8uomo8
        hCdAgFzH1s9GmaPeAjJEjONCaGU/t80=
X-Google-Smtp-Source: ABdhPJxy30ZVLLHUxMTHsn7B6EASSAvRFODlhWeqdGxFo/5MZjxXun42Tx78uDLS6jqho42+eE5BCg==
X-Received: by 2002:a05:6102:216:: with SMTP id z22mr10271674vsp.6.1608488564253;
        Sun, 20 Dec 2020 10:22:44 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id w66sm147704vkb.50.2020.12.20.10.22.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Dec 2020 10:22:43 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id u7so4202907vsg.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 10:22:42 -0800 (PST)
X-Received: by 2002:a67:3201:: with SMTP id y1mr10523626vsy.22.1608488562199;
 Sun, 20 Dec 2020 10:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20201220095830.17843-1-hca@linux.ibm.com> <CAK8P3a1NPMbKnuZ7-b0qbVVtLHT2YG6eEtzKUOf4AZkcu5VO4g@mail.gmail.com>
In-Reply-To: <CAK8P3a1NPMbKnuZ7-b0qbVVtLHT2YG6eEtzKUOf4AZkcu5VO4g@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 20 Dec 2020 13:22:06 -0500
X-Gmail-Original-Message-ID: <CA+FuTSeKfSouk7SV0cfuZ122J3fAc_ddy_a9unyCRq4F7f6+pw@mail.gmail.com>
Message-ID: <CA+FuTSeKfSouk7SV0cfuZ122J3fAc_ddy_a9unyCRq4F7f6+pw@mail.gmail.com>
Subject: Re: [PATCH] epoll: fix compat syscall wire up of epoll_pwait2
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 6:43 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Sun, Dec 20, 2020 at 11:00 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > Commit b0a0c2615f6f ("epoll: wire up syscall epoll_pwait2") wired up
> > the 64 bit syscall instead of the compat variant in a couple of places.
> >
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Fixes: b0a0c2615f6f ("epoll: wire up syscall epoll_pwait2")
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  arch/arm64/include/asm/unistd32.h         | 2 +-
> >  arch/mips/kernel/syscalls/syscall_n32.tbl | 2 +-
> >  arch/s390/kernel/syscalls/syscall.tbl     | 2 +-
> >  arch/sparc/kernel/syscalls/syscall.tbl    | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
>
> I double-checked all the entries to make sure you caught all
> the missing ones, looks good.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Willem de Bruijn <willemb@google.com>

Thanks a lot. I also arrived at the same list after comparing to
epoll_pwait and signalfd (for sigset) and ppoll_time64 (for timespec64).

Slightly tangential, it's not immediately clear to me why in
arch/x86/entry/syscalls/syscall_32.tbl epoll_pwait does not need a
compat entry, unlike on other architectures and unlike signalfd.
