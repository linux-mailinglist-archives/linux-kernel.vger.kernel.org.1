Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE0C293675
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbgJTIIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgJTIIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:08:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE68C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:08:46 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk5so39577pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+oItS62ym0EBwxT0am78ndBZVPaQnDtm/ZMUbYDDU7o=;
        b=OQC681A0oaKA6TWqfPpeMG1ClfgV/V+9CnItscTGgelZ3ZlUehXbdPIjoSeeAE8JcG
         DEzC3OEdULf6AvOQQpPGsuzMGiIg4Rhh+ZoyL9bLUuYZVYQRLHwfv5cpn/+9JpVFlujv
         gaR7y8YcT222G2WQWZJPTIGQjLZUsKvdll+6LCi2o49E3QbP/mnOaPC1sp0R6Ada2SfM
         m9MW0uNQ5398bXHFJ0qCHcIonzMkls7X8s5ggWVmUhb6uM4nrTdDej6UN2qKWH1uh7cn
         NCTZFeHbXKjxlwm0h/CCe7x3O/SaPIeUbkUZB8nKzeMn2QTLOKsh5ypw9pnJNd9/wgKS
         2oEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+oItS62ym0EBwxT0am78ndBZVPaQnDtm/ZMUbYDDU7o=;
        b=V5szQIWkJ40GyacLCV9FUGmXrWbgguNrYhAiWZYAyK/8qVJZEjGl5+Ig2BtEwLvVZA
         rAS3qB83TNS9GeJmkFlT+fr6/k8t9VU9CVhIvalLzrnO6uoUoNUisIGjoaZSoi+4l+2C
         MQrFz6hiq6lLctxyi7/jwi1nQZJC1vlcVWJGPilAPrcnJQEZgE+qX9WDxKMaA92khQjB
         dQ2SD8LlFMzOLPyag20n3v8tSQFRzsb2OZiaGokVQN+4xYQDJnhmBdpbXK/0xIgD1LVt
         TyQma151L+9KLTaCIqWWct0JBEh7puZRQuhLA7k0pMRrBmRsoMSxZXMb9Mdwsqw0QvfS
         c3Hg==
X-Gm-Message-State: AOAM533YHfoG5B4Z0M+w61xXlRwPWrVu8UuRs+5Via28KwWZ64h9yl9l
        mBsNfLXZ3ZrxFMyosYoH3C36jw==
X-Google-Smtp-Source: ABdhPJwJGiYvc1JHoVxdCWcsk3pCA+QFuF07n00utFbOkymCV3lAkl1ltrVhqbMVcprHWAPtB8fxtQ==
X-Received: by 2002:a17:90a:c28a:: with SMTP id f10mr1801418pjt.30.1603181326272;
        Tue, 20 Oct 2020 01:08:46 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id l18sm1423301pfd.210.2020.10.20.01.08.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 01:08:45 -0700 (PDT)
Date:   Tue, 20 Oct 2020 16:08:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
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
Message-ID: <20201020080839.GC13630@leoy-ThinkPad-X240s>
References: <20201015145041.10953-1-leo.yan@linaro.org>
 <20201015145041.10953-8-leo.yan@linaro.org>
 <20201020072553.GC2084117@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020072553.GC2084117@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Tue, Oct 20, 2020 at 09:25:53AM +0200, Jiri Olsa wrote:
> On Thu, Oct 15, 2020 at 03:50:40PM +0100, Leo Yan wrote:
> 
> SNIP
> 
> > @@ -1533,6 +1539,7 @@ static struct c2c_header percent_hitm_header[] = {
> >  	[DISPLAY_LCL] = HEADER_BOTH("Lcl", "Hitm"),
> >  	[DISPLAY_RMT] = HEADER_BOTH("Rmt", "Hitm"),
> >  	[DISPLAY_TOT] = HEADER_BOTH("Tot", "Hitm"),
> > +	[DISPLAY_LLC] = HEADER_BOTH("LLC", "Hit"),
> >  };
> >  
> >  static struct c2c_dimension dim_percent_hitm = {
> > @@ -2002,6 +2009,10 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
> >  		break;
> >  	case DISPLAY_TOT:
> >  		FILTER_ENTRY(tot_hitm);
> > +		break;
> > +	case DISPLAY_LLC:
> > +		FILTER_ENTRY(tot_llchit);
> > +		break;
> >  	default:
> >  		break;
> >  	}
> > @@ -2032,6 +2043,9 @@ static inline bool is_valid_hist_entry(struct hist_entry *he)
> >  	case DISPLAY_TOT:
> >  		has_record = !!c2c_he->stats.tot_hitm;
> >  		break;
> > +	case DISPLAY_LLC:
> > +		has_record = !!c2c_he->stats.tot_llchit;
> > +		break;
> >  	default:
> >  		break;
> >  	}
> 
> there's one more switch with c2c.display in percent_hitm function,
> where you did not add DISPLAY_LLC case.. I guess it should not ever
> because we will not use that column in llc display mode, but we
> should add at least some warning or that

Exactly, for "DISPLAY_LLC" case, it will not run in the function
percent_hitm(); will add warning for that.

> SNIP
> 
> > -				"cl_rmt_hitm,"
> > -				"cl_lcl_hitm,"
> > -				"cl_stores_l1hit,"
> > -				"cl_stores_l1miss,"
> > -				"dcacheline",
> > -				NULL);
> > +	ret = hpp_list__parse(&hpp_list, cl_output, NULL);
> >  
> >  	if (WARN_ONCE(ret, "failed to setup sort entries\n"))
> >  		return;
> > @@ -2357,7 +2384,7 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
> >  		fprintf(out, "%-36s: %s\n", first ? "  Events" : "", evsel__name(evsel));
> >  		first = false;
> >  	}
> > -	fprintf(out, "  Cachelines sort on                : %s HITMs\n",
> > +	fprintf(out, "  Cachelines sort on                : %s\n",
> >  		display_str[c2c.display]);
> >  	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
> >  }
> > @@ -2514,7 +2541,7 @@ static int perf_c2c_browser__title(struct hist_browser *browser,
> >  {
> >  	scnprintf(bf, size,
> >  		  "Shared Data Cache Line Table     "
> > -		  "(%lu entries, sorted on %s HITMs)",
> > +		  "(%lu entries, sorted on %s)",
> >  		  browser->nr_non_filtered_entries,
> >  		  display_str[c2c.display]);
> >  	return 0;
> > @@ -2720,6 +2747,8 @@ static int setup_display(const char *str)
> >  		c2c.display = DISPLAY_RMT;
> >  	else if (!strcmp(display, "lcl"))
> >  		c2c.display = DISPLAY_LCL;
> > +	else if (!strcmp(display, "llc"))
> > +		c2c.display = DISPLAY_LLC;
> 
> please update man page with this
> 
> >  	else {
> >  		pr_err("failed: unknown display type: %s\n", str);
> >  		return -1;
> > @@ -2766,9 +2795,10 @@ static int build_cl_output(char *cl_sort, bool no_source)
> >  	}
> >  
> >  	if (asprintf(&c2c.cl_output,
> > -		"%s%s%s%s%s%s%s%s%s%s",
> > +		"%s%s%s%s%s%s%s%s%s%s%s",
> 
> why is there extra '%s' when we did not add new argument.. ?

This is deliberate.  The change is as below:

        if (asprintf(&c2c.cl_output,
-               "%s%s%s%s%s%s%s%s%s%s",
+               "%s%s%s%s%s%s%s%s%s%s%s",
                c2c.use_stdio ? "cl_num_empty," : "",
-               "percent_rmt_hitm,"
+               c2c.display == DISPLAY_LLC ? "percent_llc_hit," :
+                                            "percent_rmt_hitm,",
                "percent_lcl_hitm,"

In the old code the string "percent_rmt_hitm," is merged with later
lines (the second string is "percent_lcl_hitm,") into single string.

In this patch, it needs to check condition c2c.display and pass
different string ("percent_llc_hit," vs "percent_rmt_hitm,"), thus
the string ("percent_llc_hit," or "percent_rmt_hitm,") is passed
independently, it's _NOT_ jointed with sequnetial lines.

> SNIP
> 
> > +			     "ld_fbhit,ld_l1hit,ld_l2hit,"
> > +			     "ld_lclhit,lcl_hitm,"
> > +			     "ld_rmthit,rmt_hitm,"
> > +			     "dram_lcl,dram_rmt";
> > +	else /* c2c.display == DISPLAY_LLC */
> > +		output_str = "cl_idx,"
> > +			     "dcacheline,"
> > +			     "dcacheline_node,"
> > +			     "dcacheline_count,"
> > +			     "percent_llchit,"
> > +			     "tot_llchit,"
> > +			     "tot_recs,"
> > +			     "tot_loads,"
> > +			     "tot_stores,"
> > +			     "stores_l1hit,stores_l1miss,"
> > +			     "ld_fbhit,ld_l1hit,ld_l2hit,"
> > +			     "ld_lclhit,lcl_hitm,"
> > +			     "ld_rmthit,rmt_hitm,"
> > +			     "dram_lcl,dram_rmt";
> > +
> > +	if (c2c.display == DISPLAY_TOT)
> > +		sort_str = "tot_hitm";
> > +	else if (c2c.display == DISPLAY_RMT)
> > +		sort_str = "rmt_hitm";
> > +	else if (c2c.display == DISPLAY_LCL)
> > +		sort_str = "lcl_hitm";
> > +	else if (c2c.display == DISPLAY_LLC)
> > +		sort_str = "tot_llchit";
> > +
> 
> could you please split addition of output_str/sort_str into separate
> patch and then add DISPLAY_LLC support? it'd ease up review 
> 
> perhaps include also print_pareto changes in it 

Will do.

Thanks a lot for reviewing,
Leo
