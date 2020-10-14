Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D24128E424
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbgJNQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgJNQPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:15:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 525F4214D8;
        Wed, 14 Oct 2020 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602692124;
        bh=Fn9uX5O2omnup/84D5aJ+WYmXcwdljJnj7f8uVPl5o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lEPAxRe3UZkCD7LhX/u9Be2a6BTGt0enhY3I5FmpaBbqI8q2g7RyOO2nvCGbnXCrZ
         cuHUI9RctbgnCfSMpHeZBbihNk09SFpAk97fUekRctlyh0JHmXUIUQLwPbUOdAW5NY
         OIlisQU6iznnsLqCW1yebgPtA46XX0WfyvNUxXXA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0FC634047F; Wed, 14 Oct 2020 13:15:22 -0300 (-03)
Date:   Wed, 14 Oct 2020 13:15:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf: Improve PT documentation slightly
Message-ID: <20201014161521.GL3100363@kernel.org>
References: <20201014035346.4772-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014035346.4772-1-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 13, 2020 at 08:53:46PM -0700, Andi Kleen escreveu:
> Document the higher level --insn-trace etc. perf script options.
> 
> Include the howto how to build xed into the manpage

Thanks, applied.
 
> Cc: adrian.hunter@intel.com
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-intel-pt.txt | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
> index d5a266d7f15b..cc2a8b2be31a 100644
> --- a/tools/perf/Documentation/perf-intel-pt.txt
> +++ b/tools/perf/Documentation/perf-intel-pt.txt
> @@ -112,6 +112,32 @@ The flags are "bcrosyiABEx" which stand for branch, call, return, conditional,
>  system, asynchronous, interrupt, transaction abort, trace begin, trace end, and
>  in transaction, respectively.
>  
> +perf script also supports higher level ways to dump instruction traces:
> +
> +	perf script --insn-trace --xed
> +
> +Dump all instructions. This requires installing the xed tool (see XED below)
> +Dumping all instructions in a long trace can be fairly slow. It is usually better
> +to start with higher level decoding, like
> +
> +	perf script --call-trace
> +
> +or
> +
> +	perf script --call-ret-trace
> +
> +and then select a time range of interest. The time range can then be examined
> +in detail with
> +
> +	perf script --time starttime,stoptime --insn-trace --xed
> +
> +While examining the trace it's also useful to filter on specific CPUs using
> +the -C option
> +
> +	perf script --time starttime,stoptime --insn-trace --xed -C 1
> +
> +Dump all instructions in time range on CPU 1.
> +
>  Another interesting field that is not printed by default is 'ipc' which can be
>  displayed as follows:
>  
> @@ -1093,6 +1119,10 @@ To display PEBS events from the Intel PT trace, use the itrace 'o' option e.g.
>  
>  	perf script --itrace=oe
>  
> +XED
> +---
> +
> +include::build-xed.txt[]
>  
>  SEE ALSO
>  --------
> -- 
> 2.28.0
> 

-- 

- Arnaldo
