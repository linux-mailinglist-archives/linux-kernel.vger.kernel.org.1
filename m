Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13522F7472
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbhAOIf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:35:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730180AbhAOIf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610699670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C7APAAHkghdqUtEMDpUh+rNGkHFJ2UCMPvGRToS0fcI=;
        b=era+JkezTJ7lsIi9mce4gDa/mslIAvZtGOJ8gRW84DQAnwbls01+JvvvxEsLsWvcd4Lgz7
        awq1lJpMVPrmdmCw4EQoKc5/MuS9jUheb6FVIKpBDDDDdLQza0gZxueob7q1qR5R+Odpnv
        oF5Y6vrilHzXwYLkPNavwsK3PSDyAsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-Yt_ewrZ7M5yoi9kILrdQ7g-1; Fri, 15 Jan 2021 03:34:25 -0500
X-MC-Unique: Yt_ewrZ7M5yoi9kILrdQ7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63C98835DE0;
        Fri, 15 Jan 2021 08:34:23 +0000 (UTC)
Received: from krava (unknown [10.40.194.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4E9EC1F0;
        Fri, 15 Jan 2021 08:34:21 +0000 (UTC)
Date:   Fri, 15 Jan 2021 09:34:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] libperf tests: Avoid uninitialized variable warning.
Message-ID: <20210115083420.GA1470103@krava>
References: <20210114212304.4018119-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114212304.4018119-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 01:23:04PM -0800, Ian Rogers wrote:
> The variable bf is read (for a write call) without being initialized
> triggering a memory sanitizer warning. Use bf in the read and switch the
> write to reading from a string.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/lib/perf/tests/test-evlist.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index 6d8ebe0c2504..1b225fe34a72 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -208,7 +208,6 @@ static int test_mmap_thread(void)
>  	char path[PATH_MAX];
>  	int id, err, pid, go_pipe[2];
>  	union perf_event *event;
> -	char bf;
>  	int count = 0;
>  
>  	snprintf(path, PATH_MAX, "%s/kernel/debug/tracing/events/syscalls/sys_enter_prctl/id",
> @@ -229,6 +228,7 @@ static int test_mmap_thread(void)
>  	pid = fork();
>  	if (!pid) {
>  		int i;
> +		char bf;
>  
>  		read(go_pipe[0], &bf, 1);
>  
> @@ -266,7 +266,7 @@ static int test_mmap_thread(void)
>  	perf_evlist__enable(evlist);
>  
>  	/* kick the child and wait for it to finish */
> -	write(go_pipe[1], &bf, 1);
> +	write(go_pipe[1], "A", 1);
>  	waitpid(pid, NULL, 0);
>  
>  	/*
> -- 
> 2.30.0.296.g2bfb1c46d8-goog
> 

