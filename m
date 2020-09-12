Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A10E267C63
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 22:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgILUvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 16:51:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42633 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725880AbgILUvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 16:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599943894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4VAzRBKI2iclcXtjU1AgaFUfTBP8NLGkZ2J0D8pWq0=;
        b=AsCug+6LJBGY7VnqqL1JSlBhcfkGYubnVYdmMkTq878DdGE0jxRVZbaV9L8Pti9Z/wykFB
        +0wDp3qmQbQKDnWa9iKbP4jMBCjV8v9cAtfuEW3YlSiZWRE6VX1/PAYFmuSDH+VVZKbXTb
        yZgeaaK0lCyjkiUcuXmctu0b36vG700=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-d-mKDSrtMK-YNadLGsLOwA-1; Sat, 12 Sep 2020 16:51:30 -0400
X-MC-Unique: d-mKDSrtMK-YNadLGsLOwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 376DA1DDE2;
        Sat, 12 Sep 2020 20:51:29 +0000 (UTC)
Received: from krava (unknown [10.40.192.28])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5E4441002D4E;
        Sat, 12 Sep 2020 20:51:25 +0000 (UTC)
Date:   Sat, 12 Sep 2020 22:51:24 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf bench: Fix 2 memory sanitizer warnings
Message-ID: <20200912205124.GF1714160@krava>
References: <20200912053725.1405857-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912053725.1405857-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 10:37:25PM -0700, Ian Rogers wrote:
> Memory sanitizer warns if a write is performed where the memory
> being read for the write is uninitialized. Avoid this warning by
> initializing the memory.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/bench/sched-messaging.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
> index 71d830d7b923..cecce93ccc63 100644
> --- a/tools/perf/bench/sched-messaging.c
> +++ b/tools/perf/bench/sched-messaging.c
> @@ -66,11 +66,10 @@ static void fdpair(int fds[2])
>  /* Block until we're ready to go */
>  static void ready(int ready_out, int wakefd)
>  {
> -	char dummy;
>  	struct pollfd pollfd = { .fd = wakefd, .events = POLLIN };
>  
>  	/* Tell them we're ready. */
> -	if (write(ready_out, &dummy, 1) != 1)
> +	if (write(ready_out, "R", 1) != 1)
>  		err(EXIT_FAILURE, "CLIENT: ready write");
>  
>  	/* Wait for "GO" signal */
> @@ -85,6 +84,7 @@ static void *sender(struct sender_context *ctx)
>  	unsigned int i, j;
>  
>  	ready(ctx->ready_out, ctx->wakefd);
> +	memset(data, 'S', sizeof(data));
>  
>  	/* Now pump to every receiver. */
>  	for (i = 0; i < nr_loops; i++) {
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

