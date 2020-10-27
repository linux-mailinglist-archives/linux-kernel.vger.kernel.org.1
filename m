Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1C29A164
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502122AbgJ0AjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439471AbgJ0AbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:31:00 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB22022242;
        Tue, 27 Oct 2020 00:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603758660;
        bh=29Jiz90kcazpK9sZKa2bxz0PY8r5UJjzXqp1TTrFHTk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QED7Fn44DIfYfkOLYwrJ2c/KOIwnBPlUlrL29tIrlr0xaWBSbPqDBHzypiEBnLT5V
         If6O4UbaE6OjkmhhDPa+YBgEJ1t4Ni1Nso0gFvBhQ9d4HVlza5VS/7kMiVarFLD/+Q
         1tR8HpHjr5xYJ/CL2LpXyGxO/O/i/yIzdBFsGGzA=
Date:   Tue, 27 Oct 2020 09:30:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: kprobes: fix arch_init_kprobes() prototype
Message-Id: <20201027093057.c685a14b386acacb3c449e3d@kernel.org>
In-Reply-To: <20201026221241.3897396-1-arnd@kernel.org>
References: <20201026221241.3897396-1-arnd@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 23:12:00 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> With extra warnings enabled, gcc complains about this function
> definition:
> 
> arch/arm/probes/kprobes/core.c: In function 'arch_init_kprobes':
> arch/arm/probes/kprobes/core.c:465:12: warning: old-style function definition [-Wold-style-definition]
>   465 | int __init arch_init_kprobes()
> 
> Fixes: 24ba613c9d6c ("ARM kprobes: core code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks Arnd!

> ---
>  arch/arm/probes/kprobes/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> index a9653117ca0d..e513d8a46776 100644
> --- a/arch/arm/probes/kprobes/core.c
> +++ b/arch/arm/probes/kprobes/core.c
> @@ -462,7 +462,7 @@ static struct undef_hook kprobes_arm_break_hook = {
>  
>  #endif /* !CONFIG_THUMB2_KERNEL */
>  
> -int __init arch_init_kprobes()
> +int __init arch_init_kprobes(void)
>  {
>  	arm_probes_decode_init();
>  #ifdef CONFIG_THUMB2_KERNEL
> -- 
> 2.27.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
