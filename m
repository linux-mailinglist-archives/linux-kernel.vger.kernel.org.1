Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FFB2D40CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgLILPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:15:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:35746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbgLILPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:15:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607512498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0DasMEnu8hJ2pUKVJiARohcG8vDoST0haFmbQ/L0X3U=;
        b=mbEFLRPFub3li48UCaK7JXrE15G1HNVVnbOdGNTrHiSfD8+f/JJSFF6cuKDnTUJcmgJcoF
        sM0K+XevCU1t5w9nuBsYKaMbSxn/fB9E5v4kcnUedUH0ZJnZ7B9wEnxUG+aK6pjy///2wQ
        /tjPPSE+J1/E+Ot9qZPG2A3wo3gB864=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DBA6AAD09;
        Wed,  9 Dec 2020 11:14:57 +0000 (UTC)
Date:   Wed, 9 Dec 2020 12:14:57 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v4 0/2] printk: remove logbuf_lock writer-protection
 of ringbuffer
Message-ID: <X9CxsWOCoWPS8KZf@alley>
References: <20201209004453.17720-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209004453.17720-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-12-09 01:50:51, John Ogness wrote:
> Hello,
> 
> Here is a v4 of the series to partially remove logbuf_lock.
> v3 is here[0]. This series removes logbuf_lock usage of most
> ringbuffer writers. The remaining logbuf_lock users are
> using the lock to synchronize other variables. These other
> users will be addressed in a later series.
> 
> I have tried to keep these changes minimal so that we can feel
> comfortable for the upcoming 5.11 merge window.

Both patches are pushed in printk/linux.git, branch printk-rework.

I hurried so that we could get some testing linux-next before
the merge window opens.

We are going to see if the many barriers in the ring buffer
code are enough ;-) I keep my fingers crossed.

Best Regards,
Petr
