Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45172B4E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbgKPRr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:47:29 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:40440 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbgKPRr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:47:28 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CZc3K30kTz1rx7x;
        Mon, 16 Nov 2020 18:47:25 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CZc3K26fdz1qtZ6;
        Mon, 16 Nov 2020 18:47:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Fcuw266vvLxM; Mon, 16 Nov 2020 18:47:24 +0100 (CET)
X-Auth-Info: wxbQwUFoWhqFj8s7Vg1V6Cvh2UMn555Uc46N/96aYxMCH5Z0HHAeNhVd/Wcn8Qne
Received: from igel.home (ppp-46-244-169-244.dynamic.mnet-online.de [46.244.169.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 16 Nov 2020 18:47:24 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id C6D3B2C3328; Mon, 16 Nov 2020 18:47:23 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] compiler.h: Fix barrier_data() on clang
References: <20201014212631.207844-1-nivedita@alum.mit.edu>
X-Yow:  It's the land of DONNY AND MARIE as promised in TV GUIDE!
Date:   Mon, 16 Nov 2020 18:47:23 +0100
In-Reply-To: <20201014212631.207844-1-nivedita@alum.mit.edu> (Arvind Sankar's
        message of "Wed, 14 Oct 2020 17:26:31 -0400")
Message-ID: <87sg999ot0.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 14 2020, Arvind Sankar wrote:

> Commit
>   815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
>
> neglected to copy barrier_data() from compiler-gcc.h into
> compiler-clang.h. The definition in compiler-gcc.h was really to work
> around clang's more aggressive optimization, so this broke
> barrier_data() on clang, and consequently memzero_explicit() as well.
>
> For example, this results in at least the memzero_explicit() call in
> lib/crypto/sha256.c:sha256_transform() being optimized away by clang.
>
> Fix this by moving the definition of barrier_data() into compiler.h.
>
> Also move the gcc/clang definition of barrier() into compiler.h,
> __memory_barrier() is icc-specific (and barrier() is already defined
> using it in compiler-intel.h) and doesn't belong in compiler.h.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")

This breaks build on riscv:

  CC [M]  drivers/net/ethernet/emulex/benet/be_main.o
In file included from ./include/vdso/processor.h:10,
                 from ./arch/riscv/include/asm/processor.h:11,
                 from ./include/linux/prefetch.h:15,
                 from drivers/net/ethernet/emulex/benet/be_main.c:14:
./arch/riscv/include/asm/vdso/processor.h: In function 'cpu_relax':
./arch/riscv/include/asm/vdso/processor.h:14:2: error: implicit declaration of function 'barrier' [-Werror=implicit-function-declaration]
   14 |  barrier();
      |  ^~~~~~~
cc1: some warnings being treated as errors
make[5]: *** [scripts/Makefile.build:283: drivers/net/ethernet/emulex/benet/be_main.o] Error 1
make[4]: *** [scripts/Makefile.build:500: drivers/net/ethernet/emulex/benet] Error 2
make[3]: *** [scripts/Makefile.build:500: drivers/net/ethernet/emulex] Error 2
make[2]: *** [scripts/Makefile.build:500: drivers/net/ethernet] Error 2
make[1]: *** [scripts/Makefile.build:500: drivers/net] Error 2
make: *** [Makefile:1799: drivers] Error 2

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
