Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD582D10D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgLGMq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:46:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:38490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgLGMqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:46:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607345168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=effV4eKUpZhOJaGdMrFLunZTIE1jehrc+23v+ZJ2gRc=;
        b=Jxz8ur8CMYKEwgIoP/8VeQbLaWeMMP6UZ0/Yv2EBdLdu5S0QwIntjPEFdCChUOzzrPFxGw
        2UrZcP0qxYe9w35DtYdrYrfVcwnCd7hQc4CaE54kks7KEvLTJ0xHKJ3DSJNKsojz+iSOum
        tRsRYsnWo4CGvZkwWEYRi8+dN+UYnSQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A68EAD09;
        Mon,  7 Dec 2020 12:46:08 +0000 (UTC)
Date:   Mon, 7 Dec 2020 13:46:08 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: vprintk_store: was: [PATCH next v2 3/3] printk: remove
 logbuf_lock, add syslog_lock
Message-ID: <X84kEEGwMGGELlWt@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-4-john.ogness@linutronix.de>
 <X8pgvA3wKRwAyyaS@alley>
 <87k0tumusi.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0tumusi.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2020-12-06 23:36:53, John Ogness wrote:
> On 2020-12-04, Petr Mladek <pmladek@suse.com> wrote:
> >> +	if (facility == 0) {
> >> +		while (text_len >= 2 && printk_get_level(text)) {
> >> +			text_len -= 2;
> >> +			text += 2;
> >> +		}
> >
> > We should avoid two completely different approaches
> > that handle printk_level prefix.
> >
> > One solution is to implement something like:
> >
> >      static char *parse_prefix(text, &level, &flags)
> >
> > That would return pointer to the text after the prefix.
> > And fill level and flags only when non-NULL pointers are passed.
> 
> OK.
> 
> > Another solution would be to pass this information from
> > vprintk_store(). The prefix has already been parsed
> > after all.
> 
> Well, there is a vscnprintf() that happens in between and I don't think
> we should trust the parsed offset from the first vsnprintf().

Good point!

> >> +
> >> +		if (text != orig_text)
> >> +			memmove(orig_text, text, text_len);
> >> +	}
> >
> > We should clear the freed space to make the ring buffer as
> > human readable as possible when someone just dumps the memory.
> 
> Data blocks are currently padded and that padding is not cleared. So it
> is already not perfectly human readable on a raw dump.

It would be nice to clean up the padding as well. But it is a cosmetic
improvement that might be done anytime later.


> > Sigh, I have to admit that I missed the problem with prefix and
> > trailing '\n' when I suggested to avoid the temporary buffers.
> > This memmove() and the space wasting is pity.
> >
> > Well, it is typically 3 bytes per message. And the copying would
> > be necessary even with the temporary buffer. So, I am less convinced
> > but I would still try to avoid the temporary buffers for now.
> 
> Agreed. I think this approach is better than the temporary buffers I
> previously used.

Another motivation is that it allows to simply handle recursion/nesting.
Othrewise, we would need temporary buffers for each allowed recursion
level or some tricky code.

> Also, if we add a trimming feature to the ringbuffer,
> it will keep the ringbuffer mostly clean anyway. Something like this:
> 
> prb_rec_init_wr(&r, text_len);
> prb_reserve(&e, prb, &r);
> text_len = printk_sprint(&r.text_buf[0], text_len, ...);
> r.info->text_len = text_len;
> prb_trim_rec(&e, &r); <--- try to reduce datablock size to @text_len
> prb_commit(&e);
> 
> I see no urgency to add such a feature. But I think we should keep it on
> our radar.

Yup. I thought about it as well. I agree that it is not a priority.

Best Regards,
Petr
