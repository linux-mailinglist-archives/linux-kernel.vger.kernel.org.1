Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBB9275D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgIWQgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:36:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:57348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbgIWQgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:36:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600878996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XfK4qkocWkT369sQkGo1FXbrIPTkvdIkrivHJ0OU0U4=;
        b=SqkYsATK3djIR4O+BKElvHh4MDMChDShXUAf3e1vma0yd4i9Z8jVuRqpDrtO8tDTw0XXyE
        u5Uajv95I/l7V2zQiyIrFfjqoaDbe/g6bmI5clGQ4M72ET2bMS/SGR2no975hEU0CkL1Wx
        RTsPTE2yV08EObUWA2wABhkB6jsHZVs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F6F4AAC7;
        Wed, 23 Sep 2020 16:37:13 +0000 (UTC)
Date:   Wed, 23 Sep 2020 18:36:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 5/5] printk: remove nmi safe buffers
Message-ID: <20200923163635.GE6442@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922153816.5883-6-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-09-22 17:44:16, John Ogness wrote:
> Since the ringbuffer is now lockless, new records can be inserted
> directly from NMI context. There is no need for the NMI safe
> buffers. Handle all NMI printk() calls using defer_console_output()
> to avoid calling console drivers that might have their own locks.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk_safe.c | 47 ++++---------------------------------
>  1 file changed, 4 insertions(+), 43 deletions(-)
> 
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index 7c186cefdb50..720935d19a3e 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -355,10 +324,11 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
>  #endif
>  
>  	/*
> -	 * Try to use the main logbuf even in NMI. But avoid calling console
> +	 * Use the main ringbuffer in NMI. But avoid calling console
>  	 * drivers that might have their own locks.
>  	 */
> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
> +	if ((this_cpu_read(printk_context) &
> +	     (PRINTK_NMI_CONTEXT_MASK | PRINTK_NMI_DIRECT_CONTEXT_MASK))) {
>  		int len;
>  
>  		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
> @@ -366,10 +336,6 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
>  		return len;
>  	}
>  
> -	/* Use extra buffer in NMI. */
> -	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
> -		return vprintk_nmi(fmt, args);
> -
>  	/* Use extra buffer to prevent a recursion deadlock in safe mode. */
>  	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK)
>  		return vprintk_safe(fmt, args);

I still hope that we will be able to get rid of printk_safe completely.

I would expect that only two situations would need special handling
with the lockless ringbuffer:

   + call vkdb_printf() in kdb context
   + defer console in NMI context

Eventually we should prevent too big level of recursion.

Best Regards,
Petr
