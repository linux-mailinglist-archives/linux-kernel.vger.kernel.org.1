Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B313269AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgIOA6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgIOA6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:58:33 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F8E120897;
        Tue, 15 Sep 2020 00:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600131509;
        bh=NxVQLW9EScB5URMkJ+lx2Qcj+SyC+38fzq5x+7YDR2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tE+pQ8tWwa6wX6HL36aNUJD8VO3NOhmHVsa/I1J4Ka6oq1qUDkpY8MeD1ciQlTCXj
         VGK74xJe0wPXnMyYEnY4ksAOafDu8sOeMsgkBCAwaSJ3sw7r3rhkSlUWDgvg/APzGm
         0qLv35HTdQtwcGFJvyHAAFWoZC2o49S7d+vidvUs=
Date:   Tue, 15 Sep 2020 09:58:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH v3 1/3] kgdb: Honour the kprobe blocklist when setting
 breakpoints
Message-Id: <20200915095824.d247c758bc355d2fa3f2ebf8@kernel.org>
In-Reply-To: <20200914130143.1322802-2-daniel.thompson@linaro.org>
References: <20200914130143.1322802-1-daniel.thompson@linaro.org>
        <20200914130143.1322802-2-daniel.thompson@linaro.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 14:01:41 +0100
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> Currently kgdb has absolutely no safety rails in place to discourage or
> prevent a user from placing a breakpoint in dangerous places such as
> the debugger's own trap entry/exit and other places where it is not safe
> to take synchronous traps.
> 
> Introduce a new config symbol KGDB_HONOUR_BLOCKLIST and modify the
> default implementation of kgdb_validate_break_address() so that we use
> the kprobe blocklist to prohibit instrumentation of critical functions
> if the config symbol is set. The config symbol dependencies are set to
> ensure that the blocklist will be enabled by default if we enable KGDB
> and are compiling for an architecture where we HAVE_KPROBES.

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  include/linux/kgdb.h      | 18 ++++++++++++++++++
>  kernel/debug/debug_core.c |  4 ++++
>  kernel/debug/kdb/kdb_bp.c |  9 +++++++++
>  lib/Kconfig.kgdb          | 14 ++++++++++++++
>  4 files changed, 45 insertions(+)
> 
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 477b8b7c908f..0d6cf64c8bb1 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -16,6 +16,7 @@
>  #include <linux/linkage.h>
>  #include <linux/init.h>
>  #include <linux/atomic.h>
> +#include <linux/kprobes.h>
>  #ifdef CONFIG_HAVE_ARCH_KGDB
>  #include <asm/kgdb.h>
>  #endif
> @@ -335,6 +336,23 @@ extern int kgdb_nmicallin(int cpu, int trapnr, void *regs, int err_code,
>  			  atomic_t *snd_rdy);
>  extern void gdbstub_exit(int status);
>  
> +/*
> + * kgdb and kprobes both use the same (kprobe) blocklist (which makes sense
> + * given they are both typically hooked up to the same trap meaning on most
> + * architectures one cannot be used to debug the other)
> + *
> + * However on architectures where kprobes is not (yet) implemented we permit
> + * breakpoints everywhere rather than blocking everything by default.
> + */
> +static inline bool kgdb_within_blocklist(unsigned long addr)
> +{
> +#ifdef CONFIG_KGDB_HONOUR_BLOCKLIST
> +	return within_kprobe_blacklist(addr);
> +#else
> +	return false;
> +#endif
> +}
> +
>  extern int			kgdb_single_step;
>  extern atomic_t			kgdb_active;
>  #define in_dbg_master() \
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index b16dbc1bf056..b1277728a835 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -188,6 +188,10 @@ int __weak kgdb_validate_break_address(unsigned long addr)
>  {
>  	struct kgdb_bkpt tmp;
>  	int err;
> +
> +	if (kgdb_within_blocklist(addr))
> +		return -EINVAL;
> +
>  	/* Validate setting the breakpoint and then removing it.  If the
>  	 * remove fails, the kernel needs to emit a bad message because we
>  	 * are deep trouble not being able to put things back the way we
> diff --git a/kernel/debug/kdb/kdb_bp.c b/kernel/debug/kdb/kdb_bp.c
> index d7ebb2c79cb8..ec4940146612 100644
> --- a/kernel/debug/kdb/kdb_bp.c
> +++ b/kernel/debug/kdb/kdb_bp.c
> @@ -306,6 +306,15 @@ static int kdb_bp(int argc, const char **argv)
>  	if (!template.bp_addr)
>  		return KDB_BADINT;
>  
> +	/*
> +	 * This check is redundant (since the breakpoint machinery should
> +	 * be doing the same check during kdb_bp_install) but gives the
> +	 * user immediate feedback.
> +	 */
> +	diag = kgdb_validate_break_address(template.bp_addr);
> +	if (diag)
> +		return diag;
> +
>  	/*
>  	 * Find an empty bp structure to allocate
>  	 */
> diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
> index 256f2486f9bd..713c17fe789c 100644
> --- a/lib/Kconfig.kgdb
> +++ b/lib/Kconfig.kgdb
> @@ -24,6 +24,20 @@ menuconfig KGDB
>  
>  if KGDB
>  
> +config KGDB_HONOUR_BLOCKLIST
> +	bool "KGDB: use kprobe blocklist to prohibit unsafe breakpoints"
> +	depends on HAVE_KPROBES
> +	select KPROBES
> +	default y
> +	help
> +	  If set to Y the debug core will use the kprobe blocklist to
> +	  identify symbols where it is unsafe to set breakpoints.
> +	  In particular this disallows instrumentation of functions
> +	  called during debug trap handling and thus makes it very
> +	  difficult to inadvertently provoke recursive trap handling.
> +
> +	  If unsure, say Y.
> +
>  config KGDB_SERIAL_CONSOLE
>  	tristate "KGDB: use kgdb over the serial console"
>  	select CONSOLE_POLL
> -- 
> 2.25.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
