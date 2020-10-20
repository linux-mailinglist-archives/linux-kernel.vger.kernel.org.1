Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187C62935B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405093AbgJTH0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405066AbgJTH0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603178765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8jk46qzoY+qKztxyvjIvkyp4/43VUHvpWhz0wxtac/k=;
        b=ibH/mp8YPNfF0Gc1sp2SuvzUANfUPHPWrw71Mc2dFlg18VYjiDiNLr4JywotCZS62exa+l
        W1w7Wi47de1JmMDLju4nCZZhasQmTo8AnUZZJhsb3NIQSofN0GS6OHcTuCr34Z0wZ5ewz8
        wsJbcNHYXFeRHwg+TPaNQuxt22EnsFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-iL_J8JbLOcKUndYdXMVDFA-1; Tue, 20 Oct 2020 03:26:01 -0400
X-MC-Unique: iL_J8JbLOcKUndYdXMVDFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0654B87505D;
        Tue, 20 Oct 2020 07:25:59 +0000 (UTC)
Received: from krava (unknown [10.40.192.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6044B55760;
        Tue, 20 Oct 2020 07:25:54 +0000 (UTC)
Date:   Tue, 20 Oct 2020 09:25:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/8] perf c2c: Add option '-d llc' for sorting with
 LLC load
Message-ID: <20201020072553.GC2084117@krava>
References: <20201015145041.10953-1-leo.yan@linaro.org>
 <20201015145041.10953-8-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015145041.10953-8-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 03:50:40PM +0100, Leo Yan wrote:

SNIP

> @@ -1533,6 +1539,7 @@ static struct c2c_header percent_hitm_header[] = {
>  	[DISPLAY_LCL] = HEADER_BOTH("Lcl", "Hitm"),
>  	[DISPLAY_RMT] = HEADER_BOTH("Rmt", "Hitm"),
>  	[DISPLAY_TOT] = HEADER_BOTH("Tot", "Hitm"),
> +	[DISPLAY_LLC] = HEADER_BOTH("LLC", "Hit"),
>  };
>  
>  static struct c2c_dimension dim_percent_hitm = {
> @@ -2002,6 +2009,10 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
>  		break;
>  	case DISPLAY_TOT:
>  		FILTER_ENTRY(tot_hitm);
> +		break;
> +	case DISPLAY_LLC:
> +		FILTER_ENTRY(tot_llchit);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -2032,6 +2043,9 @@ static inline bool is_valid_hist_entry(struct hist_entry *he)
>  	case DISPLAY_TOT:
>  		has_record = !!c2c_he->stats.tot_hitm;
>  		break;
> +	case DISPLAY_LLC:
> +		has_record = !!c2c_he->stats.tot_llchit;
> +		break;
>  	default:
>  		break;
>  	}

there's one more switch with c2c.display in percent_hitm function,
where you did not add DISPLAY_LLC case.. I guess it should not ever
because we will not use that column in llc display mode, but we
should add at least some warning or that

SNIP

> -				"cl_rmt_hitm,"
> -				"cl_lcl_hitm,"
> -				"cl_stores_l1hit,"
> -				"cl_stores_l1miss,"
> -				"dcacheline",
> -				NULL);
> +	ret = hpp_list__parse(&hpp_list, cl_output, NULL);
>  
>  	if (WARN_ONCE(ret, "failed to setup sort entries\n"))
>  		return;
> @@ -2357,7 +2384,7 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
>  		fprintf(out, "%-36s: %s\n", first ? "  Events" : "", evsel__name(evsel));
>  		first = false;
>  	}
> -	fprintf(out, "  Cachelines sort on                : %s HITMs\n",
> +	fprintf(out, "  Cachelines sort on                : %s\n",
>  		display_str[c2c.display]);
>  	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
>  }
> @@ -2514,7 +2541,7 @@ static int perf_c2c_browser__title(struct hist_browser *browser,
>  {
>  	scnprintf(bf, size,
>  		  "Shared Data Cache Line Table     "
> -		  "(%lu entries, sorted on %s HITMs)",
> +		  "(%lu entries, sorted on %s)",
>  		  browser->nr_non_filtered_entries,
>  		  display_str[c2c.display]);
>  	return 0;
> @@ -2720,6 +2747,8 @@ static int setup_display(const char *str)
>  		c2c.display = DISPLAY_RMT;
>  	else if (!strcmp(display, "lcl"))
>  		c2c.display = DISPLAY_LCL;
> +	else if (!strcmp(display, "llc"))
> +		c2c.display = DISPLAY_LLC;

please update man page with this

>  	else {
>  		pr_err("failed: unknown display type: %s\n", str);
>  		return -1;
> @@ -2766,9 +2795,10 @@ static int build_cl_output(char *cl_sort, bool no_source)
>  	}
>  
>  	if (asprintf(&c2c.cl_output,
> -		"%s%s%s%s%s%s%s%s%s%s",
> +		"%s%s%s%s%s%s%s%s%s%s%s",

why is there extra '%s' when we did not add new argument.. ?

SNIP

> +			     "ld_fbhit,ld_l1hit,ld_l2hit,"
> +			     "ld_lclhit,lcl_hitm,"
> +			     "ld_rmthit,rmt_hitm,"
> +			     "dram_lcl,dram_rmt";
> +	else /* c2c.display == DISPLAY_LLC */
> +		output_str = "cl_idx,"
> +			     "dcacheline,"
> +			     "dcacheline_node,"
> +			     "dcacheline_count,"
> +			     "percent_llchit,"
> +			     "tot_llchit,"
> +			     "tot_recs,"
> +			     "tot_loads,"
> +			     "tot_stores,"
> +			     "stores_l1hit,stores_l1miss,"
> +			     "ld_fbhit,ld_l1hit,ld_l2hit,"
> +			     "ld_lclhit,lcl_hitm,"
> +			     "ld_rmthit,rmt_hitm,"
> +			     "dram_lcl,dram_rmt";
> +
> +	if (c2c.display == DISPLAY_TOT)
> +		sort_str = "tot_hitm";
> +	else if (c2c.display == DISPLAY_RMT)
> +		sort_str = "rmt_hitm";
> +	else if (c2c.display == DISPLAY_LCL)
> +		sort_str = "lcl_hitm";
> +	else if (c2c.display == DISPLAY_LLC)
> +		sort_str = "tot_llchit";
> +

could you please split addition of output_str/sort_str into separate
patch and then add DISPLAY_LLC support? it'd ease up review 

perhaps include also print_pareto changes in it 

thanks,
jirka

> +	c2c_hists__reinit(&c2c.hists, output_str, sort_str);
>  
>  	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
>  
> -- 
> 2.17.1
> 

