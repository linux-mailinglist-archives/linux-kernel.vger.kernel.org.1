Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D873242920
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 14:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHLMKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 08:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgHLMKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:10:42 -0400
Received: from quaco.ghostprotocols.net (179.176.8.134.dynamic.adsl.gvt.net.br [179.176.8.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 259B720656;
        Wed, 12 Aug 2020 12:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597234242;
        bh=av7EL/+gBRzAVCunZ5OvR7yASKD/9geQYpFNRwsu6q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Txsim/4fE4jW7+lNs5ALhWCLu4XFSHkFaCFS0RSR7EP7tEXoHZLhhzM6ldPmm9KOe
         Zuvtn50nP6J7ergDRcsF8MrB03Q7yn8EZbKJcjDShHNpJLPqZkx/1EQMvSjd+HlfJR
         YMl0qgPLghJ1w/nY5AtZ6aaoTkH9g7r2QB/bwmoo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 29425403C6; Wed, 12 Aug 2020 09:10:40 -0300 (-03)
Date:   Wed, 12 Aug 2020 09:10:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bench: fix a couple of spelling mistakes in options
 text
Message-ID: <20200812121040.GD13995@kernel.org>
References: <20200812064647.200132-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812064647.200132-1-colin.king@canonical.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 12, 2020 at 07:46:47AM +0100, Colin King escreveu:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are a couple of spelling mistakes in the text. Fix these.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/perf/bench/find-bit-bench.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
> index fa90f3e9d368..73b5bcc5946a 100644
> --- a/tools/perf/bench/find-bit-bench.c
> +++ b/tools/perf/bench/find-bit-bench.c
> @@ -17,9 +17,9 @@ static unsigned int inner_iterations = 100000;
>  
>  static const struct option options[] = {
>  	OPT_UINTEGER('i', "outer-iterations", &outer_iterations,
> -		"Number of outerer iterations used"),
> +		"Number of outer iterations used"),
>  	OPT_UINTEGER('j', "inner-iterations", &inner_iterations,
> -		"Number of outerer iterations used"),
> +		"Number of inner iterations used"),
>  	OPT_END()
>  };
>  
> -- 
> 2.27.0
> 

-- 

- Arnaldo
