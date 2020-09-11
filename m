Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9D72669DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgIKVBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgIKVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:01:52 -0400
X-Greylist: delayed 968 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Sep 2020 14:01:52 PDT
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D80C061573;
        Fri, 11 Sep 2020 14:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=zEKQQeCho5wDyUtVNsTj1BSV4gF4ofzlmZRqY/qdBXs=; b=B+mE1wAk/yQA5RXAATYCANIBDt
        rhXyppgNEexBbMMDAyuOD0bgL7f+Uxb7eSLPY+v2MpOoUqWPY7DUUqzgedQaq7CPqIxOvmzRwYzZi
        zYz4tdKHsjsvJ3be+UzWDkJDTL/DeDN2MproBZtTFlLucKan+SgCSASNf7WkgNTDX3k5Jo34+eeIu
        19bM+2TbtqcwkvEiDFxjwCaM7Fjz7b1OKKCBlcrCaHnp5Me0R8CVWmGCayNEt3QWJ3XTG+X9Xh5kF
        LDMdy+X2t1oXF3jiVeNfPOTRxMabY8IKmnjZaEqFOUMrkjrAt7Hg69xR2zqJeOKRB+MPfZNAgl+2g
        eudrdfKg==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1kGpuz-0002ni-Jh; Fri, 11 Sep 2020 22:45:13 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
        (envelope-from <aurelien@aurel32.net>)
        id 1kGpuy-00C5q9-Mu; Fri, 11 Sep 2020 22:45:12 +0200
Date:   Fri, 11 Sep 2020 22:45:12 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     guoren@kernel.org
Cc:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, tycho@tycho.ws,
        nickhu@andestech.com, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
Message-ID: <20200911204512.GA2705@aurel32.net>
Mail-Followup-To: guoren@kernel.org, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, anup@brainfault.org,
        greentime.hu@sifive.com, zong.li@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, tycho@tycho.ws, nickhu@andestech.com,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
 <1593266228-61125-2-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593266228-61125-2-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-06-27 13:57, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When enable LOCKDEP, static_obj() will cause error. Because some
> __initdata static variables is before _stext:
> 
> static int static_obj(const void *obj)
> {
>         unsigned long start = (unsigned long) &_stext,
>                       end   = (unsigned long) &_end,
>                       addr  = (unsigned long) obj;
> 
>         /*
>          * static variable?
>          */
>         if ((addr >= start) && (addr < end))
>                 return 1;
> 
> [    0.067192] INFO: trying to register non-static key.
> [    0.067325] the code is fine but needs lockdep annotation.
> [    0.067449] turning off the locking correctness validator.
> [    0.067718] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-rc7-dirty #44
> [    0.067945] Call Trace:
> [    0.068369] [<ffffffe00020323c>] walk_stackframe+0x0/0xa4
> [    0.068506] [<ffffffe000203422>] show_stack+0x2a/0x34
> [    0.068631] [<ffffffe000521e4e>] dump_stack+0x94/0xca
> [    0.068757] [<ffffffe000255a4e>] register_lock_class+0x5b8/0x5bc
> [    0.068969] [<ffffffe000255abe>] __lock_acquire+0x6c/0x1d5c
> [    0.069101] [<ffffffe0002550fe>] lock_acquire+0xae/0x312
> [    0.069228] [<ffffffe000989a8e>] _raw_spin_lock_irqsave+0x40/0x5a
> [    0.069357] [<ffffffe000247c64>] complete+0x1e/0x50
> [    0.069479] [<ffffffe000984c38>] rest_init+0x1b0/0x28a
> [    0.069660] [<ffffffe0000016a2>] 0xffffffe0000016a2
> [    0.069779] [<ffffffe000001b84>] 0xffffffe000001b84
> [    0.069953] [<ffffffe000001092>] 0xffffffe000001092
> 
> static __initdata DECLARE_COMPLETION(kthreadd_done);
> 
> noinline void __ref rest_init(void)
> {
> 	...
> 	complete(&kthreadd_done);
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index e6f8016..f3586e3 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -22,6 +22,7 @@ SECTIONS
>  	/* Beginning of code and text segment */
>  	. = LOAD_OFFSET;
>  	_start = .;
> +	_stext = .;
>  	HEAD_TEXT_SECTION
>  	. = ALIGN(PAGE_SIZE);
>  
> @@ -54,7 +55,6 @@ SECTIONS
>  	. = ALIGN(SECTION_ALIGN);
>  	.text : {
>  		_text = .;
> -		_stext = .;
>  		TEXT_TEXT
>  		SCHED_TEXT
>  		CPUIDLE_TEXT


This patch has been backported to kernel 5.8.4. This causes the kernel
to crash when trying to execute the init process:

[    3.484586] AppArmor: AppArmor sha1 policy hashing enabled
[    4.749835] Freeing unused kernel memory: 492K
[    4.752017] Run /init as init process
[    4.753571] usercopy: Kernel memory overwrite attempt detected to kernel text (offset 507879, size 11)!
[    4.754838] ------------[ cut here ]------------
[    4.755651] kernel BUG at mm/usercopy.c:99!
[    4.756445] Kernel BUG [#1]
[    4.756815] Modules linked in:
[    4.757542] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.8.0-1-riscv64 #1 Debian 5.8.7-1
[    4.758372] epc: ffffffe0003b5120 ra : ffffffe0003b5120 sp : ffffffe07f783ca0
[    4.758960]  gp : ffffffe000cc7230 tp : ffffffe07f77cec0 t0 : ffffffe000cdafc0
[    4.759772]  t1 : 0000000000000064 t2 : 0000000000000000 s0 : ffffffe07f783cf0
[    4.760534]  s1 : ffffffe00095d780 a0 : 000000000000005b a1 : 0000000000000020
[    4.761309]  a2 : 0000000000000005 a3 : 0000000000000000 a4 : ffffffe000c1f340
[    4.761848]  a5 : ffffffe000c1f340 a6 : 0000000000000000 a7 : 0000000000000087
[    4.762684]  s2 : ffffffe000941848 s3 : 000000000007bfe7 s4 : 000000000000000b
[    4.763500]  s5 : 0000000000000000 s6 : ffffffe00091cc00 s7 : fffffffffffff000
[    4.764376]  s8 : 0000003ffffff000 s9 : ffffffe0769f3200 s10: 000000000000000b
[    4.765208]  s11: ffffffe07d548c40 t3 : 0000000000000000 t4 : 000000000001dcd0
[    4.766059]  t5 : ffffffe000cc8510 t6 : ffffffe000cd64aa
[    4.766712] status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
[    4.768308] ---[ end trace 1f8e733e834d4c3e ]---
[    4.769129] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    4.770070] SMP: stopping secondary CPUs
[    4.771110] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Note that this is with CONFIG_HARDENED_USERCOPY=y

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
