Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0152F652C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbhANPuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:50:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:55810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbhANPuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:50:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610639390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gl7QyvBkQ7ITsyEpM9dJohWOtgV8VaTLIIqhMH+bxjE=;
        b=gKqNQYoav4e16BYhJjmGegiCSX/7R1ijOacgYHE94MQWPXonnZm7OM2TihXNgtffLVrVCT
        Abp5zdnEDlKBp3w6C0zmTy/qsRp0pVbGf7RS9BajJ2rOnq+1NIqPvH7Gdyio239CP/bYmr
        sJFy6hAkP8LKfucahGmMKQsTA6Tzm9s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1000AF13;
        Thu, 14 Jan 2021 15:49:50 +0000 (UTC)
Date:   Thu, 14 Jan 2021 16:49:50 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: kmsg_dump: revert msg_print_text() workaround
Message-ID: <YABoHgNunkcfBElL@alley>
References: <20210114090511.17784-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114090511.17784-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-01-14 10:11:11, John Ogness wrote:
> The old msg_print_text() function only filled up to size-1 bytes of
> the buffer. A workaround for this quirky behavior was implemented
> with commit c9dccacfccc7 ("printk: Do not lose last line in kmsg
> buffer dump").
> 
> However, with commit 896fbe20b4e2 ("printk: use the lockless
> ringbuffer"), msg_print_text() was replaced by,
> which will fill the full buffer. Therefore, the workaround is now
> incorrectly assuming less data can fit into the buffer. Revert the
> workaround.

We should make record_print_text() behave the same as msg_print_text()
behaved. There might be more users affected by this change and even
in userspace :-(

Let's discuss it in the other thread
https://lore.kernel.org/lkml/87im8038v7.fsf@jogness.linutronix.de/

Best Regards,
Petr
