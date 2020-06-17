Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823CA1FD041
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgFQPFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 11:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgFQPFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:05:30 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 578E2206DB;
        Wed, 17 Jun 2020 15:05:29 +0000 (UTC)
Date:   Wed, 17 Jun 2020 11:05:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sascha Ortmann <sascha.ortmann@stud.uni-hannover.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Maximilian Werner <maximilian.werner96@gmail.com>
Subject: Re: [PATCH] tracing/boottime: Fix kprobe multiple events
Message-ID: <20200617110521.7ed41fdd@oasis.local.home>
In-Reply-To: <20200617140817.17161-1-sascha.ortmann@stud.uni-hannover.de>
References: <20200617140817.17161-1-sascha.ortmann@stud.uni-hannover.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 16:08:17 +0200
Sascha Ortmann <sascha.ortmann@stud.uni-hannover.de> wrote:

> Fix boottime kprobe events to add multiple events even if one fails
> and report probe generation failures.
> 
> As an example, when we try to set multiprobe kprobe events in
> bootconfig like this:
> 
> ftrace.event.kprobes.vfsevents {
> 	probes = "vfs_read $arg1 $arg2,,
>                  !error! not reported;?", // leads to error
> 		 "vfs_write $arg1 $arg2"
> }
> 
> this will not work like expected. After commit
> da0f1f4167e3af69e1d8b32d6d65195ddd2bfb64 ("tracing/boottime:
> Fix kprobe event API usage"), the function
> trace_boot_add_kprobe_event will not produce any error message,
> aborting the function and stopping subsequent probes from getting
> installed when adding a probe fails at kprobe_event_gen_cmd_start.
> Furthermore, probes continue when kprobe_event_gen_cmd_end fails
> (and kprobe_event_gen_cmd_start did not fail). In this case the
> function even returns successfully when the last call to
> kprobe_event_gen_cmd_end is successful.
> 
> The behaviour of reporting and aborting after failures is not
> consistent.
> 
> The function trace_boot_add_kprobe_event now continues even when
> one of the multiple events fails. Each failure is now reported
> individually. Since the function can only return one result to the
> caller, the function returns now the last failure (or none, if
> nothing fails).
> 
> Cc: linux-kernel@i4.cs.fau.de
> Signed-off-by: Maximilian Werner <maximilian.werner96@gmail.com>
> Signed-off-by: Sascha Ortmann <sascha.ortmann@stud.uni-hannover.de>

Why the double signed off by?

Masami, I'm fine with this, but needs your review.

-- Steve

> ---
>  kernel/trace/trace_boot.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 9de29bb45a27..dbb50184e060 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -95,18 +95,24 @@ trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
>  	struct xbc_node *anode;
>  	char buf[MAX_BUF_LEN];
>  	const char *val;
> +	int error = 0;
>  	int ret = 0;
>  
>  	xbc_node_for_each_array_value(node, "probes", anode, val) {
>  		kprobe_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
>  
> -		ret = kprobe_event_gen_cmd_start(&cmd, event, val);
> -		if (ret)
> -			break;
> +		error = kprobe_event_gen_cmd_start(&cmd, event, val);
> +		if (error) {
> +			pr_err("Failed to generate probe: %s\n", buf);
> +			ret = error;
> +			continue;
> +		}
>  
> -		ret = kprobe_event_gen_cmd_end(&cmd);
> -		if (ret)
> +		error = kprobe_event_gen_cmd_end(&cmd);
> +		if (error) {
>  			pr_err("Failed to add probe: %s\n", buf);
> +			ret = error;
> +		}
>  	}
>  
>  	return ret;

