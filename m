Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078AF3023D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 11:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbhAYKop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 05:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbhAYKie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:38:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24625C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 02:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iMGBNmPvE4v1jywfgHxZnsC9PInWaaImOpYiuSDeYH8=; b=XGpRgv3UJ1zJBW1lmzkCciStOJ
        Fp22GXksW20qouvjnkQyOJRz7xJ/3hGCev25dsQRZyK/godEYPjEsGRwphqnRH5iY36uiHOXF5YYO
        wfZ9qYFYEdIe9KbG9A3ZzKFLW89p7SQzfmydp3NSQ3fDzrUzZ2/FednXm54Jl4a9FJbd1A3M3Ao5a
        hdz912DQaJ0cw97ygdFs9UXvjl1I4lgKmwroHS7zEzbUiJgH7haBcPFJs+Mfu+O3VNYkXMjRwRDJL
        PS8Bf9tdx6drZsIMe+gOcGTMfqWY7ollFuNRcaxftHUXWMT6UZQkQgfSwvXpohLwsULrZaQIfU84L
        aDLSzj1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l3zF1-0045UB-A4; Mon, 25 Jan 2021 10:37:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61EB53010C8;
        Mon, 25 Jan 2021 11:37:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4369D2B0615C6; Mon, 25 Jan 2021 11:37:02 +0100 (CET)
Date:   Mon, 25 Jan 2021 11:37:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Add new pr_*_deferred_once() variants
Message-ID: <YA6fTuFEaCjFQB3h@hirez.programming.kicks-ass.net>
References: <20210123233741.3614408-1-qais.yousef@arm.com>
 <20210123233741.3614408-2-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123233741.3614408-2-qais.yousef@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 11:37:40PM +0000, Qais Yousef wrote:
> To allow users in code where printk is not allowed.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  include/linux/printk.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index fe7eb2351610..92c0978c7b44 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -480,21 +480,45 @@ extern int kptr_restrict;
>  	printk_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>  /* no pr_cont_once, don't do that... */
>  
> +#define pr_emerg_deferred_once(fmt, ...)				\
> +	printk_deferred_once(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
> +#define pr_alert_deferred_once(fmt, ...)				\
> +	printk_deferred_once(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
> +#define pr_crit_deferred_once(fmt, ...)					\
> +	printk_deferred_once(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
> +#define pr_err_deferred_once(fmt, ...)					\
> +	printk_deferred_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
> +#define pr_warn_deferred_once(fmt, ...)					\
> +	printk_deferred_once(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
> +#define pr_notice_deferred_once(fmt, ...)				\
> +	printk_deferred_once(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
> +#define pr_info_deferred_once(fmt, ...)					\
> +	printk_deferred_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> +/* no pr_cont_deferred_once, don't do that... */

I absolutely detest this.. the whole _deferred thing is an abomination.

We should be very close to printk not needing this anymore, printk
people?
