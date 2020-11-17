Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF3D2B6F30
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgKQTqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbgKQTq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:46:29 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72179C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:46:29 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q10so18020255pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWLn5FutqVhu6C2envdImtz3KsoVlAIGjTIx4c1QXNg=;
        b=RWwNYKUJ8FHrbEAF2X7STaEV0pLcso44r/P15V8Qw9UoO+Uu5XaR3xyuYg8SMZY5MB
         6O0nhled1fN8K81Rsb0gHRvoW8w1YJvmAgRq1KlsgbdLIb7bLbmqofZ+Q115kxkSDVuc
         poX1jX5OMLYnvAWbT+R6Eyu4Pxy4nXfwsOaYFx9UiUrFm1tUwogK7jzvRzF4AgxvDGrf
         iBjOqLPLynUKCIftZocEKRrDWH92FloVkxHYgPM75KjV05sudUTl82bXfrSY119Bzcgx
         MXOrrCiejU0KKMfmLTPOTt9vpO6s8wvQoux4Ud47/mOc2lGTa9pGLz1PqijS2/Q77Ygw
         K/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWLn5FutqVhu6C2envdImtz3KsoVlAIGjTIx4c1QXNg=;
        b=XxiVY4sDaJE/rYehEJsbrlYRLGVGDamo34xzwq+lHDH9l7NZ+v09l43N3ssgh6PS9G
         s9vY4395UvT+30P1HYKmOMQ6ONL1TkK6qotg1PCJBKuhYyUpZg8wqkE7UdB87XWrB42K
         +WULXwSLx6PZOeXGncBYp4RkxCFxZgmOJHspq5cUdkPa/4o9HaU64VEF2/e61RPxj01I
         pq7js2EQy7lBXADNPNtQVucn9quPNRjtjsv5X1itdTszaqiQK8obz6eGIPLIVb6E30wF
         6dRrG3y2DELgI76MxU3ImIzfEUZZwxYpEMcl4yWzSzxtQN15JEU2AsTUE7HDivMvrfpz
         41kQ==
X-Gm-Message-State: AOAM533ngBgFIA/cHNpSAotUVYwTNlv4c6wTp0svD7UOOSbia3/E1uqW
        9h1cjR1RNzeUEEzd0KRl0LkSNyH7XFBusEvJryb4Lw==
X-Google-Smtp-Source: ABdhPJyDrcELE42tedArMs204mY5PQM+V4W1fuc8fBPXx/V/yrIUb8NjyaPqo5jxCNkKPfw2LRZFqLy1QtS2JF7B58Q=
X-Received: by 2002:a65:4485:: with SMTP id l5mr4795692pgq.10.1605642388738;
 Tue, 17 Nov 2020 11:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20201117193053.18990-1-rdunlap@infradead.org>
In-Reply-To: <20201117193053.18990-1-rdunlap@infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Nov 2020 11:46:18 -0800
Message-ID: <CAKwvOdnAHqNkN2yRPnSSbe=C6Uc0MJXH=VU2KFRyE3AtHpcXXg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: fix barrier() use in <vdso/processor.h>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-riscv@lists.infradead.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:31 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> riscv's <vdso/processor.h> uses barrier() so it should
> #include <asm/barrier.h> to prevent build errors.
>
> Fixes this build error:
>   CC [M]  drivers/net/ethernet/emulex/benet/be_main.o
> In file included from ./include/vdso/processor.h:10,
>                  from ./arch/riscv/include/asm/processor.h:11,
>                  from ./include/linux/prefetch.h:15,
>                  from drivers/net/ethernet/emulex/benet/be_main.c:14:
> ./arch/riscv/include/asm/vdso/processor.h: In function 'cpu_relax':
> ./arch/riscv/include/asm/vdso/processor.h:14:2: error: implicit declaration of function 'barrier' [-Werror=implicit-function-declaration]
>    14 |  barrier();
>
> This happens with a total of 5 networking drivers -- they all use
> <linux/prefetch.h>.
>
> rv64 and rv32 allmodconfig now build cleanly after this patch.
>
> Fixes: 3347acc6fcd4 ("compiler.h: fix barrier_data() on clang")
> Fixes: ad5d1122b82f ("riscv: use vDSO common flow to reduce the latency of the time-related functions")
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: linux-riscv@lists.infradead.org
> Cc: clang-built-linux@googlegroups.com
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1202

> ---
> v2: update Fixes: tags (Nick);
>     also built allmodconfig cleanly on rv32;
>
>  arch/riscv/include/asm/vdso/processor.h |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- lnx-510-rc4.orig/arch/riscv/include/asm/vdso/processor.h
> +++ lnx-510-rc4/arch/riscv/include/asm/vdso/processor.h
> @@ -4,6 +4,8 @@
>
>  #ifndef __ASSEMBLY__
>
> +#include <asm/barrier.h>
> +
>  static inline void cpu_relax(void)
>  {
>  #ifdef __riscv_muldiv



-- 
Thanks,
~Nick Desaulniers
