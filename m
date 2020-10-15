Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DFD28F3AE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbgJONvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729935AbgJONvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:51:40 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA362222B;
        Thu, 15 Oct 2020 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602769900;
        bh=8WE0MUAZozCQ26RIjVh5hpjp/f+nLhddnQLQASoaggQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D7f1sNQIy+vtr5A9qRezxhRbvHbzi3ckINV04xkRThH2TjkiiwUqYNvkOZuejdssP
         94047uL3HhDT0OkRPJHEwOC/Dl40y6qBpqctOArWWx06jOYSde3DG0s9M9VhYEvHBT
         8NyWhllbaf5Bm6TnMQAbSYW/s+HpY/Suv9hCf5+I=
Date:   Thu, 15 Oct 2020 22:51:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH v2 1/3] tracing: Show real address for trace event
 arguments
Message-Id: <20201015225137.cb9c4638b7f576ad96fe6105@kernel.org>
In-Reply-To: <20201015090955.5a48b0ba@gandalf.local.home>
References: <160275239876.115066.10891356497426857018.stgit@devnote2>
        <160275240824.115066.5442110208796724044.stgit@devnote2>
        <20201015090955.5a48b0ba@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 09:09:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 15 Oct 2020 18:00:08 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > +#define STATIC_FMT_BUF_SIZE	128
> > +static char static_fmt_buf[STATIC_FMT_BUF_SIZE];
> > +
> > +const char *trace_event_format(struct trace_iterator *iter, const char *fmt)
> > +{
> > +	const char *p, *new_fmt;
> > +	char *q;
> > +
> > +	if (WARN_ON_ONCE(!fmt))
> > +		return fmt;
> > +retry:
> > +	p = fmt;
> > +	new_fmt = q = iter->fmt;
> > +	while (*p) {
> > +		if (unlikely(q - new_fmt + 3 > iter->fmt_size)) {
> > +			/* expand format buffer if needed */
> > +			if (iter->fmt == static_fmt_buf)
> > +				return fmt;
> > +
> > +			iter->fmt_size = iter->fmt_size ? iter->fmt_size * 2
> > +							: STATIC_FMT_BUF_SIZE;
> 
> Doubling may be too much, as fmt strings are not going to grow
> exponentially.

OK, then I just make it "+= STATIC_FMT_BUF_SIZE".

Actually, as far as I can see, the format string should be shorter than
128 bytes. If we see it is longer than that, it will be 2 lines in event
definition. And 128 + 128 = 256, which will be longer than 3 lines in 80
columns wide terminal. I guess no one want to write it. :)

> 
> > +			kfree(iter->fmt);
> > +			iter->fmt = kmalloc(iter->fmt_size, GFP_KERNEL);
> 
> Need to test the return value of kmalloc. But I would use realloc instead,
> and continue:

Good catch!

> 
> 			char *tmp_fmt;
> 			unsigned int tmp_size;
> 
> 			tmp_size = iter->fmt_size + STATIC_FMT_BUF_SIZE;
> 
> 			tmp_fmt = krealloc(iter->fmt, tmp_size, GFP_KERNEL);
> 			if (!tmp_fmt)
> 				return fmt;
> 
> 			q += tmp_fmt - new_fmt;
> 			new_fmt = iter->fmt = tmp_fmt;
> 			iter->fmt_size = tmp_size;
> 
> > +			goto retry;
> 
> Then you don't even need the retry, and just continue processing.
> 
> Also, if it fails to allocate, you still have the iter->fmt and fmt_size
> intact and correct.

OK, let me update it.

Thank you,

> 
> -- Steve
> 
> > +		}
> > +		*q++ = *p++;
> > +		/* Replace %p with %px */
> > +		if (p[-1] == '%') {
> > +			if (p[0] == '%') {
> > +				*q++ = *p++;
> > +			} else if (p[0] == 'p' && !isalnum(p[1])) {
> > +				*q++ = *p++;
> > +				*q++ = 'x';
> > +			}
> > +		}
> > +	}
> > +	*q = '\0';
> > +
> > +	return new_fmt;
> > +}
> > +


-- 
Masami Hiramatsu <mhiramat@kernel.org>
