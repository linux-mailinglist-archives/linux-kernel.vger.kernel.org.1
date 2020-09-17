Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501E726E6BA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgIQUX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIQUX4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:23:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F4A5206B7;
        Thu, 17 Sep 2020 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600374236;
        bh=KumwLEhVl5eZtQplN4x5y/BlG7uzLCBuoA5XBySEG3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7+6dRwD6CMRMa2YNTs4ppG6k7PV7mQ5HWYDlABRKleFV6GY4aUA/7t2r+EaMy36W
         SzLxmYrBnuqpVIYJAYzlhx81Et3N600viC0XBxZ5fZoLF79xq2btXXyAQq+L0+9LPp
         1OTUO1EF0D3SuYs4YvyUaCS65jDX8wrT7P71DOWc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 41F81400E9; Thu, 17 Sep 2020 17:23:54 -0300 (-03)
Date:   Thu, 17 Sep 2020 17:23:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 4/7] perf util: Link stream pair
Message-ID: <20200917202354.GE1431236@kernel.org>
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
 <20200911080353.13359-5-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911080353.13359-5-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 11, 2020 at 04:03:50PM +0800, Jin Yao escreveu:
> In previous patch, we have created an evsel_streams for one event,
> and top N hottest streams will be saved in a stream array in
> evsel_streams.
> 
> This patch compares total streams among two evsel_streams.
> 
> Once two streams are fully matched, they will be linked as
> a pair. From the pair, we can know which streams are matched.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  v6:
>    - Rebase to perf/core
> 
>  v5:
>    - Remove enum stream_type
> 
>  v4:
>    - New patch in v4.
> 
>  tools/perf/util/stream.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/stream.h |  4 ++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
> index 7882a7f05d97..e96e21d6e07b 100644
> --- a/tools/perf/util/stream.c
> +++ b/tools/perf/util/stream.c
> @@ -157,3 +157,43 @@ struct evsel_streams *evsel_streams_get(struct evsel_streams *es,
>  
>  	return NULL;
>  }
> +
> +static struct stream *stream_callchain_match(struct stream *base_stream,
> +					     struct evsel_streams *es_pair)

Please use stream__

> +{
> +	for (int i = 0; i < es_pair->nr_streams; i++) {
> +		struct stream *pair_stream = &es_pair->streams[i];
> +
> +		if (callchain_cnode_matched(base_stream->cnode,
> +					    pair_stream->cnode)) {
> +			return pair_stream;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct stream *stream_match(struct stream *base_stream,
> +				   struct evsel_streams *es_pair)
> +{
> +	return stream_callchain_match(base_stream, es_pair);
> +}
> +
> +static void stream_link(struct stream *base_stream, struct stream *pair_stream)
> +{
> +	base_stream->pair_cnode = pair_stream->cnode;
> +	pair_stream->pair_cnode = base_stream->cnode;
> +}
> +
> +void match_evsel_streams(struct evsel_streams *es_base,
> +			 struct evsel_streams *es_pair)
> +{
> +	for (int i = 0; i < es_base->nr_streams; i++) {
> +		struct stream *base_stream = &es_base->streams[i];
> +		struct stream *pair_stream;
> +
> +		pair_stream = stream_match(base_stream, es_pair);
> +		if (pair_stream)
> +			stream_link(base_stream, pair_stream);
> +	}
> +}
> diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
> index 66f61d954eef..2eb6f17a834e 100644
> --- a/tools/perf/util/stream.h
> +++ b/tools/perf/util/stream.h
> @@ -6,6 +6,7 @@
>  
>  struct stream {
>  	struct callchain_node	*cnode;
> +	struct callchain_node	*pair_cnode;
>  };
>  
>  struct evsel_streams {
> @@ -23,4 +24,7 @@ struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
>  struct evsel_streams *evsel_streams_get(struct evsel_streams *es,
>  					int nr_evsel, int evsel_idx);
>  
> +void match_evsel_streams(struct evsel_streams *es_base,
> +			 struct evsel_streams *es_pair);
> +
>  #endif /* __PERF_STREAM_H */
> -- 
> 2.17.1
> 

-- 

- Arnaldo
