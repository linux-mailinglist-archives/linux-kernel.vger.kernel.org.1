Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82A423DF34
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgHFRln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:41:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbgHFRbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:31:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.129.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2607A22D06;
        Thu,  6 Aug 2020 12:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596716211;
        bh=mrlLpVPzrAmCX4fMWavC252Uthg3L8Vw0h/TB6kJjxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOuXH1Bfbgxk8YSkzleSA+YnnBQHMxG2Q92ULUKAqdvslAM96aPRbJw53iDpZoV3n
         DW7dIGDfH7AWe4THaADHloY5g7H8ae5X14RaUIN+PAIz1qVsfa747lrS5Fbpiyu7Hr
         UIM59ElpmpcgcZD4hkSJPChn7+zKDbWju9K+G1dg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A4E740524; Thu,  6 Aug 2020 09:16:48 -0300 (-03)
Date:   Thu, 6 Aug 2020 09:16:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf/core: take over CAP_SYS_PTRACE creds to
 CAP_PERFMON cap
Message-ID: <20200806121648.GA71359@kernel.org>
References: <6e8392ff-4732-0012-2949-e1587709f0f6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e8392ff-4732-0012-2949-e1587709f0f6@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 05, 2020 at 10:56:56AM +0300, Alexey Budankov escreveu:
> 
> Open access to per-process monitoring for CAP_PERFMON only
> privileged processes [1]. Extend ptrace_may_access() check
> in perf_events subsystem with perfmon_capable() to simplify
> user experience and make monitoring more secure by reducing
> attack surface.


Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Peter, can you pick up this one? You said it was ok last time we
discussed this.

- Arnaldo
 
> [1] https://lore.kernel.org/lkml/7776fa40-6c65-2aa6-1322-eb3a01201000@linux.intel.com/
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 856d98c36f56..f50d528af444 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11587,7 +11587,7 @@ SYSCALL_DEFINE5(perf_event_open,
>  			goto err_task;
>  
>  		/*
> -		 * Reuse ptrace permission checks for now.
> +		 * Preserve ptrace permission check for backwards compatibility.
>  		 *
>  		 * We must hold exec_update_mutex across this and any potential
>  		 * perf_install_in_context() call for this new event to
> @@ -11595,7 +11595,7 @@ SYSCALL_DEFINE5(perf_event_open,
>  		 * perf_event_exit_task() that could imply).
>  		 */
>  		err = -EACCES;
> -		if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
> +		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
>  			goto err_cred;
>  	}
>  
> -- 
> 2.24.1
> 

-- 

- Arnaldo
