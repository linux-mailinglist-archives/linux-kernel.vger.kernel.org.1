Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F972D24E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgLHHqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgLHHqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:46:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44F3C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 23:45:34 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607413532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=994Mu/eBbAgjKa9RtniOqVKR4U+12PtsGbiLcFEIluU=;
        b=1lyul3nfOkCQwfjc2LmwAGVM5/dUK8kYL1txp7kxLoUZyYRqpWW09sVV5/vFqt+1TUWpnb
        Foc4sm6uivtJgJ5jvuNITj3RkEFijfz3jN/CqwlmX3p86NI5Bw1Ts7vDfVhh0bx6dAQ/hw
        TssHj5JuHnYrrRKkbYdlv19WVeGVS40aRciYyt+CkxGp20OIL976PM9xMJHuqNFEPBTVFn
        xzPnC6oefXKrBRmUc1xXN2FNOfkhkm0P1eCb708TSr0IZhlxGwn696JPQ2/Bm+HQA56uGx
        uPtLhue/NM8SrDTAyki2n5/sOVF3tX81VvtunIo3K5k1dmWVnz0bwJRT61XXdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607413532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=994Mu/eBbAgjKa9RtniOqVKR4U+12PtsGbiLcFEIluU=;
        b=hlS7/qn5H4HHWExN0K9k+VlTDLiNlOuA/3nbQp2p99qZepuh7kw15Dx09zwiR7xBMWDGbQ
        pNC7FKYaq+Wu7iCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v3 3/3] printk: remove logbuf_lock protection for ringbuffer
In-Reply-To: <20201207222020.2923-4-john.ogness@linutronix.de>
References: <20201207222020.2923-1-john.ogness@linutronix.de> <20201207222020.2923-4-john.ogness@linutronix.de>
Date:   Tue, 08 Dec 2020 08:51:32 +0106
Message-ID: <87h7owd9lv.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-07, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e1f068677a74..f3c0fcc3163f 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
[...]
>  int vprintk_store(int facility, int level,
>  		  const struct dev_printk_info *dev_info,
>  		  const char *fmt, va_list args)
>  {
>  	const u32 caller_id = printk_caller_id();
> -	static char textbuf[LOG_LINE_MAX];
>  	struct prb_reserved_entry e;
>  	enum log_flags lflags = 0;
>  	struct printk_record r;
>  	u16 trunc_msg_len = 0;
> -	char *text = textbuf;
> +	char prefix_buf[8];
> +	va_list args2;
>  	u16 text_len;
> +	int ret = 0;
>  	u64 ts_nsec;
>  
>  	/*
> @@ -1884,35 +1951,21 @@ int vprintk_store(int facility, int level,
>  	 */
>  	ts_nsec = local_clock();
>  
> +	va_copy(args2, args);
> +
>  	/*
>  	 * The printf needs to come first; we need the syslog
>  	 * prefix which might be passed-in as a parameter.
>  	 */
> -	text_len = vscnprintf(text, sizeof(textbuf), fmt, args);
> +	text_len = vsnprintf(&prefix_buf[0], sizeof(prefix_buf), fmt, args) + 1;
> +	if (text_len > CONSOLE_LOG_MAX)
> +		text_len = CONSOLE_LOG_MAX;

LOG_LINE_MAX should be the limit. That was the size of the static
@textbuf.

John Ogness
