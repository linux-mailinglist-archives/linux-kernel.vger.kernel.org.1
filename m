Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55665297D2E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762032AbgJXPoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756857AbgJXPoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603554262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4WzAzRY6W/KtkmIOma8lL7q2NRrkmdRzdnaMa9+D2OM=;
        b=c7OGuFoJLGDl2q6ur6gTB+4Y90jvGt7gPcIbDgxGndn14wAtuwfs6hkX9F2xMFDRxVzmdD
        ClbT0L/8t/GZAsyQJjQmQ8JsBi4FV5fGIrnj9QzO9/ESGjYRTx4GuDhQVQ1ssU/t4kpio9
        rS17rwl3zdU0jrqgOSr3wWQtSMjvmyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-XHzLszdsOKqLxqHXbSweBA-1; Sat, 24 Oct 2020 11:44:20 -0400
X-MC-Unique: XHzLszdsOKqLxqHXbSweBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7C281006CB3;
        Sat, 24 Oct 2020 15:44:18 +0000 (UTC)
Received: from krava (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id DFC821A8EC;
        Sat, 24 Oct 2020 15:44:16 +0000 (UTC)
Date:   Sat, 24 Oct 2020 17:44:16 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 14/15] perf record: start threads in the beginning of
 trace streaming
Message-ID: <20201024154416.GF2589351@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <0584888b-17b3-7a62-e585-8582d8a2d439@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0584888b-17b3-7a62-e585-8582d8a2d439@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 07:10:09PM +0300, Alexey Budankov wrote:
> 
> Start threads in detached state because its management is possible
> via messaging. Block signals prior the threads start so only main
> tool thread would be notified on external async signals during data
> collection. Streaming threads connect one-to-one to mapped data
> buffers and write into per-CPU trace files located at data directory.
> Data buffers and threads are affined to local NUMA nodes and monitored
> CPUs according to system topology. --cpu option can be used to specify
> CPUs to be monitored.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 128 +++++++++++++++++++++++++++++++++---
>  1 file changed, 120 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index a15642656066..1d41e996a994 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -56,6 +56,7 @@
>  #include <poll.h>
>  #include <pthread.h>
>  #include <unistd.h>
> +#include <sys/syscall.h>
>  #include <sched.h>
>  #include <signal.h>
>  #ifdef HAVE_EVENTFD_SUPPORT
> @@ -1377,6 +1378,62 @@ static void record__thread_munmap_filtered(struct fdarray *fda, int fd,
>  		perf_mmap__put(map);
>  }
>  
> +static void *record__thread(void *arg)
> +{
> +	enum thread_msg msg = THREAD_MSG__READY;
> +	bool terminate = false;
> +	struct fdarray *pollfd;
> +	int err, ctlfd_pos;
> +
> +	thread = arg;
> +	thread->tid = syscall(SYS_gettid);
> +
> +	err = write(thread->comm.ack[1], &msg, sizeof(msg));
> +	if (err == -1)
> +		pr_err("threads: %d failed to notify on start. Error %m", thread->tid);
> +
> +	pollfd = &(thread->pollfd);

I don't think braces are necessary in here

jirka

