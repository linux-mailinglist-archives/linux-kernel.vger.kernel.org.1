Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AFE2CDB29
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgLCQ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgLCQ0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:26:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F81C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:25:32 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607012730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CexYbNSViX2m6Yxiwhh9dV7Z3MwMc+PgUFIzsEI/wuU=;
        b=fAPAa1L5+GnHeCpqtBkszfrlO5fQd/sS4ZF3IQVM0au98hxcKsgbqrYdK0S43FpvyX374M
        bmWyxlm2xBtTEgQEsw7m4ZDE/tTbjsmZvZ2U1VFp1ubDyl/z5kLfy+5P1ELdFfnatUS6Z9
        WLPQYj4xhlJbr6TPbrnopE0cg5isWmNKK//v5E5uGOtao9PU3oeNgIvGf6tYeh2EADJdeC
        G7VlCVFEpRIo0hd6zb9Kp7UbVE+JEv+gSIF3l+pV5tG/utvsLcBWbASkYjD8mzRuQM7lOU
        UUNymTn8bKAi/7Ox4NHRq9H3I35sLHgQeSzhqpOPGBz157Oyzful/L7V5JVDyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607012730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CexYbNSViX2m6Yxiwhh9dV7Z3MwMc+PgUFIzsEI/wuU=;
        b=QwrBI6s6c95CA88BjdvyX3CZonQ0gEEG2gXfCYh9FRPc/z+tabaBlphfAcUCSzxOdgsWle
        2ncQDvdcpw3VSOAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 1/3] printk: inline log_output(),log_store() in vprintk_store()
In-Reply-To: <X8kK5nC/uWJhc4Z0@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de> <20201201205341.3871-2-john.ogness@linutronix.de> <X8kK5nC/uWJhc4Z0@alley>
Date:   Thu, 03 Dec 2020 17:31:29 +0106
Message-ID: <87v9diyhza.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-03, Petr Mladek <pmladek@suse.com> wrote:
>> +	if (lflags & LOG_CONT) {
>> +		prb_rec_init_wr(&r, text_len);
>> +		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
>> +			memcpy(&r.text_buf[r.info->text_len], text, text_len);
>> +			r.info->text_len += text_len;
>> +
>> +			if (lflags & LOG_NEWLINE) {
>> +				r.info->flags |= LOG_NEWLINE;
>> +				prb_final_commit(&e);
>> +			} else {
>> +				prb_commit(&e);
>> +			}
>> +
>> +			return text_len;
>> +		}
>> +	}
>> +
>> +	prb_rec_init_wr(&r, text_len);
>
> This is called in both branches. I would do it just once at the
> beginning.

Actually that leads to a crash when prb_reserve_in_last() fails and the
fallback code uses a record that prb_reserve_in_last() has already
touched. The implementation of prb_reserve_in_last() would have to be
changed so that failure guarantees that @r has not been
modified. Currently prb_reserve_in_last() can fail after modifying @r.

>> +	if (!prb_reserve(&e, prb, &r)) {
>> +		/* truncate the message if it is too long for empty buffer */
>> +		truncate_msg(&text_len, &trunc_msg_len);
>> +
>> +		prb_rec_init_wr(&r, text_len + trunc_msg_len);
>> +		if (!prb_reserve(&e, prb, &r))
>> +			return 0;
>> +	}
>> +
>> +	/* fill message */
>> +	memcpy(&r.text_buf[0], text, text_len);
>> +	if (trunc_msg_len)
>> +		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
>> +	r.info->text_len = text_len + trunc_msg_len;
>> +	r.info->facility = facility;
>> +	r.info->level = level & 7;
>> +	r.info->flags = lflags & 0x1f;
>> +	r.info->ts_nsec = ts_nsec;
>
> This is the only location where ts_nsec is used. I would remove the
> variable and call:
>
> 	r.info->ts_nsec = local_clock();

My reason for grabbing the clock at the beginning is so that the
timestamp is as close to the printk() call as possible. IMHO it is a
more deterministic timestamp than if it is taken after reservation(s)
and sprint'ing. I prefer to keep it as it is, but will not object if
such a change is necessary for mailine acceptance.

John Ogness
