Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E412CF14E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgLDPxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:53:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:47354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgLDPxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:53:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607097156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b3iAelrWpCA6kG9YiXezWNTW0pK+b++4D3fQ1pZaWmU=;
        b=QAdwxoBToAVSYeFOIw8Pt4Cwtj4ym5GUK8lrzdMa93PGNNJSB2aScN917hvkveLdeMILJL
        RwCgRGG2vWiATSow7jjv5SfhrbHLSoLLQMI9f6Iw4V3YSK9QXKKZNPu/Te7JeHzValLbfT
        lWgejoMgME0039EBWMv0bEmAOCgi+ss=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82AECAC9A;
        Fri,  4 Dec 2020 15:52:36 +0000 (UTC)
Date:   Fri, 4 Dec 2020 16:52:35 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: devkmsg: was [PATCH next v2 3/3] printk: remove logbuf_lock, add
 syslog_lock
Message-ID: <X8pbQ94Buqxhlqsk@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201205341.3871-4-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-12-01 21:59:41, John Ogness wrote:
> Since the ringbuffer is lockless, there is no need for it to be
> protected by @logbuf_lock. Remove @logbuf_lock.

I am going to split the feedback into few mails. It might make sense
to split also this patch into few more pieces that would remove the lock
from a particular interface.


> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e9018c4e1b66..7385101210be 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -785,7 +749,6 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
>  	if (offset)
>  		return -ESPIPE;
>  
> -	logbuf_lock_irq();

user->seq manipulation is not longer safe from the atomicity point of view.

One solution would be to use atomic variable in struct devkmsg_user().
Another solution would be to synchronize it with user->lock like we do
in devkmsg_read().

user->lock looks like an overhead. But it actually would make sense to
prevent seek in the middle of a read.

>  	switch (whence) {
>  	case SEEK_SET:
>  		/* the first record */
> @@ -820,7 +782,6 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
>  
>  	poll_wait(file, &log_wait, wait);
>  
> -	logbuf_lock_irq();
>  	if (prb_read_valid(prb, user->seq, NULL)) {

Same here. The atomicity of user->seq read/write is not guaranteed.


>  		/* return error when data has vanished underneath us */
>  		if (user->seq < prb_first_valid_seq(prb))

Best Regards,
Petr
