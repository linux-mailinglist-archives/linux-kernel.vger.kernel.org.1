Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A3B2C83A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgK3MAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:00:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgK3MAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:00:03 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DCE12074A;
        Mon, 30 Nov 2020 11:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606737561;
        bh=7EYDFHjiWGHINFznlSLihrd6/424PlpNBqXG5NEpZ04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCIhW5hfPqjM94q5hVH1DB1pGJk3SprVYFMxdoM5CEg34fuS6HIYC1zMfD/ylh9OT
         ZbXcLpSdPOXgu4XYfaMrFqhRmSIanmyK9Trv53jparb1K9/f9HTiINW165zRkfNWo4
         fbI0XOYdGqRMYfFcKfqp63nQlUIwx98m5MHhj9x8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8CE354079D; Mon, 30 Nov 2020 08:59:25 -0300 (-03)
Date:   Mon, 30 Nov 2020 08:59:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 2/2] perf test: Add shadow stat test
Message-ID: <20201130115925.GA20959@kernel.org>
References: <20201127041404.390276-1-namhyung@kernel.org>
 <20201127041404.390276-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127041404.390276-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 27, 2020 at 01:14:04PM +0900, Namhyung Kim escreveu:
> It calculates IPC from the cycles and instruction counts and compares
> it with the shadow stat for both global aggregation (default) and no
> aggregation mode.
> 
>  $ perf stat -a -A -e cycles,instructions sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>   CPU0   39,580,880      cycles
>   CPU1   45,426,945      cycles
>   CPU2   31,151,685      cycles
>   CPU3   55,167,421      cycles
>   CPU0   17,073,564      instructions      #    0.43  insn per cycle
>   CPU1   34,955,764      instructions      #    0.77  insn per cycle
>   CPU2   15,688,459      instructions      #    0.50  insn per cycle
>   CPU3   34,699,217      instructions      #    0.63  insn per cycle
> 
>        1.003275495 seconds time elapsed
> 
> In this example, the 'insn per cycle' should be matched to the number
> for each cpu.  For CPU2, 0.50 = 15,688,459 / 31,151,685 .

Merged torvalds/master into perf/core and applied this patch,

Thanks,

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/stat+shadow_stat.sh | 80 ++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100755 tools/perf/tests/shell/stat+shadow_stat.sh
> 
> diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
> new file mode 100755
> index 000000000000..249dfe48cf6a
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat+shadow_stat.sh
> @@ -0,0 +1,80 @@
> +#!/bin/sh
> +# perf stat metrics (shadow stat) test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +# skip if system-wide mode is forbidden
> +perf stat -a true > /dev/null 2>&1 || exit 2
> +
> +test_global_aggr()
> +{
> +	local cyc
> +
> +	perf stat -a --no-big-num -e cycles,instructions sleep 1  2>&1 | \
> +	grep -e cycles -e instructions | \
> +	while read num evt hash ipc rest
> +	do
> +		# skip not counted events
> +		if [[ $num == "<not" ]]; then
> +			continue
> +		fi
> +
> +		# save cycles count
> +		if [[ $evt == "cycles" ]]; then
> +			cyc=$num
> +			continue
> +		fi
> +
> +		# skip if no cycles
> +		if [[ -z $cyc ]]; then
> +			continue
> +		fi
> +
> +		# use printf for rounding and a leading zero
> +		local res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
> +		if [[ $ipc != $res ]]; then
> +			echo "IPC is different: $res != $ipc  ($num / $cyc)"
> +			exit 1
> +		fi
> +	done
> +}
> +
> +test_no_aggr()
> +{
> +	declare -A results
> +
> +	perf stat -a -A --no-big-num -e cycles,instructions sleep 1  2>&1 | \
> +	grep ^CPU | \
> +	while read cpu num evt hash ipc rest
> +	do
> +		# skip not counted events
> +		if [[ $num == "<not" ]]; then
> +			continue
> +		fi
> +
> +		# save cycles count
> +		if [[ $evt == "cycles" ]]; then
> +			results[$cpu]=$num
> +			continue
> +		fi
> +
> +		# skip if no cycles
> +		local cyc=${results[$cpu]}
> +		if [[ -z $cyc ]]; then
> +			continue
> +		fi
> +
> +		# use printf for rounding and a leading zero
> +		local res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
> +		if [[ $ipc != $res ]]; then
> +			echo "IPC is different for $cpu: $res != $ipc  ($num / $cyc)"
> +			exit 1
> +		fi
> +	done
> +}
> +
> +test_global_aggr
> +test_no_aggr
> +
> +exit 0
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 

-- 

- Arnaldo
