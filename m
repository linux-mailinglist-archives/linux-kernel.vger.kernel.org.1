Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5892E2A6958
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgKDQVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730424AbgKDQVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:21:53 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56771206A5;
        Wed,  4 Nov 2020 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604506912;
        bh=eT2NJA9afDcwktVjFhTZsUfZxwO9cq/JXQY22XhO57I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nbe/AGKM+lG3aE/eZAu4E52brujrNOrch4fb+oczCDr9MiquhJX5Tjf12fq3+yykG
         TXPJxbWtPD9p6g2SJ5XfzWPtedxukLTeuLp3KU/p83E6MZjcE0q5PVRdiq8tX/LlJG
         +etCpuwAFB1guiwU5q3EZgoO5xXZTAuu9d3f8bwc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 58C96411D1; Wed,  4 Nov 2020 13:21:50 -0300 (-03)
Date:   Wed, 4 Nov 2020 13:21:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf lock: Correct field name "flags"
Message-ID: <20201104162150.GA191991@kernel.org>
References: <20201104094229.17509-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104094229.17509-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 04, 2020 at 05:42:28PM +0800, Leo Yan escreveu:
> The tracepoint "lock:lock_acquire" contains field "flags" but not
> "flag".  Current code wrongly retrieves value from field "flag" and it
> always gets zero for the value, thus "perf lock" doesn't report the
> correct result.
> 
> This patch replaces the field name "flag" with "flags", so can read out
> the correct flags for locking.


Thanks, applied both patches.

- Arnaldo

 
> Fixes: e4cef1f65061 ("perf lock: Fix state machine to recognize lock sequence")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> ---
>  tools/perf/builtin-lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index f0a1dbacb46c..5cecc1ad78e1 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -406,7 +406,7 @@ static int report_lock_acquire_event(struct evsel *evsel,
>  	struct lock_seq_stat *seq;
>  	const char *name = evsel__strval(evsel, sample, "name");
>  	u64 tmp	 = evsel__intval(evsel, sample, "lockdep_addr");
> -	int flag = evsel__intval(evsel, sample, "flag");
> +	int flag = evsel__intval(evsel, sample, "flags");
>  
>  	memcpy(&addr, &tmp, sizeof(void *));
>  
> -- 
> 2.17.1
> 

-- 

- Arnaldo
