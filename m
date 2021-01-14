Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B7D2F655D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbhANQBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbhANQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:01:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C76C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:01:04 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610640060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73B8Qve9y0JoijTWYi5Jyf92JaqGXWY23hQFwIxZv8Y=;
        b=1MTb4dnT8kfdDDpxQ/8tMoJEy/2MYa6bI9AkRN31Lx650zE+/9G1ZHc/V7d0gKdZBOoXxh
        twrJbIRYMVwevc89y6NhL2FG3NTjgo0QeDaP71r9+J0E1rcocXrKrYWWpwIGUjhHkBBqEf
        Ij9TSpD4yZbhmSIWQNC/VVGS0bhBXNCk6RCFwdzgJcOZgEANB4gG7kVqvHD1xiIAbs8fT4
        RIqA/Jz3XtmetH6jVcVe0klIxqI/5FFtz4JOKjPWfA75Zz/9CIji6rQ3ymH1X+7iTsHvcK
        o3lvgu9Ccip90BowtIsMrmYrZYYZt9q/RExZg4wv6rlq2EB3th3a26wALrTr5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610640060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73B8Qve9y0JoijTWYi5Jyf92JaqGXWY23hQFwIxZv8Y=;
        b=0mbIr5uhSdPzfZ0v/K+IdCcM3QRupqGqD+k3PY4MVToS2VhdPvQ5v8eqM0OqGZMStmGWN9
        eSpE0MCGCgT0acDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: printk: kmsg_dump_get_line_nolock() buffer overflow
In-Reply-To: <YABhMFlIpQ/5uQ7s@alley>
References: <87im8038v7.fsf@jogness.linutronix.de> <YABhMFlIpQ/5uQ7s@alley>
Date:   Thu, 14 Jan 2021 17:06:59 +0106
Message-ID: <87im7zecec.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-14, Petr Mladek <pmladek@suse.com> wrote:
> It is pitty that I have missed this. I remember that I discussed
> exactly this problem before, see
> https://lore.kernel.org/lkml/20190710080402.ab3f4qfnvez6dhtc@axis.com/
>
> And I did exactly the same mistake. I have missed the two users in
> "arch/powerpc" and "arch/um".
>
> It is clear that this problem happens repeatedly.

Yes, because the semantics are poor and undocumented.

> Now, the change in record_printk_text() behavior affects also other
> callers. For example, syslog_print() fills the buffer completely
> as well now. I could imagine a userspace code that does the same
> mistake and it works just by chance.

No, syslog_print() works fine. There are only 2 users that think they
can blindly add a byte at buffer[len]. Their code looks scary just
seeing it.

> We should restore the original record_printk_text() behavior
> and add the comment explaining why it is done this way.

OK.

> And I would even explicitly add the trailing '\0' as suggested at
> https://lore.kernel.org/lkml/20190710121049.rwhk7fknfzn3cfkz@pathway.suse.cz/#t

OK. But then this becomes official semantics so powerpc/um no longer
need to append a terminator.

John Ogness
