Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3556B2F6464
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbhANPVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:21:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:34674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbhANPVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:21:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610637617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G8ZIziecbQcaUxe0OG0xcNS/Ea5R2ZX6Xzj4XWh3u1o=;
        b=RpnDxgUW7H/ak56r0u3q7zxEFnrCp+ncEWyrIB00dtEEcvrPbqXi+CFU0DJF2NWMnJ6lZa
        +IxChXoxuQ6uKHy9VQ3A6z4IZ5Uxqz/4mj9ZTL+ATkKqXKMflxHbfox69sngegd5OHRLFP
        wPc/eFep72KVto0/lClVkrG0lSk1Jcw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5751DAC24;
        Thu, 14 Jan 2021 15:20:17 +0000 (UTC)
Date:   Thu, 14 Jan 2021 16:20:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: printk: kmsg_dump_get_line_nolock() buffer overflow
Message-ID: <YABhMFlIpQ/5uQ7s@alley>
References: <87im8038v7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im8038v7.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-01-13 21:06:28, John Ogness wrote:
> Hello,
> 
> I have discovered that kmsg_dump_get_line_nolock() is not allowed to
> fill the full buffer that it is provided. It should leave at least 1
> byte free so that callers can append a terminator.
> 
> Example from arch/powerpc/xmon/xmon.c:
> 
>     kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len);
>     buf[len] = '\0';
> 
> This unusual behavior was not noticed and with commit 896fbe20b4e2
> ("printk: use the lockless ringbuffer") the implementation of
> kmsg_dump_get_line_nolock() was changed so that the full buffer can be
> filled. This means that the two kmsg_dump_get_line*() users currently
> can have a 1-byte buffer overflow.

Just to make it clear. There is no visible change in
kmsg_dump_get_line_nolock() in the commit 896fbe20b4e2
("printk: use the lockless ringbuffer").

The eal change happened in record_printk_text():

-		if (buf) {
-			if (prefix_len + text_len + 1 >= size - len)
+		/*
+		 * Truncate the text if there is not enough space to add the
+		 * prefix and a trailing newline.
+		 */
+		if (len + prefix_len + text_len + 1 > buf_size) {
+			/* Drop even the current line if no space. */
+			if (len + prefix_len + line_len + 1 > buf_size)
 				break;

It replaced ">=" with ">".

It is pitty that I have missed this. I remember that I discussed
exactly this problem before, see
https://lore.kernel.org/lkml/20190710080402.ab3f4qfnvez6dhtc@axis.com/

And I did exactly the same mistake. I have missed the two users in
"arch/powerpc" and "arch/um".

> This unusual kmsg_dump_get_line_nolock() behavior seems to have been
> accidentally introduced with commit 3ce9a7c0ac28 ("printk() - restore
> prefix/timestamp printing for multi-newline strings"). Indeed, the
> whitespace on the line that causes this behavior is not conform, leading
> me to think it was a last-minute change or a typo. (The behavior is
> caused by the ">=" instead of an expected ">".)
> 
> +    if (print_prefix(msg, syslog, NULL) +
> +        text_len + 1>= size - len)
> +            break;
> 
> Perhaps there was some paranoia involved because this same commit also
> fixes a buffer overflow in the old implementation:
> 
> -    if (len + msg->text_len > size)
> -            return -EINVAL;
> -    memcpy(text + len, log_text(msg), msg->text_len);
> -    len += msg->text_len;
> -    text[len++] = '\n';

It is clear that this problem happens repeatedly.

Now, the change in record_printk_text() behavior affects also other
callers. For example, syslog_print() fills the buffer completely
as well now. I could imagine a userspace code that does the same
mistake and it works just by chance.

We should restore the original record_printk_text() behavior
and add the comment explaining why it is done this way. And
I would even explicitly add the trailing '\0' as suggested at
https://lore.kernel.org/lkml/20190710121049.rwhk7fknfzn3cfkz@pathway.suse.cz/#t

Best Regards,
Petr
