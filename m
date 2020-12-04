Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D632CEA8D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgLDJM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:12:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:38736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbgLDJM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:12:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607073131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sDLKRldLHquGUNV0pZJDyPquUZT4Bb0tC+W3rrbipac=;
        b=iYKpNMPfnfS04hweczq3dosgbcrPYo1Q1/L4MBzRcfi1SJOxBDKlKxeBgLzvN270ydy3ia
        7Vyq6S9mi5r/4QLh4D1JLFNp3TgK3RRrMEfEYtCkwQscT9BKfhD4sVd39Wd6U4Ri11n4RG
        NnpdefD1jWEaDomyE+wjErm65o+HD9w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B58D9B263;
        Fri,  4 Dec 2020 09:12:11 +0000 (UTC)
Date:   Fri, 4 Dec 2020 10:12:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Message-ID: <X8n9a2DWUFE/giyB@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201205341.3871-3-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-12-01 21:59:40, John Ogness wrote:
> Currently @clear_seq access is protected by @logbuf_lock. Once
> @logbuf_lock is removed some other form of synchronization will be
> required. Change the type of @clear_seq to atomic64_t to provide the
> synchronization.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fc5e3a7d6d89..e9018c4e1b66 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3412,7 +3418,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
>   */
>  void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
>  {
> -	dumper->cur_seq = clear_seq;
> +	dumper->cur_seq = atomic64_read(&clear_seq);

Sigh, atomic64_read() uses a spin lock in the generic implementation
that is used on some architectures.

Hmm, this seems to be the only location where the lock must not be
used. At the same time, a best effort might be acceptable here.

I am not super-happy with the following hack but it might work:

	/*
	 * Use the best effort to avoid locks. In the worst case,
	 * the bottom and upper halves will be inconsistent. Then
	 * the value will be far too big or far too low. Fallback
	 * to the first available sequence number when it is
	 * too big.
	 */
	if (IS_ENABLED(CONFIG_GENERIC_ATOMIC64)) {
		u64 first_seq = prb_first_seq(prb);

		dumper->cur_seq = READ_ONCE(&clear_seq->counter);
		if (dumper->cur_seq > first_seq)
			dumper->cur_seq = first_seq;
	} else {
		dumper->cur_seq = atomic64_read(&clear_seq);
	}

Alternative solution would to always fallback to the first_seq
on these architectures. Few people would complain when they see
more messages. We could always improve it when it causes problems.

Adding Peter Zijstra for his opinion [*].

>  	dumper->next_seq = prb_next_seq(prb);

[*] I am going to hide under a stone for the above hack.

Best Regards,
Petr
