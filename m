Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4662747DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgIVR4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVR4d (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:56:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A9D22376F;
        Tue, 22 Sep 2020 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600797392;
        bh=wsMmIF1yjGFZH+6s2BiRmHOZqU/Wicuf88jr0HoRfFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZFEPsAeoBCUGYG33bC6NDkDRcjzPeOrvjsQgtV3/Fo89WWNQbUMxP8Ga1pKPZSG7
         eGxqDLhyYuAdvxEgtvjVHAj14ma+Zd2M3A1joHALQ4GHh4TcqBtYP/5Inz9qIsH93Y
         /mo0jyugBKxXcbLmyuEilYzbr1fWIN4Q7oIYI/60=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7A72F400E9; Tue, 22 Sep 2020 14:56:30 -0300 (-03)
Date:   Tue, 22 Sep 2020 14:56:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Skip duration_time in setup_system_wide
Message-ID: <20200922175630.GB2248446@kernel.org>
References: <20200922015004.30114-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922015004.30114-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 22, 2020 at 09:50:04AM +0800, Jin Yao escreveu:
> Some metrics (such as DRAM_BW_Use) consists of uncore events and
> duration_time. For uncore events, counter->core.system_wide is
> true. But for duration_time, counter->core.system_wide is false
> so target.system_wide is set to false.
> 
> Then 'enable_on_exec' is set in perf_event_attr of uncore event.
> Kernel will return error when trying to open the uncore event.
> 
> This patch skips the duration_time in setup_system_wide then
> target.system_wide will be set to true for the evlist of uncore
> events + duration_time.
> 
> Before (tested on skylake desktop):
> 
>  # perf stat -M DRAM_BW_Use -- sleep 1
>  Error:
>  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (arb/event=0x84,umask=0x1/).
>  /bin/dmesg | grep -i perf may provide additional information.
> 
> After:
> 
>  # perf stat -M DRAM_BW_Use -- sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>                 169      arb/event=0x84,umask=0x1/ #     0.00 DRAM_BW_Use
>              40,427      arb/event=0x81,umask=0x1/
>       1,000,902,197 ns   duration_time
> 
>         1.000902197 seconds time elapsed
> 
> Fixes: 648b5af3f3ae ("libperf: Move 'system_wide' from 'struct evsel' to 'struct perf_evsel'")

Humm, what makes you think that this cset was the one introducing this
problem? It just moves evsel->system_wide to evsel->core.system_wide.

- Arnaldo


> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7f8d756d9408..9bcc93bc0973 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2047,8 +2047,10 @@ static void setup_system_wide(int forks)
>  		struct evsel *counter;
>  
>  		evlist__for_each_entry(evsel_list, counter) {
> -			if (!counter->core.system_wide)
> +			if (!counter->core.system_wide &&
> +			    strcmp(counter->name, "duration_time")) {
>  				return;
> +			}
>  		}
>  
>  		if (evsel_list->core.nr_entries)
> -- 
> 2.17.1
> 

-- 

- Arnaldo
