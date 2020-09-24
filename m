Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738CF2777F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgIXRma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:42:30 -0400
Received: from mail.efficios.com ([167.114.26.124]:58850 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXRm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:42:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BF3F62D6A22;
        Thu, 24 Sep 2020 13:42:25 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P8f5KtIgWglj; Thu, 24 Sep 2020 13:42:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5CE432D68CA;
        Thu, 24 Sep 2020 13:42:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5CE432D68CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600969345;
        bh=nmtZAeR5sqORLoqN1My7cIPw8sFNxyB2cG9kgvPYQHE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=D6MfuqvV7PRSF/updhnzbHfLJlAwLaVF1KYnh4s2NmMHeRUmweqVSdcCRc3DUXIdZ
         DqEunMHEqZXFw2Xy1ngOoQcwC/SQ0+QVQORpBRYVJzUYFEiChYJUaZqWXZ8vE3HUv7
         MmPs+4BQ/B7SRpj6fD0P3EBlTofjjVjmwI5ZY8zbAuPUvE+LOQzei4xkXqOJOid8wS
         Xczw7AQQ5y2gDsvkSHtLbG/LAEAO3L+jlnK6Bq9JeMnHwVb+/Bo+QCXbs/GBKNMCN9
         J8MpD4csfN9mD6ehgJ703v8ciYmmRjCiC1ZJOMwBAkuranMxEOmLgDuwj1OzxZVTpb
         HfyllFNlKZIuA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gcDQfxz5416M; Thu, 24 Sep 2020 13:42:25 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 479852D676E;
        Thu, 24 Sep 2020 13:42:25 -0400 (EDT)
Date:   Thu, 24 Sep 2020 13:42:25 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        linux-mm <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Message-ID: <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200924171846.993048030@goodmis.org>
References: <20200924170928.466191266@goodmis.org> <20200924171846.993048030@goodmis.org>
Subject: Re: [PATCH 1/2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: tracepoints: Add helper to test if tracepoint is enabled in a header
Thread-Index: kInbMT4XAiD6v8/BFtAt63F7ketfIA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 24, 2020, at 1:09 PM, rostedt rostedt@goodmis.org wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> As tracepoints are discouraged from being added in a header because it can
> cause side effects if other tracepoints are in headers, the common
> workaround is to add a function call that calls a wrapper function in a
> C file that then calls the tracepoint. But as function calls add overhead,
> this function should only be called when the tracepoint in question is
> enabled. To get around the overhead, a static_branch can be used that only
> gets set when the tracepoint is enabled, and then inside the block of the
> static branch can contain the call to the tracepoint wrapper.
> 
> Add a tracepoint_enabled(tp) macro that gets passed the name of the
> tracepoint, and this becomes a static_branch that is enabled when the
> tracepoint is enabled and is a nop when the tracepoint is disabled.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> Documentation/trace/tracepoints.rst | 25 ++++++++++++++++++++++
> include/linux/tracepoint-defs.h     | 33 +++++++++++++++++++++++++++++
> 2 files changed, 58 insertions(+)
> 
> diff --git a/Documentation/trace/tracepoints.rst
> b/Documentation/trace/tracepoints.rst
> index 6e3ce3bf3593..833d39ee1c44 100644
> --- a/Documentation/trace/tracepoints.rst
> +++ b/Documentation/trace/tracepoints.rst
> @@ -146,3 +146,28 @@ with jump labels and avoid conditional branches.
>       define tracepoints. Check http://lwn.net/Articles/379903,
>       http://lwn.net/Articles/381064 and http://lwn.net/Articles/383362
>       for a series of articles with more details.
> +
> +If you require calling a tracepoint from a header file, it is not
> +recommended to call one directly or to use the trace_<tracepoint>_enabled()
> +function call, as tracepoints in header files can have side effects if a
> +header is included from a file that has CREATE_TRACE_POINTS set. Instead,
> +include tracepoint-defs.h and use trace_enabled().

Tracepoints per-se have no issues being used from header files. The TRACE_EVENT
infrastructure seems to be the cause of this problem. We should fix trace events
rather than require all users to use weird work-arounds thorough the kernel code
base.

I am not against the idea of a tracepoint_enabled(tp), but I am against the
motivation behind this patch and the new tracepoint user requirements it documents.

> +
> +In a C file::
> +
> +	void do_trace_foo_bar_wrapper(args)
> +	{
> +		trace_foo_bar(args);
> +	}
> +
> +In the header file::
> +
> +	DECLEARE_TRACEPOINT(foo_bar);
> +
> +	static inline void some_inline_function()
> +	{
> +		[..]
> +		if (trace_enabled(foo_bar))

Is it trace_enabled() or tracepoint_enabled() ? There is a mismatch
between the commit message/code and the documentation.

Thanks,

Mathieu

> +			do_trace_foo_bar_wrapper(args);
> +		[..]
> +	}
> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> index b29950a19205..ca2f1f77f6f8 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -48,4 +48,37 @@ struct bpf_raw_event_map {
> 	u32			writable_size;
> } __aligned(32);
> 
> +/*
> + * If a tracepoint needs to be called from a header file, it is not
> + * recommended to call it directly, as tracepoints in header files
> + * may cause side-effects. Instead, use trace_enabled() to test
> + * if the tracepoint is enabled, then if it is, call a wrapper
> + * function defined in a C file that will then call the tracepoint.
> + *
> + * For "trace_foo()", you would need to create a wrapper function
> + * in a C file to call trace_foo():
> + *   void trace_bar(args) { trace_foo(args); }
> + * Then in the header file, declare the tracepoint:
> + *   DECLARE_TRACEPOINT(foo);
> + * And call your wrapper:
> + *   static inline void some_inlined_function() {
> + *            [..]
> + *            if (tracepoint_enabled(foo))
> + *                    trace_bar(args);
> + *            [..]
> + *   }
> + *
> + * Note: tracepoint_enabled(foo) is equivalent to trace_foo_enabled()
> + *   but is safe to have in headers, where trace_foo_enabled() is not.
> + */
> +#define DECLARE_TRACEPOINT(tp) \
> +	extern struct tracepoint __tracepoint_##tp
> +
> +#ifdef CONFIG_TRACEPOINTS
> +# define tracepoint_enabled(tp) \
> +	static_key_false(&(__tracepoint_##tp).key)
> +#else
> +# define tracepoint_enabled(tracepoint) false
> +#endif
> +
> #endif
> --
> 2.28.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
