Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB8D2BBCA9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 04:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKUDZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 22:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKUDZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 22:25:33 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD56C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:25:33 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id t18so5928514plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=F4LHuwHPehTGg6C7SwMVTgSDJxeRk/wpcUvGl+GXLpg=;
        b=U92UXwN3msyCRk7cskDKA/IK+g4HTcj7kVry+hoQSSAovr8eSvCulEoBdUImOUIKXs
         9d3Nz45fFLcxE0prv5yNHdKzZC+Dn8ljLEb5JK/z0wNZcMFWbKnOGH2VzAxd4QkjWl9U
         XpodiXZ5C9tCgNFZAl2VIwUbYnNe46aUilCMK4VyU94T9qd/Z6D1iHL/P+h4IazenZO7
         V6LYITT4WulnwgX7ZjpVWsbZssu4+gc0/CcRf64YMm12LwNg2RB+bpHy5CVpsUEZzTRn
         jms9ymXrbQM8YDDwuaENU0YeQJDQH0Qs5CXWG1Tz0XIRQophOK6ftzeGidYn7UZ5rTZr
         2f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=F4LHuwHPehTGg6C7SwMVTgSDJxeRk/wpcUvGl+GXLpg=;
        b=hzC848rpkrRIiLnv5ML1VH249ZksAtPI1rRovvje1utwQEGQw9RlCR0b2fMDkF7lzp
         Ic6p+ZH1TH4Tj3tEuB8x2ROdhkDV366ZsC5KODI378BlPa2UoGDG3t42BnU1iEVfBJf9
         fq+tl1JM1R0ONw09eiJLV1hM9SF2xzgyXY6bhDNOgotzVNX9basn6qD13fnTvN2sfoDb
         DjzVCBpbu54X13EjebXaWW9YY9SIyeDBlt+EuSboBfGGQWQzUhYx1efBJmbo8J+vteIX
         2AUBxDIAd41231ChMFaxO5Mcb82KU6pe9cgMGqb0CvCvm+N4R1Cklixoc4cTwV+jp7Si
         847g==
X-Gm-Message-State: AOAM5316fKdQqwCBBtd29tdi715xWQwYCq71STWpkoIb/s4Lwn1tyPPf
        mKLgLpcVhNHZ9j24k6O8Nfnh8rMonUTzag==
X-Google-Smtp-Source: ABdhPJx3nkWlFu0uu97//0uNkR/dir2aPZDUB1x33bgenASk/eg4bD2X/6gKX3DIQiuKW8/ACRr4+w==
X-Received: by 2002:a17:902:bd98:b029:d9:7b0:e1e5 with SMTP id q24-20020a170902bd98b02900d907b0e1e5mr16129511pls.77.1605929132538;
        Fri, 20 Nov 2020 19:25:32 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w22sm4673768pge.25.2020.11.20.19.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 19:25:31 -0800 (PST)
Date:   Fri, 20 Nov 2020 19:25:31 -0800 (PST)
X-Google-Original-Date: Fri, 20 Nov 2020 19:25:30 PST (-0800)
Subject:     Re: [PATCH] RISC-V: fix barrier() use in <vdso/processor.h>
In-Reply-To: <20201117013951.7827-1-rdunlap@infradead.org>
CC:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        schwab@linux-m68k.org, akpm@linux-foundation.org,
        Stephen Rothwell <sfr@canb.auug.org.au>, nivedita@alum.mit.edu,
        linux-riscv@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        natechancellor@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-8c56f671-512a-45e7-9c94-fa39a80451da@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 17:39:51 PST (-0800), rdunlap@infradead.org wrote:
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
> rv64 allmodconfig now builds cleanly after this patch.
>
> Fixes fallout from:
> 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
>
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
> ---
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

Thanks, this is on fixes.
