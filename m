Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907162D9116
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 00:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436551AbgLMXCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 18:02:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436543AbgLMXCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 18:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607900428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aWZraJBXiN5UWeboBzyeAoAmA5muh6tgXP73Wtx9kiI=;
        b=hIQg3weXYNnIE8xsUrrqYXATmZq3FGL4G3IVuAMqTuGYn/FGt/AwJanrk2tScE8BiI5M/o
        VCbcOrh+lINXAAr0MdeUbVEmkxY7NsO8qsTLPtYSgRlVHjswNBDPD/jVMiYYowWrhZ1+Hr
        6+xMcQJUEyZMqrLLn1xxwivMLMGiVp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-QcE1AIsCMXSZUyoyVvf4Yw-1; Sun, 13 Dec 2020 18:00:24 -0500
X-MC-Unique: QcE1AIsCMXSZUyoyVvf4Yw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F06A107ACF8;
        Sun, 13 Dec 2020 23:00:22 +0000 (UTC)
Received: from krava (unknown [10.40.192.121])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9415C10021B3;
        Sun, 13 Dec 2020 23:00:20 +0000 (UTC)
Date:   Mon, 14 Dec 2020 00:00:19 +0100
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
Subject: Re: [PATCH 1/2] perf report: Support --header-only for pipe mode
Message-ID: <20201213230019.GB502638@krava>
References: <20201210061302.88213-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210061302.88213-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 03:13:01PM +0900, Namhyung Kim wrote:
> The --header-only checks file header and prints the feature data.  But
> as pipe mode doesn't have it in the header it prints almost nothing.
> Change it to process first few records until it founds HEADER_FEATURE.
> 
> Before:
>   $ perf record -o- true | perf report -i- --header-only
>   # ========
>   # captured on    : Thu Dec 10 14:34:59 2020
>   # header version : 1
>   # data offset    : 0
>   # data size      : 0
>   # feat offset    : 0
>   # ========
>   #
> 
> After:
>   $ perf record -o- true | perf report -i- --header-only
>   # ========
>   # captured on    : Thu Dec 10 14:49:11 2020
>   # header version : 1
>   # data offset    : 0
>   # data size      : 0
>   # feat offset    : 0
>   # ========
>   #
>   # hostname : balhae
>   # os release : 5.7.17-1xxx
>   # perf version : 5.10.rc6.gdb0ea13cc741
>   # arch : x86_64
>   # nrcpus online : 8
>   # nrcpus avail : 8
>   # cpudesc : Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz
>   # cpuid : GenuineIntel,6,142,12
>   # total memory : 16158916 kB
>   # cmdline : perf record -o- true
>   # event : name = cycles, , id = { 81, 82, 83, 84, 85, 86, 87, 88 }, size = 120, ...
>   # CPU_TOPOLOGY info available, use -I to display
>   # NUMA_TOPOLOGY info available, use -I to display
>   # pmu mappings: intel_pt = 9, intel_bts = 8, software = 1, power = 20, uprobe = 7, ...
>   # time of first sample : 0.000000
>   # time of last sample : 0.000000
>   # sample duration :      0.000 ms
>   # MEM_TOPOLOGY info available, use -I to display
>   # cpu pmu capabilities: branches=32, max_precise=3, pmu_name=skylake
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-report.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 5efbd0602f17..2a845d6cac09 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -226,6 +226,8 @@ static int process_feature_event(struct perf_session *session,
>  		pr_err("failed: wrong feature ID: %" PRI_lu64 "\n",
>  		       event->feat.feat_id);
>  		return -1;
> +	} else if (rep->header_only) {
> +		session_done = 1;
>  	}
>  
>  	/*
> @@ -1512,6 +1514,13 @@ int cmd_report(int argc, const char **argv)
>  		perf_session__fprintf_info(session, stdout,
>  					   report.show_full_info);
>  		if (report.header_only) {
> +			if (data.is_pipe) {
> +				/*
> +				 * we need to process first few records
> +				 * which contains PERF_RECORD_HEADER_FEATURE.
> +				 */
> +				perf_session__process_events(session);
> +			}
>  			ret = 0;
>  			goto error;
>  		}
> -- 
> 2.29.2.576.ga3fc446d84-goog
> 

