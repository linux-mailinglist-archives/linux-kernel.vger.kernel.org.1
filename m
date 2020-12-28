Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67162E42B8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392577AbgL1P1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 10:27:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504228AbgL1PZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 10:25:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6E5A22472;
        Mon, 28 Dec 2020 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609169117;
        bh=R4iMJC11Whx65fQ+/OHxhLFq9u6boBvRzAZlsJBOZQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBmAFpC/eM9LibG1FggIqdnIA+pvCwQExPTtTRBW7qv4vpNhsN8tPbSFmpAwSTYbr
         TxWwYpQFoCd0DRYck3dDRgrGU1qqQYXzaQFvH9A2kCXzCqGgesCA23IilSMZhW2emi
         ijbOgb2DRBRVdTk45ddiBBptS6+ngnkMlJ9zf7swif3M6eKbNTPRjWEFDdOy42kGQT
         VmYDKmC+W7+nTnkem9kN+Io+cTx/O7PEDGOIDU8KA5bBb5Zm6eVnX3M3Ki+VQL5ABj
         qXD9I6xSHi3w0NaVoP53CrbTtT6bOtf7hT7Af1QgwOqfj3andDwfInan4EtoCua0Mj
         OvzCHr66AlhYg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F048411E9; Mon, 28 Dec 2020 12:25:32 -0300 (-03)
Date:   Mon, 28 Dec 2020 12:25:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hans-Peter Nilsson <hp@axis.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf record: Tweak "Lowering..." warning in
 record_opts__config_freq
Message-ID: <20201228152532.GE521329@kernel.org>
References: <20201228031908.B049B203B5@pchp3.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228031908.B049B203B5@pchp3.se.axis.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 28, 2020 at 04:19:08AM +0100, Hans-Peter Nilsson escreveu:
> That is, instead of "Lowering default frequency rate to <F>" say
> "Lowering default frequency rate from <f> to <F>", specifying
> the overridden default frequency <f>, so you don't have to grep
> through the source to "remember" that was e.g. 4000.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Hans-Peter Nilsson <hp@axis.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/record.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index 07e4b96a6625..3b38e7be10da 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -202,10 +202,10 @@ static int record_opts__config_freq(struct record_opts *opts)
>  	 * Default frequency is over current maximum.
>  	 */
>  	if (max_rate < opts->freq) {
> -		pr_warning("Lowering default frequency rate to %u.\n"
> +		pr_warning("Lowering default frequency rate from %u to %u.\n"
>  			   "Please consider tweaking "
>  			   "/proc/sys/kernel/perf_event_max_sample_rate.\n",
> -			   max_rate);
> +			   opts->freq, max_rate);
>  		opts->freq = max_rate;
>  	}
>  
> -- 
> 2.11.0
> 
> brgds, H-P

-- 

- Arnaldo
