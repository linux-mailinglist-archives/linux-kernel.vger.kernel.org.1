Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5992B3971
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 22:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgKOVRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 16:17:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727982AbgKOVRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 16:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605475061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dcxEgisiyuBAGEbUp7jGJ0krwIO5Jsu6BrWaL3RZuEg=;
        b=dFmcMFFin0OxpXCPfvXBhTzUS7byxJscRP22lG0hBDVCja4rL3DoBLNxO0QGmVQxtUOx7N
        EEwXA/e6SIMNMrasNzLKgYnJhb09clvMiYVL1eB0kv+5GRlzY1uVi9MD0+XrM7s2cz6sCH
        94ulFI9VM1id6BDX9sMqoOhqueCe0Xk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-taCK5goON6uQMCGxRCvV7w-1; Sun, 15 Nov 2020 16:17:37 -0500
X-MC-Unique: taCK5goON6uQMCGxRCvV7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9FD4100747C;
        Sun, 15 Nov 2020 21:17:35 +0000 (UTC)
Received: from krava (unknown [10.40.192.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9B33F1002C07;
        Sun, 15 Nov 2020 21:17:33 +0000 (UTC)
Date:   Sun, 15 Nov 2020 22:17:32 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 02/13 v4] perf tools: Use allocator for perf_cpu_map
Message-ID: <20201115211732.GB1081385@krava>
References: <20201113172654.989-1-james.clark@arm.com>
 <20201113172654.989-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113172654.989-3-james.clark@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 07:26:43PM +0200, James Clark wrote:
> Use the existing allocator for perf_cpu_map to avoid use
> of raw malloc. This could cause an issue in later commits
> where the size of perf_cpu_map is changed.
> 
> No functional changes.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/util/cpumap.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index dc5c5e6fc502..fd7d0a77a9e6 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -132,15 +132,16 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
>  		       int (*f)(struct perf_cpu_map *map, int cpu, void *data),
>  		       void *data)
>  {
> -	struct perf_cpu_map *c;
>  	int nr = cpus->nr;
> +	struct perf_cpu_map *c = perf_cpu_map__empty_new(nr);
>  	int cpu, s1, s2;
>  
> -	/* allocate as much as possible */
> -	c = calloc(1, sizeof(*c) + nr * sizeof(int));
>  	if (!c)
>  		return -1;
>  
> +	/* Reset size as it may only be partially filled */
> +	c->nr = 0;
> +
>  	for (cpu = 0; cpu < nr; cpu++) {
>  		s1 = f(cpus, cpu, data);
>  		for (s2 = 0; s2 < c->nr; s2++) {

also remove refcount_set call down here,
it's already in set in perf_cpu_map__empty_new

thanks,
jirka

> -- 
> 2.28.0
> 

