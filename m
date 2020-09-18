Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59F626F9E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgIRKGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:06:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:47342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgIRKGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:06:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600423563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mYF+Wi3WMDWoazzJwrTnv0GcjFZjh3JOohuX21hrpWI=;
        b=BqWzsdRcHXPzE/3GuwrIzIG6WirPKVg7coU3ryL1grTzF/DVVPjg+6zFjgmuOqzd6ppaJ3
        +k1+V2mO/F6cwjlJxw4EzSknYjITWLTpnolbLwOSg0a94UOSBIc63dSAndVoFzJw9Eleh7
        ZmkF+oyRTBfHhB13XZuYXZ7qiUFXTJc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1FE04B1B9;
        Fri, 18 Sep 2020 10:06:37 +0000 (UTC)
Date:   Fri, 18 Sep 2020 12:06:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 1/3] printk: move printk_info into separate array
Message-ID: <20200918100602.GB14605@alley>
References: <20200917131644.25838-1-john.ogness@linutronix.de>
 <20200917131644.25838-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917131644.25838-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-17 15:22:42, John Ogness wrote:
> The majority of the size of a descriptor is taken up by meta data,
> which is often not of interest to the ringbuffer (for example,
> when performing state checks). Since descriptors are often
> temporarily stored on the stack, keeping their size minimal will
> help reduce stack pressure.
> 
> Rather than embedding the printk_info into the descriptor, create
> a separate printk_info array. The index of a descriptor in the
> descriptor array corresponds to the printk_info with the same
> index in the printk_info array. The rules for validity of a
> printk_info match the existing rules for the data blocks: the
> descriptor must be in a consistent state.

I like this approach.

IMHO, it better separates dict_ring- and printk-specific metadata.

The three printk-specific values (seq, caller_id, len) are still
accessed by the ring buffer code. It is not ideal. But it helps
to hide tricky operations in the ring buffer API, keep the code
more safe and sane. These exceptions are actually better
visible now.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1097,6 +1097,7 @@ static char setup_dict_buf[CONSOLE_EXT_LOG_MAX] __initdata;
>  
>  void __init setup_log_buf(int early)
>  {
> +	struct printk_info *new_infos;
>  	unsigned int new_descs_count;
>  	struct prb_desc *new_descs;
>  	struct printk_info info;
> @@ -1156,6 +1157,17 @@ void __init setup_log_buf(int early)
>  		return;
>  	}
>  
> +	new_descs_size = new_descs_count * sizeof(struct printk_info);

Must be stored into new variable, e.g.  new_infos_size.=

> +	new_infos = memblock_alloc(new_descs_size, LOG_ALIGN);
> +	if (unlikely(!new_infos)) {
> +		pr_err("log_buf_len: %zu info bytes not available\n",
> +		       new_descs_size);
> +		memblock_free(__pa(new_descs), new_log_buf_len);
> +		memblock_free(__pa(new_dict_buf), new_log_buf_len);

The above two calls have wrong size.

The same problem is there also in the error path when new_descs
allocation fail. It might be better to handle this using some
goto err_* tagrets.

Please, fix the old problem in a separate patch.

> +		memblock_free(__pa(new_log_buf), new_log_buf_len);
> +		return;
> +	}
> +
>  	prb_rec_init_rd(&r, &info,
>  			&setup_text_buf[0], sizeof(setup_text_buf),
>  			&setup_dict_buf[0], sizeof(setup_dict_buf));


> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1726,12 +1762,12 @@ static bool copy_data(struct prb_data_ring *data_ring,
>  	/*
>  	 * Actual cannot be less than expected. It can be more than expected
>  	 * because of the trailing alignment padding.
> +	 *
> +	 * Note that invalid @len values can occur because the caller loads
> +	 * the value during an allowed data race.

I hope that this will not bite us in the future. The fact is that
copying the entire struct printk_info in get_desc() is ugly and
copy_data() has to be careful anyway.

>  	 */
> -	if (WARN_ON_ONCE(data_size < (unsigned int)len)) {
> -		pr_warn_once("wrong data size (%u, expecting >=%hu) for data: %.*s\n",
> -			     data_size, len, data_size, data);
> +	if (data_size < (unsigned int)len)


>  		return false;
> -	}
>  
>  	/* Caller interested in the line count? */
>  	if (line_count)

Otherwise, I like this patch.

Best Regards,
Petr
