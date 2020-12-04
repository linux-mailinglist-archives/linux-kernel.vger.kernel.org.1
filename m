Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B652CE98B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgLDI1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:27:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:34430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbgLDI1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:27:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607070387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uh9RU3xuOo+3e2/RiTuGm0aN6kch6e4ntS4xBPJlcaA=;
        b=bKCqxL5HOOmEfzfJiCJ0rLLIi6zdhOQHU5Y2ASoRLb4ee4H1s3XFQT6FnA3BQrWFZaW0jA
        4S4jFhjXdnDPhwTBThFXNiLSokYFC5OmU0RL5epBF/ViI8Wid+p2PrAVJjKypvN+LIW1cv
        4h+D/cEAgdn9Gv6BMnUvtN0bVDZkkvQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7934EAE1C;
        Fri,  4 Dec 2020 08:26:27 +0000 (UTC)
Date:   Fri, 4 Dec 2020 09:26:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 1/3] printk: inline log_output(),log_store() in
 vprintk_store()
Message-ID: <X8nysl/ne1f0nlKe@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-2-john.ogness@linutronix.de>
 <X8kK5nC/uWJhc4Z0@alley>
 <87v9diyhza.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9diyhza.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-12-03 17:31:29, John Ogness wrote:
> On 2020-12-03, Petr Mladek <pmladek@suse.com> wrote:
> >> +	if (lflags & LOG_CONT) {
> >> +		prb_rec_init_wr(&r, text_len);
> >> +		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
> >> +			memcpy(&r.text_buf[r.info->text_len], text, text_len);
> >> +			r.info->text_len += text_len;
> >> +
> >> +			if (lflags & LOG_NEWLINE) {
> >> +				r.info->flags |= LOG_NEWLINE;
> >> +				prb_final_commit(&e);
> >> +			} else {
> >> +				prb_commit(&e);
> >> +			}
> >> +
> >> +			return text_len;
> >> +		}
> >> +	}
> >> +
> >> +	prb_rec_init_wr(&r, text_len);
> >
> > This is called in both branches. I would do it just once at the
> > beginning.
> 
> Actually that leads to a crash when prb_reserve_in_last() fails and the
> fallback code uses a record that prb_reserve_in_last() has already
> touched. The implementation of prb_reserve_in_last() would have to be
> changed so that failure guarantees that @r has not been
> modified. Currently prb_reserve_in_last() can fail after modifying @r.

I see. It would deserve a comment so that nobody repeats my mistake
again. I am sure that I would be able to do it once again few
months from now ;-)

> >> +	if (!prb_reserve(&e, prb, &r)) {
> >> +		/* truncate the message if it is too long for empty buffer */
> >> +		truncate_msg(&text_len, &trunc_msg_len);
> >> +
> >> +		prb_rec_init_wr(&r, text_len + trunc_msg_len);
> >> +		if (!prb_reserve(&e, prb, &r))
> >> +			return 0;
> >> +	}
> >> +
> >> +	/* fill message */
> >> +	memcpy(&r.text_buf[0], text, text_len);
> >> +	if (trunc_msg_len)
> >> +		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
> >> +	r.info->text_len = text_len + trunc_msg_len;
> >> +	r.info->facility = facility;
> >> +	r.info->level = level & 7;
> >> +	r.info->flags = lflags & 0x1f;
> >> +	r.info->ts_nsec = ts_nsec;
> >
> > This is the only location where ts_nsec is used. I would remove the
> > variable and call:
> >
> > 	r.info->ts_nsec = local_clock();
> 
> My reason for grabbing the clock at the beginning is so that the
> timestamp is as close to the printk() call as possible. IMHO it is a
> more deterministic timestamp than if it is taken after reservation(s)
> and sprint'ing. I prefer to keep it as it is, but will not object if
> such a change is necessary for mailine acceptance.

Fair enough. It would deserve a comment as well.

Best Regards,
Petr
