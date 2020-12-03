Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC412CDA84
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbgLCP6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:58:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:35256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgLCP6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:58:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607011047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3D5PmsM5o2/MsyFq3BHithOYdqUSwVQEVFuHkMBs+lE=;
        b=E1arrP/BXzu1AEH5OJMW/e258UKo0Ul3MP6ZX230bn9qxBL93sV2g9eFumgGG1Q5sbK9Uz
        SIZyWsY2F2Zr+OkyJ0z1ntFX84zBRCO2f92/exAkJUvpecu2+L1QKFWIUdK2YwD7D1h8mC
        fyANJZT+zf6OXoNGKz6xrMWUdtVJZgM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91784AC65;
        Thu,  3 Dec 2020 15:57:27 +0000 (UTC)
Date:   Thu, 3 Dec 2020 16:57:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 1/3] printk: inline log_output(),log_store() in
 vprintk_store()
Message-ID: <X8kK5nC/uWJhc4Z0@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201205341.3871-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-12-01 21:59:39, John Ogness wrote:
> In preparation for removing logbuf_lock, inline log_output()
> and log_store() into vprintk_store(). This will simplify dealing
> with the various code branches and fallbacks that are possible.
> ---
>  kernel/printk/printk.c | 134 +++++++++++++++++------------------------
>  1 file changed, 56 insertions(+), 78 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index f279d4fbd9dd..fc5e3a7d6d89 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1983,7 +1915,53 @@ int vprintk_store(int facility, int level,
>  	if (dev_info)
>  		lflags |= LOG_NEWLINE;
>  
> -	return log_output(facility, level, lflags, dev_info, text, text_len);
> +	if (lflags & LOG_CONT) {
> +		prb_rec_init_wr(&r, text_len);
> +		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
> +			memcpy(&r.text_buf[r.info->text_len], text, text_len);
> +			r.info->text_len += text_len;
> +
> +			if (lflags & LOG_NEWLINE) {
> +				r.info->flags |= LOG_NEWLINE;
> +				prb_final_commit(&e);
> +			} else {
> +				prb_commit(&e);
> +			}
> +
> +			return text_len;
> +		}
> +	}
> +
> +	prb_rec_init_wr(&r, text_len);

This is called in both branches. I would do it just once at the
beginning.

> +	if (!prb_reserve(&e, prb, &r)) {
> +		/* truncate the message if it is too long for empty buffer */
> +		truncate_msg(&text_len, &trunc_msg_len);
> +
> +		prb_rec_init_wr(&r, text_len + trunc_msg_len);
> +		if (!prb_reserve(&e, prb, &r))
> +			return 0;
> +	}
> +
> +	/* fill message */
> +	memcpy(&r.text_buf[0], text, text_len);
> +	if (trunc_msg_len)
> +		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
> +	r.info->text_len = text_len + trunc_msg_len;
> +	r.info->facility = facility;
> +	r.info->level = level & 7;
> +	r.info->flags = lflags & 0x1f;
> +	r.info->ts_nsec = ts_nsec;

This is the only location where ts_nsec is used. I would remove the
variable and call:

	r.info->ts_nsec = local_clock();

> +	r.info->caller_id = caller_id;
> +	if (dev_info)
> +		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
> +
> +	/* A message without a trailing newline can be continued. */
> +	if (!(lflags & LOG_NEWLINE))
> +		prb_commit(&e);
> +	else
> +		prb_final_commit(&e);
> +
> +	return (text_len + trunc_msg_len);
>  }

Both changes are cosmetic and I do not resist on them. Please, do the changes
if v3 is needed and you agree with them.

Anyway, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
