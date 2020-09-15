Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B1326A4AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgIOMHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgIOL7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:59:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5464D21D7B;
        Tue, 15 Sep 2020 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600171143;
        bh=bAHStdZBUJVfsBb4E6LEysvo2W312lbCuwZ1ty8lOt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwyNj5xAquE0d3gT5R2SIDq6kdvMTJfCCFJm4XzVUZuJXI3lSMcdf1I107cM0/RdN
         COsuFiSV69/7VjrWySrUJfxAtGVvlLBpXdHcXkJMXuhoc83QRwUXCt3ZVTzmByIySl
         0+77wR/ptVpWV24e00WAu5kOIICKFMny9pBlLJbs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7318940D3D; Tue, 15 Sep 2020 08:59:01 -0300 (-03)
Date:   Tue, 15 Sep 2020 08:59:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 02/11] perf metric: Fix some memory leaks - part 2
Message-ID: <20200915115901.GD720847@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
 <20200915031819.386559-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915031819.386559-3-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 15, 2020 at 12:18:10PM +0900, Namhyung Kim escreveu:
> The metric_event_delete() missed to free expr->metric_events and it
> should free an expr when metric_refs allocation failed.
 

Thanks, applied.

- Arnaldo

> Cc: Kajol Jain <kjain@linux.ibm.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Ian Rogers <irogers@google.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Fixes: 4ea2896715e67 ("perf metric: Collect referenced metrics in struct metric_expr")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/metricgroup.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 90d14c63babb..53747df601fa 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -84,6 +84,7 @@ static void metric_event_delete(struct rblist *rblist __maybe_unused,
>  
>  	list_for_each_entry_safe(expr, tmp, &me->head, nd) {
>  		free(expr->metric_refs);
> +		free(expr->metric_events);
>  		free(expr);
>  	}
>  
> @@ -315,6 +316,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>  			if (!metric_refs) {
>  				ret = -ENOMEM;
>  				free(metric_events);
> +				free(expr);
>  				break;
>  			}
>  
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

-- 

- Arnaldo
