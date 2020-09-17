Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D442F26DC8B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgIQNMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:12:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26463 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726954AbgIQNLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:11:46 -0400
X-Greylist: delayed 18274 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 09:11:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600348285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y13kNQSQkyoMEtpuNiNgNOwEuejpbNAmamQDJ5HhCP8=;
        b=F/Jx39+YdlEcpmG6Yr6cQ3MURM34ynI5hYQqCNlc7qJBmMbDDo/lc9IlNYtnKbY+oRT3YJ
        34yClRpbsqhIMldRNqKj4zboUIhsClltLoFzITR3HIPCN6RrGphLMxDXTiSWoNICfw0DG8
        ob7AVgNVePamX9Lt6IcbTBXUgqgr1eQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-btNsDDkCOg6OTVKPMy6r0g-1; Thu, 17 Sep 2020 09:11:21 -0400
X-MC-Unique: btNsDDkCOg6OTVKPMy6r0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EA988DE782;
        Thu, 17 Sep 2020 13:11:02 +0000 (UTC)
Received: from krava (ovpn-113-64.ams2.redhat.com [10.36.113.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id C541C1A268;
        Thu, 17 Sep 2020 13:10:59 +0000 (UTC)
Date:   Thu, 17 Sep 2020 15:10:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 1/2] perf parse-event: Release cpu_map if evsel alloc
 failed
Message-ID: <20200917131058.GA2514666@krava>
References: <20200917060219.1287863-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917060219.1287863-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:02:18PM +0900, Namhyung Kim wrote:
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/parse-events.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 667cbca1547a..176a51698a64 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -360,8 +360,10 @@ __add_event(struct list_head *list, int *idx,
>  		event_attr_init(attr);
>  
>  	evsel = evsel__new_idx(attr, *idx);
> -	if (!evsel)
> +	if (!evsel) {
> +		perf_cpu_map__put(cpus);

if there's pmu defined, we don't we get on perf_cpu_map:

        struct perf_cpu_map *cpus = pmu ? pmu->cpus :
                               cpu_list ? perf_cpu_map__new(cpu_list) : NULL;

jirka

>  		return NULL;
> +	}
>  
>  	(*idx)++;
>  	evsel->core.cpus   = perf_cpu_map__get(cpus);
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

