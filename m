Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38682279E74
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 07:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgI0Fh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 01:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgI0Fh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 01:37:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED146C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 22:37:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q4so1704188pjh.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 22:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6vQ7uwNEeNjn5nyRTVkXYl319JRvBv7r0RTNPxYsLpk=;
        b=iPFgK2kD3/yis/Pwn1tUpOH+16ZnAkgwAT/Jz3e/qZnEnJlCedVu2XaiaDlXESfbWN
         AGN/Lzju647hK1UnAE2iUsS2qlduZYSv9syXu1VnpyJvJSSwAYQdFvHzeyOMHXdxJLSZ
         Wcu8cC7cpCkG19ahE0YROfWwPkZujPpeF67kyi1hmKJYPODsb6h9t7kG3tCXAXQ7VLo2
         bNxdumt/86VL5mC+Fu2cOe7FjWyUNCYRiC5Fe7+DBLvIQ5wV/HE/QCi3yRWrtnD3AwwT
         tYfb6xVhRVqy46knrz6+yehDQVubZY7/vjsucYYdIf2dWqAP5pKADp+2OM31gsbYNOwY
         0rVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6vQ7uwNEeNjn5nyRTVkXYl319JRvBv7r0RTNPxYsLpk=;
        b=TcsUTm44aV8V7gXsfd/FxMTiOzoKzQqvjRkoJI+uf19LncgX0rlePcvzP1dwYJQTJi
         HEQvCur0tu9puE/a3Hu14FdtZdPdRqeTKLgaH+cC0tuNewPJ1Wbld/ltoJVVx6HwcGLC
         FFTvfAM58JbAcRWvtMeIk9gC2kjYu4/SjVLccALdMC6IPPp0qj9hYiruqbJ4heZaZiEA
         O2evqvboktc1xlSEznzoQ1DSbw6jnHxsgr3GWNGeR4tp8D1Kn21qYXpcT5Ph3YcXdKoe
         e9RAxSVvkDFZHzjXTeakuItlvHQ/YF5VWNcG3ieP9dd+bRJDT7JE4qxqhEgQ+sBVfye/
         NxeQ==
X-Gm-Message-State: AOAM5335YSMZoOkOPw8sNiujVal/NaGQ9iHRXt1kzUIDxLuLfqnmhhZA
        B1pTH9WQWDTd/LhOTb7gBjSGZm0M5FkPpY5B
X-Google-Smtp-Source: ABdhPJyEovXT0cY5nbLWbBD832kvDrUkp7RKbSbIZ20Y9VBdPTrFnsd/+qs9rLwMfvm5z8YcQOyz4w==
X-Received: by 2002:a17:90a:e02:: with SMTP id v2mr4324857pje.6.1601185074419;
        Sat, 26 Sep 2020 22:37:54 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w185sm7477380pfc.36.2020.09.26.22.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 22:37:53 -0700 (PDT)
Date:   Sat, 26 Sep 2020 22:37:53 -0700 (PDT)
X-Google-Original-Date: Sat, 26 Sep 2020 22:37:51 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: Check clint_time_val before use
In-Reply-To: <CAAhSdy1T38v-O2v+fiKJHcpOeoxteMwzxXs0wNG46qhRDXAUmA@mail.gmail.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     anup@brainfault.org
Message-ID: <mhng-1183a9e0-5954-4e30-9a69-2fe95ae4f270@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 22:35:39 PDT (-0700), anup@brainfault.org wrote:
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
>
> Overall, this approach is good but this change is incomplete so does not work.
>
> The linux/timex.h expects random_get_entropy() to be macro so we need a
> "#define" as well.
>
> After fixing rand_initialize() with custom random_get_entropy(), we get another
> issue in boot_init_stack_canary() because boot_init_stack_canary() directly
> calls get_cycles() so we remove use of get_cycles() from
> boot_init_stack_canary()
> and this is similar to ARM, ARM64, and MIPS kernel.

OK, are you going to send that patch or do you want me to?

>
> Regards,
> Anup
>
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
