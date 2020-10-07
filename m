Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DF028577B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 06:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgJGEMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 00:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGEMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 00:12:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EDAC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 21:12:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t23so2249385pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 21:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Y42f+xCeFC9aJfaprUfLKsV1W6cjiDKd4zVBYm3so2c=;
        b=Am626B1mMSzKkJtKZO1KtVxoCrwhVXv6gfab3stoZ4ewy7b5+MYDP5R7eYl4JXL9kX
         ngSMaYqPVKvRv6wfttCJyW7VySrZdpDbLVd7OXy+XZCkdwvcmrH1JLH8ZQ0zqNwHMdhZ
         RZ3ankVeIu7omdFnqWFsJolMHytMcIUGg66DgJJxck6zBkvtdO8i2MrZAocOAIq3aHsp
         5iLjQ/pLIF+y0LHaRinPO/bNl9vZoIsTNCOKSfB3ekqC+P+gxY4eSuLt5B6wI3DOSxb0
         oXGMvUdklTynf3UE5QGClSGXUMnp/GW7uNrd+7RMirJIs1rUp948JKc47+jePxPQJnkc
         1E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Y42f+xCeFC9aJfaprUfLKsV1W6cjiDKd4zVBYm3so2c=;
        b=oyUiG2U9oMPnMUlCxkSMeCX0SEVFIcGO7G87q/fCGltzq9r+W4bsUV/5KYdRchhAhQ
         vZHOz1HXzZD/CxgNuuXz1pY45h0vOlYljZuy+VUGJL2vVk1g//NUc+mntBXWDBg4beyz
         VuWWKyHdrdRtcjWk9r3cuhL9XWj1FO8xDU4MOjns69PAmlg4Tf7CIjQwTO/EGXhdy9Du
         cDyjCCkhM1bb9j8ttDQdUuu2v+OLP3G2PuL888Z181c/8zxZjHx8BjdpmMSgFRUD65Mb
         d/WSqp0c8Oy4cXEAdLSjKBk61VkQfpaQ6/8ekZD9/8p130N1C7rl2+2ytIa9iIhTL/VX
         h+1g==
X-Gm-Message-State: AOAM533PWMT2uGXCa89BD5AoysPftkSjrzahx07REgluMlHtWRIJbLbG
        VF6mYN1l3NkD/G3Xe1UBHIjL3FNE0ht9Ng==
X-Google-Smtp-Source: ABdhPJyYQFQrTMby8WlVHEvFCUzvT2Fa9HBpYH785CXECo64okrkWsmHHRBwGUcT1huT8BhMIW8nMA==
X-Received: by 2002:a17:90b:698:: with SMTP id m24mr1227870pjz.154.1602043935036;
        Tue, 06 Oct 2020 21:12:15 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h9sm810241pgk.52.2020.10.06.21.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 21:12:14 -0700 (PDT)
Date:   Tue, 06 Oct 2020 21:12:14 -0700 (PDT)
X-Google-Original-Date: Tue, 06 Oct 2020 20:22:44 PDT (-0700)
Subject:     Re: [PATCH] riscv: Fixup bootup failure with HARDENED_USERCOPY
In-Reply-To: <1602002973-92934-1-git-send-email-guoren@kernel.org>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@linux.alibaba.com, atishp@atishpatra.org,
        schwab@linux-m68k.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-405fa3f3-74ce-4a03-958e-d0a6c42de3f6@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Oct 2020 09:49:33 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> As Aurelien has reported:
>
> [    3.484586] AppArmor: AppArmor sha1 policy hashing enabled
> [    4.749835] Freeing unused kernel memory: 492K
> [    4.752017] Run /init as init process
> [    4.753571] usercopy: Kernel memory overwrite attempt detected to kernel text (offset 507879, size 11)!
> [    4.754838] ------------[ cut here ]------------
> [    4.755651] kernel BUG at mm/usercopy.c:99!
> [    4.756445] Kernel BUG [#1]
> [    4.756815] Modules linked in:
> [    4.757542] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.8.0-1-riscv64 #1 Debian 5.8.7-1
> [    4.758372] epc: ffffffe0003b5120 ra : ffffffe0003b5120 sp : ffffffe07f783ca0
> [    4.758960]  gp : ffffffe000cc7230 tp : ffffffe07f77cec0 t0 : ffffffe000cdafc0
> [    4.759772]  t1 : 0000000000000064 t2 : 0000000000000000 s0 : ffffffe07f783cf0
> [    4.760534]  s1 : ffffffe00095d780 a0 : 000000000000005b a1 : 0000000000000020
> [    4.761309]  a2 : 0000000000000005 a3 : 0000000000000000 a4 : ffffffe000c1f340
> [    4.761848]  a5 : ffffffe000c1f340 a6 : 0000000000000000 a7 : 0000000000000087
> [    4.762684]  s2 : ffffffe000941848 s3 : 000000000007bfe7 s4 : 000000000000000b
> [    4.763500]  s5 : 0000000000000000 s6 : ffffffe00091cc00 s7 : fffffffffffff000
> [    4.764376]  s8 : 0000003ffffff000 s9 : ffffffe0769f3200 s10: 000000000000000b
> [    4.765208]  s11: ffffffe07d548c40 t3 : 0000000000000000 t4 : 000000000001dcd0
> [    4.766059]  t5 : ffffffe000cc8510 t6 : ffffffe000cd64aa
> [    4.766712] status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
> [    4.768308] ---[ end trace 1f8e733e834d4c3e ]---
> [    4.769129] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    4.770070] SMP: stopping secondary CPUs
> [    4.771110] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
>
> Above failure is relate to commit: a0fa4027dc911 (riscv: Fixup

That commit isn't in Linus' tree (at least, as far as I see it).  I have
6184358da000 ("riscv: Fixup static_obj() fail"), so I'm going to fix that -- in
fact, I'm going to essentially just replace most of this rationale with what I
wrote up in my revert as this is all a bit too long for a commit message.

I was kind of worried the initdata move was a bit too risky, but after reading
the users of __init_{begin,end} I think it's safe.  Here's what I ended up with
on fixes.

Thanks!

commit 84814460eef9af0fb56a4698341c9cb7996a6312 (HEAD -> fixes, riscv/fixes)
gpg: Signature made Tue 06 Oct 2020 09:11:35 PM PDT
gpg:                using RSA key 2B3C3747446843B24A943A7A2E1319F35FBB1889
gpg:                issuer "palmer@dabbelt.com"
gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
gpg:                 aka "Palmer Dabbelt <palmerdabbelt@google.com>" [ultimate]
Author: Guo Ren <guoren@linux.alibaba.com>
Date:   Tue Oct 6 16:49:33 2020 +0000

    riscv: Fixup bootup failure with HARDENED_USERCOPY
    
    6184358da000 ("riscv: Fixup static_obj() fail") attempted to elide a lockdep
    failure by rearranging our kernel image to place all initdata within [_stext,
    _end], thus triggering lockdep to treat these as static objects.  These objects
    are released and eventually reallocated, causing check_kernel_text_object() to
    trigger a BUG().
    
    This backs out the change to make [_stext, _end] all-encompassing, instead just
    moving initdata.  This results in initdata being outside of [__init_begin,
    __init_end], which means initdata can't be freed.
    
    Link: https://lore.kernel.org/linux-riscv/1593266228-61125-1-git-send-email-guoren@kernel.org/T/#t
    Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
    Reported-by: Aurelien Jarno <aurelien@aurel32.net>
    Tested-by: Aurelien Jarno <aurelien@aurel32.net>
    [Palmer: Clean up commit text]
    Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

> static_obj() fail). When we expand static_obj include INIT_DATA,
> we also include INIT_TEXT into usercopy check kernel text:
>
> /* Is this address range in the kernel text area? */
> static inline void check_kernel_text_object(const unsigned long ptr,
>                                             unsigned long n, bool to_user)
> {
>         unsigned long textlow = (unsigned long)_stext;
>         unsigned long texthigh = (unsigned long)_etext;
>         unsigned long textlow_linear, texthigh_linear;
>
>         if (overlaps(ptr, n, textlow, texthigh))
>                 usercopy_abort("kernel text", NULL, to_user, ptr - textlow, n);
>
> When INIT_TEXT/DATA are freed, new allocation will reuse these
> memory and overlaps check will be triggered.
>
> The patch met static_obj and check_kernel_text_object requirements.
>
> Link: https://lore.kernel.org/linux-riscv/1593266228-61125-1-git-send-email-guoren@kernel.org/T/#t
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Tested-by: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Atish Patra <atishp@atishpatra.org>
> Cc: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  arch/riscv/kernel/vmlinux.lds.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index f3586e3..34d00d9 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -22,13 +22,11 @@ SECTIONS
>  	/* Beginning of code and text segment */
>  	. = LOAD_OFFSET;
>  	_start = .;
> -	_stext = .;
>  	HEAD_TEXT_SECTION
>  	. = ALIGN(PAGE_SIZE);
>
>  	__init_begin = .;
>  	INIT_TEXT_SECTION(PAGE_SIZE)
> -	INIT_DATA_SECTION(16)
>  	. = ALIGN(8);
>  	__soc_early_init_table : {
>  		__soc_early_init_table_start = .;
> @@ -55,6 +53,7 @@ SECTIONS
>  	. = ALIGN(SECTION_ALIGN);
>  	.text : {
>  		_text = .;
> +		_stext = .;
>  		TEXT_TEXT
>  		SCHED_TEXT
>  		CPUIDLE_TEXT
> @@ -67,6 +66,8 @@ SECTIONS
>  		_etext = .;
>  	}
>
> +	INIT_DATA_SECTION(16)
> +
>  	/* Start of data section */
>  	_sdata = .;
>  	RO_DATA(SECTION_ALIGN)
