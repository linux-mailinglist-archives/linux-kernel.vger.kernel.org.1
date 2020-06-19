Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C391FFFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 03:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgFSB6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 21:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbgFSB6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:58:32 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C27A020776;
        Fri, 19 Jun 2020 01:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592531911;
        bh=F/8ShmQT8YBz5aQ9FSoJ8n8biUK+yb4/2n2kI3CCzVg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LW8stfj4UEZ4mxBhDblDfhrmV3TUHLN52q7VCCq0/nOxeCznoT/7G1LrRdjQWcoc6
         qxnvAvDHSMkJhI/IpQ6y7/wbbZBJ8rmWEoRMW0K7zGbD3XPzdDW7QO5O8Oyc4V+nQP
         3TIXke8huxq5QUiR2HoYzcGd6GvMtcQlOIrK9NAE=
Date:   Fri, 19 Jun 2020 10:58:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Sascha Ortmann <sascha.ortmann@stud.uni-hannover.de>
Cc:     linux-kernel@i4.cs.fau.de, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, maximilian.werner96@gmail.com,
        mingo@redhat.com, rostedt@goodmis.org
Subject: Re: [PATCH v2] tracing/boottime: Fix kprobe multiple events
Message-Id: <20200619105827.c6042e60cdcd8609f5ec79e4@kernel.org>
In-Reply-To: <20200618163301.25854-1-sascha.ortmann@stud.uni-hannover.de>
References: <20200618105051.ce01a84a13bbf67b816c1363@kernel.org>
        <20200618163301.25854-1-sascha.ortmann@stud.uni-hannover.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 18:33:01 +0200
Sascha Ortmann <sascha.ortmann@stud.uni-hannover.de> wrote:

> Fix boottime kprobe events to report and abort after each failure when
> adding probes.
> 
> As an example, when we try to set multiprobe kprobe events in
> bootconfig like this:
> 
> ftrace.event.kprobes.vfsevents {
>         probes = "vfs_read $arg1 $arg2,,
>                  !error! not reported;?", // leads to error
>                  "vfs_write $arg1 $arg2"
> }
> 
> This will not work as expected. After 
> commit da0f1f4167e3af69e ("tracing/boottime: Fix kprobe event API usage"), 
> the function trace_boot_add_kprobe_event will not produce any error 
> message when adding a probe fails at kprobe_event_gen_cmd_start. 
> Furthermore, we continue to add probes when kprobe_event_gen_cmd_end fails
> (and kprobe_event_gen_cmd_start did not fail). In this case the function 
> even returns successfully when the last call to kprobe_event_gen_cmd_end
> is successful.
> 
> The behaviour of reporting and aborting after failures is not
> consistent.
> 
> The function trace_boot_add_kprobe_event now reports each failure and
> stops adding probes immediately.

Thanks for updating. This looks good to me. 

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

and 

Fixes: da0f1f4167e3 ("tracing/boottime: Fix kprobe event API usage")

Thank you!

> 
> Cc: linux-kernel@i4.cs.fau.de
> Co-developed-by: Maximilian Werner <maximilian.werner96@gmail.com>
> Signed-off-by: Maximilian Werner <maximilian.werner96@gmail.com>
> Signed-off-by: Sascha Ortmann <sascha.ortmann@stud.uni-hannover.de>
> ---
>  kernel/trace/trace_boot.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 9de29bb45a27..be893eb22071 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -101,12 +101,16 @@ trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
>  		kprobe_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
>  
>  		ret = kprobe_event_gen_cmd_start(&cmd, event, val);
> -		if (ret)
> +		if (ret) {
> +			pr_err("Failed to generate probe: %s\n", buf);
>  			break;
> +		}
>  
>  		ret = kprobe_event_gen_cmd_end(&cmd);
> -		if (ret)
> +		if (ret) {
>  			pr_err("Failed to add probe: %s\n", buf);
> +			break;
> +		}
>  	}
>  
>  	return ret;
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
