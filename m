Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD77228BD46
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390420AbgJLQJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:09:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:5364 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389068AbgJLQJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:09:39 -0400
IronPort-SDR: H6I+iFHSytWO02kIBxfwHd2oU0PGHfQgA9Rw9pfQsv1HM86uWFG+u7lSgrJ1NxnXfpfgNaKB64
 L/j3cz7gqQXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="250457780"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="250457780"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 09:09:22 -0700
IronPort-SDR: /ehqO5gfje49rvZmY8Pqw/cgZmO8/buZ2GWo0HlsOFtZn/8CbQmV/xmd26m7WVGqfZgxYkpyHe
 jRAxVkfZl5kQ==
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="313493064"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 09:09:22 -0700
Date:   Mon, 12 Oct 2020 09:09:21 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 06/15] perf session: load data directory into tool
 process memory
Message-ID: <20201012160921.GD466880@tassilo.jf.intel.com>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <39cf6164-f3be-ae34-292a-94faef32fdb9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39cf6164-f3be-ae34-292a-94faef32fdb9@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:58:58AM +0300, Alexey Budankov wrote:
> 
> Read trace files located at data directory into tool process memory.
> Basic analysis support of data directories is provided for report
> mode. Raw dump (-D) and aggregated reports are available for data
> directories, still with no memory consumption optimizations. However
> data directories collected with --compression-level option enabled
> can be analyzed with little less memory because trace files are
> unmaped from tool process memory after loading collected data.
> The implementation is based on the prototype [1], [2].

Should credit the author(s) of the prototypes.
> 
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/session.c | 48 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/session.h |  1 +
>  2 files changed, 49 insertions(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 6afc670fdf0c..0752eec19813 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2212,6 +2212,17 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  		goto more;
>  
>  out:
> +	if (rd->unmap_file) {
> +		int i;
> +
> +		for (i = 0; i < NUM_MMAPS; i++) {
> +			if (mmaps[i]) {
> +				munmap(mmaps[i], mmap_size);
> +				mmaps[i] = NULL;

Okay so where is the mmap? Would make more sense to put that
into the same patch as who adds the mmap. Or is the mmap
code already in the perf source? In that case it should
probably be some common helper with the existing users.

