Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C00525C8FD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 20:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgICSxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 14:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgICSxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:53:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F8CF20722;
        Thu,  3 Sep 2020 18:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599159183;
        bh=+ChGGmmjNKqiXCRRK/zltvj5iuOSNFYWr1Ewxx4CGJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=abw8+sVb+d2Yr1U00w9LxtxqRdLOp6i5PXxwzgLn/GaYYn5fyzki0c2RXoZjaVJjM
         0RcvPQ4/qXWW1jjEm9RQ8tG8CKjdhO6JiO854c3QjQYTf60GtQbMMoKkNQLExWXXc6
         TkVbFkbDWmD3//WCMnOwCMUwTYE/9AQuYBw1sBE4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4C35E40D3D; Thu,  3 Sep 2020 15:53:01 -0300 (-03)
Date:   Thu, 3 Sep 2020 15:53:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] perf bench: fix return value check in
 do_run_multi_threaded()
Message-ID: <20200903185301.GE3495158@kernel.org>
References: <20200902140526.26916-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902140526.26916-1-yuehaibing@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 02, 2020 at 10:05:26PM +0800, YueHaibing escreveu:
> In case of error, the function perf_session__new() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR()
> 
> Fixes: 13edc237200c ("perf bench: Add a multi-threaded synthesize benchmark")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks, applied, kudos for adding the Fixes: tag, appreciated!

- Arnaldo


> ---
>  tools/perf/bench/synthesize.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
> index 8d624aea1c5e..e39daa609db2 100644
> --- a/tools/perf/bench/synthesize.c
> +++ b/tools/perf/bench/synthesize.c
> @@ -162,8 +162,8 @@ static int do_run_multi_threaded(struct target *target,
>  	init_stats(&event_stats);
>  	for (i = 0; i < multi_iterations; i++) {
>  		session = perf_session__new(NULL, false, NULL);
> -		if (!session)
> -			return -ENOMEM;
> +		if (IS_ERR(session)) {
> +			return PTR_ERR(session);
>  
>  		atomic_set(&event_count, 0);
>  		gettimeofday(&start, NULL);
> -- 
> 2.17.1
> 
> 

-- 

- Arnaldo
