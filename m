Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1EC2A14FC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 10:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgJaJxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 05:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbgJaJxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604138021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHE5e7rFYlfQgrwEH2WFaMaIsva2MPTmgNHiU/i5upA=;
        b=K/CUNd6uzpUT9H2E4i9Cb2OkDLmFToqMtrwjRddvG4xe/JFi+XFKSPlSgZMp+4Lp+NmniH
        iXgyF9ZoM2D4BREtgknqs56+MNQSSaIIIK7uqkT34OKlAX7FnZTPs4JfjXscAhx2ofXPtR
        0obd6nHX6SZopHPVsht2PEwAIu4PTqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-5Cu-v9zANp6-EmjMPfdK_w-1; Sat, 31 Oct 2020 05:53:37 -0400
X-MC-Unique: 5Cu-v9zANp6-EmjMPfdK_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 983101842162;
        Sat, 31 Oct 2020 09:53:35 +0000 (UTC)
Received: from krava (unknown [10.40.192.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 54F985B4A0;
        Sat, 31 Oct 2020 09:53:33 +0000 (UTC)
Date:   Sat, 31 Oct 2020 10:53:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] perf tools: Support -x for perf stat report
Message-ID: <20201031095333.GA3345514@krava>
References: <20201028051510.9526-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028051510.9526-1-andi@firstfloor.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 10:15:10PM -0700, Andi Kleen wrote:
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
> ---
>  tools/perf/builtin-stat.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 743fe47e7a88..2f7eb6b68344 100644
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
> +	if (strcmp(stat_config.csv_sep, " ")) {

please use the DEFAULT_SEPARATOR instad of " "

thanks,
jirka

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

