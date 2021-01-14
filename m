Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727072F6964
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbhANSUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:20:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbhANSUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:20:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E01723A50;
        Thu, 14 Jan 2021 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610648390;
        bh=sOO1zD9aDo2u505vdOs5Rg/qv2nPKR2y7ZPhV0TuM24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VBVZUEdcvjS2WAl/JRpvi/n+ssahfTNAj2ATzmfaLIskBeCtZZS0yfqGDExQLcqcs
         WQdz5A62QT67WZrHmU5Pn9yl99C9KrQsh/G1eOJKYxoUJSizUBDevdGKvo/nej739g
         DHB8VSq7mPHmfkYv3FNr78jvjkzjXbyV+2hpa90jnUE82iwrYcaQNYgddgrDQiAIxt
         Wh6ICBb9uk6LGTw6PkFI9hdpA8ZiaIBq9M9voELJykOU9rSuYS6N6aElOfPkHedN3q
         s59b0BdrItQry1PwtbPWfO0fzS176tsUnkR+7UB/KX7Mbb8UFbrzi0o5RMgr9Bbcgf
         oDcSXXMXZDAiw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BE4BA411E9; Thu, 14 Jan 2021 15:20:22 -0300 (-03)
Date:   Thu, 14 Jan 2021 15:20:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        David Laight <David.Laight@aculab.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH v2] perf test: Fix shadow stat test for non-bash shells
Message-ID: <20210114182022.GA307547@kernel.org>
References: <20210114050609.1258820-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114050609.1258820-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 14, 2021 at 02:06:09PM +0900, Namhyung Kim escreveu:
> It was using some bash-specific features and failed to parse when
> running with a different shell like below:
> 
>   root@kbl-ppc:~/kbl-ws/perf-dev/lck-9077/acme.tmp/tools/perf# ./perf test 83 -vv
>   83: perf stat metrics (shadow stat) test                            :
>   --- start ---
>   test child forked, pid 3922
>   ./tests/shell/stat+shadow_stat.sh: 19: ./tests/shell/stat+shadow_stat.sh: [[: not found
>   ./tests/shell/stat+shadow_stat.sh: 24: ./tests/shell/stat+shadow_stat.sh: [[: not found
>   ./tests/shell/stat+shadow_stat.sh: 30: ./tests/shell/stat+shadow_stat.sh: [[: not found
>   (standard_in) 2: syntax error
>   ./tests/shell/stat+shadow_stat.sh: 36: ./tests/shell/stat+shadow_stat.sh: [[: not found
>   ./tests/shell/stat+shadow_stat.sh: 19: ./tests/shell/stat+shadow_stat.sh: [[: not found
>   ./tests/shell/stat+shadow_stat.sh: 24: ./tests/shell/stat+shadow_stat.sh: [[: not found
>   ./tests/shell/stat+shadow_stat.sh: 30: ./tests/shell/stat+shadow_stat.sh: [[: not found
>   (standard_in) 2: syntax error
>   ./tests/shell/stat+shadow_stat.sh: 36: ./tests/shell/stat+shadow_stat.sh: [[: not found
>   ./tests/shell/stat+shadow_stat.sh: 45: ./tests/shell/stat+shadow_stat.sh: declare: not found
>   test child finished with -1
>   ---- end ----
>   perf stat metrics (shadow stat) test: FAILED!

Jiri provided an Acked-by for v1, Jiri, can I keep it for this v2?

- Arnaldo
 
> Reported-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/stat+shadow_stat.sh | 30 ++++++++++------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
> index 249dfe48cf6a..ebebd3596cf9 100755
> --- a/tools/perf/tests/shell/stat+shadow_stat.sh
> +++ b/tools/perf/tests/shell/stat+shadow_stat.sh
> @@ -9,31 +9,29 @@ perf stat -a true > /dev/null 2>&1 || exit 2
>  
>  test_global_aggr()
>  {
> -	local cyc
> -
>  	perf stat -a --no-big-num -e cycles,instructions sleep 1  2>&1 | \
>  	grep -e cycles -e instructions | \
>  	while read num evt hash ipc rest
>  	do
>  		# skip not counted events
> -		if [[ $num == "<not" ]]; then
> +		if [ "$num" = "<not" ]; then
>  			continue
>  		fi
>  
>  		# save cycles count
> -		if [[ $evt == "cycles" ]]; then
> +		if [ "$evt" = "cycles" ]; then
>  			cyc=$num
>  			continue
>  		fi
>  
>  		# skip if no cycles
> -		if [[ -z $cyc ]]; then
> +		if [ -z "$cyc" ]; then
>  			continue
>  		fi
>  
>  		# use printf for rounding and a leading zero
> -		local res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
> -		if [[ $ipc != $res ]]; then
> +		res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
> +		if [ "$ipc" != "$res" ]; then
>  			echo "IPC is different: $res != $ipc  ($num / $cyc)"
>  			exit 1
>  		fi
> @@ -42,32 +40,32 @@ test_global_aggr()
>  
>  test_no_aggr()
>  {
> -	declare -A results
> -
>  	perf stat -a -A --no-big-num -e cycles,instructions sleep 1  2>&1 | \
>  	grep ^CPU | \
>  	while read cpu num evt hash ipc rest
>  	do
>  		# skip not counted events
> -		if [[ $num == "<not" ]]; then
> +		if [ "$num" = "<not" ]; then
>  			continue
>  		fi
>  
>  		# save cycles count
> -		if [[ $evt == "cycles" ]]; then
> -			results[$cpu]=$num
> +		if [ "$evt" = "cycles" ]; then
> +			results="$results $cpu:$num"
>  			continue
>  		fi
>  
> +		cyc=${results##* $cpu:}
> +		cyc=${cyc%% *}
> +
>  		# skip if no cycles
> -		local cyc=${results[$cpu]}
> -		if [[ -z $cyc ]]; then
> +		if [ -z "$cyc" ]; then
>  			continue
>  		fi
>  
>  		# use printf for rounding and a leading zero
> -		local res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
> -		if [[ $ipc != $res ]]; then
> +		res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
> +		if [ "$ipc" != "$res" ]; then
>  			echo "IPC is different for $cpu: $res != $ipc  ($num / $cyc)"
>  			exit 1
>  		fi
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 

-- 

- Arnaldo
