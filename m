Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BFA28D8FD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 05:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgJNDZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 23:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbgJNDZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 23:25:06 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1891820776;
        Wed, 14 Oct 2020 03:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602645905;
        bh=FkJc0CmuRPalgH76j9U05svRZoE1Y2u+M8oN8ffu1hA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PLQEQ9ldreseaGL2zWcASqVxIbeSKfX6IMro+N4vlFBtHv44Q9N1vv2jkzwDyzClo
         xe7XkMWSq5n/KR1f3qV5GjSDuvWIvHjedZ2462Q0uu/MP2Vwe/uagqwizHxlAaMeb/
         d6O5mXLcP0sej2d6VNcpDZL/FgSC+tfYeTifbEaA=
Date:   Wed, 14 Oct 2020 12:25:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tracing: Check return value of __create_val_fields()
 before using its result
Message-Id: <20201014122500.744019110c1c37897c750a9a@kernel.org>
In-Reply-To: <20201013154852.3abd8702@gandalf.local.home>
References: <20201013154852.3abd8702@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 15:48:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> After having a typo for writing a histogram trigger.
> 
> Wrote:
>   echo 'hist:key=pid:ts=common_timestamp.usec' > events/sched/sched_waking/trigger
> 
> Instead of:
>   echo 'hist:key=pid:ts=common_timestamp.usecs' > events/sched/sched_waking/trigger
> 
> and the following crash happened:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000008
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] PREEMPT SMP PTI
>  CPU: 4 PID: 1641 Comm: sh Not tainted 5.9.0-rc5-test+ #549
>  Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
>  RIP: 0010:event_hist_trigger_func+0x70b/0x1ee0
>  Code: 24 08 89 d5 49 89 cc e9 8c 00 00 00 4c 89 f2 41 b9 00 10 00 00 4c 89 e1 44 89 ee 4c 89 ff e8 dc d3 ff ff 45 89 ea 4b 8b 14 d7 <f6> 42 08 04 74 17 41 8b 8f c0 00 00 00 8d 71 01 41 89 b7 c0 00 00
>  RSP: 0018:ffff959213d53db0 EFLAGS: 00010202
>  RAX: ffffffffffffffea RBX: 0000000000000000 RCX: 0000000000084c04
>  RDX: 0000000000000000 RSI: df7326aefebd174c RDI: 0000000000031080
>  RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000001
>  R10: 0000000000000001 R11: 0000000000000046 R12: ffff959211dcf690
>  R13: 0000000000000001 R14: ffff95925a36e370 R15: ffff959251c89800
>  FS:  00007fb9ea934740(0000) GS:ffff95925ab00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000008 CR3: 00000000c976c005 CR4: 00000000001706e0
>  Call Trace:
>   ? trigger_process_regex+0x78/0x110
>   trigger_process_regex+0xc5/0x110
>   event_trigger_write+0x71/0xd0
>   vfs_write+0xca/0x210
>   ksys_write+0x70/0xf0
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  RIP: 0033:0x7fb9eaa29487
>  Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> 
> This was caused by accessing the hlist_data fields after the call to
> __create_val_fields() without checking if the creation succeed.
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Fixes: 63a1e5de3006 ("tracing: Save normal string variables")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index c74a7d157306..96c3f86b81c5 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3687,7 +3687,7 @@ static int create_var_field(struct hist_trigger_data *hist_data,
>  
>  	ret = __create_val_field(hist_data, val_idx, file, var_name, expr_str, flags);
>  
> -	if (hist_data->fields[val_idx]->flags & HIST_FIELD_FL_STRING)
> +	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_STRING)
>  		hist_data->fields[val_idx]->var_str_idx = hist_data->n_var_str++;
>  
>  	return ret;
> -- 
> 2.25.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
