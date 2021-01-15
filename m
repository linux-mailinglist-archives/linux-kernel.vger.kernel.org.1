Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188B02F7DED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbhAOOQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbhAOOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:16:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DC8C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:16:05 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610720163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPi6fTcj3IVxsBPOSRmGWJff7Jf+U46uJ6tlls9bJWg=;
        b=bJhF3AqsBHe8cSV/ZwgFZNa3yMWmZL0s/N9YcybooMrLYzpP3Ibn++du0g8G1etuGGLxc8
        l3Z9NTQLFIfUtu1HNbe2uq1oUbhsZmpPUNPMiWbrXrZCsVONLxZl0wRKwRKU6WbC23P4bt
        bjEp7HtkdNk2lhoaYwLO+MmczNb8nY/R6KiVj4jlTr4hnwVVpo5jqpuyyA6XF0+upiJQHw
        ggD94kGxR8WVrz2YEtnomPJT0kGMSa9pHkOdbhqwt+ODiiSEXEc3LI4kgQeM0xALAZfCxO
        tKY8ReOjy6bGk99myXjAB4jlqdC/zC+LCuFOHOKb9/cFqWDpF5iHmd0JQCHl6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610720163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPi6fTcj3IVxsBPOSRmGWJff7Jf+U46uJ6tlls9bJWg=;
        b=+Qko1N7vlyUz7BuHTXKGyx4U+EI++yyckEoCJGBpw64EJmVfsx2ckgjpIR0AMJdJY/ceKx
        W2awZC0oblVz9zAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
In-Reply-To: <20210114170412.4819-1-john.ogness@linutronix.de>
References: <20210114170412.4819-1-john.ogness@linutronix.de>
Date:   Fri, 15 Jan 2021 15:22:03 +0106
Message-ID: <878s8ujnfg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

I noticed some minor errors in the commit log and comments...

On 2021-01-14, John Ogness <john.ogness@linutronix.de> wrote:
> Before commit b6cf8b3f3312 ("printk: add lockless ringbuffer"),
> msg_print_text()

The correct commit where the change was made is: 896fbe20b4e2333fb55
("printk: use the lockless ringbuffer")

> would only write up to size-1 bytes into the
> provided buffer. Some callers expect this behavior and append
> a terminator to returned string. In particular:
>
> arch/powerpc/xmon/xmon.c:dump_log_buf()
> arch/um/kernel/kmsg_dump.c:kmsg_dumper_stdout()
>
> msg_print_text() has been replaced by record_print_text(), which
> currently fills the full size of the buffer. This causes a
> buffer overflow for the above callers.
>
> Change record_print_text() so that it will only use size-1 bytes
> for text data. Also, for paranoia sakes, add a terminator after
> the text data.
>
> And finally, document this behavior so that it is clear that only
> size-1 bytes are used and a terminator is added.
>
> Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")

Ditto for Fixes tag:

896fbe20b4e2333fb55 ("printk: use the lockless ringbuffer")

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ffdd0dc7ec6d..73f9eae19f05 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1293,9 +1293,15 @@ static size_t info_print_prefix(const struct printk_info  *info, bool syslog,
>   *   - Add prefix for each line.
>   *   - Add the trailing newline that has been removed in vprintk_store().
>   *   - Drop truncated lines that do not longer fit into the buffer.
> + *   - Add a trailing newline.
> + *   - Add a string terminator.

I didn't realize that the newline was already listed (since it was out
of order). I recommend these comments changing to:

- Add prefix for each line.
- Drop truncated lines that no longer fit into the buffer.
- Add the trailing newline that has been removed in vprintk_store().
- Add a string terminator.

Can you fixup the patch for the commit or do you need a v2?

John Ogness
