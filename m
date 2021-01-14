Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C112F619A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbhANNMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:12:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:35852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbhANNMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:12:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610629889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NmtcablsKSbfT/kPFSeW/UwkLbr0hcu7CM8rAe854EM=;
        b=s2Z0T0YTG3S6gGDghmbDdbWwhK/d1psqMmti18bbuWWjtl1yOxcnqIG/3g/GOeZh2D6TQn
        a820kQgQB8vXQUDJM68bFcS6EfE4NjmLeTWBZlpsAJs0iRX9Iiokk3eTVFx5v+JhDTTSMk
        2C9i6nYnBOmaC5rw/zb+MiowW4TbRJE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2BE8CB775;
        Thu, 14 Jan 2021 13:11:29 +0000 (UTC)
Date:   Thu, 14 Jan 2021 14:11:28 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: ringbuffer: fix line counting
Message-ID: <YABDAPYB4URXtpJD@alley>
References: <20210113144234.6545-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113144234.6545-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-01-13 15:48:34, John Ogness wrote:
> Counting text lines in a record simply involves counting the number
> of newline characters (+1). However, it is searching the full data
> block for newline characters, even though the text data can be (and
> often is) a subset of that area. Since the extra area in the data
> block was never initialized, the result is that extra newlines may
> be seen and counted.

Great catch!

> Restrict newline searching to the text data length.
> 
> Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

There is a note below.

> ---
>  kernel/printk/printk_ringbuffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 6704f06e0417..8a7b7362c0dd 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1718,7 +1718,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
>  
>  	/* Caller interested in the line count? */
>  	if (line_count)
> -		*line_count = count_lines(data, data_size);
> +		*line_count = count_lines(data, len);
>  
>  	/* Caller interested in the data content? */
>  	if (!buf || !buf_size)

Another question is what line count should be returned when
the data are copied into the buffer. In this case, the text
might get shrunken even more.

Well, this case is not supported by the API at the moment.
@line_count is defined only in prb_read_valid_info() where
the buffer is always NULL.

But we might add a WARN_ONCE() or a comment there to prevent
similar mistakes in the future.

Best Regards,
Petr
