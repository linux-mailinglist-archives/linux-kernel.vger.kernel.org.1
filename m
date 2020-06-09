Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6279F1F3F83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 17:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbgFIPhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 11:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbgFIPhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:37:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D8320774;
        Tue,  9 Jun 2020 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591717033;
        bh=3nKS9nvh6ZEopoO4uY4Sbrc9TYsSWEMTgTcU3kcNFr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYsDg7vpYoQIAnv07rNNJ4rONVnN5glNqDRVYJnarX1+2bfNNHoMK9pmcu7LNaokh
         lruX+1XidWBIbzBwv/gHj7jdXukkI3+ethkT0kmC5W+vIKbOOlm3OVZAwtGhenGx7f
         z3GaKMzH0UprZY0fLHcfkI9FqINvDkpcFpXKd9Wg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 31A5B40AFD; Tue,  9 Jun 2020 12:37:11 -0300 (-03)
Date:   Tue, 9 Jun 2020 12:37:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/2] perf parse-events: fix an old style declaration
Message-ID: <20200609153711.GH24868@kernel.org>
References: <20200609053610.206588-1-irogers@google.com>
 <20200609053610.206588-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609053610.206588-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 08, 2020 at 10:36:10PM -0700, Ian Rogers escreveu:
> Fixes: a26e47162d76 (perf tools: Move ALLOC_LIST into a function)
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.y | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index d4e076c9c2ab..acef87d9af58 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -26,7 +26,7 @@ do { \
>  		YYABORT; \
>  } while (0)
>  
> -static struct list_head* alloc_list()
> +static struct list_head* alloc_list(void)
>  {
>  	struct list_head *list;

Thanks, applied.

- Arnaldo
