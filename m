Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BB228F2ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgJONJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbgJONJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:09:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F0032225C;
        Thu, 15 Oct 2020 13:09:57 +0000 (UTC)
Date:   Thu, 15 Oct 2020 09:09:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH v2 1/3] tracing: Show real address for trace event
 arguments
Message-ID: <20201015090955.5a48b0ba@gandalf.local.home>
In-Reply-To: <160275240824.115066.5442110208796724044.stgit@devnote2>
References: <160275239876.115066.10891356497426857018.stgit@devnote2>
        <160275240824.115066.5442110208796724044.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 18:00:08 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> +#define STATIC_FMT_BUF_SIZE	128
> +static char static_fmt_buf[STATIC_FMT_BUF_SIZE];
> +
> +const char *trace_event_format(struct trace_iterator *iter, const char *fmt)
> +{
> +	const char *p, *new_fmt;
> +	char *q;
> +
> +	if (WARN_ON_ONCE(!fmt))
> +		return fmt;
> +retry:
> +	p = fmt;
> +	new_fmt = q = iter->fmt;
> +	while (*p) {
> +		if (unlikely(q - new_fmt + 3 > iter->fmt_size)) {
> +			/* expand format buffer if needed */
> +			if (iter->fmt == static_fmt_buf)
> +				return fmt;
> +
> +			iter->fmt_size = iter->fmt_size ? iter->fmt_size * 2
> +							: STATIC_FMT_BUF_SIZE;

Doubling may be too much, as fmt strings are not going to grow
exponentially.

> +			kfree(iter->fmt);
> +			iter->fmt = kmalloc(iter->fmt_size, GFP_KERNEL);

Need to test the return value of kmalloc. But I would use realloc instead,
and continue:

			char *tmp_fmt;
			unsigned int tmp_size;

			tmp_size = iter->fmt_size + STATIC_FMT_BUF_SIZE;

			tmp_fmt = krealloc(iter->fmt, tmp_size, GFP_KERNEL);
			if (!tmp_fmt)
				return fmt;

			q += tmp_fmt - new_fmt;
			new_fmt = iter->fmt = tmp_fmt;
			iter->fmt_size = tmp_size;

> +			goto retry;

Then you don't even need the retry, and just continue processing.

Also, if it fails to allocate, you still have the iter->fmt and fmt_size
intact and correct.

-- Steve

> +		}
> +		*q++ = *p++;
> +		/* Replace %p with %px */
> +		if (p[-1] == '%') {
> +			if (p[0] == '%') {
> +				*q++ = *p++;
> +			} else if (p[0] == 'p' && !isalnum(p[1])) {
> +				*q++ = *p++;
> +				*q++ = 'x';
> +			}
> +		}
> +	}
> +	*q = '\0';
> +
> +	return new_fmt;
> +}
> +
