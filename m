Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554EE2DF546
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 12:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbgLTLoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 06:44:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbgLTLoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 06:44:14 -0500
X-Gm-Message-State: AOAM533ZZ/J0+i2cWVHCy0xnET4mAiXxPHDO2ughtMo8deeLRGYr+PGB
        rArUQMkwA7m4ytRXCVzs6ghYhq+ejJlQwirbP6g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608464614;
        bh=ID72aXXEbkR6z/UZ/MCiCcq7QXsW2gsf0AnM5JxYXxg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sokCLyrNX1eaplE8bo1C8H/DxkiAnIsLw4Y9bwjRAtrLiOmv0xVf7RotrAsk9aiwi
         prSLdaenAbfHLk+LSoloIk6gnAhHtgFlOWozU/oQ2Tott3MHK27nACKV1/VFrRCrF5
         dHm9cdhvza3W9GXsv8yKeszjR60PoQ7YQB0QA4tVPO2uKp/SmTpHx3+dmRZ96Z8LLz
         6Uzw9P7g0INz9D1XKqLOzVYJSOFRXsqL+CJYXCiKS5E5YLE0htaHCqbedy4vQw2jGe
         8cIW+8l5GaPP0SDu41MqGB3vT32t9hvYjt8nflMEk9J5z/uhyOgScXgBylJV8C/Wy0
         OkBc4VKBarBFQ==
X-Google-Smtp-Source: ABdhPJyXmhtCZZEnD9yK+QLFWM2mErYOyJJmniV00BJhGSQuS0hXyuQsTyUqjKLRzLd2DRZ3aDt0DLm1B9CXKeLiTqA=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr8962200ots.251.1608464613379;
 Sun, 20 Dec 2020 03:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20201220095830.17843-1-hca@linux.ibm.com>
In-Reply-To: <20201220095830.17843-1-hca@linux.ibm.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 20 Dec 2020 12:43:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1NPMbKnuZ7-b0qbVVtLHT2YG6eEtzKUOf4AZkcu5VO4g@mail.gmail.com>
Message-ID: <CAK8P3a1NPMbKnuZ7-b0qbVVtLHT2YG6eEtzKUOf4AZkcu5VO4g@mail.gmail.com>
Subject: Re: [PATCH] epoll: fix compat syscall wire up of epoll_pwait2
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willem de Bruijn <willemb@google.com>,
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

On Sun, Dec 20, 2020 at 11:00 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> Commit b0a0c2615f6f ("epoll: wire up syscall epoll_pwait2") wired up
> the 64 bit syscall instead of the compat variant in a couple of places.
>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Fixes: b0a0c2615f6f ("epoll: wire up syscall epoll_pwait2")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/arm64/include/asm/unistd32.h         | 2 +-
>  arch/mips/kernel/syscalls/syscall_n32.tbl | 2 +-
>  arch/s390/kernel/syscalls/syscall.tbl     | 2 +-
>  arch/sparc/kernel/syscalls/syscall.tbl    | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

I double-checked all the entries to make sure you caught all
the missing ones, looks good.

Acked-by: Arnd Bergmann <arnd@arndb.de>
