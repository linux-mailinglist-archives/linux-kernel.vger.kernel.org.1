Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E684327ADAC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgI1MWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgI1MWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:22:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25FF42083B;
        Mon, 28 Sep 2020 12:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601295751;
        bh=+EkZxhskeg3iV+2V8plgF6/BmcC1Xkzld9TpaN73fyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=trwGNEjXMSbjudNxIuzk0IViePmAUgr8kFd86Hqc4f4+eKytJ6wxywv0HNiULvcsE
         1mEiWl2rlDwRFi39d0VY1z92rYH+ldriLcL91VAya6VvfqW68iOXRMpLnfljIU6Emj
         StXQnehQYlxHAYB7Xv9+J0NwWa52xTn+kogwnWgQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1D698400E9; Mon, 28 Sep 2020 09:22:29 -0300 (-03)
Date:   Mon, 28 Sep 2020 09:22:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf parse-events: Reduce casts around bp_addr
Message-ID: <20200928122229.GC3087422@kernel.org>
References: <20200925003903.561568-1-irogers@google.com>
 <20200925130103.GA3273770@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925130103.GA3273770@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 25, 2020 at 03:01:03PM +0200, Jiri Olsa escreveu:
> On Thu, Sep 24, 2020 at 05:39:03PM -0700, Ian Rogers wrote:
> > perf_event_attr bp_addr is a u64. parse-events.y parses it as a u64, but
> > casts it to a void* and then parse-events.c casts it back to a u64.
> > Rather than all the casts, change the type of the address to be a u64.
> > This removes an issue noted in:
> > https://lore.kernel.org/lkml/20200903184359.GC3495158@kernel.org/
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>


Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/parse-events.c | 4 ++--
> >  tools/perf/util/parse-events.h | 2 +-
> >  tools/perf/util/parse-events.y | 8 ++++----
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 667cbca1547a..f82ef1e840b2 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -940,12 +940,12 @@ do {					\
> >  }
> >  
> >  int parse_events_add_breakpoint(struct list_head *list, int *idx,
> > -				void *ptr, char *type, u64 len)
> > +				u64 addr, char *type, u64 len)
> >  {
> >  	struct perf_event_attr attr;
> >  
> >  	memset(&attr, 0, sizeof(attr));
> > -	attr.bp_addr = (unsigned long) ptr;
> > +	attr.bp_addr = addr;
> >  
> >  	if (parse_breakpoint_type(type, &attr))
> >  		return -EINVAL;
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> > index 00cde7d2e30c..e80c9b74f2f2 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -190,7 +190,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
> >  			   struct parse_events_error *error,
> >  			   struct list_head *head_config);
> >  int parse_events_add_breakpoint(struct list_head *list, int *idx,
> > -				void *ptr, char *type, u64 len);
> > +				u64 addr, char *type, u64 len);
> >  int parse_events_add_pmu(struct parse_events_state *parse_state,
> >  			 struct list_head *list, char *name,
> >  			 struct list_head *head_config,
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > index 645bf4f1859f..d5b6aff82f21 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -511,7 +511,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
> >  	list = alloc_list();
> >  	ABORT_ON(!list);
> >  	err = parse_events_add_breakpoint(list, &parse_state->idx,
> > -					(void *)(uintptr_t) $2, $6, $4);
> > +					  $2, $6, $4);
> >  	free($6);
> >  	if (err) {
> >  		free(list);
> > @@ -528,7 +528,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
> >  	list = alloc_list();
> >  	ABORT_ON(!list);
> >  	if (parse_events_add_breakpoint(list, &parse_state->idx,
> > -						(void *)(uintptr_t) $2, NULL, $4)) {
> > +					$2, NULL, $4)) {
> >  		free(list);
> >  		YYABORT;
> >  	}
> > @@ -544,7 +544,7 @@ PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
> >  	list = alloc_list();
> >  	ABORT_ON(!list);
> >  	err = parse_events_add_breakpoint(list, &parse_state->idx,
> > -					(void *)(uintptr_t) $2, $4, 0);
> > +					  $2, $4, 0);
> >  	free($4);
> >  	if (err) {
> >  		free(list);
> > @@ -561,7 +561,7 @@ PE_PREFIX_MEM PE_VALUE sep_dc
> >  	list = alloc_list();
> >  	ABORT_ON(!list);
> >  	if (parse_events_add_breakpoint(list, &parse_state->idx,
> > -						(void *)(uintptr_t) $2, NULL, 0)) {
> > +					$2, NULL, 0)) {
> >  		free(list);
> >  		YYABORT;
> >  	}
> > -- 
> > 2.28.0.681.g6f77f65b4e-goog
> > 
> 

-- 

- Arnaldo
