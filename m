Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7066275DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgIWQlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:41:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:33222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWQlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:41:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600879305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IM69qc/OE8PO5fk7UQqc5zqiXF1MhlwGn7B85mXjcM4=;
        b=WCfbu7chftYh7/i4FIfm86OVHIr0goskgXU8g4XjmJmwiX2TbjAS61GML1iY0Sva90Z9Gj
        Y3bzIftyJnjZZElskfJ/8sIiqmjy42r757tPWDxt3CqaNiGNpoAUtbG059blQvQ8ixoxB8
        fiVLcqk4+AtoJ8MEmfvNV2kJyyd1g50=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D178AAC7;
        Wed, 23 Sep 2020 16:42:22 +0000 (UTC)
Date:   Wed, 23 Sep 2020 18:41:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Message-ID: <20200923164144.GF6442@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200923151129.GC6442@alley>
 <f4c854b05b394a5f9548715698fd5f59@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4c854b05b394a5f9548715698fd5f59@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-09-23 15:21:41, David Laight wrote:
> From: Petr Mladek
> > Sent: 23 September 2020 16:11
> > 
> > On Tue 2020-09-22 17:44:14, John Ogness wrote:
> > > vprintk_store() is using a single static buffer as a temporary
> > > sprint buffer for the message text. This will not work once
> > > @logbuf_lock is removed. Replace the single static buffer with a
> > > pool of buffers.
> > 
> > The buffer is used because we do not know the length of the
> > formatted message to reserve the right space in the ring buffer
> > in advance.
> > 
> > There was the idea to call vsprintf(NULL, fmt, args) to count
> > the length in advance.
> > 
> > AFAIK, there is one catch. We need to use va_copy() around
> > the 1st call because va_format can be proceed only once.
> > See, va_format() in lib/vsprintf.c as an example.
> > 
> > Is there any other problem, please?
> 
> Potentially the data can change after the vsprintf(NULL, ...)
> call so that the buffer isn't guaranteed to be the right length.

Yup. Well, in the worst case, we would shrink the text when the length
increased in the meantime. The content of such a message is racy
anyway.

> Never mind the extra cost of doing all the work twice.

IMHO, neither of this is worth the extra complexity with a pool
of buffers.

I would prefer to increase the complexity only when there are real life
problems.

Best Regards,
Petr
