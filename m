Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DE62F764E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbhAOKK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:10:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbhAOKKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610705336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvY1XticEr4lohhJjafmxjamY8OXYrJlY0cIwbxcnjk=;
        b=MzSp6g35LqCYNq/TftbGXRB9cnrzV6Ys7Y13wpQQJZb1JiapFnEKGmnTNhB6F+pWE1buHZ
        vZCmE5RiLbxWiXwpAR13uGaF+z9HunlaXhbltiG77O/3wSqKUMgW4VXfIVf0p4F0Kf+Ppi
        BktGxnFwCggW0ZlAOyUaKjBpcnxPZSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-3Jm4x-5gNJ6Rzq-WJftV3g-1; Fri, 15 Jan 2021 05:08:52 -0500
X-MC-Unique: 3Jm4x-5gNJ6Rzq-WJftV3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 777011006C81;
        Fri, 15 Jan 2021 10:08:50 +0000 (UTC)
Received: from krava (unknown [10.40.194.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8B8CC10013C1;
        Fri, 15 Jan 2021 10:08:47 +0000 (UTC)
Date:   Fri, 15 Jan 2021 11:08:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Subject: Re: [PATCH v7 1/5] perf metric: Restructure struct expr_parse_ctx.
Message-ID: <20210115100846.GC1478666@krava>
References: <20210112230434.2631593-1-irogers@google.com>
 <20210112230434.2631593-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112230434.2631593-2-irogers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 03:04:30PM -0800, Ian Rogers wrote:

SNIP

> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index 0ca6a5a53523..cf5afd126934 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -478,9 +478,14 @@ static int test_parsing(void)
>  	struct pmu_event *pe;
>  	int i, j, k;
>  	int ret = 0;
> -	struct expr_parse_ctx ctx;
> +	struct expr_parse_ctx *ctx;
>  	double result;
>  
> +	ctx = expr__ctx_new();
> +	if (!ctx) {
> +		pr_debug("expr__ctx_new failed");
> +		return TEST_FAIL;
> +	}
>  	i = 0;
>  	for (;;) {
>  		map = &pmu_events_map[i++];
> @@ -496,8 +501,8 @@ static int test_parsing(void)
>  				break;
>  			if (!pe->metric_expr)
>  				continue;
> -			expr__ctx_init(&ctx);
> -			if (expr__find_other(pe->metric_expr, NULL, &ctx, 0)
> +			expr__ctx_clear(ctx);

why move the clear from bottom in here?


SNIP

>  
> -void expr__ctx_init(struct expr_parse_ctx *ctx)
> +struct expr_parse_ctx *expr__ctx_new(void)
>  {
> -	hashmap__init(&ctx->ids, key_hash, key_equal, NULL);
> +	struct expr_parse_ctx *ctx;
> +
> +	ctx = malloc(sizeof(struct expr_parse_ctx));
> +	if (!ctx)
> +		return NULL;
> +
> +	ctx->ids = hashmap__new(key_hash, key_equal, NULL);

we should check for allocation failuer

jirka

> +	ctx->parent = NULL;
> +	return ctx;
>  }
>  
>  void expr__ctx_clear(struct expr_parse_ctx *ctx)
> @@ -221,11 +229,24 @@ void expr__ctx_clear(struct expr_parse_ctx *ctx)
>  	struct hashmap_entry *cur;
>  	size_t bkt;
>  
> -	hashmap__for_each_entry((&ctx->ids), cur, bkt) {
> +	hashmap__for_each_entry(ctx->ids, cur, bkt) {
> +		free((char *)cur->key);
> +		free(cur->value);

SNIP

