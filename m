Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDAC2759BB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIWOR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:17:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:49836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWORZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:17:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600870644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0OVhQPNL/lRHEob24DJ/83f5alIqhGthtJlH+2DfDo=;
        b=c1Bg5peZ7S3MvWN3v3ypExI6QIHqmSH50IDBZmW+ffkDXwz+LInIR8n882qaYDCZov+ehc
        L3fC7m/Bu8UWgmc26adGQiyshOQVyZQVJB4QjfqwDz2Nje11GJdlkKfcgjZpEE+lY3QfH1
        8DnPoUENLJXqojG9L1kNH4GaONOH7+Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7BA3AD57;
        Wed, 23 Sep 2020 14:18:01 +0000 (UTC)
Date:   Wed, 23 Sep 2020 16:17:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 1/5] printk: get new seq before enabling interrupts
Message-ID: <20200923141723.GA6442@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922153816.5883-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-09-22 17:44:12, John Ogness wrote:
> After copying all records to the dynamic ringbuffer, setup_log_buf()
> checks to see if any records were dropped during the switch. However,
> it needs to check before enabling interrupts since new records could
> arrive in an interrupt, thus causing setup_log_buf() to erroneously
> think that it had dropped messages.

Have you seen the problem, please?

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1fe3d0cb2fe0..00bc1fce3299 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1181,12 +1181,12 @@ void __init setup_log_buf(int early)
>  	 */
>  	prb = &printk_rb_dynamic;
>  
> +	seq = prb_next_seq(&printk_rb_static) - seq;
> +
>  	logbuf_unlock_irqrestore(flags);
>  
> -	if (seq != prb_next_seq(&printk_rb_static)) {

I can't see how these two values could get modified after enabling interrupts.

  + @seq is set in the for-cycle before the interrupts are enabled.

  + @prb is updated before the interrupts are  enabled. So that
    the static buffer should not longer be used after that.

> -		pr_err("dropped %llu messages\n",
> -		       prb_next_seq(&printk_rb_static) - seq);
> -	}
> +	if (seq)
> +		pr_err("dropped %llu messages\n", seq);
>  
>  	pr_info("log_buf_len: %u bytes\n", log_buf_len);
>  	pr_info("early log buf free: %u(%u%%)\n",

Best Regards,
Petr
