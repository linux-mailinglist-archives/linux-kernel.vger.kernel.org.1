Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43A02B27F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgKMWQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:16:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKMWQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605305771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RU/SSy/zKQ6WuVt0KMSkbVTJl5tSXBXiAe6IqFkcJeg=;
        b=EMqGkpH3Vt/07VPADfh5wudyH4z8bUFTy/d2XSI7nkTy4zrpO52WIu+CBKmHc9pG2XPyf8
        eqWZAVTFFW///7J46HsUqtb7tuL2hZ72EClxCLZpc7G+KxkLweBLCM39C+Z0vaf2CiJLtS
        5yXat7UKvBJk7xYNjkZhMahcBfcKbSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-mqBnpqnRNyagKiVGVM6Uuw-1; Fri, 13 Nov 2020 17:16:07 -0500
X-MC-Unique: mqBnpqnRNyagKiVGVM6Uuw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81BEA188C122;
        Fri, 13 Nov 2020 22:16:05 +0000 (UTC)
Received: from krava (unknown [10.40.195.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id C2A8627BA9;
        Fri, 13 Nov 2020 22:16:02 +0000 (UTC)
Date:   Fri, 13 Nov 2020 23:16:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, Sam Xi <xyzsam@google.com>
Subject: Re: [PATCH] perf stat: Use proper cpu for shadow stats
Message-ID: <20201113221601.GE842058@krava>
References: <20201113050236.175141-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113050236.175141-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 02:02:36PM +0900, Namhyung Kim wrote:
> Currently perf stat shows some metrics (like IPC) for defined events.
> But when no aggregation mode is used (-A option), it shows incorrect
> values since it used a value from a different cpu.
> 
> Before:
> 
>   $ perf stat -aA -e cycles,instructions sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>   CPU0      116,057,380      cycles
>   CPU1       86,084,722      cycles
>   CPU2       99,423,125      cycles
>   CPU3       98,272,994      cycles
>   CPU0       53,369,217      instructions      #    0.46  insn per cycle
>   CPU1       33,378,058      instructions      #    0.29  insn per cycle
>   CPU2       58,150,086      instructions      #    0.50  insn per cycle
>   CPU3       40,029,703      instructions      #    0.34  insn per cycle
> 
>        1.001816971 seconds time elapsed
> 
> So the IPC for CPU1 should be 0.38 (= 33,378,058 / 86,084,722)
> but it was 0.29 (= 33,378,058 / 116,057,380) and so on.
> 
> After:
> 
>   $ perf stat -aA -e cycles,instructions sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>   CPU0      109,621,384      cycles
>   CPU1      159,026,454      cycles
>   CPU2       99,460,366      cycles
>   CPU3      124,144,142      cycles
>   CPU0       44,396,706      instructions      #    0.41  insn per cycle
>   CPU1      120,195,425      instructions      #    0.76  insn per cycle
>   CPU2       44,763,978      instructions      #    0.45  insn per cycle
>   CPU3       69,049,079      instructions      #    0.56  insn per cycle
> 
>        1.001910444 seconds time elapsed
> 
> Reported-by: Sam Xi <xyzsam@google.com>
> Fixes: 44d49a600259 ("perf stat: Support metrics in --per-core/socket mode")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

nice catch! would be great to have test for this

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/stat-display.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 4b57c0c07632..a963b5b8eb72 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -324,13 +324,10 @@ static int first_shadow_cpu(struct perf_stat_config *config,
>  	struct evlist *evlist = evsel->evlist;
>  	int i;
>  
> -	if (!config->aggr_get_id)
> -		return 0;
> -
>  	if (config->aggr_mode == AGGR_NONE)
>  		return id;
>  
> -	if (config->aggr_mode == AGGR_GLOBAL)
> +	if (!config->aggr_get_id)
>  		return 0;
>  
>  	for (i = 0; i < evsel__nr_cpus(evsel); i++) {
> -- 
> 2.29.2.299.gdc1121823c-goog
> 

