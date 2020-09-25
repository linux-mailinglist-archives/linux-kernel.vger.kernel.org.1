Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC362788F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgIYNBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728406AbgIYNBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:01:14 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601038873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pmK3dOa/4I5VffapQp2jgBD5KTgzscwxckDLa4qNJis=;
        b=PeAh9Y6T0f0W6g12KZygSKCSi29V0nA3ReZswZJJkTT3p6P6M4Qn+jqMqFFkfTTGSK/h9W
        tnYPKpFNjMz7oUk+ZsTObhNVZLT8SHcNIkSEryf9nlEKxz8o279h6YWVoJwakt9x+y7kLK
        LN0YFDIAfuHOkJ+Zww3/BXVT7piNyS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-4GDv-sN-OWuZOSQNDJwnOg-1; Fri, 25 Sep 2020 09:01:09 -0400
X-MC-Unique: 4GDv-sN-OWuZOSQNDJwnOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DC7018BE162;
        Fri, 25 Sep 2020 13:01:08 +0000 (UTC)
Received: from krava (unknown [10.40.192.203])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9EF515C1DC;
        Fri, 25 Sep 2020 13:01:04 +0000 (UTC)
Date:   Fri, 25 Sep 2020 15:01:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf parse-events: Reduce casts around bp_addr
Message-ID: <20200925130103.GA3273770@krava>
References: <20200925003903.561568-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925003903.561568-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 05:39:03PM -0700, Ian Rogers wrote:
> perf_event_attr bp_addr is a u64. parse-events.y parses it as a u64, but
> casts it to a void* and then parse-events.c casts it back to a u64.
> Rather than all the casts, change the type of the address to be a u64.
> This removes an issue noted in:
> https://lore.kernel.org/lkml/20200903184359.GC3495158@kernel.org/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/parse-events.c | 4 ++--
>  tools/perf/util/parse-events.h | 2 +-
>  tools/perf/util/parse-events.y | 8 ++++----
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 667cbca1547a..f82ef1e840b2 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -940,12 +940,12 @@ do {					\
>  }
>  
>  int parse_events_add_breakpoint(struct list_head *list, int *idx,
> -				void *ptr, char *type, u64 len)
> +				u64 addr, char *type, u64 len)
>  {
>  	struct perf_event_attr attr;
>  
>  	memset(&attr, 0, sizeof(attr));
> -	attr.bp_addr = (unsigned long) ptr;
> +	attr.bp_addr = addr;
>  
>  	if (parse_breakpoint_type(type, &attr))
>  		return -EINVAL;
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 00cde7d2e30c..e80c9b74f2f2 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -190,7 +190,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>  			   struct parse_events_error *error,
>  			   struct list_head *head_config);
>  int parse_events_add_breakpoint(struct list_head *list, int *idx,
> -				void *ptr, char *type, u64 len);
> +				u64 addr, char *type, u64 len);
>  int parse_events_add_pmu(struct parse_events_state *parse_state,
>  			 struct list_head *list, char *name,
>  			 struct list_head *head_config,
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 645bf4f1859f..d5b6aff82f21 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -511,7 +511,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
>  	list = alloc_list();
>  	ABORT_ON(!list);
>  	err = parse_events_add_breakpoint(list, &parse_state->idx,
> -					(void *)(uintptr_t) $2, $6, $4);
> +					  $2, $6, $4);
>  	free($6);
>  	if (err) {
>  		free(list);
> @@ -528,7 +528,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
>  	list = alloc_list();
>  	ABORT_ON(!list);
>  	if (parse_events_add_breakpoint(list, &parse_state->idx,
> -						(void *)(uintptr_t) $2, NULL, $4)) {
> +					$2, NULL, $4)) {
>  		free(list);
>  		YYABORT;
>  	}
> @@ -544,7 +544,7 @@ PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
>  	list = alloc_list();
>  	ABORT_ON(!list);
>  	err = parse_events_add_breakpoint(list, &parse_state->idx,
> -					(void *)(uintptr_t) $2, $4, 0);
> +					  $2, $4, 0);
>  	free($4);
>  	if (err) {
>  		free(list);
> @@ -561,7 +561,7 @@ PE_PREFIX_MEM PE_VALUE sep_dc
>  	list = alloc_list();
>  	ABORT_ON(!list);
>  	if (parse_events_add_breakpoint(list, &parse_state->idx,
> -						(void *)(uintptr_t) $2, NULL, 0)) {
> +					$2, NULL, 0)) {
>  		free(list);
>  		YYABORT;
>  	}
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 

