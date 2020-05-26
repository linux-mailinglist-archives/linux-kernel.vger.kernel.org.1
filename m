Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646B719C2DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 15:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbgDBNlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 09:41:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37654 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388745AbgDBNlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585834875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hhEMRSGYDYFQ/KgBZ70DNva1ydxEodVvyfwI5v0wh74=;
        b=AP2vLKhnCgFvpUp7a0fChY8TBZhIYuSm0xihw2CbaTt+m9Z72jE3lQE74yF55mf1Oiz4yQ
        NRwU1a+3SIUMEykRTvQTj6xPJUJCZMMtQ+Tl9XGyd5kiG9VRKN1QeCKIWzdaeVAmza9I75
        YlHsQymx2zylhgRw+rqRYlBCJFc9gwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-fec4BehDO5aq4VcSnogc6g-1; Thu, 02 Apr 2020 09:41:11 -0400
X-MC-Unique: fec4BehDO5aq4VcSnogc6g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0C8FDB66;
        Thu,  2 Apr 2020 13:41:08 +0000 (UTC)
Received: from krava (unknown [10.40.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA4F81001B09;
        Thu,  2 Apr 2020 13:41:05 +0000 (UTC)
Date:   Thu, 2 Apr 2020 15:41:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 5/5] perf synthetic events: Remove use of sscanf from
 /proc reading
Message-ID: <20200402134103.GJ2518490@krava>
References: <20200401233945.133550-1-irogers@google.com>
 <20200401233945.133550-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401233945.133550-6-irogers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:39:45PM -0700, Ian Rogers wrote:

SNIP

> @@ -279,9 +353,9 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  				       struct machine *machine,
>  				       bool mmap_data)
>  {
> -	FILE *fp;
>  	unsigned long long t;
>  	char bf[BUFSIZ];
> +	struct io io;
>  	bool truncation = false;
>  	unsigned long long timeout = proc_map_timeout * 1000000ULL;
>  	int rc = 0;
> @@ -294,28 +368,39 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  	snprintf(bf, sizeof(bf), "%s/proc/%d/task/%d/maps",
>  		machine->root_dir, pid, pid);
>  
> -	fp = fopen(bf, "r");
> -	if (fp == NULL) {
> +	io.fd = open(bf, O_RDONLY, 0);
> +	if (io.fd < 0) {
>  		/*
>  		 * We raced with a task exiting - just return:
>  		 */
>  		pr_debug("couldn't open %s\n", bf);
>  		return -1;
>  	}
> +	init_io(&io, io.fd, bf, sizeof(bf));
>  
>  	event->header.type = PERF_RECORD_MMAP2;
>  	t = rdclock();
>  
> -	while (1) {
> -		char prot[5];
> -		char execname[PATH_MAX];
> -		char anonstr[] = "//anon";
> -		unsigned int ino;
> +	while (!io.eof) {
> +		static const char anonstr[] = "//anon";
>  		size_t size;
> -		ssize_t n;
>  
> -		if (fgets(bf, sizeof(bf), fp) == NULL)
> -			break;
> +		/* ensure null termination since stack will be reused. */
> +		strcpy(event->mmap2.filename, "");

could you just do 'event->mmap2.filename[0] = 0x0' instad ?

jirka

> +
> +		/* 00400000-0040c000 r-xp 00000000 fd:01 41038  /bin/cat */
> +		if (!read_proc_maps_line(&io,
> +					&event->mmap2.start,
> +					&event->mmap2.len,
> +					&event->mmap2.prot,
> +					&event->mmap2.flags,
> +					&event->mmap2.pgoff,
> +					&event->mmap2.maj,
> +					&event->mmap2.min,
> +					&event->mmap2.ino,
> +					sizeof(event->mmap2.filename),
> +					event->mmap2.filename))
> +			continue;
>  

SNIP

