Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE9A293493
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 08:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391911AbgJTGGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 02:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730596AbgJTGGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603173997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MyUCx3lGcn+//ZMO1Cv2esu6vXCXBYtgBEkJ4GQi6cY=;
        b=g1yCIPM6c39jTTFDawxajm+0JLdj4L3nA6jd4eq78YLjMLQPjG4E0i6v7XhOtOoFmGQmml
        YoaueBRF89fmivyWIqI+7DjhxW+6rSUP4RIYCmfZf9JLJSjkPaPuH1+LXdyu79pvbKQ5IG
        akttqxALm8etcnHAZsdUe5EuW6QRGJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-t9oc-lq3MlSixffOh4mCzg-1; Tue, 20 Oct 2020 02:06:32 -0400
X-MC-Unique: t9oc-lq3MlSixffOh4mCzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 359B959;
        Tue, 20 Oct 2020 06:06:31 +0000 (UTC)
Received: from krava (unknown [10.40.192.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id A43BA5C1A3;
        Tue, 20 Oct 2020 06:06:28 +0000 (UTC)
Date:   Tue, 20 Oct 2020 08:06:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf mem2node: Improve warning if detected no memory
 nodes
Message-ID: <20201020060627.GA2084117@krava>
References: <20201019003613.8399-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019003613.8399-1-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 08:36:13AM +0800, Leo Yan wrote:
> Some archs (e.g. x86 and Arm64) don't enable the configuration
> CONFIG_MEMORY_HOTPLUG by default, if this configuration is not enabled
> when build the kernel image, the SysFS for memory nodes will be missed.
> This results in perf tool has no chance to catpure the memory nodes
> information, when perf tool reports the result and detects no memory
> nodes, it outputs "assertion failed at util/mem2node.c:99".
> 
> The output log doesn't give out reason for the failure and users have no
> clue for how to fix it.  This patch changes to use explicit way for
> warning: it tells user that detected no memory nodes and suggests to
> enable CONFIG_MEMORY_HOTPLUG for kernel building.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/mem2node.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
> index c84f5841c7ab..03a7d7b27737 100644
> --- a/tools/perf/util/mem2node.c
> +++ b/tools/perf/util/mem2node.c
> @@ -96,7 +96,8 @@ int mem2node__init(struct mem2node *map, struct perf_env *env)
>  
>  	/* Cut unused entries, due to merging. */
>  	tmp_entries = realloc(entries, sizeof(*entries) * j);
> -	if (tmp_entries || WARN_ON_ONCE(j == 0))
> +	if (tmp_entries ||
> +	    WARN_ONCE(j == 0, "No memory nodes, is CONFIG_MEMORY_HOTPLUG enabled?\n"))
>  		entries = tmp_entries;
>  
>  	for (i = 0; i < j; i++) {
> -- 
> 2.17.1
> 

