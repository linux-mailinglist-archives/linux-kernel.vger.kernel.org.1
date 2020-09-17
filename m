Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204B826E6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgIQUVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIQUVD (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:21:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB395206B7;
        Thu, 17 Sep 2020 20:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600374062;
        bh=jX532LNZ1qKT2Z9Xb5HDR0anwSZcTgZtK3cxKMwDatE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QWaEkP2BM8NsHQhswmKGBvOfMDvnijB4A5pNN+QkkOLvkxclUxVcpTslYrejNUfu7
         M73qJ0Ma+Rzb+qJbeJtaycMPX3OLV64TcA7DE8gnnV6wuUxtq1qm3HNJnUM/hHT4HS
         cuoBxjiPgSzfcTISb9xRwiZUug9TmxD4x4xz26Tg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0C8B3400E9; Thu, 17 Sep 2020 17:21:00 -0300 (-03)
Date:   Thu, 17 Sep 2020 17:20:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 1/7] perf util: Create streams
Message-ID: <20200917202059.GC1431236@kernel.org>
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
 <20200911080353.13359-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911080353.13359-2-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 11, 2020 at 04:03:47PM +0800, Jin Yao escreveu:
> We define the stream is the branch history which is aggregated by
> the branch records from perf samples. For example, the callchains
> aggregated from the branch records are considered as streams.
> By browsing the hot stream, we can understand the hot code path.
> 
> Now we only support the callchain for stream. For measuring the
> hot level for a stream, we use the callchain_node->hit, higher
> is hotter.
> 
> There may be many callchains sampled so we only focus on the top
> N hottest callchains. N is a user defined parameter or predefined
> default value (nr_streams_max).
> 
> This patch creates an evsel_streams array per event, and saves
> the top N hottest streams in a stream array.
> 
> So now we can get the per-event top N hottest streams.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  v6:
>    - Rebase to perf/core
> 
>  v5:
>    - Remove enum stram_type
>    - Rebase to perf/core
> 
>  v4:
>    - Refactor the code
>    - Rename patch name from 'perf util: Create streams for managing
>      top N hottest callchains' to 'perf util: Create streams'
> 
>  v2:
>    - Use zfree in free_evsel_streams().
> 
>  tools/perf/util/Build    |   1 +
>  tools/perf/util/stream.c | 148 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/stream.h |  23 ++++++
>  3 files changed, 172 insertions(+)
>  create mode 100644 tools/perf/util/stream.c
>  create mode 100644 tools/perf/util/stream.h
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index cd5e41960e64..6ffdf833cd51 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -101,6 +101,7 @@ perf-y += call-path.o
>  perf-y += rwsem.o
>  perf-y += thread-stack.o
>  perf-y += spark.o
> +perf-y += stream.o
>  perf-$(CONFIG_AUXTRACE) += auxtrace.o
>  perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
>  perf-$(CONFIG_AUXTRACE) += intel-pt.o
> diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
> new file mode 100644
> index 000000000000..015c1d07ce3a
> --- /dev/null
> +++ b/tools/perf/util/stream.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Compare and figure out the top N hottest streams
> + * Copyright (c) 2020, Intel Corporation.
> + * Author: Jin Yao
> + */
> +
> +#include <inttypes.h>
> +#include <stdlib.h>
> +#include <linux/zalloc.h>
> +#include "debug.h"
> +#include "hist.h"
> +#include "sort.h"
> +#include "stream.h"
> +#include "evlist.h"
> +
> +static void free_evsel_streams(struct evsel_streams *es, int nr_evsel)

Please name the functions with the struct name first, followed by __ and
then the method name, i.e. for this one:

static void evsel_streams__delete(struct evsel_streams *es, int nr_evsels)

One thing that made me curious is why nr_evsels (plural please) isn't in
'struct evsel_streams', why?

> +{
> +	for (int i = 0; i < nr_evsel; i++)
> +		zfree(&es[i].streams);
> +
> +	free(es);
> +}
> +
> +static struct evsel_streams *create_evsel_streams(int nr_evsel,
> +						  int nr_streams_max)

Oh, I see, you create just an array :-\

Please rename it to:

evsel_streams__new(int nr_evsels, int nr_streams_max)

> +{
> +	struct evsel_streams *es;
> +
> +	es = calloc(nr_evsel, sizeof(struct evsel_streams));
> +	if (!es)
> +		return NULL;
> +
> +	for (int i = 0; i < nr_evsel; i++) {
> +		struct evsel_streams *s = &es[i];
> +
> +		s->streams = calloc(nr_streams_max, sizeof(struct stream));
> +		if (!s->streams)
> +			goto err;
> +
> +		s->nr_streams_max = nr_streams_max;
> +		s->evsel_idx = -1;
> +	}
> +
> +	return es;
> +
> +err:
> +	free_evsel_streams(es, nr_evsel);
> +	return NULL;
> +}
> +
> +/*
> + * The cnodes with high hit number are hot callchains.
> + */
> +static void set_hot_cnode(struct evsel_streams *es,
> +			  struct callchain_node *cnode)

Since it is static its kinda ok not to have the prefix, but I'd do it
as:

static void evsel_streams__set_hot_cnode(...)

For ctags sake, for instance, i.e. navigate in vim using ctags.

> +{
> +	int i, idx = 0;
> +	u64 hit;
> +
> +	if (es->nr_streams < es->nr_streams_max) {
> +		i = es->nr_streams;
> +		es->streams[i].cnode = cnode;
> +		es->nr_streams++;
> +		return;
> +	}
> +
> +	/*
> +	 * Considering a few number of hot streams, only use simple
> +	 * way to find the cnode with smallest hit number and replace.
> +	 */
> +	hit = (es->streams[0].cnode)->hit;
> +	for (i = 1; i < es->nr_streams; i++) {
> +		if ((es->streams[i].cnode)->hit < hit) {
> +			hit = (es->streams[i].cnode)->hit;
> +			idx = i;
> +		}
> +	}
> +
> +	if (cnode->hit > hit)
> +		es->streams[idx].cnode = cnode;
> +}
> +
> +static void update_hot_callchain(struct hist_entry *he,
> +				 struct evsel_streams *es)
> +{
> +	struct rb_root *root = &he->sorted_chain;
> +	struct rb_node *rb_node = rb_first(root);
> +	struct callchain_node *cnode;
> +
> +	while (rb_node) {
> +		cnode = rb_entry(rb_node, struct callchain_node, rb_node);
> +		set_hot_cnode(es, cnode);
> +		rb_node = rb_next(rb_node);
> +	}
> +}
> +
> +static void init_hot_callchain(struct hists *hists, struct evsel_streams *es)
> +{
> +	struct rb_node *next = rb_first_cached(&hists->entries);
> +
> +	while (next) {
> +		struct hist_entry *he;
> +
> +		he = rb_entry(next, struct hist_entry, rb_node);
> +		update_hot_callchain(he, es);
> +		next = rb_next(&he->rb_node);
> +	}
> +}
> +
> +static int evlist_init_callchain_streams(struct evlist *evlist,
> +					 struct evsel_streams *es, int nr_es)

So here we miss just one extra _, i.e.:

+static int evlist__init_callchain_streams(struct evlist *evlist,
+					   struct evsel_streams *es, int nr_es)

> +{
> +	struct evsel *pos;
> +	int i = 0;
> +
> +	BUG_ON(nr_es < evlist->core.nr_entries);
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		struct hists *hists = evsel__hists(pos);
> +
> +		hists__output_resort(hists, NULL);
> +		init_hot_callchain(hists, &es[i]);
> +		es[i].evsel_idx = pos->idx;
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
> +						  int nr_streams_max)

And here it should be:

+struct evsel_streams *evlist__create_streams(struct evlist *evlist,
+					      int nr_streams_max)

I.e. without the perf_ prefix, since that is for 'struct perf_evlist'
methods, that are in tools/lib/perf/, aka libperf

> +{
> +	struct evsel_streams *es;
> +	int nr_evsel = evlist->core.nr_entries, ret = -1;
> +
> +	es = create_evsel_streams(nr_evsel, nr_streams_max);

Minor nitpick, usually combine declaration with first attribution, if
possible, i.e.:

+	struct evsel_streams *es = create_evsel_streams(nr_evsel, nr_streams_max);

> +	if (!es)
> +		return NULL;
> +
> +	ret = evlist_init_callchain_streams(evlist, es, nr_evsel);
> +	if (ret) {
> +		free_evsel_streams(es, nr_evsel);
> +		return NULL;
> +	}
> +
> +	return es;
> +}
> diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
> new file mode 100644
> index 000000000000..c6844c5787cb
> --- /dev/null
> +++ b/tools/perf/util/stream.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_STREAM_H
> +#define __PERF_STREAM_H
> +
> +#include "callchain.h"
> +
> +struct stream {
> +	struct callchain_node	*cnode;
> +};
> +
> +struct evsel_streams {
> +	struct stream		*streams;
> +	int			nr_streams_max;
> +	int			nr_streams;
> +	int			evsel_idx;
> +};
> +
> +struct evlist;
> +
> +struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
> +						  int nr_streams_max);
> +

evlist__create_streams()

> +#endif /* __PERF_STREAM_H */
> -- 
> 2.17.1
> 

-- 

- Arnaldo
