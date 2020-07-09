Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D70621AA55
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 00:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGIWOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 18:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgGIWOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:14:01 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1911120672;
        Thu,  9 Jul 2020 22:14:01 +0000 (UTC)
Date:   Thu, 9 Jul 2020 18:13:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] tracing: toplevel d_entry already initialized
Message-ID: <20200709181359.42b4e61e@oasis.local.home>
In-Reply-To: <20200703020612.12930-5-richard.weiyang@linux.alibaba.com>
References: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
        <20200703020612.12930-5-richard.weiyang@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Jul 2020 10:06:12 +0800
Wei Yang <richard.weiyang@linux.alibaba.com> wrote:

> Currently we have following call flow:
> 
>     tracer_init_tracefs()
>         tracing_init_dentry()
>         event_trace_init()
>             tracing_init_dentry()
> 
> This shows tracing_init_dentry() is called twice in this flow and this
> is not necessary.

There's no reason to have patch 4 and 5 separate. Fold the two together.

If you want, you can create another patch that changes
tracing_init_dentry() to return a integer, as you point out, it never
returns an actual dentry. No reason for having it return a pointer then.

-- Steve


> 
> Let's remove the second one when it is for sure be properly initialized.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  kernel/trace/trace_events.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 8b3aa57dcea6..76879b29cf33 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3434,7 +3434,6 @@ early_initcall(event_trace_enable_again);
>  __init int event_trace_init(void)
>  {
>  	struct trace_array *tr;
> -	struct dentry *d_tracer;
>  	struct dentry *entry;
>  	int ret;
>  
> @@ -3442,10 +3441,6 @@ __init int event_trace_init(void)
>  	if (!tr)
>  		return -ENODEV;
>  
> -	d_tracer = tracing_init_dentry();
> -	if (IS_ERR(d_tracer))
> -		return 0;
> -
>  	entry = tracefs_create_file("available_events", 0444, NULL,
>  				    tr, &ftrace_avail_fops);
>  	if (!entry)

