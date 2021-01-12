Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65692F2B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392159AbhALJbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:31:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732913AbhALJbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610443825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2C68mBDe9I1ILKks3Ahnxhq0efU6A1qDeM0dEQ5Oyog=;
        b=LK6+60pOiMefZX687kQPhGluGkv5zC4EzWwO2kBLJ1w2n2e0FleXbpy9MANzgUgmX/m6JZ
        53OELhaF5rxwbObAcUj7hKerrZRa+clnswhNvtEIM2ouYxAbvhssLlZmYimoEvBIQtzKtU
        lAt/pz65CxppvXZGa07s79qN01125ZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-VxT4EDg-MFyzRHKTedvwlg-1; Tue, 12 Jan 2021 04:30:21 -0500
X-MC-Unique: VxT4EDg-MFyzRHKTedvwlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 043D21800D42;
        Tue, 12 Jan 2021 09:30:20 +0000 (UTC)
Received: from krava (unknown [10.40.195.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4F7C7100164C;
        Tue, 12 Jan 2021 09:30:17 +0000 (UTC)
Date:   Tue, 12 Jan 2021 10:30:16 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH] perf test: Fix shadow stat test for non-bash shells
Message-ID: <20210112093016.GB1252618@krava>
References: <20210108074712.947223-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108074712.947223-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 04:47:12PM +0900, Namhyung Kim wrote:
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
> 
> Reported-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/tests/shell/stat+shadow_stat.sh | 24 ++++++++++++----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
> index 249dfe48cf6a..e2c7ac4ed91d 100755
> --- a/tools/perf/tests/shell/stat+shadow_stat.sh
> +++ b/tools/perf/tests/shell/stat+shadow_stat.sh
> @@ -16,24 +16,24 @@ test_global_aggr()
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
>  		local res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
> -		if [[ $ipc != $res ]]; then
> +		if [ "$ipc" != "$res" ]; then
>  			echo "IPC is different: $res != $ipc  ($num / $cyc)"
>  			exit 1
>  		fi
> @@ -42,36 +42,38 @@ test_global_aggr()
>  
>  test_no_aggr()
>  {
> -	declare -A results
> +	results=$(mktemp /tmp/perf-test-shadow-stat-XXXXXX)
>  
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
> +			echo $cpu $num >> $results
>  			continue
>  		fi
>  
>  		# skip if no cycles
> -		local cyc=${results[$cpu]}
> -		if [[ -z $cyc ]]; then
> +		local cyc=$(grep $cpu $results | cut -d' ' -f2)
> +		if [ -z "$cyc" ]; then
>  			continue
>  		fi
>  
>  		# use printf for rounding and a leading zero
>  		local res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
> -		if [[ $ipc != $res ]]; then
> +		if [ "$ipc" != "$res" ]; then
>  			echo "IPC is different for $cpu: $res != $ipc  ($num / $cyc)"
> +			rm -f $results
>  			exit 1
>  		fi
>  	done
> +	rm -f $results
>  }
>  
>  test_global_aggr
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 

