Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B8328BA8E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbgJLOPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbgJLOPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:15:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 026302076E;
        Mon, 12 Oct 2020 14:15:29 +0000 (UTC)
Date:   Mon, 12 Oct 2020 10:15:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/2] tracing: support "bool" type in synthetic trace
 events
Message-ID: <20201012101527.6df53dda@gandalf.local.home>
In-Reply-To: <20201009220524.485102-2-axelrasmussen@google.com>
References: <20201009220524.485102-1-axelrasmussen@google.com>
        <20201009220524.485102-2-axelrasmussen@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tom,

Can you ack this patch for me?

-- Steve


On Fri,  9 Oct 2020 15:05:23 -0700
Axel Rasmussen <axelrasmussen@google.com> wrote:

> It's common [1] to define tracepoint fields as "bool" when they contain
> a true / false value. Currently, defining a synthetic event with a
> "bool" field yields EINVAL. It's possible to work around this by using
> e.g. u8 (assuming sizeof(bool) is 1, and bool is unsigned; if either of
> these properties don't match, you get EINVAL [2]).
> 
> Supporting "bool" explicitly makes hooking this up easier and more
> portable for userspace.
> 
> [1]: grep -r "bool" include/trace/events/
> [2]: check_synth_field() in kernel/trace/trace_events_hist.c
> 
> Acked-by: Michel Lespinasse <walken@google.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  kernel/trace/trace_events_synth.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 8e1974fbad0e..8f94c84349a6 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -234,6 +234,8 @@ static int synth_field_size(char *type)
>  		size = sizeof(long);
>  	else if (strcmp(type, "unsigned long") == 0)
>  		size = sizeof(unsigned long);
> +	else if (strcmp(type, "bool") == 0)
> +		size = sizeof(bool);
>  	else if (strcmp(type, "pid_t") == 0)
>  		size = sizeof(pid_t);
>  	else if (strcmp(type, "gfp_t") == 0)
> @@ -276,6 +278,8 @@ static const char *synth_field_fmt(char *type)
>  		fmt = "%ld";
>  	else if (strcmp(type, "unsigned long") == 0)
>  		fmt = "%lu";
> +	else if (strcmp(type, "bool") == 0)
> +		fmt = "%d";
>  	else if (strcmp(type, "pid_t") == 0)
>  		fmt = "%d";
>  	else if (strcmp(type, "gfp_t") == 0)
> --
> 2.28.0.1011.ga647a8990f-goog

