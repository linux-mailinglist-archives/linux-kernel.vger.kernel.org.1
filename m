Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D75B279E80
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 07:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbgI0Fqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 01:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgI0Fqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 01:46:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42CCC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 22:46:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q4so1710967pjh.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 22:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TsLq3yTVB4OQmzkkPV+zv+aZeH19E2zG8aMl0EQ8nnk=;
        b=GbYBSAUkCQPmIP+raGcf3eamtVRS+l/iONJ306qd9Rpah5NT8Eb7Ywb6Nspazt+AG7
         0xOoE5g/cC37+bkkGe6sigT961/go64/C6I3N9jdscACO3d4YF/n+YdAdZT168FlRsh9
         a/cucMSR5wOMJwdZUJG9+SMlr5B5+7/GSHdKznfSQn9/OsEAAilY0XoWbkmaJK4gQykb
         OUqNK2D5T464acjJwO9+BARcGrZFY3P6e8QZU6fbCofLwhPiVv/SdgNFtyerhWaNZfsB
         /UhPK+omsU6phLX3TW7Lht7YLChlGaaqzC5EZuMeBCMQT6ZBSwBr6R5ZzgipQ/M8BCBv
         wEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TsLq3yTVB4OQmzkkPV+zv+aZeH19E2zG8aMl0EQ8nnk=;
        b=lTjDLr/Pa43v5YDIsoseScYpw3YrAj+dW2TCiMEgUv3Pwx2NILalRUZP0IXrwAa5gx
         sfst7FG91Av3k4EdjWGO/EGwI+uwW44CAlQClahTu3cRmwnqfcurfD2+E37hMt7XKaTw
         Sl+hSVkoSBDKYbTIC2t78BUE9Yrf4OMHrm+ukFVhCjy3edTviUfZZbjOp/Gd08uek9xk
         EYWJYS3s8VmokgEmu0cqVMYq5dbWhB5ujP1bLGhoxqLeijpwvRAHizf00uCkmGc5rU+W
         BXqxuyfo5K9lchMDFzaEIz+DyrNGSKYHJyOEicF5SU3epKt8x7k5ypTPbm84VtcvVF4Z
         T2WA==
X-Gm-Message-State: AOAM533/AIpIrmBrbnMuyN/rTHEomcG0IDaX0UEY8GfclKi10jwpJcDA
        HwjyJzwSf3Uy39OGc/rFhRePG0y7JDUxFlsC
X-Google-Smtp-Source: ABdhPJzRALxpjL/rjQnlHmfq5XBuWLKuRUeHGoir55DNUAAAMOJbV09wfugauxbLTs0LYJbMVeRM+A==
X-Received: by 2002:a17:90a:ebd7:: with SMTP id cf23mr4339711pjb.126.1601185605121;
        Sat, 26 Sep 2020 22:46:45 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k3sm7389313pfp.41.2020.09.26.22.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 22:46:44 -0700 (PDT)
Date:   Sat, 26 Sep 2020 22:46:44 -0700 (PDT)
X-Google-Original-Date: Sat, 26 Sep 2020 22:46:31 PDT (-0700)
Subject:     Re: [PATCH v3] RISC-V: Check clint_time_val before use
In-Reply-To: <20200927053916.879116-1-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-0fd4eb79-05f0-49cd-8527-e5c74c65b7b1@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 22:39:16 PDT (-0700), Anup Patel wrote:
> The NoMMU kernel is broken for QEMU virt machine from Linux-5.9-rc6
> because clint_time_val is used even before CLINT driver is probed
> at following places:
> 1. rand_initialize() calls get_cycles() which in-turn uses
>    clint_time_val
> 2. boot_init_stack_canary() calls get_cycles() which in-turn
>    uses clint_time_val
>
> The issue#1 (above) is fixed by providing custom random_get_entropy()
> for RISC-V NoMMU kernel. For issue#2 (above), we remove dependency of
> boot_init_stack_canary() on get_cycles() and this is aligned with the
> boot_init_stack_canary() implementations of ARM, ARM64 and MIPS kernel.
>
> Fixes: d5be89a8d118 ("RISC-V: Resurrect the MMIO timer implementation
> for M-mode systems")
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
> Changes since v2:
>  - Take different approach and provide custom random_get_entropy() for
>    RISC-V NoMMU kernel
>  - Remove dependency of boot_init_stack_canary() on get_cycles()
>  - Hopefully we don't require to set clint_time_val = NULL in CLINT
>    driver with a different approach to fix.
> Changes since v1:
>  - Explicitly initialize clint_time_val to NULL in CLINT driver to
>    avoid hang on Kendryte K210
> ---
>  arch/riscv/include/asm/stackprotector.h |  4 ----
>  arch/riscv/include/asm/timex.h          | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/stackprotector.h b/arch/riscv/include/asm/stackprotector.h
> index d95f7b2a7f37..5962f8891f06 100644
> --- a/arch/riscv/include/asm/stackprotector.h
> +++ b/arch/riscv/include/asm/stackprotector.h
> @@ -5,7 +5,6 @@
>
>  #include <linux/random.h>
>  #include <linux/version.h>
> -#include <asm/timex.h>
>
>  extern unsigned long __stack_chk_guard;
>
> @@ -18,12 +17,9 @@ extern unsigned long __stack_chk_guard;
>  static __always_inline void boot_init_stack_canary(void)
>  {
>  	unsigned long canary;
> -	unsigned long tsc;
>
>  	/* Try to get a semi random initial value. */
>  	get_random_bytes(&canary, sizeof(canary));
> -	tsc = get_cycles();
> -	canary += tsc + (tsc << BITS_PER_LONG/2);
>  	canary ^= LINUX_VERSION_CODE;
>  	canary &= CANARY_MASK;
>
> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> index 7f659dda0032..ab104905d4db 100644
> --- a/arch/riscv/include/asm/timex.h
> +++ b/arch/riscv/include/asm/timex.h
> @@ -33,6 +33,19 @@ static inline u32 get_cycles_hi(void)
>  #define get_cycles_hi get_cycles_hi
>  #endif /* CONFIG_64BIT */
>
> +/*
> + * Much like MIPS, we may not have a viable counter to use at an early point
> + * in the boot process. Unfortunately we don't have a fallback, so instead
> + * we just return 0.
> + */
> +static inline unsigned long random_get_entropy(void)
> +{
> +	if (unlikely(clint_time_val == NULL))
> +		return 0;
> +	return get_cycles();
> +}
> +#define random_get_entropy()	random_get_entropy()
> +
>  #else /* CONFIG_RISCV_M_MODE */
>
>  static inline cycles_t get_cycles(void)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

I'm going to wait for Damien to chime in about the NULL initialization boot
failure, though, as I'm a bit worried something else was going on.

Thanks!
