Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE351F1D7B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 18:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgFHQg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 12:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730432AbgFHQg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:36:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32F6D2053B;
        Mon,  8 Jun 2020 16:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591634188;
        bh=TQYnd+7jrdlMhST038vUWV9CRgsCgFOs6vSSUKQVhvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fHvmWE+Dn5EuiO+5LGDqUG5J2MILT8zrgz5QMTPOA5V/y+KfKyO65h4SHsGdNo9AH
         pZa7mFa43e4UgC0jb6MCJj59hSFAHgvCk+w1r5Fo7w9h1VJK1WCgyXBYbdAiB7YKVv
         JDR81MmamaXyS62q2oZRspCUy/5XSQ8chVAgD3UI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AB51640AFD; Mon,  8 Jun 2020 13:36:25 -0300 (-03)
Date:   Mon, 8 Jun 2020 13:36:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hongbo Yao <yaohongbo@huawei.com>
Cc:     alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        jolsa@redhat.com, namhyung@kernel.org, liwei391@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf util: Fix null pointer dereference
Message-ID: <20200608163625.GC3073@kernel.org>
References: <20200605091740.40206-1-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605091740.40206-1-yaohongbo@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 05, 2020 at 05:17:40PM +0800, Hongbo Yao escreveu:
> If config->aggr_map is Null and config->aggr_get_id is not Null,
> the function print_aggr() will still calling arrg_update_shadow(),
> which can result in accessing the invalid pointer.

Looks legit, but you forgot to add this:

Cc: Jiri Olsa <jolsa@kernel.org>
Fixes: 088519f318be ("perf stat: Move the display functions to stat-display.c")

That is not completely correct as this is just moving pre-existing code
(and bugs) to a different place, but at least the stable guys will get
this fix back to a good number of kernels.

Also you forgot to CC lkml,

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> ---
>  tools/perf/util/stat-display.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 3c6976f7574c..57d0706e1330 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -668,7 +668,7 @@ static void print_aggr(struct perf_stat_config *config,
>  	int s;
>  	bool first;
>  
> -	if (!(config->aggr_map || config->aggr_get_id))
> +	if (!config->aggr_map || !config->aggr_get_id)
>  		return;
>  
>  	aggr_update_shadow(config, evlist);
> @@ -1169,7 +1169,7 @@ static void print_percore(struct perf_stat_config *config,
>  	int s;
>  	bool first = true;
>  
> -	if (!(config->aggr_map || config->aggr_get_id))
> +	if (!config->aggr_map || !config->aggr_get_id)
>  		return;
>  
>  	if (config->percore_show_thread)
> -- 
> 2.20.1
> 

-- 

- Arnaldo
