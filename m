Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63A6269901
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgINWhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgINWhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:37:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FFF020732;
        Mon, 14 Sep 2020 22:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600123038;
        bh=O13iZ2FgTSU6wni8JyIYJRc6hM5MQp9DOxykior0dhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLW3mtu3fnscg7ZXtLlwH1sCSI9JBVW+yDQ/8WojgWa1ajm8T09IBrY8RPZ2O4uKS
         kpB+CjQYcj6c/YYO6YBNWbdv6OuSJdQC5O8xAVShYosPYc67t5XimCmDWLgFaUw5bV
         TBXmI8kLG4BfiSKJdSMJq4PnXcEk9Aab47OwFIVk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB86640D3D; Mon, 14 Sep 2020 19:37:16 -0300 (-03)
Date:   Mon, 14 Sep 2020 19:37:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Henry Burns <henrywolfeburns@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf vendor events amd: remove trailing comma
Message-ID: <20200914223716.GK166601@kernel.org>
References: <20200912041101.2123-1-henrywolfeburns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912041101.2123-1-henrywolfeburns@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Sep 12, 2020 at 12:10:56AM -0400, Henry Burns escreveu:
> amdzen2/core.json had a trailing comma on the x_ret_fus_brnch_inst
> event. Since that goes against the JSON standard, lets remove it.

is this the only case in all the .json files we have in
tools/perf/pmu-events/?

- Arnaldo
 
> Signed-off-by: Henry Burns <henrywolfeburns@gmail.com>
> ---
>  tools/perf/pmu-events/arch/x86/amdzen2/core.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/core.json b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
> index de89e5a44ff1..4b75183da94a 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen2/core.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
> @@ -125,6 +125,6 @@
>    {
>      "EventName": "ex_ret_fus_brnch_inst",
>      "EventCode": "0x1d0",
> -    "BriefDescription": "Retired Fused Instructions. The number of fuse-branch instructions retired per cycle. The number of events logged per cycle can vary from 0-8.",
> +    "BriefDescription": "Retired Fused Instructions. The number of fuse-branch instructions retired per cycle. The number of events logged per cycle can vary from 0-8."
>    }
>  ]
> -- 
> 2.25.1
> 

-- 

- Arnaldo
