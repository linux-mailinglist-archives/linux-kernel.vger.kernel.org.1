Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D144B2C4AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 23:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbgKYWXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 17:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbgKYWXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 17:23:45 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12680C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 14:23:30 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id x15so103342ilq.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4fSseuUDkF72EVISoG/Otds+xMHGbUooGtI19qB6eM=;
        b=CuHq7PCbfrHF0SPoiaoJXMYDNgo8HlTyg5TQ4xZaSdJUq/QWlEHE1GpA9W+CUAYnr1
         y+M0ONnzSsWa754QAYsQCD77c10HvzvC2gU72xPOPVivW3h2r4u2A+DhbcgmHwV9Tmpq
         gQiXMP0UqGi3PhZrry2As1JEk4xtHJ3vXVK0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4fSseuUDkF72EVISoG/Otds+xMHGbUooGtI19qB6eM=;
        b=k2yXGhAscOfOB53Jm7dCtZrijhwv+zqfe534ANf0xXyD5YlyljbkXwXYG7XXZuhwL8
         xgNpMDFyF7c9T3tsEQVwV8JdvNDwS0EUtJtII6CotazxE9mnXwzpLykbAw5meqy4E/5o
         thvCu2XJSNojVk2FR2pFDVJHvT/jCFJHTJT5mRFNwrAzOj0LWZX0A5Ni7hLSAbGZGdZE
         Wce/6PXs9c1xG0/lzjdsNkQ8cAIj1LaOpgCzK19sIJNmfBLt/YMx79RjXEZq3GLCCqZU
         V3740QyeY52X/3CYisTM4Ox4LuPVUkHymMYiCeNGnGL+0sbfSFiyMDnZs55631rhjuzM
         PEuw==
X-Gm-Message-State: AOAM533BNUjb2ol6OCkScgAAHVUOmXDbKb0Vn3DJYr3cJdXzv1otF5Vh
        s6elF0YncwnGTsvCTooMRevbNG20NYpK+Rbgt2Ib
X-Google-Smtp-Source: ABdhPJwwuYvxJ6HvFMi1Q0K59YCEOU141q4wr394wJ/Gfa4gkkBlYcl1CtkE+71tMasA+4XVM3u6ED3Ck9PWWcVBEZ4=
X-Received: by 2002:a92:d588:: with SMTP id a8mr5209085iln.79.1606343009520;
 Wed, 25 Nov 2020 14:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20201125195703.3780383-1-palmer@dabbelt.com>
In-Reply-To: <20201125195703.3780383-1-palmer@dabbelt.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 25 Nov 2020 14:23:19 -0800
Message-ID: <CAOnJCUJy1Jai2YBTfOOnKUmx3vydFwchD7dRLacL8iTDihbpKw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Define get_cycles64() regardless of M-mode
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        kernel-team@android.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 11:58 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> The timer driver uses get_cycles64() unconditionally to obtain the current
> time.  A recent refactoring lost the common definition for some configs, which
> is now the only one we need.
>
> Fixes: d5be89a8d118 ("RISC-V: Resurrect the MMIO timer implementation for M-mode systems")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/include/asm/timex.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> index ab104905d4db..81de51e6aa32 100644
> --- a/arch/riscv/include/asm/timex.h
> +++ b/arch/riscv/include/asm/timex.h
> @@ -60,6 +60,8 @@ static inline u32 get_cycles_hi(void)
>  }
>  #define get_cycles_hi get_cycles_hi
>
> +#endif /* !CONFIG_RISCV_M_MODE */
> +
>  #ifdef CONFIG_64BIT
>  static inline u64 get_cycles64(void)
>  {
> @@ -79,8 +81,6 @@ static inline u64 get_cycles64(void)
>  }
>  #endif /* CONFIG_64BIT */
>
> -#endif /* !CONFIG_RISCV_M_MODE */
> -
>  #define ARCH_HAS_READ_CURRENT_TIMER
>  static inline int read_current_timer(unsigned long *timer_val)
>  {
> --
> 2.29.2.454.gaff20da3a2-goog
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atish.patra@wdc.com>
-- 
Regards,
Atish
