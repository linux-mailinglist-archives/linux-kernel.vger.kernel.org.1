Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18182C68E7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbgK0PqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:46:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726889AbgK0PqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606491966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jw6xSHB1ku4HkbQvC54VFrU10m1ClQBvKVEt/dMltsQ=;
        b=BbmlpUsA4w0ViEqlPK9Klke0dCuN0TYLv3T7NtraJiFum7NKzqD1tNyiwQpgFepWOvIG10
        UCTliuRoafGs4NuVZLVDe9C9jezovp1V0zwbFLojQAv95IGK8h0OTKDPkebkgWmjHWv2HR
        pxfr1nwVaT4zpey8jvg0PSdpmdDcXGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-wTIz-jiXNNSm7kPqLiVseQ-1; Fri, 27 Nov 2020 10:46:02 -0500
X-MC-Unique: wTIz-jiXNNSm7kPqLiVseQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A6D91074650;
        Fri, 27 Nov 2020 15:46:00 +0000 (UTC)
Received: from krava (unknown [10.40.194.2])
        by smtp.corp.redhat.com (Postfix) with SMTP id 551C31001B2C;
        Fri, 27 Nov 2020 15:45:58 +0000 (UTC)
Date:   Fri, 27 Nov 2020 16:45:57 +0100
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
Subject: Re: [PATCH] perf record: Synthesize cgroup events only if needed
Message-ID: <20201127154557.GB2729821@krava>
References: <20201127054356.405481-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127054356.405481-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 02:43:56PM +0900, Namhyung Kim wrote:
> It didn't check the tool->cgroup_events bit which is set when
> the --all-cgroups option is given.  Without it, samples will not have
> cgroup info so no reason to synthesize.
> 
> We can check the PERF_RECORD_CGROUP records after running perf record
> *WITHOUT* the --all-cgroups option:
> 
> Before:
>   $ perf report -D | grep CGROUP
>   0 0 0x8430 [0x38]: PERF_RECORD_CGROUP cgroup: 1 /
>           CGROUP events:          1
>           CGROUP events:          0
>           CGROUP events:          0
> 
> After:
>   $ perf report -D | grep CGROUP
>           CGROUP events:          0
>           CGROUP events:          0
>           CGROUP events:          0
> 
> Fixes: 8fb4b67939e16 ("perf record: Add --all-cgroups option")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/synthetic-events.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 8a23391558cf..d9c624377da7 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -563,6 +563,9 @@ int perf_event__synthesize_cgroups(struct perf_tool *tool,
>  	char cgrp_root[PATH_MAX];
>  	size_t mount_len;  /* length of mount point in the path */
>  
> +	if (!tool || !tool->cgroup_events)
> +		return 0;

can !tool actually happen here? or it's just being extra cautious

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> +
>  	if (cgroupfs_find_mountpoint(cgrp_root, PATH_MAX, "perf_event") < 0) {
>  		pr_debug("cannot find cgroup mount point\n");
>  		return -1;
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 

