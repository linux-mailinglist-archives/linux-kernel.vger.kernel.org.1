Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABDD279D26
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 02:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgI0AUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 20:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgI0AUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 20:20:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6B7C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 17:20:13 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm21so1491743pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 17:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Hs9mLaM9QJjA7QhpUv/f+9+N0sU3vQhU7QQqL2xb8zU=;
        b=KgYHR3evLAlofZjmxy7xtcAssDoyckmUck6gmNfmVG1EL2iTR188aSUJtHSDSUZ0nE
         xdC+ewr7xw4AyO2CdGamgs2aGkb/k4ssA/QFlBNU/S0eQmKTr2bQxOc/IfrMaTqJ7oj3
         HMCmF2I1Z3qsdwGEOIaGR4Vlja3UhrUTgW2nK+C9ChSgaeKij3W1ld0FsaG93eJ2DDHn
         87E2Q131HOs1rp9i6xb9jXwnfWnZnarbC/EAgVTSPXX6SdagZbxMTe4zQdVjMtni5rEz
         COebEo9K4rUZQX5WnLf17bP7E3ngbcJKqJxn/2O8CDMNzMnaMYeQ+b3k6SWvpzRSK5VS
         scWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Hs9mLaM9QJjA7QhpUv/f+9+N0sU3vQhU7QQqL2xb8zU=;
        b=UtHkxGBrSknqSSzBhPBEyktCpDheD/EWMdXAnipqJTohdt9S0TkQsck5apRBgt7+/Q
         0bh3cDv+8q6DHQIx3Cw2Dtmi07LQBG6YjcFzbGy96N/E2C96KTsqGpHhX2aHWQEhOUe8
         HiPNHT+IbQoIq4QiRQ492AwswNnrxFOgYxFpbrpinjmf5hPePmfZlBpMLSvlBFP/97ux
         PlJeMxKPGaCXRf3YawI/pDdwq0AjoZFZKEDREOEWUCs0szKi1ayIQCVF4hHqpeh7U6Hl
         Z6nG2VfVzqqsoEkOML9A5Dg6QxJZ2SK6vIYNFkTkYpRjZLui5NOe3POwZPdpAKRXkfGA
         8AcQ==
X-Gm-Message-State: AOAM533RpEOt+SPjEzYIWNkSqgZYwkvzgang51YfPaEBDW7ordL4PUKi
        7s7ERx6H7o+7iC3BlYtRubQ19Q==
X-Google-Smtp-Source: ABdhPJxkhIWEgptCK4x109gR4W2bv8RGxG+jJF3c1D6WYNNJo8naz9TwJLCO+qKn5JJ+pO0QemPEZw==
X-Received: by 2002:a17:90a:528a:: with SMTP id w10mr3580342pjh.107.1601166013023;
        Sat, 26 Sep 2020 17:20:13 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p11sm6640791pfq.130.2020.09.26.17.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 17:20:12 -0700 (PDT)
Date:   Sat, 26 Sep 2020 17:20:12 -0700 (PDT)
X-Google-Original-Date: Sat, 26 Sep 2020 17:20:10 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: Check clint_time_val before use
In-Reply-To: <4950cd11fcf66bc3606f309d6289577b5dc65b2e.camel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Message-ID: <mhng-bcea0448-fc43-406d-a56c-53e16306e12d@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 03:31:29 PDT (-0700), Damien Le Moal wrote:
> On Sat, 2020-09-26 at 15:51 +0530, Anup Patel wrote:
>> The NoMMU kernel is broken for QEMU virt machine from Linux-5.9-rc6
>> because the get_cycles() and friends are called very early from
>> rand_initialize() before CLINT driver is probed. To fix this, we
>> should check clint_time_val before use in get_cycles() and friends.

I don't think this is the right way to solve that problem, as we're essentially
just lying about the timer rather than informing the system we can't get
timer-based entropy right now.  MIPS is explicit about this, I don't see any
reason why we shouldn't be as well.

Does this fix the boot issue (see below for the NULL)?  There's some other
random-related arch functions so this might not be quite the right way to do
it.

diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index 7f659dda0032..7e39b0068932 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -33,6 +33,18 @@ static inline u32 get_cycles_hi(void)
 #define get_cycles_hi get_cycles_hi
 #endif /* CONFIG_64BIT */
 
+/*
+ * Much like MIPS, we may not have a viable counter to use at an early point in
+ * the boot process.  Unfortunately we don't have a fallback, so instead we
+ * just return 0.
+ */
+static inline unsigned long random_get_entropy(void)
+{
+	if (unlikely(clint_time_val == NULL))
+		return 0;
+	return get_cycles();
+}
+
 #else /* CONFIG_RISCV_M_MODE */
 
 static inline cycles_t get_cycles(void)

>> Fixes: d5be89a8d118 ("RISC-V: Resurrect the MMIO timer implementation
>> for M-mode systems")
>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> ---
>> Changes since v1:
>>  - Explicitly initialize clint_time_val to NULL in CLINT driver to
>>    avoid hang on Kendryte K210
>> ---
>>  arch/riscv/include/asm/timex.h    | 12 +++++++++---
>>  drivers/clocksource/timer-clint.c |  2 +-
>>  2 files changed, 10 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
>> index 7f659dda0032..6e7b04874755 100644
>> --- a/arch/riscv/include/asm/timex.h
>> +++ b/arch/riscv/include/asm/timex.h
>> @@ -17,18 +17,24 @@ typedef unsigned long cycles_t;
>>  #ifdef CONFIG_64BIT
>>  static inline cycles_t get_cycles(void)
>>  {
>> -	return readq_relaxed(clint_time_val);
>> +	if (clint_time_val)
>> +		return readq_relaxed(clint_time_val);
>> +	return 0;
>>  }
>>  #else /* !CONFIG_64BIT */
>>  static inline u32 get_cycles(void)
>>  {
>> -	return readl_relaxed(((u32 *)clint_time_val));
>> +	if (clint_time_val)
>> +		return readl_relaxed(((u32 *)clint_time_val));
>> +	return 0;
>>  }
>>  #define get_cycles get_cycles
>>  
>>  static inline u32 get_cycles_hi(void)
>>  {
>> -	return readl_relaxed(((u32 *)clint_time_val) + 1);
>> +	if (clint_time_val)
>> +		return readl_relaxed(((u32 *)clint_time_val) + 1);
>> +	return 0;
>>  }
>>  #define get_cycles_hi get_cycles_hi
>>  #endif /* CONFIG_64BIT */
>> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
>> index d17367dee02c..8dbec85979fd 100644
>> --- a/drivers/clocksource/timer-clint.c
>> +++ b/drivers/clocksource/timer-clint.c
>> @@ -37,7 +37,7 @@ static unsigned long clint_timer_freq;
>>  static unsigned int clint_timer_irq;
>>  
>>  #ifdef CONFIG_RISCV_M_MODE
>> -u64 __iomem *clint_time_val;
>> +u64 __iomem *clint_time_val = NULL;

This one I definately don't get.  According the internet, the C standard says

    If an object that has static storage duration is not initialized
    explicitly, it is initialized implicitly as if every member that has
    arithmetic type were assigned 0 and every member that has pointer type were
    assigned a null pointer constant.

so unless I'm missing something there shouldn't be any difference between these
two lines.  When I just apply this I get exactly the same "objdump -dt" before
and after.  I do see some difference in assembly, but only when I don't pass
"-fno-common" and that ends up being passed during my Linux builds.

>>  #endif
>>  
>>  static void clint_send_ipi(const struct cpumask *target)
> 
> For Kendryte:
> 
> Tested-by: Damien Le Moal <damien.lemoal@wdc.com>
> 
> -- 
> Damien Le Moal
> Western Digital
