Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1D927E7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgI3L2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:28:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:47802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgI3L2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:28:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601465317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJDgWAYhRp6it/2DpEbAViTJ8/e5BFTejOFXfq86KFU=;
        b=THtL5oLxX+5tAvr5GMG47Or7AqFGxz5Ug9Lu943eInO8oBaSfeU1cgV1ke8CmmORaVScXf
        NkpPrFYfzxA8jRp2BMMj5RfRLMHV7JWOKfqPDYFMuswtRolYJtSYYqeWRQvXc9LhmqDTxX
        +HMYofEotjjnFXG8Ds1jTsvLnXffsZQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0245DABC1;
        Wed, 30 Sep 2020 11:28:37 +0000 (UTC)
Date:   Wed, 30 Sep 2020 13:28:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 1/2] printk: avoid and/or handle record truncation
Message-ID: <20200930112836.GC29288@alley>
References: <20200930090134.8723-1-john.ogness@linutronix.de>
 <20200930090134.8723-2-john.ogness@linutronix.de>
 <20200930094316.GB987@jagdpanzerIV.localdomain>
 <87imbv1s0d.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imbv1s0d.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-09-30 12:30:50, John Ogness wrote:
> On 2020-09-30, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > On (20/09/30 11:07), John Ogness wrote:
> >>  bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
> >> -			 struct printk_record *r, u32 caller_id);
> >> +			 struct printk_record *r, u32 caller_id, unsigned int max_size);
> >
> > Isn't `max_size' always LOG_LINE_MAX?
> 
> Yes. But I still think it makes sense that it is an argument of the
> function. It is quite an important setting and hard-coding it within the
> ringbuffer code might lead to hidden problems later.

I personally prefer the argument as well.

It is true that printk_ringbuffer is not a fully generic ringbuffer.
It has very special behavior so that it can be hardly be used
anywhere else.

Sometimes it is not clear what printk() requirements should be passed via
the API or hardcoded into the ring buffer code. IMHO, it depends on the code
complexity.

Anyway, I see hardcoded limit more like a hack. It limits something
somewhere so that some other code somewhere else is safe to use.

And printk.c is really bad from this point. It sometimes does not
check for overflow because it "knows" that the buffers are big
enough. But it is error prone code, especially when there are more
limits defined (pure text, prefix, extended prefix). And it
will be worse if we allow to add more optional information
into the prefix.

Best Regards,
Petr
