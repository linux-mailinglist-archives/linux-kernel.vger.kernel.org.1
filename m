Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312972E1D98
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgLWOs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgLWOs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:48:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D70752255F;
        Wed, 23 Dec 2020 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608734895;
        bh=TgX0UgDtm1mxQbQPVBtBN5XZAOwdO5dq9Y6Nash01Oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IY+OUr2eeisdLXSTcfpAdahOc72ivPoJmDJnxoEQkd0aPfr4ILxnifxhphNwxaDDD
         3ibGm2jPYfibcwLlFkFdZpZLpY5o++retf55TVX0YaH2MhXrQO+Bj6lDv/kEBmqAWn
         bPpMu1opj0tvD8pc9jAMKvzcmlq97UTctFfpSRwyrTJkM4G/bzPs2WeDLN8YGHFJCp
         uwtY7A3XrFUNi4DTA+UQLbXiZ45P01YrRy4f3GkuN4UJdYK1wZIeNZ+9QZVpRzESYP
         W79GklKQsHRoertP3gqH97dtcudFvEwsbWMWm053y/kg2a8VoouNsQkkvCZbKfIat7
         30CmVKOLWj0Iw==
Date:   Wed, 23 Dec 2020 14:48:09 +0000
From:   Will Deacon <will@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willem de Bruijn <willemb@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] epoll: fix compat syscall wire up of epoll_pwait2
Message-ID: <20201223144809.GA22082@willie-the-truck>
References: <20201220095830.17843-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220095830.17843-1-hca@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 10:58:30AM +0100, Heiko Carstens wrote:
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
> 
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index f4bca2b90218..cccfbbefbf95 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -890,7 +890,7 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
>  #define __NR_process_madvise 440
>  __SYSCALL(__NR_process_madvise, sys_process_madvise)
>  #define __NR_epoll_pwait2 441
> -__SYSCALL(__NR_epoll_pwait2, sys_epoll_pwait2)
> +__SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)


For this bit ^^

Acked-by: Will Deacon <will@kernel.org>

Will
