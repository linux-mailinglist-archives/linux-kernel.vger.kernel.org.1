Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8162728BB97
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbgJLPLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389142AbgJLPLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:11:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6C220878;
        Mon, 12 Oct 2020 15:11:42 +0000 (UTC)
Date:   Mon, 12 Oct 2020 11:11:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tracing/boot: Add ftrace.instance.*.alloc_snapshot
 option
Message-ID: <20201012111140.5e8e2e0c@gandalf.local.home>
In-Reply-To: <160234368948.400560.15313384470765915015.stgit@devnote2>
References: <160234368056.400560.6282640165007466754.stgit@devnote2>
        <160234368948.400560.15313384470765915015.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Oct 2020 00:28:09 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add ftrace.instance.*.alloc_snapshot option.
> 
> This option has been described in Documentation/trace/boottime-trace.rst
> but not implemented yet.
> 
> ftrace.[instance.INSTANCE.]alloc_snapshot
>    Allocate snapshot buffer.
> 
> The difference from kernel.alloc_snapshot is that the kernel.alloc_snapshot
> will allocate the buffer only for the main instance, but this can allocate
> buffer for any new instances.

I queued this up. Thanks Masami!

-- Steve

> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_boot.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 754e3cf2df3a..c22a152ef0b4 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -284,6 +284,12 @@ trace_boot_enable_tracer(struct trace_array *tr, struct xbc_node *node)
>  		if (tracing_set_tracer(tr, p) < 0)
>  			pr_err("Failed to set given tracer: %s\n", p);
>  	}
> +
> +	/* Since tracer can free snapshot buffer, allocate snapshot here.*/
> +	if (xbc_node_find_value(node, "alloc_snapshot", NULL)) {
> +		if (tracing_alloc_snapshot_instance(tr) < 0)
> +			pr_err("Failed to allocate snapshot buffer\n");
> +	}
>  }
>  
>  static void __init

