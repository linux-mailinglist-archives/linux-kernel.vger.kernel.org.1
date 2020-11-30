Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE392C8D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgK3Suh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgK3Suh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:50:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B49C20725;
        Mon, 30 Nov 2020 18:49:56 +0000 (UTC)
Date:   Mon, 30 Nov 2020 13:49:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: set the right timestamp in the slow path
 of __rb_reserve_next()
Message-ID: <20201130134954.4ba23d0e@gandalf.local.home>
In-Reply-To: <X8IVJcp1gRE+FJCJ@xps-13-7390>
References: <X8IVJcp1gRE+FJCJ@xps-13-7390>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Nov 2020 10:15:17 +0100
Andrea Righi <andrea.righi@canonical.com> wrote:

> In the slow path of __rb_reserve_next() a nested event(s) can happen
> between evaluating the timestamp delta of the current event and updating
> write_stamp via local_cmpxchg(); in this case the delta is not valid
> anymore and it should be set to 0 (same timestamp as the interrupting
> event), since the event that we are currently processing is not the last
> event in the buffer.
> 
> Link: https://lwn.net/Articles/831207

And it looks like we have a WINNER!

Thanks! It shows someone is paying attention.

There's a few other patches I need to test, but I've queued this up for my
next pull request.

-- Steve


> Fixes: a389d86f7fd0 ("ring-buffer: Have nested events still record running time stamp")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  kernel/trace/ring_buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index dc83b3fa9fe7..5e30e0cdb6ce 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3287,11 +3287,11 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
>  		ts = rb_time_stamp(cpu_buffer->buffer);
>  		barrier();
>   /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
> -		    info->after < ts) {
> +		    info->after < ts &&
> +		    rb_time_cmpxchg(&cpu_buffer->write_stamp,
> +				    info->after, info->ts)) {
>  			/* Nothing came after this event between C and E */
>  			info->delta = ts - info->after;
> -			(void)rb_time_cmpxchg(&cpu_buffer->write_stamp,
> -					      info->after, info->ts);
>  			info->ts = ts;
>  		} else {
>  			/*

