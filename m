Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1E4279E77
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 07:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgI0FjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 01:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgI0FjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 01:39:07 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94207C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 22:39:07 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c3so1583095plz.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 22:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=LMQphMQQC1ZS52mjolpGUg46gp7rKFN7yP9FdquBqU8=;
        b=qF54auphWnDSQ59t6x3KMjN/NTjWZiu9aibdYBcrSrxOTSOeKKI8+vfUXW3da8z88X
         A8+WX7+hoVVW5tTyBI6YRHvRy0lwayMnRJBjKmZWhwJ0ObxvTiRcCPZXfscUjvEHM76F
         HGpaQr295HcLlymMDy8AeJ6YX1OV7xwxTMaT6TOUP35cJzOAWXpkcQzjFZVC9iJwafiP
         bWgNhv+aX6CmsRwL2PWwsrnU273bDfh2vY+rlCJ6GryQ2l+LtfPELQu2ps4kcvEdj3Ps
         tw+4ly2IT4i7HJfgmnBWRzwI2g4qu2ZjWRMkyoFoKNksopFx1NgTjDDn7HAdddu1aTGU
         7row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=LMQphMQQC1ZS52mjolpGUg46gp7rKFN7yP9FdquBqU8=;
        b=ffPngue34ZTxRr6YO/3hEgFbPAXI8dc4FuBZemTneoWAhu4NWUFGW4BTLYDayxl7Kr
         7JAJ/ktCuZveWChkyFu47u4QbLiSPjw0B08Q16QN9Pz+6nHx5pLN29zac+VogK1Rq70O
         UxG+oTDt0xTV7RF8jHUUq0prCmvrJJs20QoBCZ31ABLoQ38ajDRwXKtvYnhn+SbUmstj
         qunMoYhlLMgy2kEdpNr4BVc6fDWCn6jgKchCNi22BKl0btyeuq+1C+R+S/I03zVzGE4m
         0uZteLinyDQQR6lmz8o+LLeoSSDBVu7R2cNYibZOYP8XEiHlLaRUenjmA1slPEbDNrNN
         d6Dg==
X-Gm-Message-State: AOAM533u7VHsxWDgT08BWnfKqxoP59kLT7pxbLY4Sp8bB51d/6aSrcbZ
        9qUvVQX2h9MeDbZ2n9q7aagSiw==
X-Google-Smtp-Source: ABdhPJwDFMeN1C5G3h8RDbBH/LKHNMwpi62d4kKmJsP/wuS/kyLNJaJPPG8gp0MvVLGQJg3zfGfDGQ==
X-Received: by 2002:a17:90b:3c1:: with SMTP id go1mr4384822pjb.192.1601185146863;
        Sat, 26 Sep 2020 22:39:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 84sm7045469pfw.14.2020.09.26.22.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 22:39:06 -0700 (PDT)
Date:   Sat, 26 Sep 2020 22:39:06 -0700 (PDT)
X-Google-Original-Date: Sat, 26 Sep 2020 22:39:04 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: Check clint_time_val before use
In-Reply-To: <CAAhSdy1EeeNcyHbk-MN+auKX+mZmvF=W=S-UPuRhrqVBjch4ow@mail.gmail.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     anup@brainfault.org
Message-ID: <mhng-4f4adf29-bb3f-4ea9-a7b9-8f69ef3071f4@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 22:38:17 PDT (-0700), anup@brainfault.org wrote:
> On Sun, Sep 27, 2020 at 5:50 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>>
>> On Sat, 26 Sep 2020 03:31:29 PDT (-0700), Damien Le Moal wrote:
>> > On Sat, 2020-09-26 at 15:51 +0530, Anup Patel wrote:
>> >> The NoMMU kernel is broken for QEMU virt machine from Linux-5.9-rc6
>> >> because the get_cycles() and friends are called very early from
>> >> rand_initialize() before CLINT driver is probed. To fix this, we
>> >> should check clint_time_val before use in get_cycles() and friends.
>>
>> I don't think this is the right way to solve that problem, as we're essentially
>> just lying about the timer rather than informing the system we can't get
>> timer-based entropy right now.  MIPS is explicit about this, I don't see any
>> reason why we shouldn't be as well.
>>
>> Does this fix the boot issue (see below for the NULL)?  There's some other
>> random-related arch functions so this might not be quite the right way to do
>> it.
>>
>> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
>> index 7f659dda0032..7e39b0068932 100644
>> --- a/arch/riscv/include/asm/timex.h
>> +++ b/arch/riscv/include/asm/timex.h
>> @@ -33,6 +33,18 @@ static inline u32 get_cycles_hi(void)
>>  #define get_cycles_hi get_cycles_hi
>>  #endif /* CONFIG_64BIT */
>>
>> +/*
>> + * Much like MIPS, we may not have a viable counter to use at an early point in
>> + * the boot process.  Unfortunately we don't have a fallback, so instead we
>> + * just return 0.
>> + */
>> +static inline unsigned long random_get_entropy(void)
>> +{
>> +       if (unlikely(clint_time_val == NULL))
>> +               return 0;
>> +       return get_cycles();
>> +}
>> +
>>  #else /* CONFIG_RISCV_M_MODE */
>>
>>  static inline cycles_t get_cycles(void)
>>
>> >> Fixes: d5be89a8d118 ("RISC-V: Resurrect the MMIO timer implementation
>> >> for M-mode systems")
>> >> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> >> ---
>> >> Changes since v1:
>> >>  - Explicitly initialize clint_time_val to NULL in CLINT driver to
>> >>    avoid hang on Kendryte K210
>> >> ---
>> >>  arch/riscv/include/asm/timex.h    | 12 +++++++++---
>> >>  drivers/clocksource/timer-clint.c |  2 +-
>> >>  2 files changed, 10 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
>> >> index 7f659dda0032..6e7b04874755 100644
>> >> --- a/arch/riscv/include/asm/timex.h
>> >> +++ b/arch/riscv/include/asm/timex.h
>> >> @@ -17,18 +17,24 @@ typedef unsigned long cycles_t;
>> >>  #ifdef CONFIG_64BIT
>> >>  static inline cycles_t get_cycles(void)
>> >>  {
>> >> -    return readq_relaxed(clint_time_val);
>> >> +    if (clint_time_val)
>> >> +            return readq_relaxed(clint_time_val);
>> >> +    return 0;
>> >>  }
>> >>  #else /* !CONFIG_64BIT */
>> >>  static inline u32 get_cycles(void)
>> >>  {
>> >> -    return readl_relaxed(((u32 *)clint_time_val));
>> >> +    if (clint_time_val)
>> >> +            return readl_relaxed(((u32 *)clint_time_val));
>> >> +    return 0;
>> >>  }
>> >>  #define get_cycles get_cycles
>> >>
>> >>  static inline u32 get_cycles_hi(void)
>> >>  {
>> >> -    return readl_relaxed(((u32 *)clint_time_val) + 1);
>> >> +    if (clint_time_val)
>> >> +            return readl_relaxed(((u32 *)clint_time_val) + 1);
>> >> +    return 0;
>> >>  }
>> >>  #define get_cycles_hi get_cycles_hi
>> >>  #endif /* CONFIG_64BIT */
>> >> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
>> >> index d17367dee02c..8dbec85979fd 100644
>> >> --- a/drivers/clocksource/timer-clint.c
>> >> +++ b/drivers/clocksource/timer-clint.c
>> >> @@ -37,7 +37,7 @@ static unsigned long clint_timer_freq;
>> >>  static unsigned int clint_timer_irq;
>> >>
>> >>  #ifdef CONFIG_RISCV_M_MODE
>> >> -u64 __iomem *clint_time_val;
>> >> +u64 __iomem *clint_time_val = NULL;
>>
>> This one I definately don't get.  According the internet, the C standard says
>>
>>     If an object that has static storage duration is not initialized
>>     explicitly, it is initialized implicitly as if every member that has
>>     arithmetic type were assigned 0 and every member that has pointer type were
>>     assigned a null pointer constant.
>>
>> so unless I'm missing something there shouldn't be any difference between these
>> two lines.  When I just apply this I get exactly the same "objdump -dt" before
>> and after.  I do see some difference in assembly, but only when I don't pass
>> "-fno-common" and that ends up being passed during my Linux builds.
>
> Even checkpatch complains about explicit NULL assignment to global variables.
>
> I will send v3 with a different approach to fix this so hopefully with
> v3 we will
> not require explicit NULL assignment.

Awesome, thanks!

>
> Regards,
> Anup
>
>>
>> >>  #endif
>> >>
>> >>  static void clint_send_ipi(const struct cpumask *target)
>> >
>> > For Kendryte:
>> >
>> > Tested-by: Damien Le Moal <damien.lemoal@wdc.com>
>> >
>> > --
>> > Damien Le Moal
>> > Western Digital
