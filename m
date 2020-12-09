Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AE52D40BC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgLILMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:12:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:33800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbgLILMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:12:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607512274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=idMlQTYOnMdWg066O+TrOvZ3wrc3r/NV0fxwJgGhHRA=;
        b=nQApMpz5aWNn5UDhJeBZH/0d17YWczfYbeEnihhv068beOj3pjv3dC1E6toUr3nOQ5QhfQ
        oUn+yjRH4t2n4xVjHMsgpwjo5VbqLDFZhHOEazcOQXGnyl4kYVwZD7aiGZXkr7Eh9h1/Dg
        4xSqnH44iD9wb0ckO/YjvDSa5B5LlTg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78108B113;
        Wed,  9 Dec 2020 11:11:14 +0000 (UTC)
Date:   Wed, 9 Dec 2020 12:11:13 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v4 2/2] printk: remove logbuf_lock writer-protection
 of ringbuffer
Message-ID: <X9Cw0WK4kweSB1yi@alley>
References: <20201209004453.17720-1-john.ogness@linutronix.de>
 <20201209004453.17720-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209004453.17720-3-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-12-09 01:50:53, John Ogness wrote:
> Since the ringbuffer is lockless, there is no need for it to be
> protected by @logbuf_lock. Remove @logbuf_lock writer-protection of
> the ringbuffer. The reader-protection is not removed because some
> some variables used by readers are using @logbuf_lock for
> synchronization: @syslog_seq, @syslog_time, @syslog_partial,
> @console_seq, struct kmsg_dumper.
> 
> For PRINTK_NMI_DIRECT_CONTEXT_MASK, @logbuf_lock usage is not removed
> because it may be used for dumper synchronization.
> 
> Without @logbuf_lock synchronization of vprintk_store() it is no
> longer possible to use the single static buffer for temporarily
> sprint'ing the message. Instead, use vsnprintf() to determine the
> length and perform the real vscnprintf() using the area reserved from
> the ringbuffer. This leads to suboptimal packing of the message data,
> but will result in less wasted storage than multiple per-cpu buffers
> to support lockless temporary sprint'ing.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
