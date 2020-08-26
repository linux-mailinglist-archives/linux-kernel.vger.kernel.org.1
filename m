Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1262C252F91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgHZNVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 09:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbgHZNVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:21:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA3412080C;
        Wed, 26 Aug 2020 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598448070;
        bh=s0l3MRlai5y9sJL8ojERRg++aQ7zKvgtUOFyEiGCDjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBmDlq7C52cAgdico/iqHb4N3ZZwmfrDiaZyeiD0cnZiDAGfaf32maM6ddwis58Db
         QOtPIXBA6WIBeuKS+ETcBnDZxsoL60dXdJLEc0JeuuD36PnpOn1D2kQQGz+KOVdIj8
         Abssa8DxULUajRDLTBuqsBZn4DK9iy+EEOzrbPTE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0118840D3D; Wed, 26 Aug 2020 10:21:07 -0300 (-03)
Date:   Wed, 26 Aug 2020 10:21:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Kajol Jain <kjain@linux.ibm.com>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        daniel@iogearbox.net, brho@google.com, srikar@linux.vnet.ibm.com
Subject: Re: [RFC] perf/core: Fixes hung issue on perf stat command during
 cpu hotplug
Message-ID: <20200826132107.GH1059382@kernel.org>
References: <20200826093236.446024-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826093236.446024-1-kjain@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 26, 2020 at 03:02:36PM +0530, Kajol Jain escreveu:
> Commit 2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
> added assignment of ret value as -EAGAIN in case function
> call to 'smp_call_function_single' fails.
> For non-zero ret value, it did 
> 'ret = !ret ? data.ret : -EAGAIN;', which always
> assign -EAGAIN to ret and make second if condition useless.
> 
> In scenarios like when executing a perf stat with --per-thread option, and 
> if any of the monitoring cpu goes offline, the 'smp_call_function_single'
> function could return -ENXIO, and with the above check,
> task_function_call hung and increases CPU
> usage (because of repeated 'smp_call_function_single()')
> 
> Recration scenario:
> 	# perf stat -a --per-thread && (offline a CPU )

Peter, this is kernel stuff, can you take a look?

- Arnaldo
 
> Patch here removes the tertiary condition added as part of that 
> commit and added a check for NULL and -EAGAIN.
> 
> Fixes: 2ed6edd33a21("perf: Add cond_resched() to task_function_call()")
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/events/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5bfe8e3c6e44..330c53f7df9c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -115,9 +115,9 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
>  	for (;;) {
>  		ret = smp_call_function_single(task_cpu(p), remote_function,
>  					       &data, 1);
> -		ret = !ret ? data.ret : -EAGAIN;
> -
> -		if (ret != -EAGAIN)
> +		if (!ret)
> +			ret = data.ret;
> +		else if (ret != -EAGAIN)
>  			break;
>  
>  		cond_resched();
> -- 
> 2.26.2
> 

-- 

- Arnaldo
