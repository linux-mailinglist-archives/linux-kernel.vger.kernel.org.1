Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C081B5A80
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 13:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgDWL3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 07:29:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22375 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728092AbgDWL3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587641345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XOEN4B8Ie5LAo/htQJnbUAJ1Wor8L10utCvM/1xZYOo=;
        b=BdO5fIxr7KwI+PaZLYR8+QGTJpINuDqfzjqQ9qS4hCQsi45Tq2dNGNOphiQFfD1YUgpx7C
        qOXtz3AA6Er7TSLDktoJE4S0k+Ybigo3MvEVO0MM6666rrD93EdTlVjjJNrIf/oPEjktax
        CMcSkZR9o0d8S4tPsIByRRL6hTdSilo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-qFaKQ_PxNBK3oVWI3I29rA-1; Thu, 23 Apr 2020 07:29:03 -0400
X-MC-Unique: qFaKQ_PxNBK3oVWI3I29rA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86B00107BEF8;
        Thu, 23 Apr 2020 11:29:00 +0000 (UTC)
Received: from krava (unknown [10.40.196.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B2745F7CB;
        Thu, 23 Apr 2020 11:28:50 +0000 (UTC)
Date:   Thu, 23 Apr 2020 13:28:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 11/11] perf test: add expr test for pmu metrics
Message-ID: <20200423112847.GF1136647@krava>
References: <20200422220430.254014-1-irogers@google.com>
 <20200422220430.254014-12-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422220430.254014-12-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:04:30PM -0700, Ian Rogers wrote:

SNIP

> +
> +static int pmu_tests(void)
> +{
> +	struct pmu_events_map *map;
> +	struct pmu_event *pe;
> +	int i, j, k;
> +	const char **ids;
> +	int idnum;
> +	int ret = 0;
> +	struct expr_parse_ctx ctx;
> +	double result;
> +
> +	i = 0;
> +	for (;;) {
> +		map = &pmu_events_map[i++];
> +		if (!map->table) {
> +			map = NULL;
> +			break;
> +		}
> +		j = 0;
> +		for (;;) {
> +			pe = &map->table[j++];
> +			if (!pe->name && !pe->metric_group && !pe->metric_name)
> +				break;
> +			if (!pe->metric_expr)
> +				continue;

so we go throught all the metrics for the current cpu
and test the parsing on them.. great!

thanks,
jirka

