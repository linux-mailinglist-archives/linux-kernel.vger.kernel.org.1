Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5102F27E1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgI3G6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3G6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:58:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4E9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 23:58:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id j19so348041pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 23:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=WxGFU9YDPgIQ/fxu1xfkvWboEWfSXnck0Qqf8eZXDR4=;
        b=IGLm/TPd2cst9B3C+u06qjtEKQHk+YAAmFT2oHnDCCUKaQfjJ/ekdr/zHUEGjJKH3E
         a4fh5Uxiqzy2uwR1TgeEhTonnE48LpF7QM8lExLsyIQxGz76DLcANWFokDgFvV0Iw6wg
         EYyIjBtOnJr1WYzHGvpi3M4ElFtJOkPJop5KNWYpGn7VUJmi52Nh985b02bXCSFrk2zM
         vxDjjfFfeGop+iYi0luPhQDM+LIYBoxXYnidtry8EZM5fnwD0hSO3P/cESQWCok6DM9+
         5p2OuSU+nKfAR0sHWVCIXnl18hp4dqtLlsk7fC65wx3Q9+RkxL5o3oivfTWWWdEtt298
         VvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=WxGFU9YDPgIQ/fxu1xfkvWboEWfSXnck0Qqf8eZXDR4=;
        b=fwe1hUj1W815nc4RaoJOgGcclH86S7PAwvGCC6LQozopvFUaF9zI3dFpd7RjdA3xOQ
         zLLNi7xHWwdGPkBeZpqa+Aj/WxDxYHr5SLMKnH3fXfBMUOmAUlG8lS0uLp34q6RgWN1/
         jbEs3MCeK18JwmBotQiTcYbxhi3Xl0HzP3Jvz5XfrR15IGYvscb4S1zrBu15PzVHpNy4
         Ra8LWcQzUfCr5MJ12kDIlJlmaCd94JuJNcwkdgd1Ra2Y3QzWAw+1oe6YXrDbgLuG/fA3
         Y7laqIW3/8I2m5E20iwmvOVnWDMRNltazKGXRtNk6+tRI4GqHWg9SrMocVwfMYsRKI80
         vhKw==
X-Gm-Message-State: AOAM530emjQdwFLIfOK9zgX6u5/U4CSzVDyF4DJyJ4JAyOS2F6eGcrC2
        2nDQMbGp2rc6JxHvVLDcxbupxCoN2XTp8rS0
X-Google-Smtp-Source: ABdhPJx5K7wSx+QNqAsFDY7NVRMJVu6NqeQEZpcM36Fmvm6hPdyBnKRyFQgmxcyXEBEwYV++xLMsFw==
X-Received: by 2002:a17:90a:ca82:: with SMTP id y2mr1238562pjt.233.1601449108087;
        Tue, 29 Sep 2020 23:58:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a71sm1063804pfa.26.2020.09.29.23.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 23:58:27 -0700 (PDT)
Date:   Tue, 29 Sep 2020 23:58:27 -0700 (PDT)
X-Google-Original-Date: Tue, 29 Sep 2020 23:58:25 PDT (-0700)
Subject:     Re: [PATCH v3] RISC-V: Check clint_time_val before use
In-Reply-To: <c0ec481bf0413f391b16415530d2606114ea150a.camel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Message-ID: <mhng-6eec6bf8-1c59-4c5a-9a93-8e4f7bd7faed@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 22:52:19 PDT (-0700), Damien Le Moal wrote:
> On Sun, 2020-09-27 at 11:09 +0530, Anup Patel wrote:
>> The NoMMU kernel is broken for QEMU virt machine from Linux-5.9-rc6
>> because clint_time_val is used even before CLINT driver is probed
>> at following places:
>> 1. rand_initialize() calls get_cycles() which in-turn uses
>>    clint_time_val
>> 2. boot_init_stack_canary() calls get_cycles() which in-turn
>>    uses clint_time_val
>> 
>> The issue#1 (above) is fixed by providing custom random_get_entropy()
>> for RISC-V NoMMU kernel. For issue#2 (above), we remove dependency of
>> boot_init_stack_canary() on get_cycles() and this is aligned with the
>> boot_init_stack_canary() implementations of ARM, ARM64 and MIPS kernel.
>> 
>> Fixes: d5be89a8d118 ("RISC-V: Resurrect the MMIO timer implementation
>> for M-mode systems")
>> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> ---
>> Changes since v2:
>>  - Take different approach and provide custom random_get_entropy() for
>>    RISC-V NoMMU kernel
>>  - Remove dependency of boot_init_stack_canary() on get_cycles()
>>  - Hopefully we don't require to set clint_time_val = NULL in CLINT
>>    driver with a different approach to fix.
>> Changes since v1:
>>  - Explicitly initialize clint_time_val to NULL in CLINT driver to
>>    avoid hang on Kendryte K210
>> ---
>>  arch/riscv/include/asm/stackprotector.h |  4 ----
>>  arch/riscv/include/asm/timex.h          | 13 +++++++++++++
>>  2 files changed, 13 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/riscv/include/asm/stackprotector.h b/arch/riscv/include/asm/stackprotector.h
>> index d95f7b2a7f37..5962f8891f06 100644
>> --- a/arch/riscv/include/asm/stackprotector.h
>> +++ b/arch/riscv/include/asm/stackprotector.h
>> @@ -5,7 +5,6 @@
>>  
>>  #include <linux/random.h>
>>  #include <linux/version.h>
>> -#include <asm/timex.h>
>>  
>>  extern unsigned long __stack_chk_guard;
>>  
>> @@ -18,12 +17,9 @@ extern unsigned long __stack_chk_guard;
>>  static __always_inline void boot_init_stack_canary(void)
>>  {
>>  	unsigned long canary;
>> -	unsigned long tsc;
>>  
>>  	/* Try to get a semi random initial value. */
>>  	get_random_bytes(&canary, sizeof(canary));
>> -	tsc = get_cycles();
>> -	canary += tsc + (tsc << BITS_PER_LONG/2);
>>  	canary ^= LINUX_VERSION_CODE;
>>  	canary &= CANARY_MASK;
>>  
>> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
>> index 7f659dda0032..ab104905d4db 100644
>> --- a/arch/riscv/include/asm/timex.h
>> +++ b/arch/riscv/include/asm/timex.h
>> @@ -33,6 +33,19 @@ static inline u32 get_cycles_hi(void)
>>  #define get_cycles_hi get_cycles_hi
>>  #endif /* CONFIG_64BIT */
>>  
>> +/*
>> + * Much like MIPS, we may not have a viable counter to use at an early point
>> + * in the boot process. Unfortunately we don't have a fallback, so instead
>> + * we just return 0.
>> + */
>> +static inline unsigned long random_get_entropy(void)
>> +{
>> +	if (unlikely(clint_time_val == NULL))
>> +		return 0;
>> +	return get_cycles();
>> +}
>> +#define random_get_entropy()	random_get_entropy()
>> +
>>  #else /* CONFIG_RISCV_M_MODE */
>>  
>>  static inline cycles_t get_cycles(void)
> 
> Did not reply to the patch... So again for Kendryte:
> 
> Tested-by: Damien Le Moal <damien.lemoal@wdc.com>

Thanks.  I've put this on for-next, right after the patch I just posted to add
EXPORT_SYMBOL(clint_time_val) as it turns out random_get_entropy() is used by a
driver.
