Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5541A28B88F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390341AbgJLNxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388750AbgJLNx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:53:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56569206F4;
        Mon, 12 Oct 2020 13:53:26 +0000 (UTC)
Date:   Mon, 12 Oct 2020 09:53:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] trace: Return ENOTCONN instead of EBADF
Message-ID: <20201012095324.78996fd2@gandalf.local.home>
In-Reply-To: <20201012082642.1394-1-peter.enderborg@sony.com>
References: <20201012082642.1394-1-peter.enderborg@sony.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 10:26:42 +0200
Peter Enderborg <peter.enderborg@sony.com> wrote:

> When there is no clients listening on event the trace return
> EBADF. The file is not a bad file descriptor and to get the
> userspace able to do a proper error handling it need a different
> error code that separate a bad file descriptor from a empty listening.

I have no problem with this patch, but your description is incorrect. And
before making this change, I want to make sure that what you think is
happening is actually happening.

This has nothing to do with "clients listening". This happens when the ring
buffer is disabled for some reason. The most likely case of this happening
is if someone sets /sys/kernel/tracing/tracing_on to zero.

If this is still something you want applied, please update the change log
to a more accurate scenario.

Thanks,

-- Steve


> 
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  kernel/trace/trace.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d3e5de717df2..6e592bf736df 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6651,8 +6651,8 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>  	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
>  					    irq_flags, preempt_count());
>  	if (unlikely(!event))
> -		/* Ring buffer disabled, return as if not open for write */
> -		return -EBADF;
> +		/* Ring buffer disabled, return as if not connected */
> +		return -ENOTCONN;
>  
>  	entry = ring_buffer_event_data(event);
>  	entry->ip = _THIS_IP_;
> @@ -6731,8 +6731,8 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
>  	event = __trace_buffer_lock_reserve(buffer, TRACE_RAW_DATA, size,
>  					    irq_flags, preempt_count());
>  	if (!event)
> -		/* Ring buffer disabled, return as if not open for write */
> -		return -EBADF;
> +		/* Ring buffer disabled, return not connected */
> +		return -ENOTCONN;
>  
>  	entry = ring_buffer_event_data(event);
>  

