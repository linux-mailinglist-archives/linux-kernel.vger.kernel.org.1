Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116A026E6A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgIQUXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgIQUXF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:23:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 713EA206B7;
        Thu, 17 Sep 2020 20:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600374184;
        bh=SnKbMZNoOAr40OyOw3njr0gVg42lGZNE5Fqawp0V5xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7WUeSj/CBda1qkU4ToHIEHN7jlosXCYzpZURrnRGvidlt/reArlG1NZ6gqxqo7df
         1P7vcrBfBJbxv9Id8y+GTQw+VZoGtdnUMZp/Jyzjd6cjv3fei5/rUoOM4bqhyHlF0d
         DBKIjHOMr8wLJSxByocjjbdUVNogdkZ0P1FndSjY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 922A6400E9; Thu, 17 Sep 2020 17:23:02 -0300 (-03)
Date:   Thu, 17 Sep 2020 17:23:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 2/7] perf util: Get the evsel_streams by evsel_idx
Message-ID: <20200917202302.GD1431236@kernel.org>
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
 <20200911080353.13359-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911080353.13359-3-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 11, 2020 at 04:03:48PM +0800, Jin Yao escreveu:
> In previous patch, we have created evsel_streams array
> 
> This patch returns the specified evsel_streams according to the
> evsel_idx.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  v6:
>    - Rebase to perf/core
> 
>  v5:
>    - Rebase to perf/core
> 
>  v4:
>    - Rename the patch from 'perf util: Return per-event callchain
>      streams' to 'perf util: Get the evsel_streams by evsel_idx'
> 
>  tools/perf/util/stream.c | 11 +++++++++++
>  tools/perf/util/stream.h |  3 +++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
> index 015c1d07ce3a..7882a7f05d97 100644
> --- a/tools/perf/util/stream.c
> +++ b/tools/perf/util/stream.c
> @@ -146,3 +146,14 @@ struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
>  
>  	return es;
>  }
> +
> +struct evsel_streams *evsel_streams_get(struct evsel_streams *es,
> +					int nr_evsel, int evsel_idx)

  foo__get() is the idiom for refcount_t method to bump the refcount for
  'struct foo', so please rename it to:

  struct evsel_streams__entry(struct evsel_streams *es, int nr_evsel, int evsel_idx)

Also please consider having the array and the number of entries in
'struct evsel_streams', so that you don't have to always pass the
number of entries around.

> +{
> +	for (int i = 0; i < nr_evsel; i++) {
> +		if (es[i].evsel_idx == evsel_idx)
> +			return &es[i];
> +	}
> +
> +	return NULL;
> +}
> diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
> index c6844c5787cb..66f61d954eef 100644
> --- a/tools/perf/util/stream.h
> +++ b/tools/perf/util/stream.h
> @@ -20,4 +20,7 @@ struct evlist;
>  struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
>  						  int nr_streams_max);
>  
> +struct evsel_streams *evsel_streams_get(struct evsel_streams *es,
> +					int nr_evsel, int evsel_idx);
> +
>  #endif /* __PERF_STREAM_H */
> -- 
> 2.17.1
> 

-- 

- Arnaldo
