Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1134F2D9117
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 00:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436700AbgLMXCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 18:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436568AbgLMXCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 18:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607900443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lc4XgJcIu2ELxMQygAT8Kc9KkJ2gvLdIoHGXb9sy1tg=;
        b=BcL2MU+pIHtf0hIcd+hd1SVh/hEgb9W98KXng0TQ49U5vTRGYCO6xFGgXfeWuPCxUfOop2
        rkojzP0CPUicoqf5L2WY2Ewo4JDaOD/PpUJH3e01AkozLf60kEe/htCagsuGL3UHNjH3H/
        26otFkurk7WHCpp9ELDn8qoCZ8sg+fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-0-rmws2zMSG1pn405DjMwQ-1; Sun, 13 Dec 2020 18:00:39 -0500
X-MC-Unique: 0-rmws2zMSG1pn405DjMwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36F22803621;
        Sun, 13 Dec 2020 23:00:38 +0000 (UTC)
Received: from krava (unknown [10.40.192.121])
        by smtp.corp.redhat.com (Postfix) with SMTP id 43EF261F49;
        Sun, 13 Dec 2020 23:00:35 +0000 (UTC)
Date:   Mon, 14 Dec 2020 00:00:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/2] perf evlist: Support pipe mode display
Message-ID: <20201213230035.GC502638@krava>
References: <20201210061302.88213-1-namhyung@kernel.org>
 <20201210061302.88213-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210061302.88213-2-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 03:13:02PM +0900, Namhyung Kim wrote:
> Likewise, perf evlist command should print event attributes by reading
> PERF_RECORD_HEADER_ATTR records.
> 
> Before:
>   $ perf record -o- true | ./perf evlist -i-
>   (prints nothing)
> 
> After:
>   $ perf record -o- true | ./perf evlist -i-
>   cycles:pppH
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-evlist.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
> index 98e992801251..4617b32c9c97 100644
> --- a/tools/perf/builtin-evlist.c
> +++ b/tools/perf/builtin-evlist.c
> @@ -17,6 +17,14 @@
>  #include "util/data.h"
>  #include "util/debug.h"
>  #include <linux/err.h>
> +#include "util/tool.h"
> +
> +static int process_header_feature(struct perf_session *session __maybe_unused,
> +				  union perf_event *event __maybe_unused)
> +{
> +	session_done = 1;
> +	return 0;
> +}
>  
>  static int __cmd_evlist(const char *file_name, struct perf_attr_details *details)
>  {
> @@ -27,12 +35,20 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
>  		.mode      = PERF_DATA_MODE_READ,
>  		.force     = details->force,
>  	};
> +	struct perf_tool tool = {
> +		/* only needed for pipe mode */
> +		.attr = perf_event__process_attr,
> +		.feature = process_header_feature,
> +	};
>  	bool has_tracepoint = false;
>  
> -	session = perf_session__new(&data, 0, NULL);
> +	session = perf_session__new(&data, 0, &tool);
>  	if (IS_ERR(session))
>  		return PTR_ERR(session);
>  
> +	if (data.is_pipe)
> +		perf_session__process_events(session);
> +
>  	evlist__for_each_entry(session->evlist, pos) {
>  		evsel__fprintf(pos, details, stdout);
>  
> -- 
> 2.29.2.576.ga3fc446d84-goog
> 

