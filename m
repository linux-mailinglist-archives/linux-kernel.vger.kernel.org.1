Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC2A2A1CD7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 10:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgKAJYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 04:24:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbgKAJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 04:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604222682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v+0PI8WS3le3Ug1l0DY5WxMog4p0RKOAd20R3Fx4bb4=;
        b=ZtWewyej0iiHWj94NhCuORy2wraAj6HMw9Y9Haqed3J3NNzwjHSAkUZeJzs/4M+MuIgScr
        kt4vLGkWI4wkXLTWilveA9VFvgU4Ay2rvz+61lSOCmyEs2Lh4veB96BeF6IgziqNvtdnxU
        PL/E5nj0uqK4A62jffJjeKwLhNL7vnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-YMkftHzzNd-gLmGe2S0eag-1; Sun, 01 Nov 2020 04:24:40 -0500
X-MC-Unique: YMkftHzzNd-gLmGe2S0eag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0E521006C81;
        Sun,  1 Nov 2020 09:24:38 +0000 (UTC)
Received: from krava (unknown [10.40.192.52])
        by smtp.corp.redhat.com (Postfix) with SMTP id 568E45B4B2;
        Sun,  1 Nov 2020 09:24:37 +0000 (UTC)
Date:   Sun, 1 Nov 2020 10:24:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3] perf tools: Support -x for perf stat report
Message-ID: <20201101092435.GA3405508@krava>
References: <20201101063133.32179-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101063133.32179-1-andi@firstfloor.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 11:31:33PM -0700, Andi Kleen wrote:
> Add support for the -x, option to enable CSV output with perf stat
> report. Useful to parse the information with other programs.
> 
> % perf stat record --quiet -a -I 1000 sleep 5
> % perf stat report -x,
>      1.000838672,4003.55,msec,cpu-clock,4003548736,100.00,,
>      1.000838672,11243,,context-switches,4003631885,100.00,0.003,M/sec
>      1.000838672,1682,,cpu-migrations,4003672150,100.00,0.420,K/sec
>      1.000838672,13244,,page-faults,4003697471,100.00,0.003,M/sec
>      1.000838672,2953214077,,cycles,4003715495,100.00,0.738,GHz
>      1.000838672,4380820799,,instructions,4003738270,100.00,1.48,insn per cycle
>      1.000838672,809865653,,branches,4003760616,100.00,202.287,M/sec
>      1.000838672,12439843,,branch-misses,4003780785,100.00,1.54,of all branches
> ...
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ---
> 
> v2: Fix default output (Jiri). Also handle \t as special value like the
> original parser (Andi)
> v3: Use DEFAULT_SEPARATOR

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-stat.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 743fe47e7a88..9fcc7351ce43 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1988,6 +1988,8 @@ static int __cmd_report(int argc, const char **argv)
>  		     "aggregate counts per numa node", AGGR_NODE),
>  	OPT_SET_UINT('A', "no-aggr", &perf_stat.aggr_mode,
>  		     "disable CPU count aggregation", AGGR_NONE),
> +	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
> +		   "print counts with custom separator"),
>  	OPT_END()
>  	};
>  	struct stat st;
> @@ -2002,6 +2004,13 @@ static int __cmd_report(int argc, const char **argv)
>  			input_name = "perf.data";
>  	}
>  
> +	if (strcmp(stat_config.csv_sep, DEFAULT_SEPARATOR)) {
> +		stat_config.csv_output = true;
> +		if (!strcmp(stat_config.csv_sep, "\\t"))
> +			stat_config.csv_sep = "\t";
> +		stat_config.big_num = false;
> +	}
> +
>  	perf_stat.data.path = input_name;
>  	perf_stat.data.mode = PERF_DATA_MODE_READ;
>  
> -- 
> 2.28.0
> 

