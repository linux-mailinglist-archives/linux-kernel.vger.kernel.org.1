Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC75326E9F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 02:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIRAbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 20:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgIRAbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:31:31 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 396AC207FF;
        Fri, 18 Sep 2020 00:31:30 +0000 (UTC)
Date:   Thu, 17 Sep 2020 20:31:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: use __this_cpu_read() in
 trace_buffered_event_enable()
Message-ID: <20200917203127.091e23f2@rorschach.local.home>
In-Reply-To: <20200813112803.12256-1-tian.xianting@h3c.com>
References: <20200813112803.12256-1-tian.xianting@h3c.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply (been busy with Linux Plumbers, took a
vacation, and then trying to catch up on all my email for the last two
months!)

But I just wanted to let you know that I added this to my queue.

Thanks!

-- Steve


On Thu, 13 Aug 2020 19:28:03 +0800
Xianting Tian <tian.xianting@h3c.com> wrote:

> The code is executed with preemption disabled, so it's
> safe to use __this_cpu_read().
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index bb6226972..7d0d71ce9 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2514,7 +2514,7 @@ void trace_buffered_event_enable(void)
>  
>  		preempt_disable();
>  		if (cpu == smp_processor_id() &&
> -		    this_cpu_read(trace_buffered_event) !=
> +		    __this_cpu_read(trace_buffered_event) !=
>  		    per_cpu(trace_buffered_event, cpu))
>  			WARN_ON_ONCE(1);
>  		preempt_enable();

