Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64982F24BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391637AbhALAZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404209AbhAKXwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:52:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C583522BED;
        Mon, 11 Jan 2021 23:51:30 +0000 (UTC)
Date:   Mon, 11 Jan 2021 18:51:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] trace: Remove get/put_cpu() from function_trace_init
Message-ID: <20210111185129.0d5745f9@gandalf.local.home>
In-Reply-To: <20201230140521.31920-1-hqjagain@gmail.com>
References: <20201230140521.31920-1-hqjagain@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 22:05:21 +0800
Qiujun Huang <hqjagain@gmail.com> wrote:

> Since commit b6f11df26fdc ("trace: Call tracing_reset_online_cpus before
> tracer->init()"), get/put_cpu() are not needed anymore.
> We can use raw_smp_processor_id() instead.

I added both your patches (this one and the trace_ignore_this_task()
kernel-doc fix to my queue.

Thanks!

-- Steve

> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
> v2:
> Use raw_smp_processor_id() instead of smp_processor_id()
> ---
>  kernel/trace/trace_functions.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index c5095dd28e20..f67aec5bb771 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -106,8 +106,7 @@ static int function_trace_init(struct trace_array *tr)
>  
>  	ftrace_init_array_ops(tr, func);
>  
> -	tr->array_buffer.cpu = get_cpu();
> -	put_cpu();
> +	tr->array_buffer.cpu = raw_smp_processor_id();
>  
>  	tracing_start_cmdline_record();
>  	tracing_start_function_trace(tr);

