Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2D620C581
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 04:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgF1C7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 22:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgF1C7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 22:59:50 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C449A2080C;
        Sun, 28 Jun 2020 02:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593313190;
        bh=sbQMZend8KSxiw8gOOfzjzEdTwk4tp9URNJS8mJYa+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hGHAMylK7A0agHTX8RpBjZx86ofHLEMji07TlApTbh/WFsA0CNL6wtoBXChXIIvAO
         5as3zBX/O2vShnD3N7ZDJOjbbVFKkqPTqwpnQO3ZACRdSmudz0PPHcJMEAkUwNPuMg
         VeX0JJLsLQtmv6+lVXrzMYp+VIPp2Y0PLuAuq/Jc=
Date:   Sun, 28 Jun 2020 11:59:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     guoren@kernel.org
Cc:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] riscv: Fixup compile error BUILD_BUG_ON failed
Message-Id: <20200628115945.335b92c517cb8a8fa87be759@kernel.org>
In-Reply-To: <1593274802-46332-1-git-send-email-guoren@kernel.org>
References: <1593274802-46332-1-git-send-email-guoren@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jun 2020 16:20:02 +0000
guoren@kernel.org wrote:

> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Unfortunately, the current code couldn't be compiled, because
> BUILD_BUG_ON needs a static defined value, not a dynamic
> variable with a0 regs. Just use it inline as a solution.
> 
>   CC      arch/riscv/kernel/patch.o
> In file included from ./include/linux/kernel.h:11,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/preempt.h:11,
>                  from ./include/linux/spinlock.h:51,
>                  from arch/riscv/kernel/patch.c:6:
> In function ‘fix_to_virt’,
>     inlined from ‘patch_map’ at arch/riscv/kernel/patch.c:37:17:
> ./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_205’ declared with attribute error: BUILD_BUG_ON failed: idx >= __end_of_fixed_addresses
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^
> ./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
>     prefix ## suffix();    \
>     ^~~~~~
> ./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>   ^~~~~~~~~~~~~~~~
> ./include/asm-generic/fixmap.h:32:2: note: in expansion of macro ‘BUILD_BUG_ON’
>   BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
>   ^~~~~~~~~~~~
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/kernel/patch.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index d4a64df..f8e84f2 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -20,7 +20,7 @@ struct patch_insn {
>  };
>  
>  #ifdef CONFIG_MMU
> -static void *patch_map(void *addr, int fixmap)
> +static inline void *patch_map(void *addr, int fixmap)

Would we be better to use "__always_inline" as same as fix_to_virt?
And also, could you add a comment why we need to make it inline?

Thank you,

>  {
>  	uintptr_t uintaddr = (uintptr_t) addr;
>  	struct page *page;
> @@ -37,7 +37,6 @@ static void *patch_map(void *addr, int fixmap)
>  	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
>  					 (uintaddr & ~PAGE_MASK));
>  }
> -NOKPROBE_SYMBOL(patch_map);
>  
>  static void patch_unmap(int fixmap)
>  {
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
