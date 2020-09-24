Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C342768F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgIXGd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIXGd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:33:57 -0400
Received: from localhost (unknown [84.241.198.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C4A82311A;
        Thu, 24 Sep 2020 06:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600929237;
        bh=4/P3ZUYO2V2jRyA7YB32zRBOvcFdYM0p0Ma1pDQrDbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAo4sEazkhdK5B0M9MG9nHzvZJzn+idWiYi7GAE0HvYBHYZVHtM4H61RitFksOEug
         vSWE0oyfS2DsID2B00xSqxOzSaip13wFW+oapcQ8+KkE9y5RhieLYgRhwLecv7OCHr
         /42XPUKdWpl9ldaKVip6S26E4mACsXPTT9BIqiRs=
Date:   Thu, 24 Sep 2020 08:33:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     rostedt@goodmis.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, tkjos@google.com,
        Mohammed Khajapasha <mkhaja@codeaurora.org>
Subject: Re: [PATCH 2/2] printk: Make the console flush configurable in
 hotplug path
Message-ID: <20200924063352.GB592892@kroah.com>
References: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
 <1600906112-126722-2-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600906112-126722-2-git-send-email-psodagud@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 05:08:32PM -0700, Prasad Sodagudi wrote:
> From: Mohammed Khajapasha <mkhaja@codeaurora.org>
> 
> The thread which initiates the hot plug can get scheduled
> out, while trying to acquire the console lock,
> thus increasing the hot plug latency. This option
> allows to selectively disable the console flush and
> in turn reduce the hot plug latency.
> 
> Signed-off-by: Mohammed Khajapasha <mkhaja@codeaurora.org>
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> ---
>  init/Kconfig           | 10 ++++++++++
>  kernel/printk/printk.c | 10 ++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index d6a0b31..9ce39ba 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -699,6 +699,16 @@ config LOG_BUF_SHIFT
>  		     13 =>  8 KB
>  		     12 =>  4 KB
>  
> +config CONSOLE_FLUSH_ON_HOTPLUG
> +	bool "Enable console flush configurable in hot plug code path"
> +	depends on HOTPLUG_CPU
> +	def_bool n

n is the default, no need to list it.

> +	help
> +	In cpu hot plug path console lock acquire and release causes the
> +	console to flush. If console lock is not free hot plug latency
> +	increases. So make console flush configurable in hot plug path
> +	and default disabled to help in cpu hot plug latencies.

Why would you not want this option?

Why isn't this just a bugfix?

> +
>  config LOG_CPU_MAX_BUF_SHIFT
>  	int "CPU kernel log buffer size contribution (13 => 8 KB, 17 => 128KB)"
>  	depends on SMP
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 9b75f6b..f02d3ef 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2283,6 +2283,8 @@ void resume_console(void)
>  	console_unlock();
>  }
>  
> +#ifdef CONFIG_CONSOLE_FLUSH_ON_HOTPLUG
> +
>  /**
>   * console_cpu_notify - print deferred console messages after CPU hotplug
>   * @cpu: unused
> @@ -2302,6 +2304,8 @@ static int console_cpu_notify(unsigned int cpu)
>  	return 0;
>  }
>  
> +#endif
> +
>  /**
>   * console_lock - lock the console system for exclusive use.
>   *
> @@ -2974,7 +2978,7 @@ void __init console_init(void)
>  static int __init printk_late_init(void)
>  {
>  	struct console *con;
> -	int ret;
> +	int ret = 0;
>  
>  	for_each_console(con) {
>  		if (!(con->flags & CON_BOOT))
> @@ -2996,13 +3000,15 @@ static int __init printk_late_init(void)
>  			unregister_console(con);
>  		}
>  	}
> +#ifdef CONFIG_CONSOLE_FLUSH_ON_HOTPLUG

#ifdef in .c code is a mess to maintain.

>  	ret = cpuhp_setup_state_nocalls(CPUHP_PRINTK_DEAD, "printk:dead", NULL,
>  					console_cpu_notify);
>  	WARN_ON(ret < 0);
>  	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "printk:online",
>  					console_cpu_notify, NULL);
>  	WARN_ON(ret < 0);
> -	return 0;
> +#endif

What happens if we don't make these calls entirely?  Why not just remove
them as who wants extra latency for their system?

thanks,

greg k-h
