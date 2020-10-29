Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EB929EB13
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgJ2L5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgJ2L5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603972672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dMc/1trCtvDJZhClGbDnABHwGU/CZHZ5LiraBXGQZzI=;
        b=IF2F9wMay7E2/WdY7RDBR7PBoz2fl0vs/qCqkDF+FD4nb9r4tbJG8zX1RzcFLIlpxd5fPM
        0+pqdZ6ekI6QFxB/thcfaZRb77vAJjS4u/NPStdS6ua8WxIXE1fCumSZH4I5YWeOHbpljG
        Sh6F95doa6CVivmyvuPeCWzyk41tMqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-G-cIaxb2MZmhusLPnGwJDg-1; Thu, 29 Oct 2020 07:57:48 -0400
X-MC-Unique: G-cIaxb2MZmhusLPnGwJDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E66E78049ED;
        Thu, 29 Oct 2020 11:57:46 +0000 (UTC)
Received: from krava (unknown [10.40.193.60])
        by smtp.corp.redhat.com (Postfix) with SMTP id B4AD46EF40;
        Thu, 29 Oct 2020 11:57:44 +0000 (UTC)
Date:   Thu, 29 Oct 2020 12:57:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf data: Allow to use stdio functions for pipe mode
Message-ID: <20201029115743.GF3027684@krava>
References: <20201028085632.825804-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028085632.825804-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 05:56:32PM +0900, Namhyung Kim wrote:
> When perf data is in a pipe, it reads each event separately using
> read(2) syscall.  This is a huge performance bottleneck when
> processing large data like in perf inject.  Also perf inject needs to
> use write(2) syscall for the output.
> 
> So convert it to use buffer I/O functions in stdio library for pipe
> data.  This makes inject-build-id bench time drops from 20ms to 8ms.
> 
>   $ perf bench internals inject-build-id
>   # Running 'internals/inject-build-id' benchmark:
>     Average build-id injection took: 8.074 msec (+- 0.013 msec)
>     Average time per event: 0.792 usec (+- 0.001 usec)
>     Average memory usage: 8328 KB (+- 0 KB)
>     Average build-id-all injection took: 5.490 msec (+- 0.008 msec)
>     Average time per event: 0.538 usec (+- 0.001 usec)
>     Average memory usage: 7563 KB (+- 0 KB)
> 
> This patch enables it just for perf inject when used with pipe (it's a
> default behavior).  Maybe we could do it for perf record and/or report
> later..
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-inject.c |  2 ++
>  tools/perf/util/data.c      | 36 +++++++++++++++++++++++++++++++++---
>  tools/perf/util/data.h      | 11 ++++++++++-
>  tools/perf/util/header.c    |  8 ++++----
>  tools/perf/util/session.c   |  7 ++++---
>  5 files changed, 53 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 452a75fe68e5..14d6c88fed76 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -853,10 +853,12 @@ int cmd_inject(int argc, const char **argv)
>  		.output = {
>  			.path = "-",
>  			.mode = PERF_DATA_MODE_WRITE,
> +			.use_stdio = true,
>  		},
>  	};
>  	struct perf_data data = {
>  		.mode = PERF_DATA_MODE_READ,
> +		.use_stdio = true,
>  	};
>  	int ret;
>  
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index c47aa34fdc0a..47b5a4b50ca5 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -174,8 +174,16 @@ static bool check_pipe(struct perf_data *data)
>  			is_pipe = true;
>  	}
>  
> -	if (is_pipe)
> -		data->file.fd = fd;
> +	if (is_pipe) {
> +		if (data->use_stdio) {
> +			const char *mode;
> +
> +			mode = perf_data__is_read(data) ? "r" : "w";
> +			data->file.fptr = fdopen(fd, mode);

I guess fdopen should never fail right? but I think we should
add BUG_ON(data->file.fptr == NULL) or something

other than this the change looks good, I can see the speedup
in bench as well

jirka

