Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF79627C710
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbgI2LvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:51:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730256AbgI2LvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:51:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601380268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kqP+VKUP21zbmiPlzTiabxKdYjDjr6MWefWBXor11nI=;
        b=RWzdT8HozkPtvNJIlHGAXaiiHv9RQOYyI2BSxbDTTODQn+7Bn/STSdQTiDrHOxUV488Iwa
        pD/M93H81moz7S098/N8BeYKhHAayxocOVNWuCItftyESbmgBGoJnCtUoEEN5zb7K98K+2
        taXW2fweQO8UWjGsTSq2kMl3xvqo2xo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E921ACB8;
        Tue, 29 Sep 2020 11:51:08 +0000 (UTC)
Date:   Tue, 29 Sep 2020 13:51:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 1/2] printk: avoid and/or handle record truncation
Message-ID: <20200929115107.GO6442@alley>
References: <20200926015526.8921-1-john.ogness@linutronix.de>
 <20200926015526.8921-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926015526.8921-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-09-26 04:01:25, John Ogness wrote:
> If a reader provides a buffer that is smaller than the message text,
> the @text_len field of @info will have a value larger than the buffer
> size. If readers blindly read @text_len bytes of data without
> checking the size, they will read beyond their buffer.

Great catch!

> Add this check to record_print_text() to properly recognize when such
> truncation needs to occur.
> 
> Add a maximum size argument to the ringbuffer function to extend
> records so that records can not be created that are larger than the
> buffer size of readers.
> 
> When extending records (LOG_CONT), do not extend records beyond
> LOG_LINE_MAX since that is the maximum size available in the buffers
> used by consoles and syslog.
> 
> Fixes: f5f022e53b87 ("printk: reimplement log_cont using record extension")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>  kernel/printk/printk.c            |  7 ++++++-
>  kernel/printk/printk_ringbuffer.c | 12 ++++++++++--
>  kernel/printk/printk_ringbuffer.h |  2 +-
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 78f68b4830dc..270f19b60e6f 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1357,6 +1357,11 @@ static size_t record_print_text(struct printk_record *r, bool syslog,
>  	size_t len = 0;
>  	char *next;
>  
> +	if (text_len > buf_size) {
> +		text_len = buf_size;
> +		truncated = true;

@truncate must not be set here. Otherwise, the prefix would not be
added when there no '\n' in the entire string. It would call:

			/* Drop truncated line(s). */
			if (truncated)
				break;

before copying the prefix.

It is enough to remove the line. It will be set in the very first
cycle anyway. We need to add one prefix at all. It would require to
truncate even more bytes.

Otherwise, the patch looks good to me.

Best Regards,
Petr
