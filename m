Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D722F6623
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbhANQll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:41:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:47770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbhANQll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:41:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610642454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RxVe1CfZqObBuFGF6gIc0SuEJKRUZtNp5wb+yusLnRI=;
        b=fHB+0wplMd/fqGPeMK9GrPZYue2EL8K/RNxNaob9sTG0eef6C09doFF6tJAgMCgHQofWEQ
        5GRpByPRC6LzObPdbwSHFgFY76Ki+Jh44tkPaEwLB8xurC30yT/exFT7yI3vEwRQlUSz0f
        COiaywCdhUrR5FYd8MKtreqYRqEXUzM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43183AF72;
        Thu, 14 Jan 2021 16:40:54 +0000 (UTC)
Date:   Thu, 14 Jan 2021 17:40:53 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: printk: kmsg_dump_get_line_nolock() buffer overflow
Message-ID: <YAB0FfMLfkrRd4uT@alley>
References: <87im8038v7.fsf@jogness.linutronix.de>
 <YABhMFlIpQ/5uQ7s@alley>
 <87im7zecec.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im7zecec.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-01-14 17:06:59, John Ogness wrote:
> On 2021-01-14, Petr Mladek <pmladek@suse.com> wrote:
> > It is pitty that I have missed this. I remember that I discussed
> > exactly this problem before, see
> > https://lore.kernel.org/lkml/20190710080402.ab3f4qfnvez6dhtc@axis.com/
> >
> > And I did exactly the same mistake. I have missed the two users in
> > "arch/powerpc" and "arch/um".
> >
> > It is clear that this problem happens repeatedly.
> 
> Yes, because the semantics are poor and undocumented.

I fully agree.


> > Now, the change in record_printk_text() behavior affects also other
> > callers. For example, syslog_print() fills the buffer completely
> > as well now. I could imagine a userspace code that does the same
> > mistake and it works just by chance.
> 
> No, syslog_print() works fine.

Not really. It fills the entire buffer provided by the user space now.
It never filled the last byte before. User space might do exactly
the same mistake:

	len = syslog(SYSLOG_ACTION_READ, buf, sizeof(*buf));
	buf[len] = '\0';

This worked before and it causes overflow now.

> There are only 2 users that think they
> can blindly add a byte at buffer[len]. Their code looks scary just
> seeing it.

Except that the functions are exported. I know that breaking external
modules that do ugly things might motivate them to upstream them but...


> > We should restore the original record_printk_text() behavior
> > and add the comment explaining why it is done this way.
> 
> OK.
> 
> > And I would even explicitly add the trailing '\0' as suggested at
> > https://lore.kernel.org/lkml/20190710121049.rwhk7fknfzn3cfkz@pathway.suse.cz/#t
> 
> OK. But then this becomes official semantics so powerpc/um no longer
> need to append a terminator.

We either risk the change of the semantic and break external code.

Or we should make it official. The '\0' will not be used by most of
the API users. But it will make it more safe. The free byte will be
there anyway.

Best Regards,
Petr
