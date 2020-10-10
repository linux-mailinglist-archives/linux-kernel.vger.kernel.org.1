Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B4728A307
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgJJW7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731904AbgJJTyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:54:11 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50376222B8;
        Sat, 10 Oct 2020 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602340744;
        bh=VKttiuENtiWHH3T6V9S6RmhCbu0RiQwdS2O9eY84YMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ynh8xWT2d+PyrCHPtPN5G2l9stBhUIS0W7QPOeNDyhFYu/7J5K7Z7wqP6Vjv3c9w7
         jPwjmj7ZepWTE7xhdFO7xbl2myPnAh0ofPaTVhOgwSeiKtIl4d24XSGEaC4h/eHBTv
         4k1m+wLuen+otB9vGZQopMKO9HHeQPlEob5KzHzE=
Date:   Sat, 10 Oct 2020 23:39:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] tracing: Move is_good_name() from trace_probe.h to
 trace.h
Message-Id: <20201010233900.8a8e0e3c4f2e5e897cfe14ef@kernel.org>
In-Reply-To: <235fe1ca3bac2ab40f069f3e62788fc3ec768fea.1602255803.git.zanussi@kernel.org>
References: <cover.1602255803.git.zanussi@kernel.org>
        <235fe1ca3bac2ab40f069f3e62788fc3ec768fea.1602255803.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Oct 2020 10:17:08 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> is_good_name() is useful for other trace infrastructure, such as
> synthetic events, so make it available via trace.h.
> 

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace.h       | 13 +++++++++++++
>  kernel/trace/trace_probe.h | 13 -------------
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 5b0e797cacdd..a94852838491 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -19,6 +19,7 @@
>  #include <linux/glob.h>
>  #include <linux/irq_work.h>
>  #include <linux/workqueue.h>
> +#include <linux/ctype.h>
>  
>  #ifdef CONFIG_FTRACE_SYSCALLS
>  #include <asm/unistd.h>		/* For NR_SYSCALLS	     */
> @@ -2090,4 +2091,16 @@ static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
>  	iter->pos = -1;
>  }
>  
> +/* Check the name is good for event/group/fields */
> +static inline bool is_good_name(const char *name)
> +{
> +	if (!isalpha(*name) && *name != '_')
> +		return false;
> +	while (*++name != '\0') {
> +		if (!isalpha(*name) && !isdigit(*name) && *name != '_')
> +			return false;
> +	}
> +	return true;
> +}
> +
>  #endif /* _LINUX_KERNEL_TRACE_H */
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 04d00987da69..2f703a20c724 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -16,7 +16,6 @@
>  #include <linux/tracefs.h>
>  #include <linux/types.h>
>  #include <linux/string.h>
> -#include <linux/ctype.h>
>  #include <linux/ptrace.h>
>  #include <linux/perf_event.h>
>  #include <linux/kprobes.h>
> @@ -348,18 +347,6 @@ bool trace_probe_match_command_args(struct trace_probe *tp,
>  #define trace_probe_for_each_link_rcu(pos, tp)	\
>  	list_for_each_entry_rcu(pos, &(tp)->event->files, list)
>  
> -/* Check the name is good for event/group/fields */
> -static inline bool is_good_name(const char *name)
> -{
> -	if (!isalpha(*name) && *name != '_')
> -		return false;
> -	while (*++name != '\0') {
> -		if (!isalpha(*name) && !isdigit(*name) && *name != '_')
> -			return false;
> -	}
> -	return true;
> -}
> -
>  #define TPARG_FL_RETURN BIT(0)
>  #define TPARG_FL_KERNEL BIT(1)
>  #define TPARG_FL_FENTRY BIT(2)
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
