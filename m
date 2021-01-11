Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558862F0E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbhAKIsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbhAKIse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:48:34 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55038C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:47:54 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l23so10142350pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VqTf2JcINqC2+jTniT8N8K29KqeobB0chisBHkID2tY=;
        b=Z7/IgLdkbvlM/vtqs1SpOhIcDcMLtKDkK4M/bkv/g3NsL4kpPceLa7wDd+rD0FuJlz
         lDlQbPzdnJYf4te0OoFpjQ5390FTZazvsa8SmJVNt+YthAOvYj86mxzYfhvqLlbJlnej
         QdWitIpdfJjOfmHzUnAan/6z+/1hb3NIpDy862xlw3pQbao2ZtMaJXF+nvvfu9feoIjv
         rWywSV6IJVbOtXgJhuc12sq9lzwyUir9OHEYpPDRUucamkNDss8GtHaIbpNeSvB5vquT
         vwRxblS1YZE/dEFiUYxd9Kdobi9J1IOjDaRUTIZaVhPX3wxlNmzvtz6Yt3abfN1Dppzs
         rosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VqTf2JcINqC2+jTniT8N8K29KqeobB0chisBHkID2tY=;
        b=U9iHHgRHePIvYe3sOOUpSeX66isdPbwxwg1YxMHAoiKDCXQS3r2rxKkSWFLPdVS7of
         4Z7eUackvmEAzUpvoU4QA09hfZoFIzt6qMZ82DktWojwG/NwYxZOcxEvPRME8ihXK8Pd
         RVOQUuchY39FGMpWQWY3P3xMfGGatl0OSrScs8avvb7JI6ppqCOeSVt7VjVpHjwHobYT
         xbaHFqzibpX5bxUcTgfu1JHXRnn21hcIr47QlFtcmko87cCUlB2s3drjdUhmcVk/CO7x
         83eQPv6aSy/jna/ajx2uzb35Jn4C6WBhemxFZPp/9S7Z26Dv+wqTJbmr/eoccxxeQa+x
         5YPQ==
X-Gm-Message-State: AOAM530myAjv/7BMblcJaB+RTS46ykuR0ZW6uqQl0UxK2L2Q4qsTnfbL
        x6DZ2PpVUhdWaVStIvClevJKeQ==
X-Google-Smtp-Source: ABdhPJzaacWwVpLjkh/nAUEGD7HpqCdBbX2nX8Xyo9vn7HQoY3argyAW07jUkWzjhcyL2iMLY3jClQ==
X-Received: by 2002:a17:902:59dc:b029:da:84c7:f175 with SMTP id d28-20020a17090259dcb02900da84c7f175mr15454551plj.75.1610354873818;
        Mon, 11 Jan 2021 00:47:53 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id gw21sm17435375pjb.28.2021.01.11.00.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 00:47:53 -0800 (PST)
Date:   Mon, 11 Jan 2021 16:47:48 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/11] perf c2c: Sort on all cache hit for load
 operations
Message-ID: <20210111084748.GI3241@leoy-ThinkPad-X240s>
References: <20201213133850.10070-1-leo.yan@linaro.org>
 <20201213133850.10070-11-leo.yan@linaro.org>
 <CAM9d7cj=SDLyCgBOKfEX91s7VrWbJZa-Qn+8SuE+rzC+vGGs_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj=SDLyCgBOKfEX91s7VrWbJZa-Qn+8SuE+rzC+vGGs_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:52:15PM +0900, Namhyung Kim wrote:

[...]

> > @@ -2502,12 +2528,21 @@ static void print_pareto(FILE *out)
> >         int ret;
> >         const char *cl_output;
> >
> > -       cl_output = "cl_num,"
> > -                   "cl_rmt_hitm,"
> > -                   "cl_lcl_hitm,"
> > -                   "cl_stores_l1hit,"
> > -                   "cl_stores_l1miss,"
> > -                   "dcacheline";
> > +       if (c2c.display == DISPLAY_TOT || c2c.display == DISPLAY_LCL ||
> > +           c2c.display == DISPLAY_RMT)
> > +               cl_output = "cl_num,"
> > +                           "cl_rmt_hitm,"
> > +                           "cl_lcl_hitm,"
> > +                           "cl_stores_l1hit,"
> > +                           "cl_stores_l1miss,"
> > +                           "dcacheline";
> > +       else /* c2c.display == DISPLAY_ALL */
> > +               cl_output = "cl_num,"
> > +                           "cl_tot_ld_hit,"
> > +                           "cl_tot_ld_miss,"
> > +                           "cl_stores_l1hit,"
> > +                           "cl_stores_l1miss,"
> > +                           "dcacheline";
> 
> Nit: You can keep the default value as is, and add an if statement
> just for the DISPLAY_ALL.

Okay, this might be more friendly for review.  Will change to this
way.

> >
> >         perf_hpp_list__init(&hpp_list);
> >         ret = hpp_list__parse(&hpp_list, cl_output, NULL);
> > @@ -2543,7 +2578,7 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
> >                 fprintf(out, "%-36s: %s\n", first ? "  Events" : "", evsel__name(evsel));
> >                 first = false;
> >         }
> > -       fprintf(out, "  Cachelines sort on                : %s HITMs\n",
> > +       fprintf(out, "  Cachelines sort on                : %s\n",
> >                 display_str[c2c.display]);
> >         fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
> >  }
> > @@ -2700,7 +2735,7 @@ static int perf_c2c_browser__title(struct hist_browser *browser,
> >  {
> >         scnprintf(bf, size,
> >                   "Shared Data Cache Line Table     "
> > -                 "(%lu entries, sorted on %s HITMs)",
> > +                 "(%lu entries, sorted on %s)",
> >                   browser->nr_non_filtered_entries,
> >                   display_str[c2c.display]);
> >         return 0;
> > @@ -2906,6 +2941,8 @@ static int setup_display(const char *str)
> >                 c2c.display = DISPLAY_RMT;
> >         else if (!strcmp(display, "lcl"))
> >                 c2c.display = DISPLAY_LCL;
> > +       else if (!strcmp(display, "all"))
> > +               c2c.display = DISPLAY_ALL;
> >         else {
> >                 pr_err("failed: unknown display type: %s\n", str);
> >                 return -1;
> > @@ -2952,10 +2989,12 @@ static int build_cl_output(char *cl_sort, bool no_source)
> >         }
> >
> >         if (asprintf(&c2c.cl_output,
> > -               "%s%s%s%s%s%s%s%s%s%s",
> > +               "%s%s%s%s%s%s%s%s%s%s%s",
> >                 c2c.use_stdio ? "cl_num_empty," : "",
> > -               "percent_rmt_hitm,"
> > -               "percent_lcl_hitm,"
> > +               c2c.display == DISPLAY_ALL ? "percent_ld_hit,"
> > +                                            "percent_ld_miss," :
> > +                                            "percent_rmt_hitm,"
> > +                                            "percent_lcl_hitm,",
> >                 "percent_stores_l1hit,"
> >                 "percent_stores_l1miss,"
> >                 "offset,offset_node,dcacheline_count,",
> > @@ -2984,6 +3023,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
> >  static int setup_coalesce(const char *coalesce, bool no_source)
> >  {
> >         const char *c = coalesce ?: coalesce_default;
> > +       const char *sort_str = NULL;
> >
> >         if (asprintf(&c2c.cl_sort, "offset,%s", c) < 0)
> >                 return -ENOMEM;
> > @@ -2991,12 +3031,16 @@ static int setup_coalesce(const char *coalesce, bool no_source)
> >         if (build_cl_output(c2c.cl_sort, no_source))
> >                 return -1;
> >
> > -       if (asprintf(&c2c.cl_resort, "offset,%s",
> > -                    c2c.display == DISPLAY_TOT ?
> > -                    "tot_hitm" :
> > -                    c2c.display == DISPLAY_RMT ?
> > -                    "rmt_hitm,lcl_hitm" :
> > -                    "lcl_hitm,rmt_hitm") < 0)
> > +       if (c2c.display == DISPLAY_TOT)
> > +               sort_str = "tot_hitm";
> > +       else if (c2c.display == DISPLAY_RMT)
> > +               sort_str = "rmt_hitm,lcl_hitm";
> > +       else if (c2c.display == DISPLAY_LCL)
> > +               sort_str = "lcl_hitm,rmt_hitm";
> > +       else if (c2c.display == DISPLAY_ALL)
> > +               sort_str = "tot_ld_hit";
> > +
> > +       if (asprintf(&c2c.cl_resort, "offset,%s", sort_str) < 0)
> >                 return -ENOMEM;
> >
> >         pr_debug("coalesce sort   fields: %s\n", c2c.cl_sort);
> > @@ -3131,20 +3175,37 @@ static int perf_c2c__report(int argc, const char **argv)
> >                 goto out_mem2node;
> >         }
> >
> > -       output_str = "cl_idx,"
> > -                    "dcacheline,"
> > -                    "dcacheline_node,"
> > -                    "dcacheline_count,"
> > -                    "percent_hitm,"
> > -                    "tot_hitm,lcl_hitm,rmt_hitm,"
> > -                    "tot_recs,"
> > -                    "tot_loads,"
> > -                    "tot_stores,"
> > -                    "stores_l1hit,stores_l1miss,"
> > -                    "ld_fbhit,ld_l1hit,ld_l2hit,"
> > -                    "ld_lclhit,lcl_hitm,"
> > -                    "ld_rmthit,rmt_hitm,"
> > -                    "dram_lcl,dram_rmt";
> > +       if (c2c.display == DISPLAY_TOT || c2c.display == DISPLAY_LCL ||
> > +           c2c.display == DISPLAY_RMT)
> > +               output_str = "cl_idx,"
> > +                            "dcacheline,"
> > +                            "dcacheline_node,"
> > +                            "dcacheline_count,"
> > +                            "percent_hitm,"
> > +                            "tot_hitm,lcl_hitm,rmt_hitm,"
> > +                            "tot_recs,"
> > +                            "tot_loads,"
> > +                            "tot_stores,"
> > +                            "stores_l1hit,stores_l1miss,"
> > +                            "ld_fbhit,ld_l1hit,ld_l2hit,"
> > +                            "ld_lclhit,lcl_hitm,"
> > +                            "ld_rmthit,rmt_hitm,"
> > +                            "dram_lcl,dram_rmt";
> > +       else /* c2c.display == DISPLAY_ALL */
> > +               output_str = "cl_idx,"
> > +                            "dcacheline,"
> > +                            "dcacheline_node,"
> > +                            "dcacheline_count,"
> > +                            "percent_tot_ld_hit,"
> > +                            "tot_ld_hit,"
> > +                            "tot_recs,"
> > +                            "tot_loads,"
> > +                            "tot_stores,"
> > +                            "stores_l1hit,stores_l1miss,"
> > +                            "ld_fbhit,ld_l1hit,ld_l2hit,"
> > +                            "ld_lclhit,lcl_hitm,"
> > +                            "ld_rmthit,rmt_hitm,"
> > +                            "dram_lcl,dram_rmt";
> 
> Ditto.

Agreed.

Thanks,
Leo
