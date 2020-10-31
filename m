Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDBF2A1A85
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 21:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgJaUXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 16:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728451AbgJaUXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 16:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604175798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=exFMJNCEzwLpkQpIkJYv5pthPpdPLPk5MlNf/nMD4Bc=;
        b=WUZSNBZ+r2O/pw6FJ23Y/LPGnVAAAZ19oQ/TXRvZnP3DI0eA0taZjlqgwswkeMwXEFTXAy
        G813Z+epmqRrLYmMw+zqawYeq/vcHrY54CANEZs2LYMw1l8qFvGnq+JtW1QxGSCNOX5HRk
        hDlkeoQ+HB26XYoDJr5GUtKDV1PH1uM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-eG4xOfmxOPSWtsUkAnLddg-1; Sat, 31 Oct 2020 16:23:14 -0400
X-MC-Unique: eG4xOfmxOPSWtsUkAnLddg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9DD8107B472;
        Sat, 31 Oct 2020 20:23:11 +0000 (UTC)
Received: from krava (unknown [10.40.192.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1912F5C26A;
        Sat, 31 Oct 2020 20:23:07 +0000 (UTC)
Date:   Sat, 31 Oct 2020 21:23:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/9] perf mem: Support new memory event
 PERF_MEM_EVENTS__LOAD_STORE
Message-ID: <20201031202307.GB3380099@krava>
References: <20201028063813.8562-1-leo.yan@linaro.org>
 <20201028063813.8562-4-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028063813.8562-4-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:38:07PM +0800, Leo Yan wrote:

SNIP

>  		struct stat st;
>  
> +		/*
> +		 * If the event entry isn't valid, skip initialization
> +		 * and "e->supported" will keep false.
> +		 */
> +		if (!e->tag)
> +			continue;
> +
>  		scnprintf(path, PATH_MAX, "%s/devices/%s",
>  			  mnt, e->sysfs_name);
>  
> @@ -123,7 +134,7 @@ void perf_mem_events__list(void)
>  		struct perf_mem_event *e = perf_mem_events__ptr(j);
>  
>  		fprintf(stderr, "%-13s%-*s%s\n",
> -			e->tag,
> +			e->tag ? e->tag : "",

nit, could be:          e->tag ?: "",

jirka

>  			verbose > 0 ? 25 : 0,
>  			verbose > 0 ? perf_mem_events__name(j) : "",
>  			e->supported ? ": available" : "");
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index 726a9c8103e4..5ef178278909 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -28,6 +28,7 @@ struct mem_info {
>  enum {
>  	PERF_MEM_EVENTS__LOAD,
>  	PERF_MEM_EVENTS__STORE,
> +	PERF_MEM_EVENTS__LOAD_STORE,
>  	PERF_MEM_EVENTS__MAX,
>  };
>  
> -- 
> 2.17.1
> 

