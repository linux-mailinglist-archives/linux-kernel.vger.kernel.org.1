Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D5E276C48
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgIXIp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:45:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:50566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgIXIp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:45:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600937156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LiDYwk9lySi3d8BWgZSBd7bGIz2hU9PObtVbPv44pU0=;
        b=qRbvu818hxb4yQXYEV6arBnycD4gPXoawp779lJY5QVHURh4kC+3d4wN4aM9tKR16SzLl6
        npXu34KsVvaEvmIm60mGfnbYEio2ElAPs7oB5CEl23vZc32ZiGCUKbAgGIzxu4Y8ethp/X
        DPPYc78oNBZZwdXp91VbUq0oC7VyIl4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40316AD6B;
        Thu, 24 Sep 2020 08:46:34 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:45:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Message-ID: <20200924084555.GJ6442@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200923151129.GC6442@alley>
 <20200924054058.GE577@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924054058.GE577@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-24 14:40:58, Sergey Senozhatsky wrote:
> On (20/09/23 17:11), Petr Mladek wrote:
> >
> > AFAIK, there is one catch. We need to use va_copy() around
> > the 1st call because va_format can be proceed only once.
> >
> 
> Current printk() should be good enough for reporting, say, "Kernel
> stack overflow" errors. Is extra pressure that va_copy() adds something
> that we need to consider?

The thing is that vsprintf() traverses the arguments using va_arg().
It modifies internal values so that the next va_arg() will read
the next value.

If we want to call vsprintf() twice then we need to reset the internal
va_list states. My understanding is that va_copy() is the only legal
way when we are already nested inside va_start()/va_end().

See also the commit 5756b76e4db643d8f7 ("vsprintf: make %pV handling
compatible with kasprintf()").

Best Regards,
Petr
