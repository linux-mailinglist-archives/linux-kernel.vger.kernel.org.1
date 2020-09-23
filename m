Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29BC275AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIWOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:52:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:58938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgIWOwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:52:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600872729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CUTpQM5HoufUKrkApLxYrepbdg1WoLwvxJQbyZvYlKI=;
        b=VHGUJgQpkN2viXPP+1lqdbr+ePgnIz6qnw302dVdwS5CfjP7ygWKrpSj796t6clly5bC0Q
        Nd95zn5JUa63C4imf9leKzZ+kVmTVIMT/P8XqaG0Z3ovJzQuHcbAG5X4WVHCTi2ZRRF+F+
        noBpN0dHsxzVPnluEhN2PE1hibEFoqw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E3E7AD43;
        Wed, 23 Sep 2020 14:52:46 +0000 (UTC)
Date:   Wed, 23 Sep 2020 16:52:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 2/5] printk: kmsg_dump_rewind_nolock: start from
 first record
Message-ID: <20200923145208.GB6442@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922153816.5883-3-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-09-22 17:44:13, John Ogness wrote:
> kmsg_dump_rewind_nolock() accesses @clear_seq without any locking.
> However, accessing this global variable requires holding
> @logbuf_lock. For the _nolock() variant, start from the first record
> in the ringbuffer rather than the @clear_seq record.

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 00bc1fce3299..cff13b33e926 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3410,11 +3410,12 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
>   * kmsg_dump_get_buffer() can be called again and used multiple
>   * times within the same dumper.dump() callback.
>   *
> - * The function is similar to kmsg_dump_rewind(), but grabs no locks.
> + * The function is similar to kmsg_dump_rewind(), but grabs no locks
> + * and starts from the oldest record rather than from @clear_seq.
>   */
>  void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
>  {
> -	dumper->cur_seq = clear_seq;
> +	dumper->cur_seq = 0;

Just to understand it. Is the problem that the value might be in
an inconsistent state?

I mean that it might be modified by more instructions, for example,
because of compiler optimizations or on 32-bit system by definition.

I still have to look at the later patches. But it seems that
the new syslog_lock is taken mostly only around reading or
writing the global @clear_seq variable. Atomic variable might
do the same job.

Best Regards,
Petr
