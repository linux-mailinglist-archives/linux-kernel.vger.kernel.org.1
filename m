Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEDF293AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404056AbgJTMGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394080AbgJTMGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:06:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A32AB20691;
        Tue, 20 Oct 2020 12:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603195597;
        bh=jGPSdlUUbqB/K1MtveeqGOu3jhDkOt/EewiXt4GbuyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hUG+/CP6yrEYCXYlyxAiVDhRnUOLeN4S/n+IO+AzJIOTiM0++Y1sxuRbZT5+VHTuV
         +hCsK1Ipu3JuwEOB9f+S6nPU0JppMN4d+4kbyS/bMaVjdBAZBLrE9GBY5twDhpOahS
         kLxKS5XrGtQbzwTnXXpOugGY3P3u4ZApsxa/mlMg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2D165403C2; Tue, 20 Oct 2020 09:06:35 -0300 (-03)
Date:   Tue, 20 Oct 2020 09:06:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf mem2node: Improve warning if detected no memory
 nodes
Message-ID: <20201020120635.GC2294271@kernel.org>
References: <20201019003613.8399-1-leo.yan@linaro.org>
 <20201020060627.GA2084117@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020060627.GA2084117@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 20, 2020 at 08:06:27AM +0200, Jiri Olsa escreveu:
> On Mon, Oct 19, 2020 at 08:36:13AM +0800, Leo Yan wrote:
> > Some archs (e.g. x86 and Arm64) don't enable the configuration
> > CONFIG_MEMORY_HOTPLUG by default, if this configuration is not enabled
> > when build the kernel image, the SysFS for memory nodes will be missed.
> > This results in perf tool has no chance to catpure the memory nodes
> > information, when perf tool reports the result and detects no memory
> > nodes, it outputs "assertion failed at util/mem2node.c:99".
> > 
> > The output log doesn't give out reason for the failure and users have no
> > clue for how to fix it.  This patch changes to use explicit way for
> > warning: it tells user that detected no memory nodes and suggests to
> > enable CONFIG_MEMORY_HOTPLUG for kernel building.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/mem2node.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
> > index c84f5841c7ab..03a7d7b27737 100644
> > --- a/tools/perf/util/mem2node.c
> > +++ b/tools/perf/util/mem2node.c
> > @@ -96,7 +96,8 @@ int mem2node__init(struct mem2node *map, struct perf_env *env)
> >  
> >  	/* Cut unused entries, due to merging. */
> >  	tmp_entries = realloc(entries, sizeof(*entries) * j);
> > -	if (tmp_entries || WARN_ON_ONCE(j == 0))
> > +	if (tmp_entries ||
> > +	    WARN_ONCE(j == 0, "No memory nodes, is CONFIG_MEMORY_HOTPLUG enabled?\n"))
> >  		entries = tmp_entries;
> >  
> >  	for (i = 0; i < j; i++) {
> > -- 
> > 2.17.1
> > 
> 

-- 

- Arnaldo
