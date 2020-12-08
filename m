Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68DF2D2CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgLHOOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:14:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:56078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgLHOOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:14:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607436804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oqaRiuwUNHlPLFbMAEPQzUSrZGbrPkZVKcJhLr1BWJw=;
        b=pu/M/IqGgdKAEgr/d+OTrLJi4i1S5XG12M/Pijzgw2RcftxMWHGXjxhX9xFgimfL7nqCTR
        zgfPS7m2HFv/F/a+aU8ZXdsDNiZgTTo87xkGqbTPrxwOaMi/mxRNWJu4z527UEcTuCV2DH
        yFKjUeTdLi2QsnzqPFGmMmfeb1Oi1UY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 424BBAC9A;
        Tue,  8 Dec 2020 14:13:24 +0000 (UTC)
Date:   Tue, 8 Dec 2020 15:13:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v3 0/3] printk: remove logbuf_lock protection of
 ringbuffer
Message-ID: <X8+KA7+sYUYPlEiU@alley>
References: <20201207222020.2923-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207222020.2923-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-12-07 23:26:17, John Ogness wrote:
> Hello,
> 
> Here is a v3 of the series to remove logbuf_lock. v2 is
> here[0]. Rather than completely removing logbuf_lock, this
> version only removes logbuf_lock usage protecting the
> ringbuffer. I have tried to keep the changes minimal so that
> we can feel comfortable for the upcoming 5.11 merge window.
> 
> Although small, this series is significant because it allows
> printk callers direct lockless access to the ringbuffer and
> it replaces the use of a temporary static sprint buffer with
> sprint'ing directly to the reserved ringbuffer data block.

Yes, it might allow to see eventual races in the ring buffer
code. It is great that we do the switch in many "small" steps.

> The other changes from v2 (recursion limiting, introduction
> of syslog_lock, using clear_seq as seqcount_latch, and full
> removal of logbuf_lock) will be included in a later series,
> which may or may not make the 5.11 merge window.

I am slightly nervous when such changes could not spend longer
time in linux-next. On the other hand, I do not want to block
it too much. The races will hopefully be hard to hit if there
are any. And it is good that there are no other big changes
waiting for 5.11.

Let's see how the patches look like in the end...

Best Regards,
Petr
